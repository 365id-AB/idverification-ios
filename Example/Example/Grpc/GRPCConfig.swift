import Foundation

/// GRPC server and client config file.
class GRPCConfig {

    // GRPC server host and port
    static let host = "frontend-device-ag.int.365id.com"; // Production host name

    static let port = 5001

    // MARK: - Certificates and private keys

    // NOTE: use the "makecerts" script in the scripts directory to generate new
    // certificates and private keys when these expire.

    static let caCert = """
    -----BEGIN CERTIFICATE-----
    MIIE5TCCAs2gAwIBAgIUe4m0mD4L0dem1tRjKFIYB8/swQswDQYJKoZIhvcNAQEN
    BQAwEDEOMAwGA1UEAwwFaHR0cHMwHhcNMjExMjAxMTQ1NjM2WhcNMjIxMjAxMTQ1
    NjM2WjAQMQ4wDAYDVQQDDAVodHRwczCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCC
    AgoCggIBALaHcAesBL8YbbOkS1lubjiVn6WBvqmfYtT3rqPe1f2d/FQVsUNbZy+C
    Hkc+2+UiC1NGJFp6VzjYWLGYNmC0WXBXHGitGP8nPWEkSBzV5m+N6Gr7C6XNB7s/
    sEG4clIy8/eumrdK6T48u6i1miK/ONQEJxNyThuj+d0kykvx5GRXLsn8GMFNimbz
    HC1Nkcy/yuB7kEdVttKt349ffok1HppH9wYfV+nrOnDpAhgJ1iFcTwNxXPLWICKf
    kH97ii7ulSMdDv+8qcoPJ7feg9CohVQW3Tdlv9wYX3KwQJM1A6Gvg60Hksmv8Bo9
    ttnYC/6tEc7nYGli5UBACJJJSn0Ovcm7tRbkooYxu25Kt1O9iOZ1rtHLTlr3uTG+
    sgPt0ltcElO9RQXHWOVzg2xYXLFerKkFQl6HC2f0dgb7J6/CT24QZkxBJkdFZbbj
    +z6ZVGTSdlqDzODwunX8kKGN9UFU2iFHFU8reKwHjIIEGRWkfQaTVn1OfnfmBTdQ
    NcFwZepOxrzgb8mlXH9F+LmdrfZ0gnW7xAd/NhwcD39H+1Q2bXQGsFhmLDNXyOXK
    NPUR7rz6F+xy+LYvjY5du08k2IpAPcoY0DSXU87yLU6gX6PLT6ZjMnwMGJKS8ux9
    1f7yRsEOuFwGiIOwcGuhUkvfsvPYfH5P66aCWq5Yl4RalBPi2FmVAgMBAAGjNzA1
    MAkGA1UdEwQCMAAwCwYDVR0PBAQDAgXgMBsGA1UdEQQUMBKCCXd3dy5odHRwc4IF
    aHR0cHMwDQYJKoZIhvcNAQENBQADggIBAAzt20wsUXPNs4E6Et30ZC5MgnOlU3pk
    W3GaQivJ4KZKRYPC3xtxtKUuttxt6efZhtQckDC4pP4KszLlMzV1rMfi8VWZB4fc
    XhkaqVOIWR2rJw/FsvGTdbCeOzoD/8QCxVqxodqkbh3yyHPMRfX0mmhLQOzsIYaw
    VYUd+hlzYscXA8rSw5CwCXueKeEZaR0sJ3naxNlDs9mt3V3EjIIZ8KDlkxOzYhg0
    WygP/Nle0pwDynDI+yzx+fEP19nSWmmhdcIT8sYkR0x47cPxytTuC5IeqKPaKf8h
    Rvel7v/Ad0qBQ7xLOCyyI3iY3NcOJQwS12ve3rB8NLSlBSSxbkPSVSytye3OdD+9
    LorMgU+J9OUHfSjW5DqpHa8yhW8BZuBC3F2JtncuiaH/E2r95YrPqpFU/FdzE/J0
    5Dyov3ZW83TiRfUiOCHfrdNxldqKnlyyq796o7vUVIGvNc/AhVO8Mjn/eP0ms+U/
    sAtd6ForU+/OenArqFfXK/np+5gKVMIpJdVdHu8AlA+pErBAmrMeARqdGKOjDinH
    sIvIssgxyrMXzhRmWxmBdOn/pHDsXqmiPlrvajSD+8O317bsBeXhPn0qDLS425Yr
    YhSqB1A3TZl8iWPmhWZRRdo9qf/8UQamQAN8KhgAKQhtXwRukFIvU/1Zt+IFOegw
    P9QYJAVvo358
    -----END CERTIFICATE-----
    """

