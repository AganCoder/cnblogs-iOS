# Uncomment the next line to define a global platform for your project
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'

inhibit_all_warnings!
use_frameworks!

workspace 'iCnblogs.xcworkspace'

def workspace_pods
	pod 'Alamofire'
  pod 'Hero'
end

def login
  pod "PromiseKit"
  pod 'PKHUD', '~> 5.0'
end


target 'CNBlog' do
  workspace_pods
 
end

target 'CnBlogs-iOS' do

  login
  workspace_pods


  # Pods for CnBlogs-iOS

end


