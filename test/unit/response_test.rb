require 'minitest/autorun'
require_relative "../../src/response"

RequestMock = Struct.new(:method,
                         :path,
                         :version,
                         :headers,
                         :data)

class ResponseTest < Minitest::Test

  def test_that_whitespace_is_preserved
    request = RequestMock.new("POST   ", "/   ", "VERSION", {'Test': '    test'}, " data")
    response = Response.new(request).gets
    assert_includes response, 'POST    /    VERSION'
    assert_includes response, 'Test:     test'
    assert_match /^ data$/, response
  end

end
