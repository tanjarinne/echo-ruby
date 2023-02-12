class Response
  @@code = 200
  @@headers = {
    'Content-Type': "text/plain",
    'Server': 'Echo',
  }

  def initialize(request)
    data = clean(<<~DATA
      #{request.method} #{request.path} #{request.version}
      #{request.headers.map{|e| e.join(': ') }.join("\r\n")}
      #{request.data}
    DATA
    )
    @@headers['Content-Length'] = data.bytesize.to_s
    @response = clean(<<~RESPONSE
      HTTP/1.1 #{@@code}
      #{@@headers.map{|e| e.join(': ')}.join("\r\n")}

      #{data}
    RESPONSE
    )
  end

  def gets()
    @response
  end

  private

  def clean(input)
    input.chomp.strip.gsub(/\n$/, "\r\n")
  end
end
