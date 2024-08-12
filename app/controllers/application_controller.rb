# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :basic_auth, if: :admin_url

  private
  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV['BASIC_AUTH_USER'] && password == ENV['BASIC_AUTH_PASSWORD']
    end
  end

  def admin_url
    request.fullpath.include?('/admin')
  end

end
