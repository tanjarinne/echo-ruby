require 'minitest/test_task'

Minitest::TestTask.create(:test) do |test|
  test.libs << 'test'
  test.libs << 'lib'
  test.warning = false
  test.test_globs = ["test/**/*_test.rb"]
end
