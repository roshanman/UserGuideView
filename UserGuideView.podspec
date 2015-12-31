Pod::Spec.new do |s|
  s.name          = "UserGuideView"
  s.version       = "0.9.0"
  s.summary       = "User guide view (write using siwft2)"
  s.homepage      = "https://github.com/Jameson-zxm/UserGuideView"
  s.license       = { :type => 'MIT', :file => 'LICENSE' }
  s.author        = { "Jameson-zxm" => "morenotepad@163.com" }
  s.platform      = :ios, '8.0'
  s.source        = { :git => "https://github.com/Jameson-zxm/UserGuideView.git", :tag => "v#{s.version}" }
  s.source_files  = 'Source', 'Source/**/*.{swift}'
  s.resources     = "Resource/UserGuideView.bundle"
  s.requires_arc  = true
end
