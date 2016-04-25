Pod::Spec.new do |s|
	s.name = 'TimerScrollView'
	s.version = '1.0.0'
	s.summary = 'An easy way to archive scrollView for timer'
	s.homepage = 'https://github.com/qdz153642698/TimerScrollView.git'
	s.license = 'MIT'
	s.platform = :ios
	s.author = {'qdz153642698' => '15810695683@163.com'}
	s.ios.deployment_target = '8.0'
	s.source = {:git => 'https://github.com/qdz153642698/TimerScrollView.git',:tag => s.version}
	s.source_files = 'TimerScrollView/*.swift'
	s.requires_arc = true
	s.frameworks = 'UIKit'
end
