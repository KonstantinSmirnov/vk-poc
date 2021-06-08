require "uri"
require "net/http"

class PagesController < ApplicationController
  def index
    @setting = Setting.first

    url_base = "https://oauth.vk.com/authorize"
    client_id = @setting.vk_app_id
    display = "page"
    redirect_uri = "https://warm-savannah-24055.herokuapp.com/"
    scope = "market"
    response_type = "code"
    api_version = @setting.vk_api_version

    full_url_request = url_base + "?client_id=" + client_id + "&display=" + display + "&redirect_uri=" + redirect_uri + "&scope=" + scope + "&response_type=" + response_type + "&v=" + api_version

    @authorize_url = full_url_request
  end

  # def authorize
  #   @setting = Setting.first
  #
  #   # https://oauth.vk.com/authorize?client_id=7838738&display=page&redirect_uri=https://smi.design/&scope=market&response_type=code&v=5.130"
  #   url_base = "https://oauth.vk.com/authorize"
  #   client_id = @setting.vk_app_id
  #   display = "page"
  #   redirect_uri = "https://smi.design/"
  #   scope = "market"
  #   response_type = "code"
  #   api_version = @setting.vk_api_version
  #
  #   full_url_request = url_base + "?client_id=" + client_id + "&display=" + display + "&redirect_uri=" + redirect_uri + "&scope=" + scope + "&response_type=" + response_type + "&v=" + api_version
  #
  #
  #
  #   if @response = HTTParty.get("https://oauth.vk.com/authorize?client_id=7838738&display=page&redirect_uri=https://smi.design/&scope=market&response_type=code&v=5.130")
  #     puts "!!!!!!!!!!!!"
  #     puts @response
  #     redirect_to root_path
  #   end


  #end
end
