Pod::Spec.new do |s|
  s.name             = "IdVerification365id"
  s.version          = "2.5.33"
  s.summary          = 'A Framework that enables the integration of id verification from 365id AB.'
  s.homepage         = 'http://www.365id.com/'
  s.license          = { :type => 'Copyright', :text => <<-LICENSE
                          Copyright 2025
                          All rights reserved by 365id AB.
                          LICENSE
                      }
  s.author           = { '365id' => 'support@365id.com' }
  s.source           = { :git => 'https://github.com/365id-AB/idverification-ios.git', :tag => s.version.to_s }

  s.ios.deployment_target = '15.0'
  s.swift_version = '5.3'

  s.ios.vendored_frameworks = 'IdVerification365id.xcframework'

  s.dependency "iProov", "12.2.2"
  s.dependency "MBCaptureCore", "1.4.3"

end
