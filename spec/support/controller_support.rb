module ControllerSupport
  def response_json
    JSON.parse(response.body)
  end
end