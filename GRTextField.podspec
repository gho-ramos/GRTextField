#
# Be sure to run `pod lib lint GRTextField.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'GRTextField'
  s.version          = '1.0.3'
  s.summary          = 'Customizable TextField'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
A customizable TextField in OBJC with possibility of attaching own error labels and custom colors to its own validation
                       DESC

  s.homepage         = 'https://github.com/gho-ramos/GRTextField'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Pogramos' => 'pogramoss@gmail.com' }
  s.source           = { :git => 'https://github.com/gho-ramos/GRTextField.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/pogramos'

  s.ios.deployment_target = '8.0'

  s.source_files = 'GRTextField/Classes/**/*', 'GRTextField/Extensions/**/*', 'GRTextField/Protocols/**/*'

  # s.resource_bundles = {
  #   'GRTextField' => ['GRTextField/Assets/**/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
