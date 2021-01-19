Pod::Spec.new do |s|
	s.name          = 'ToastUI'
	s.version       = '2.0.0'
	s.swift_version = '5.3'

	s.authors          = { 'Quan Tran' => 'quan@shousio.com' }
	s.social_media_url = 'https://quanshousio.com'
	s.license          = { :type => 'MIT', :file => 'LICENSE' }
	s.homepage         = 'https://github.com/quanshousio/ToastUI'
	s.source           = { :git => 'https://github.com/quanshousio/ToastUI.git', :tag => s.version.to_s }

	s.summary     = 'A simple way to show toast in SwiftUI.'
	s.description = 'ToastUI provides you a simple way to show toast, heads-up display (HUD), custom alert or any SwiftUI views on top of everything in SwiftUI.'

	s.ios.deployment_target  = '14.0'
	s.tvos.deployment_target = '14.0'
	s.osx.deployment_target  = '11.0'

	s.source_files = 'Sources/**/*.swift'
end
