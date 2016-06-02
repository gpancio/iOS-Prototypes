#
# Be sure to run `pod lib lint GPUIKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "GPUIKit"
  s.version          = "0.1.0"
  s.summary          = "Some basic UI elements."

  s.description      = <<-DESC
These are some basic UI elements I am prototyping.
                       DESC

  s.homepage         = "https://github.com/gpancio/GPUIKit"
  s.license          = 'MIT'
  s.author           = { "Graham Pancio" => "gpancio@yahoo.com" }
  s.source           = { :git => "https://github.com/gpancio/GPUIKit.git", :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'GPUIKit/Classes/**/*'
  s.resource_bundles = {
    'GPUIKit' => ['GPUIKit/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
