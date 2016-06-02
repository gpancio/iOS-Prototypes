Pod::Spec.new do |s|
  s.name             = 'GPPackageOptions'
  s.version          = '0.1.0'
  s.summary          = 'Select packages and options'

  s.description      = <<-DESC
A prototype allowing you to select packages and options.
                       DESC

  s.homepage         = 'https://github.com/gpancio/GPPackageOptions'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Graham Pancio' => 'gpancio@yahoo.com' }
  s.source           = { :git => 'https://github.com/gpancio/GPPackageOptions.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'GPPackageOptions/Classes/**/*'

  s.resources = ['GPPackageOptions/Classes/*.storyboard', 'GPPackageOptions/Assets/*.png']
  
  # s.resource_bundles = {
  #   'GPPackageOptions' => ['GPPackageOptions/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
