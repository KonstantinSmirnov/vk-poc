require "uri"
require "net/http"

class PagesController < ApplicationController
  def index
    @setting = Setting.first

    build_authorize_url if @setting
  end

  def build_authorize_url
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

  def authorize
    @setting = Setting.first

    client_id = @setting.vk_app_id
    client_secret = @setting.vk_app_secret
    redirect_uri = "https://warm-savannah-24055.herokuapp.com/"

    @complete_authorization_url = "https://oauth.vk.com/access_token" + "?client_id=" + client_id + "&client_secret=" + client_secret + "&redirect_uri=" + redirect_uri + "&code=" + params[:code]

    if @response = HTTParty.get(@complete_authorization_url)
      @setting.vk_access_token = @response["access_token"]
      @setting.save!

      redirect_to root_path,  notice: "Получили ответ от VK с токеном: #{@response}. Сохраняем токен! #{@response["access_token"]}"
    end
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
