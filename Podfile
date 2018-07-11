platform :ios, '11.0'
use_frameworks!
workspace 'instagram'

def default_pods
    pod 'InstagramKit'
    pod 'AlamofireImage'
end

target 'InstaPlay' do
    project 'InstaPlay'
    default_pods
end


post_install do
 puts 'tata'
    `sed -i -e 's/\[\[NSString\ alloc\]\ initWithString:info\[kFullName\]\]/(IKNotNull(info[kFullName])) ? [[NSString alloc] initWithString:info[kFullName]] : @""/g' Pods/InstagramKit/InstagramKit/Models/InstagramUser.m`
    `cat Pods/InstagramKit/InstagramKit/Models/InstagramUser.m`
end
