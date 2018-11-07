# frozen_string_literal: true

class ServicesBase
  attr_accessor :success, :result

  class << self
    def run(*args)
      new(*args).perform
    end
  end

  def perform
    @result = perform!
    @success = @result.try(:errors).to_a.empty?
    self
  end

  def success?
    !!@success
  end
end
