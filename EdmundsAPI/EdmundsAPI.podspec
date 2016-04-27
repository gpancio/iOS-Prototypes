Pod::Spec.new do |s|
  s.name             = "EdmundsAPI"
  s.version          = "0.1.0"
  s.summary          = "Easy acccess to the Edmunds API."

  s.description      = <<-DESC
                       DESC

  s.homepage         = "https://github.com/<GITHUB_USERNAME>/EdmundsAPI"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Graham Pancio" => "gpancio@yahoo.com" }
  s.source           = { :git => "https://github.com/<GITHUB_USERNAME>/EdmundsAPI.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'EdmundsAPI/Classes/**/*'
  s.resource_bundles = {
    'EdmundsAPI' => ['EdmundsAPI/Assets/*.png']
  }

  s.dependency 'Alamofire', '~> 3.0'
  s.dependency 'SwiftyJSON'
  s.dependency 'AlamofireObjectMapper', '~> 2.1'

end
