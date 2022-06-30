import Foundation
import NIOSSL

/// Wraps `NIOSSLCertificate` to provide the certificate common name and expiry date.
struct GRPCCertificate {
    var certificate: NIOSSLCertificate
    private var commonName: String
    private var notAfter: Date

    static func getCaCert() throws -> GRPCCertificate {
        var caCert: GRPCCertificate!
        do {
            caCert = try GRPCCertificate(
                            certificate: NIOSSLCertificate(bytes: .init(GRPCConfig.caCert.utf8), format: .pem),
                            commonName: "foo",
                            // 22/07/2024 16:32:23
                            notAfter: Date(timeIntervalSince1970: 1_721_662_343.0)
                        )
        } catch {
            print("\(error)")
            throw error
        }
        return caCert
    }

    static func getClient() throws -> GRPCCertificate {
        var client: GRPCCertificate!
        do {
            client = try GRPCCertificate(
                            certificate: NIOSSLCertificate(bytes: .init(GRPCConfig.clientCert.utf8), format: .pem),
                            commonName: GRPCConfig.host,
                            // 22/07/2024 16:32:23
                            notAfter: Date(timeIntervalSince1970: 1_721_662_343.0)
                        )
        } catch {
            print("\(error)")
            throw error
        }
        return client
    }
}

/// Provides convenience methods to make `NIOSSLPrivateKey`s for corresponding `GRPCSwiftCertificate`s.
struct GRPCPrivateKey {
    private init() {}

    static func getClient() throws -> NIOSSLPrivateKey {
        var client: NIOSSLPrivateKey!
        do {
            try client = NIOSSLPrivateKey(bytes: .init(GRPCConfig.clientKey.utf8), format: .pem)
        } catch {
            print("\(error)")
            throw error
        }
        return client
    }

}
