Pod::Spec.new do |s|
  s.name             = 'VehicleID'
  s.version          = '0.1.0'
  s.summary          = 'Provides utilities to identify vehicles.'

  s.description      = <<-DESC
Provides a set of utilities to help identify a vehicle.
                       DESC

  s.homepage         = 'https://github.com/gpancio/VehicleID'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Graham Pancio' => 'gpancio@yahoo.com' }
  s.source           = { :git => 'https://github.com/gpancio/VehicleID.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'VehicleID/Classes/**/*'
  
  # s.resource_bundles = {
  #   'VehicleID' => ['VehicleID/Assets/*.png']
  # }

  s.dependency 'MBProgressHUD', '~> 0.9.2'
end