    static let clientCert = """
    -----BEGIN CERTIFICATE-----
    MIIEUzCCArugAwIBAgIRAMlgv6RQ0tAryfgSYy7NtPkwDQYJKoZIhvcNAQELBQAw
    gY0xHjAcBgNVBAoTFW1rY2VydCBkZXZlbG9wbWVudCBDQTExMC8GA1UECwwobGFs
    Ym9zY29AbGFsbWFjZXRoLmRldi5sb2NhbCAoTGFsIEJvc2NvKTE4MDYGA1UEAwwv
    bWtjZXJ0IGxhbGJvc2NvQGxhbG1hY2V0aC5kZXYubG9jYWwgKExhbCBCb3Njbykw
    HhcNMjExMjAyMTEyMjE4WhcNMjQwMzAyMTEyMjE4WjBcMScwJQYDVQQKEx5ta2Nl
    cnQgZGV2ZWxvcG1lbnQgY2VydGlmaWNhdGUxMTAvBgNVBAsMKGxhbGJvc2NvQGxh
    bG1hY2V0aC5kZXYubG9jYWwgKExhbCBCb3NjbykwggEiMA0GCSqGSIb3DQEBAQUA
    A4IBDwAwggEKAoIBAQDb9XPy0I3j0dL0/WpeqODTPWIm87ty+pehn6MCVY3vBUlx
    ti15t7O2/Ig0RsBYRkaIGIOhb6YiD+0lpzDWe9E2glVbPaevIlV+39Ehf0Fi7BQf
    YauYdnUuBv/k6rX9ncYwxGLhA1OEIU04QXC7UspDyiylAy2apu9F35FhmxJxXMt3
    inXoyZQvsbstFIyT7qJWSr0MWZib01kHZAy0rcMOdCKpQgrM5YBypZmCVPrQjHKG
    /kajy2g330+mNGWec0ATMQL0eE1e7f2SIUppy3lkSD2VSgRUZyknpA4y50DqcU9J
    G5DvyKm40XnWOLrZBRQgUErQpmhE5Xx47dqYuebFAgMBAAGjXjBcMA4GA1UdDwEB
    /wQEAwIFoDATBgNVHSUEDDAKBggrBgEFBQcDATAfBgNVHSMEGDAWgBR2YUHwGpRg
    G5gr1cVsC9YQsbXiWzAUBgNVHREEDTALgglodHRwcy5jcnQwDQYJKoZIhvcNAQEL
    BQADggGBAEQo8lrTJ9/ro0yMpgTLER+hC0BL+Q9wGLhafuUd0FBzVrJ2x/rVHfO/
    nkC/6h24tOzYvRHeqJQWzl9ZEAAegt4wX9KRsocucJuFwqMBSaZXq/oUEEIuPB20
    kfIIKQh2iDVHLntWsVyd6SgNcP4ryLeavMtHle1q4drMIzU7F/AojRyBYs9Q9UOQ
    AXWdgOEGodKHKhnCsS76ExzR0O03K0LzTe5nJy0R8tKbvnfq8jpsEMfSmGO+ElVd
    9hAkRtbXg6eQh567IEKjhduMxQdW0tDYE2FSYKXW0d98YCGbcFLwzDpgkKnA4ZX5
    E29hg6R679QWeAnGIuHv9PVHS+XgUgfJUtrAHr+UlK9YOr059Z4BjNMBsSAbOXfZ
    mmCdGX2b+8Tp8aqXsjTha4UdwOyvmI0tDDP5XkCNuJDhZ1OSzTBt7cTZZjixv3kv
    cdndMXcZ/Lc0jDyXsRvN0jCV2dY2vc/2UW0KIVilR015dwMVinUiuQnc9h32LXGb
    7x8DJqDgmA==
    -----END CERTIFICATE-----
    """

