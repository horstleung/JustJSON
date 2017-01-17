Pod::Spec.new do |s|
  s.name = 'JustJson'
  s.version = '0.1.0'
  s.license = { :type => 'MIT', :file => 'LICENSE' }
  s.summary = 'JustJson is a simple project for handling JSON with keypaths. Copying the logic from https://oleb.net/blog/2017/01/dictionary-key-paths/'
  s.description      = <<-DESC
  SwiftyJSON is great but I want a lazy way to access the data. Ole Begemann gave a good example to make it.
                       DESC
  s.requires_arc = true
  s.homepage         = 'https://github.com/fattomhk/JustJson'
  s.authors = { 'PROJECT_OWNER' => 'fattomhk@gmail.com' }
  s.source = { :git => 'https://github.com/fattomhk/JustJson.git', :tag => s.version }
  s.ios.deployment_target = '8.0'
  s.source_files = 'Source/*.swift'
  s.pod_target_xcconfig =  {
        'SWIFT_VERSION' => '3.0',
  }
end
