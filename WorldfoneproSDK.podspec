Pod::Spec.new do |s|
    s.name         = 'WorldfoneproSDK'
    s.version      = '1.0.2'
    s.summary      = 'WorldfoneproSDK sdk videocall southtelecom.'
    s.description = "WorldfoneproSDK is a comprehensive framework for managing voice and video calls with seamless integration for iOS applications."
    s.homepage     = 'https://southtelecom.vn'
    s.swift_versions = '5.0'
    s.license = { :type => 'MIT', :file => 'LICENSE' }
    s.author       = { 'VuPhan' => 'phanvanvu.0313@gmail.com' }
    s.source = { :git => 'https://github.com/phanvu0313/WorldfoneproSDK.git', :tag => '1.0.2' }
    s.platform     = :ios, '13.0'
    s.source_files  = 'WorldfoneproSDK/**/*.{swift,h,m}'
  end