import SwiftUI
import GRPC
import NIOHPACK

class GrpcCommunicator {
    private static var sharedGRPCCommunicator = GrpcCommunicator()
    private var channel: GRPCChannel?

    /// The GRPC error
    enum GRPCError: Error {
        case deviceIDIdentifierError
    }

    /// Share the instance of GRPCCommunicatore
    /// - Returns: Returns instance of GRPCCommunicatore
    class func sharedInstance() -> GrpcCommunicator {
        return sharedGRPCCommunicator
    }

    /// Opens a new gRPC channel
    func openGrpcChannel() throws {

        self.channel = ClientConnection.usingTLSBackedByNIOSSL(
            on: PlatformSupport.makeEventLoopGroup(loopCount: 1))
            .connect(host: GRPCConfig.host, port: GRPCConfig.port)
    }

    /// Close the gRPC channel
    func closeGrpcChannel() throws {

        if self.channel == nil {
            return
        }

        do {
            try self.channel!.close().wait()
        } catch {
            print("Error closing the gRPC channel: \(error)")
            throw error
        }
    }

    /// Get the token from the server
    /// - Parameters:
    ///   - licenseKey: License key to connect with frontend in order to get the token
    /// - Returns: A tuple containing the Token and the Refresh Token
    func authenticate(licenseKey: String) throws -> (String, String) {

        var response:
        _365id_Glootie_Contracts_GRPC_Authentication_AuthenticateResponse!

        let vendorId: String

        if let devId = UIDevice.current.identifierForVendor {
            vendorId = devId.uuidString
        } else {
            print("Unable to get the identifierForVendor")
            throw GRPCError.deviceIDIdentifierError
        }

        do {
            try self.openGrpcChannel()

            // Provide the connection to the generated client.
            let client = _365id_Glootie_Contracts_GRPC_Authentication_AuthenticationClient(channel: self.channel!)

            // Form the request with the name, if one was provided.
            let request = _365id_Glootie_Contracts_GRPC_Authentication_AuthenticateRequest.with {
                $0.licenseKey = licenseKey
                $0.vendorID = vendorId
            }

            // Make the RPC call to the server.
            let reply = client.authenticate(request)
            response = try reply.response.wait()
            print("Received response from frontend [Get Token]: \(response as Optional)")

            try closeGrpcChannel()
        } catch {
            print("Failed to receive the message from frontend [Get Token]: \(error)")
            throw error
        }
        
        return (response.token, response.refreshToken)
    }

    /// Does a refresh of the token
    /// - Parameters:
    ///   - refreshToken: The one time use RefreshToken
    ///   - token: The expired Token
    /// - Returns: A tuple containing the refreshed Token and a new single use RefreshToken
    func refresh(refreshToken: String, token: String) throws -> (String, String) {

        var response:
        _365id_Glootie_Contracts_GRPC_Authentication_RefreshTokenResponse!

        do {
            try self.openGrpcChannel()

            // Provide the connection to the generated client.
            let client = _365id_Glootie_Contracts_GRPC_Authentication_AuthenticationClient(channel: self.channel!)

            // Form the request with the name, if one was provided.
            let request = _365id_Glootie_Contracts_GRPC_Authentication_RefreshTokenRequest.with {
                $0.refreshToken = refreshToken
            }
            /// Use CallOptions to send the token to the frontend.
            var headers: CallOptions {
                get {
                    let header: HPACKHeaders = ["Authorization": "Bearer \(token)"]
                    return CallOptions(customMetadata: header)
                }
            }

            // Make the RPC call to the server.
            let reply = client.refreshToken(request, callOptions: headers)
            response = try reply.response.wait()
            print("Received response from frontend [Get Token]: \(response as Optional)")

        } catch {
            print("Failed to receive the message from frontend [Get Token]: \(error)")
            throw error
        }

        return (response.token, response.refreshToken)
    }
}
