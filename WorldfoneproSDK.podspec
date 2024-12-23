Pod::Spec.new do |s|
    s.name         = 'WorldfoneproSDK'
    s.version      = '1.0.0'
    s.summary      = 'WorldfoneproSDK sdk videocall southtelecom.'
    s.description  = <<-DESC
                     A longer description of WorldfoneproSDK.
                     DESC
    s.homepage     = 'https://your-homepage-url.com'
    s.license      = { :type => 'MIT', :file => 'LICENSE' }
    s.author       = { 'VuPhan' => 'phanvanvu.0313@gmail.com' }
    s.source       = { :git => 'https://github.com/phanvu0313/WorldfoneproSDK.git', :tag => s.version.to_s }
    s.platform     = :ios, '13.0'
    s.source_files  = 'WorldfoneproSDK/**/*.{swift,h,m}'
  end