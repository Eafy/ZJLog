Pod::Spec.new do |s|
  s.name         = "ZJLog"
  s.version      = "1.0.8"
  s.summary      = "Log redirection output tool for iOS, support for c、c++、m、mm code files."
  s.description  = <<-DESC
	Log redirection output tool for iOS, you can set the Log level, redirect output to the proxy interface, save logs to the sandbox, support for c、c++、m、mm code files, and more.
                   DESC
  s.homepage     = "https://github.com/Eafy/ZJLog.git"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "lzj" => "lizhijian_21@163.com" }
  s.source       = { :git => "https://github.com/Eafy/ZJLog.git", :tag => "#{s.version}" }
  s.platform     = :ios, "8.0"

  s.source_files = "ZJLog/ZJLog.h", "ZJLog/ZJLogBridgeOC.h", "ZJLog/ZJLogBridgeC.h", "ZJLog/ZJPrintfLog.h"
  s.public_header_files = "ZJLog/ZJLog.h", "ZJLog/ZJLogBridgeOC.h", "ZJLog/ZJLogBridgeC.h", "ZJLog/ZJPrintfLog.h"
  s.libraries = "c++"

  s.subspec 'ZJLog' do |ss|
    ss.source_files = "ZJLog/{ZJ}*.{h,m,mm,c}", "ZJLog/Singleton.h"
  end

end
