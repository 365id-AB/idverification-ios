Pod::Spec.new do |s|
    s.name         = "IdVerification365id"
    s.version      = "0.0.1"
    s.summary      = "A Framework that enables the integration of id verification from 365id AB."
    s.description  = <<-DESC
    This framework enables an integrator to easily make use of the id verification offered by 365id, Please contact us for any questions.
    DESC
    s.homepage     = "http://www.365id.com/"
    s.license = { :type => 'Copyright', :text => <<-LICENSE
                   Copyright 2022
                   All rights reserved by 365id AB.
                  LICENSE
                }
    s.author             = { "365id" => "support@365id.com" }
    s.source       = { :git => 'https://github.com/365id-AB/idverification-ios.git' }

    s.ios.vendored_frameworks = 'IdVerification365id.framework'

    s.platform = :ios
    s.swift_version = "5.5.2"
    s.ios.deployment_target  = '14.0'
end


