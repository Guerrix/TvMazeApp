install! 'cocoapods', :generate_multiple_pod_projects => true
platform :ios, '15.0'

target 'TvMazeApp' do
  use_frameworks!

  # Storage
  pod 'RealmSwift', '~>10', :project_name => 'Storage'

  # Networking
  pod 'Alamofire', :project_name => 'Networking'
  pod 'Kingfisher', '~> 7.0', :project_name => 'Networking'

  # UI
  pod 'SnapKit', '~> 5.6.0', :project_name => 'UI'
  pod 'Reusable', :project_name => 'UI'

  # Rx
  pod 'RxSwift', :project_name => 'Rx'
  pod 'RxCocoa', :project_name => 'Rx'
  pod 'RxSwiftExt', :project_name => 'Rx'
  pod "RxRealm", :project_name => 'Rx'
  pod 'NSObject+Rx'

  # Utils
  pod 'ObjectMapper', :project_name => 'Utils'

end
