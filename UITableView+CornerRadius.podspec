#UITabelView+CornerRadius.podspec
Pod::Spec.new do |s|
  s.name         = "UITableView+CornerRadius"
  s.version      = "0.1"
  s.summary      = "快速给UITableView添加圆角样式"

  s.homepage     = "https://github.com/kirayamato1989/UITableView-CornerRadius"
  s.license      = 'MIT'
  s.author       = { "Kira Yamato" => "https://github.com/kirayamato1989" }
  s.platform     = :ios, "7.0"
  s.ios.deployment_target = "7.0"
  s.source       = { :git => "https://github.com/kirayamato1989/UITableView-CornerRadius.git", :tag => s.version}
  s.source_files  = 'UITableView+CornerRadius/*.{h,m}'
  s.requires_arc = true
end
