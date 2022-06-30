import Foundation
import GRPC
import NIOCore
import NIOPosix
import SwiftUI
import NIOHPACK

class GRPCCommunicator {
    private static var sharedGRPCCommunicator = GRPCCommunicator()
    private var channel: GRPCChannel!

    /// The GRPC error
    enum GRPCError: Error {
        case deviceIDIdentifierError
    }

    /// Share the instance of GRPCCommunicatore
    /// - Returns: Returns instance of GRPCCommunicatore
    class func sharedInstance() -> GRPCCommunicator {
        return sharedGRPCCommunicator
    }

    /// Make a new gRPC channel
    /// - Returns: Created grpc channel
    func createGrpcChannel() throws {
        var channel: GRPCChannel!

        do {
            let group = MultiThreadedEventLoopGroup(numberOfThreads: 1)

            // TLS certificate configuration
            let caCert = try GRPCCertificate.getCaCert()
            let clientCert = try GRPCCertificate.getClient()
            let tlsConfiguration = GRPCTLSConfiguration.makeServerConfigurationBackedByNIOSSL(
               certificateChain: [.certificate(clientCert.certificate)],
               privateKey: .privateKey(try GRPCPrivateKey.getClient()),
               trustRoots: .certificates([caCert.certificate])
             )

            // Configure the channel
            channel = try GRPCChannelPool.with(
                target: .host(GRPCConfig.host, port: GRPCConfig.port),
                transportSecurity: .tls(tlsConfiguration),
                eventLoopGroup: group
            )

        } catch {
            print("Failed to create GRPC Channel\n\(error)")
            throw error
        }

        self.channel = channel
    }

    // Close the GRPC connection when we're done with it.
    func closeGRPCConnection() throws {
        do {
            // make sure that the channel has created
            if self.channel != nil {
                try self.channel.close().wait()
            }
        } catch {
            throw error
        }
    }

    /// Get the token from the server
    /// - Parameters:
    ///   - licenseKey: License key to connect with frontend in order to get the token
    func getToken(licenseKey: String) throws -> String {
        var response: _365id_Glootie_Contracts_GRPC_Authentication_AuthenticateResponse!

        let vendorId: String
        if let devId = UIDevice.current.identifierForVendor {
            vendorId = devId.uuidString
        } else {
            print("Unable to get the identifierForVendor")
            throw GRPCError.deviceIDIdentifierError
        }

        do {
            try self.createGrpcChannel()

            // Provide the connection to the generated client.
            let client = _365id_Glootie_Contracts_GRPC_Authentication_AuthenticationClient(channel: self.channel)

            // Form the request with the name, if one was provided.
            let request = _365id_Glootie_Contracts_GRPC_Authentication_AuthenticateRequest.with {
                $0.licenseKey = licenseKey
                $0.vendorID = vendorId
            }

            // Make the RPC call to the server.
            let reply = client.authenticate(request)
            response = try reply.response.wait()
            print("Received response from frontend [Get Token]: \(response as Optional)")

            try closeGRPCConnection()
        } catch {
            print("Failed to receive the message from frontend [Get Token]: \(error)")
            throw error
        }

        return response.token
    }
}
