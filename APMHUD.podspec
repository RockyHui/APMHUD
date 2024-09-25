Pod::Spec.new do |s|
  s.name         = 'APMHUD'
  s.version      = '1.0.0'
  s.summary      = '监控应用的运行时硬件性能指标，包括内存占用、CPU占比、屏幕刷新率。'
  s.description  = <<-DESC
                   APMHUD（Application Performance Monitor）实时监控应用的运行性能指标，包括内存占用、CPU占比、屏幕刷新率，以HUD的形式显示在屏幕上方，帮助开发者及时发现性能问题。
                   DESC
  s.homepage     = 'https://github.com/RockyHui/APMHUD'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { 'RockyHui' => 'linchaohuirocky@gmail.com' }
  s.source       = { :git => 'https://github.com/RockyHui/APMHUD.git', :tag => s.version.to_s }
  s.source_files = 'Classes/*'
  s.platform     = :ios, '11.0'
  s.swift_version = '4.2', '5.0'
end