    static let clientKey = """
    -----BEGIN RSA PRIVATE KEY-----
    MIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQDb9XPy0I3j0dL0
    /WpeqODTPWIm87ty+pehn6MCVY3vBUlxti15t7O2/Ig0RsBYRkaIGIOhb6YiD+0l
    pzDWe9E2glVbPaevIlV+39Ehf0Fi7BQfYauYdnUuBv/k6rX9ncYwxGLhA1OEIU04
    QXC7UspDyiylAy2apu9F35FhmxJxXMt3inXoyZQvsbstFIyT7qJWSr0MWZib01kH
    ZAy0rcMOdCKpQgrM5YBypZmCVPrQjHKG/kajy2g330+mNGWec0ATMQL0eE1e7f2S
    IUppy3lkSD2VSgRUZyknpA4y50DqcU9JG5DvyKm40XnWOLrZBRQgUErQpmhE5Xx4
    7dqYuebFAgMBAAECggEAWJoLxbCKp01a+8KkuVKvlYexZN1jEZKtx7YFNKh/zttD
    VWG7+b6szrX0q5IgYq6UNLgjNcFCm4/sx/EL9CnWAW4IsgMo65wZ8kx38lVPYmiU
    RnvSYky9MPgy1eRRwMJwFi7VYaw0VRIRB+scXOihfyMOTr3z/crmsS+4YSfVCwJF
    5WoEpOvi2tfsuqSm8UndWLqRHTp3LCKXoMklXgRfokk1XlkuYrjDq/v9JXwE/p0u
    I5o2h3whjzcr7zstPeP/FTJBQEe/gkCwyxdVpGiV2F9zM15NcBBs3YR0FUa4p6NB
    Ja/R9QrO9Cw4Bsx79FDX+AFvRUj2q7oRl4m+asyNQQKBgQDw57GyK8EvQknm2tGs
    gFke6nixZiLzqDXL1cRyCF9hdfZ6ellAhTRO0btsj/BdU/wtkWD/446a+S02cTsY
    Ksc9NIMf720WYQpOTTIrDnYd9/NsbrfgdLHrivGJEZFzSqtuGyE31U41P5c9x004
    lL82ia7gXONS+irVyBchBCFBFQKBgQDpvcOzkFeiI7txp7XhSgvQkUNDcKZBvfZc
    ryDqrK1cPvxnjgZyezZw72sA4KetZM2qZUuQuaMMzr4XtaqGyCcegWC9eeMUX0wV
    8mEggOiM8CxnEsEbMPGi6TnDUmVZRaCdZVIpMLJ8eVoUJ1BBww7PoC2x4DSA73Na
    bM8GknGa8QKBgQCBU/E6dHDmnRCthYWQtOqjRT78BZf39LLEtgMbMNF7sedbgzlN
    APW+5qtWscNZZw/3qpdHaHOTUPfrxUfzRmvluL44M8H9hKUSujCXmtDgb89Xw+yk
    7CDkEZhvfGX4XfrARoJDxhiRT40zFj6nhHtOnQWr31IOpsy+Lgf0qpHrrQKBgQCU
    E4HdSb4am6Rt9h9FIBGoCb6hBMZus5dVVCT4Rnh1Dfn86H6xG9l7ZlFVdv0C3e9k
    2VMr1k6zGG5Yut/TDw2pR7Evl/4Bs/WRmcFqRAAO+UBH9BudzD3oRPQxBwvpqDB+
    Refs7ErGjGJCjj1Ly/SgGAuaujzIyek8Cd6FfVS3IQKBgQCX0FOzJ+xE0VobMmkR
    diJmCpy7YSYI2p9cjYujYJMlbQ4NKYWJfs4xW7eIh07F0VxaJqF8rnMqw6Msu1V6
    aBfQ7QNIF/5q/0585ZeoQc79GqsWcchX04QJxlXxN8Vz9ZB6L0HknLKDgg+hf7fG
    RjW9tHC0HWYgDHG4PETPG8tzUA==
    -----END RSA PRIVATE KEY-----
    """
}
