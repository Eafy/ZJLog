Pod::Spec.new do |s|
  s.name         = "ZJLog"
  s.version      = "1.0.5"
  s.summary      = "Log redirection output tool for iOS."
  s.description  = <<-DESC
	Log redirection output tool for iOS, you can set the Log level, redirect output to the proxy interface, save logs to the sandbox, and more.
                   DESC
  s.homepage     = "https://github.com/Eafy/ZJLog.git"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "lzj" => "lizhijian_21@163.com" }
  s.source       = { :git => "https://github.com/Eafy/ZJLog.git", :tag => "#{s.version}" }
  s.platform     = :ios, "8.0"

  s.source_files = "ZJLog/ZJLog.h", "ZJLog/ZJLogBridgeOC.h", "ZJLog/ZJLogBridgeC.h"
  s.public_header_files = "ZJLog/ZJLog.h", "ZJLog/ZJLogBridgeOC.h", "ZJLog/ZJLogBridgeC.h"

  s.subspec 'ZJLog' do |ss|
    ss.source_files = "ZJLog/{ZJ}*.{h,m,mm,c}", "ZJLog/Singleton.h"
  end

end
