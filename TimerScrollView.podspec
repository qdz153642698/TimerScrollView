Pod::Spec.new do |s|
	s.name = 'TimerScrollView'
	s.version = '1.0.1'
	s.summary = 'An easy way to archive scrollView for timer'
	s.homepage = 'https://github.com/qdz153642698/TimerScrollView.git'
	s.license = 'MIT'
	s.platform = :ios
	s.author = {'qdz153642698' => '15810695683@163.com'}
	s.ios.deployment_target = '8.0'
	s.source = {:git => 'https://github.com/qdz153642698/TimerScrollView.git',:commit => '7771262fd504feca103d4743356aa1c3d1043b4a'}
	s.source_files = 'TimerScrollView/*.swift'
	s.requires_arc = true
	s.frameworks = 'UIKit'
end
