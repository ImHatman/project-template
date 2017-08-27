source 'https://github.com/CocoaPods/Specs.git'

platform :ios, :deployment_target => "9.0"

workspace 'Kandu'

xcodeproj 'Kandu.xcodeproj'

inhibit_all_warnings!

def import_pods
    pod 'AFNetworking', '~> 2.0'
    pod 'SVProgressHUD', '1.1.3'
    pod 'SDWebImage', '~>3.8'
end

target :'Kandu-production' do
    xcodeproj 'Kandu.xcodeproj'
    import_pods
end

target :'Kandu-internal' do
    xcodeproj 'Kandu.xcodeproj'
    import_pods
end
