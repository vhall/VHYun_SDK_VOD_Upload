Pod::Spec.new do |s|
  s.name            = "VHYun_Upload"
  s.version         = "2.1.0"
  s.author          = { "wangxiaoxiang" => "xiaoxiang.wang@vhall.com" }
  s.license         = { :type => "MIT", :file => "LICENSE" }
  s.homepage        = 'https://www.vhall.com'
  s.source          = { :git => "https://github.com/vhall/VHYun_SDK_VOD_Upload_iOS.git", :tag => s.version.to_s}
  s.summary         = "iOS VHYun_Upload framework"
  s.platform        = :ios, '9.0'
  s.requires_arc    = true
  #s.source_files    = ''
  s.frameworks      = 'Foundation'
  s.module_name     = 'VHYun_Upload'
  s.resources       = ['README.md']
  #s.resource_bundles= {}
  s.vendored_frameworks = 'VHYunFrameworks/VHUpload.framework'
  s.pod_target_xcconfig = {
    'FRAMEWORK_SEARCH_PATHS' => '$(inherited) $(PODS_ROOT)/**',
    'HEADER_SEARCH_PATHS' => '$(inherited) $(PODS_ROOT)/**',
    'VALID_ARCHS' => 'armv7 arm64 x86_64 i386',
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64'
  }

  s.dependency 'VHCore','>=2.0.3'
end
