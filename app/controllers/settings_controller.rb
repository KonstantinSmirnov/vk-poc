class SettingsController < ApplicationController
  def new
    @setting = Setting.new
  end

  def show
    @setting = Setting.first
  end

  def create
    @setting = Setting.new(setting_params)

    if @setting.save
      redirect_to @setting,  notice: "Saved"
    else
      render :new
    end
  end

  def edit
    @setting = Setting.first
  end

  def update
   @setting = Setting.first

   if @setting.update(setting_params)
     redirect_to @setting,  notice: "Saved"
   else
     render :edit
   end
 end

  private
    def setting_params
      params.require(:setting).permit(:vk_app_id, :vk_app_secret, :vk_api_version, :vk_access_token, :vk_token_expires_in, :vk_user_id, :vk_community_selected_id)
    end

end
