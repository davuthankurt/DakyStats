# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

use_frameworks!

inhibit_all_warnings!

workspace 'DakyStatsApp'

$Kingfisher =  pod 'Kingfisher'
$Alamofire =  pod 'Alamofire', '~> 5.4'
$SnapKit = pod 'SnapKit', '~> 5.7.0'
$FirebaseCore  = pod 'Firebase/Core'
$FirebaseDatabase  = pod 'Firebase/Database'
$FirebaseAuth = pod 'Firebase/Auth'

target 'DakyStatsApp' do
  
  project 'DakyStatsApp.xcodeproj'
  # Pods for DakyStatsApp
  $Kingfisher
  $SnapKit
  $FirebaseCore
  $FirebaseDatabase
  $FirebaseAuth

end

target 'StatsAPI' do
  project 'StatsAPI/StatsAPI.xcodeproj'
  
  $Alamofire
  
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
    end
  end
end
