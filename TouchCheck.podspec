#
# Be sure to run `pod lib lint TouchCheck.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'TouchCheck'
  s.version          = '0.0.2'
  s.summary          = 'The easiest way to check interactive views and buttons are suitably sized.'
  s.description      = <<-DESC
  TouchCheck shows debug overlays on buttons and interactive views based on a typical finger size - it'll show green and red depending on if the view is big enough and avoids clashes with other touch areas.
                       DESC

  s.homepage         = 'https://github.com/rossbeale/TouchCheck'
  s.license          = { :type => 'MIT', :file => 'LICENSE.md' }
  s.author           = { 'rossbeale' => 'ross@rossbeale.com' }
  s.source           = { :git => 'https://github.com/rossbeale/TouchCheck.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/rossbeale'

  s.ios.deployment_target = '8.2'

  s.source_files = 'TouchCheck.swift'
end