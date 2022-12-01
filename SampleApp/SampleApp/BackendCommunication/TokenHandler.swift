import UIKit

// MARK: - Handle Token requests
class TokenHandler {
    
    private static let baseUrl: String = "https://eu.customer.365id.com/api/v1/"
    
    // MARK: The token object
    private struct TokenData : Codable {
        
        private let accessToken: String?
        private let expiresIn: Int?
        private let refreshToken: String?
        private var expireTimeTxt: String?
        private var clientSecret: String?
        private var clientId: String?
        private let minimumSecondsToUseToken: Int = 25
        private static let storedTokenDataKey: String = "TokenData365ID"
        
        public func getAccessToken() -> String? {
            self.accessToken
        }
        
        public func getRefreshToken() -> String {
            self.refreshToken ?? ""
        }
        
        private mutating func setExpireTimeTxt() {
            guard let expireTime = Calendar.current.date(byAdding: .second, value: self.expiresIn ?? 0, to: Date()) else { return }
            self.expireTimeTxt = getDateFormatter().string(from: expireTime)
        }
        
        private mutating func setClientSecret(_ value: String) {
            self.clientSecret = value
        }
        
        private mutating func setClientId(_ value: String) {
            self.clientId = value
        }
        
        private func getClientSecret() -> String? {
            self.clientSecret
        }
        
        private func getClientId() -> String? {
            self.clientId
        }
        
        /** Keys to handle from the response */
        private enum CodingKeys: String, CodingKey {
            case accessToken = "access_token"
            case expiresIn = "expires_in"
            case refreshToken = "refresh_token"
            case expireTimeTxt = "expireTimeTxt"
            case clientSecret = "clientSecret"
            case clientId = "clientId"
        }
        
        /** Parse json to objects */
        public init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            accessToken = try values.decodeIfPresent(String.self, forKey: .accessToken)
            expiresIn = try values.decodeIfPresent(Int.self, forKey: .expiresIn)
            refreshToken = try values.decodeIfPresent(String.self, forKey: .refreshToken)
            expireTimeTxt = try values.decodeIfPresent(String.self, forKey: .expireTimeTxt)
            clientSecret = try values.decodeIfPresent(String.self, forKey: .clientSecret)
            clientId = try values.decodeIfPresent(String.self, forKey: .clientId)
        }
        
        /** Get a UTC date formatter */
        private func getDateFormatter() -> DateFormatter {
            let dateFormatter = DateFormatter()
            if let timeZone = TimeZone(identifier: "UTC") {
                dateFormatter.timeZone = timeZone
            }
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            return dateFormatter
        }
        
        /** Get seconds left of active token */
        public func getTokenSecondsLeft() -> Int {
            guard let dateTxt = self.expireTimeTxt else { return 0 }
            guard let futureDate = getDateFormatter().date(from: dateTxt) else { return 0 }
            var secondsLeft = Calendar.current.dateComponents([.second], from: Date(), to: futureDate).second ?? 0
            if secondsLeft < 0 {
                secondsLeft = 0
            }
            return secondsLeft
        }
        
        /** Check if the token is valid based on the expire date */
        public func isValidToken() -> Bool {
            getTokenSecondsLeft() >= self.minimumSecondsToUseToken
        }
        
        /** Create TokenData object from json */
        private static func jsonToTokenData(_ json: String) -> TokenData? {
            guard let data: Data = json.data(using: .utf8) else { return nil }
            return try? JSONDecoder().decode(TokenData.self, from: data)
        }
        
        /** Create json from TokenData object */
        private static func tokenDataToJson(_ tokenData: TokenData) -> String? {
            guard let jsonData = try? JSONEncoder().encode(tokenData) else { return nil }
            return String(data: jsonData, encoding: .utf8)
        }
        
