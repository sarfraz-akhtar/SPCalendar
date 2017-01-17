#
# Be sure to run `pod lib lint SPCalendar.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SPCalendar'
  s.version          = '0.1.0'
  s.summary          = 'SPCalendar is written in swift and provide functionality for schedulingPlus application.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
SPCalendar is written in swift. it will provide daily and weekly selection. ovverride default functionality using delegates.
                       DESC

  s.homepage         = 'https://github.com/sarfraz-akhtar01/SPCalendar'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'SPCalendar' => 'sarfraz.akhtar4@gmail.com' }
  s.source           = { :git => 'https://github.com/sarfraz-akhtar01/SPCalendar.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'SPCalendar/Classes/**/*'
  
  # s.resource_bundles = {
  #   'SPCalendar' => ['SPCalendar/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
