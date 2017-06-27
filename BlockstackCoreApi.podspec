#
# Be sure to run `pod lib lint BlockstackCoreApi.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'BlockstackCoreApi-iOS'
  s.version          = '0.1.1'
  s.summary          = 'A pod for interacting with blockstack core, core.blockstack.org'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
    This pod allows you to perform lookups against the blockstack core api from your mobile apps and to authorize your app to
    access user data from the blockstack platform
                       DESC

  s.homepage         = 'https://github.com/bedkin/BlockstackCoreApi'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Logan Sease' => 'logan@bedkin.com' }
  s.source           = { :git => 'https://github.com/bedkin/BlockstackCoreApi-iOS.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'

  s.source_files = 'BlockstackCoreApi/Classes/**/*'
  
  # s.resource_bundles = {
  #   'BlockstackCoreApi' => ['BlockstackCoreApi/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
