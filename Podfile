platform :ios, '12.0'

source 'https://github.com/YabbiSDKTeam/CocoaPods'
source 'https://cdn.cocoapods.org/'

target 'Yabbi iOS Demo' do
  use_frameworks!
  pod 'YabbiAds'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['BUILD_LIBRARY_FOR_DISTRIBUTION'] = 'YES'
    end
  end
end

