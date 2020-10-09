Pod::Spec.new do |s|
  s.name        = 'ToastUI'
  s.version     = '1.2.0'
  s.summary     = 'A simple way to show toast in SwiftUI.'
  s.description = 'ToastUI provides you a simple way to show toast, heads-up display (HUD), custom alert or any SwiftUI views on top of everything in SwiftUI.'

  s.homepage         = 'https://github.com/quanshousio/ToastUI.git'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Quan Tran' => 'quan@shousio.com' }
  s.source           = { :git => 'https://github.com/quanshousio/ToastUI.git', :tag => s.version.to_s }
  s.social_media_url = 'https://quanshousio.com'

  s.ios.deployment_target  = '13.0'
  s.tvos.deployment_target = '13.0'
  s.source_files           = 'Sources/**/*.swift'
  s.swift_version          = '5.1'
end
