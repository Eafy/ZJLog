Pod::Spec.new do |s|
  s.name         = "ZJLog"
  s.version      = "1.2.3"
  s.summary      = "Log redirection output tool for iOS, support for c、c++、m、mm code files."
  s.description  = <<-DESC
	Log redirection output tool for iOS, you can set the Log level, redirect output to the proxy interface, save logs to the sandbox, support for c、c++、m、mm code files, and more.
                   DESC
  s.homepage     = "https://github.com/Eafy/ZJLog"
  s.license      = { :type => "MIT" }
  s.author       = { "eafy" => "lizhijian_21@163.com" }
  s.source       = { :git => "https://github.com/Eafy/ZJLog.git", :tag => "v#{s.version}" }
  s.platform     = :ios, "11.0"
  s.pod_target_xcconfig = {
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64',
    'EXCLUDED_ARCHS[sdk=iphoneos*]' => 'armv7s armv7'
  }
  s.user_target_xcconfig = {
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64',
    'EXCLUDED_ARCHS[sdk=iphoneos*]' => 'armv7s armv7'
  }

  s.source_files = "ZJLog/**/*.{h,m,c,mm}"
  s.libraries = "c++"

end

#推送命令
#pod trunk push ZJLog.podspec --verbose --allow-warnings --use-libraries
