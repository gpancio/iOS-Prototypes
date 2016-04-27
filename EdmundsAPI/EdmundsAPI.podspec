Pod::Spec.new do |s|
  s.name             = "EdmundsAPI"
  s.version          = "0.1.0"
  s.summary          = "Easy acccess to the Edmunds API."

  s.description      = <<-DESC
Wraps the Edmunds API to hopefully make it easy to use.
                       DESC

  s.homepage         = "https://github.com/gpancio/iOS-Prototypes"
  s.license          = 'MIT'
  s.author           = { "Graham Pancio" => "gpancio@yahoo.com" }
  s.source           = { :git => "https://github.com/gpancio/iOS-Prototypes", :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'

  s.source_files = 'EdmundsAPI/Classes/**/*'
  s.resource_bundles = {
    'EdmundsAPI' => ['EdmundsAPI/Assets/*.png']
  }

  s.dependency 'Alamofire', '~> 3.0'
  s.dependency 'SwiftyJSON'
  s.dependency 'AlamofireObjectMapper', '~> 2.1'

end
