Gem::Specification.new do |s|
  s.name        = 'boj'
  s.version     = '0.1'
  s.date        = '2024-02-19'
  s.summary     = 'boj automation'
  s.description = 'Baekjoon Online Judge Automation CLI'
  s.authors     = ["Seung Gyu Lee"]
  s.email       = 'winwing.you@gmail.com'
  s.files       = ['lib/boj/app.rb', 'lib/boj/domain.rb', 'lib/boj/fetcher.rb', 'lib/boj/parser.rb', 'lib/boj/testcase_io.rb', 'lib/boj/testcase_runner.rb', 'lib/boj/util.rb']
  s.executables << 'boj'
  s.homepage    = ''
  s.license     = 'MIT'
end
