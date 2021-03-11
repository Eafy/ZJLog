Pod::Spec.new do |s|
  s.name         = "ZJLog"
  s.version      = "1.1.5"
  s.summary      = "Log redirection output tool for iOS, support for c、c++、m、mm code files."
  s.description  = <<-DESC
	Log redirection output tool for iOS, you can set the Log level, redirect output to the proxy interface, save logs to the sandbox, support for c、c++、m、mm code files, and more.
                   DESC
  s.homepage     = "https://github.com/Eafy/ZJLog"
  s.license      = { :type => "MIT" }
  s.author       = { "eafy" => "lizhijian_21@163.com" }
  s.source       = { :git => "https://github.com/Eafy/ZJLog.git", :tag => "#{s.version}" }
  s.platform     = :ios, "8.0"

  s.source_files = "ZJLog/**/*.{h,m,c,mm}"
  s.libraries = "c++"

end

#推送命令
#pod trunk push ZJLog.podspec --verbose --allow-warnings --use-libraries