        /** Save the TokenData on the device */
        public static func save(clientSecret: String, clientId: String, responseBody: String) -> Bool {
            guard var tokenData = jsonToTokenData(responseBody) else { return false }
            tokenData.setExpireTimeTxt()
            tokenData.setClientId(clientId)
            tokenData.setClientSecret(clientSecret)
            guard let updatedJson = tokenDataToJson(tokenData) else { return false }
            UserDefaults.standard.set(updatedJson, forKey: storedTokenDataKey)
            return true
        }
        
        /** Load the TokenData from the device */
        public static func load() -> TokenData? {
            guard let json = UserDefaults.standard.string(forKey: storedTokenDataKey) else { return nil }
            guard let tokenData = jsonToTokenData(json) else {
                delete()
                return nil
            }
            return tokenData
        }
        
        /** Delete the TokenData from the device */
        public static func delete() {
            UserDefaults.standard.removeObject(forKey: storedTokenDataKey)
        }
        
        /** Delete TokenData if Credentials has been changed */
        public static func deleteIfCredentialsChanged(clientSecret: String, clientId: String) {
            guard let tokenData = TokenData.load() else { return }
            let storedClientId = tokenData.getClientId()
            let storedClientSecret = tokenData.getClientSecret()
            if storedClientId != clientId || storedClientSecret != clientSecret {
                TokenData.delete()
            }
        }
    }
    
    /** Get a token for starting the SDK */
    public static func getToken(clientSecret: String, clientId: String, _ completionHandler: @escaping (_ token: String?) -> Void) {
        
        TokenData.deleteIfCredentialsChanged(clientSecret: clientSecret, clientId: clientId)
        let storedTokenData = TokenData.load()
        
        if let tokenData = storedTokenData {
            print("getToken() - \(tokenData.getTokenSecondsLeft()) seconds left of token.")
            if tokenData.isValidToken() {
                print("getToken() - Using stored token.")
                completionHandler(tokenData.getAccessToken())
                return
            }
        }
        
        let action: String
        let bodyParams: [String: Any]
        let bearer: String?
        if let tokenData = storedTokenData {
            action = "refresh_token"
            bodyParams = [
                "refresh_token": tokenData.getRefreshToken()
            ]
            bearer = tokenData.getAccessToken()
            TokenData.delete()
        }
        else{
            action = "access_token"
            bodyParams = [
                "client_id": clientId,
                "client_secret": clientSecret
            ]
            bearer = nil
        }
        
        guard let url = URL(string: "\(self.baseUrl)\(action)") else {
            completionHandler(nil)
            return
        }
        var request = URLRequest(url: url)
        request.timeoutInterval = 5
        request.httpMethod = "POST"
        request.cachePolicy = .reloadIgnoringLocalCacheData
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        if let bearerData = bearer {
            request.setValue("Bearer \(bearerData)", forHTTPHeaderField: "Authorization")
        }
        guard let jsonParams = try? JSONSerialization.data(withJSONObject: bodyParams) else {
            completionHandler(nil)
            return
        }
        request.httpBody = jsonParams
        
        let mainThread = DispatchQueue.main
        let currentThread = Thread.current
        URLSession.shared.dataTask(with: request) { [weak mainThread, weak currentThread] (data, response, error) in
            guard mainThread != nil && currentThread != nil else { return }
            let httpStatus = response as? HTTPURLResponse
            guard
                error == nil,
                httpStatus?.statusCode == 200,
                let receivedData = data,
                let responseBody = String(data: receivedData, encoding: .utf8),
                !responseBody.isEmpty,
                TokenData.save(clientSecret: clientSecret, clientId: clientId, responseBody: responseBody)
            else {
                print("getToken() - error:")
                print("\(error?.localizedDescription ?? "N/A")")
                print("\(httpStatus?.description ?? "N/A")")
                mainThread?.async {
                    completionHandler(nil)
                }
                return
            }
            print("getToken() - success!")
            mainThread?.async {
                completionHandler(TokenData.load()?.getAccessToken() ?? nil)
            }
        }.resume()
    }
}
