class Admin::HeadwaresController < ApplicationController

  def index
    @headware = Headware.new
    @headwares = Headware.all
  end

  def create
    @headware = Headware.new(headware_params)
    @headware.save
    redirect_to admin_headwares_path
  end

  

  private

  def headware_params
    params.require(:headware).permit(:name)
  end

end
