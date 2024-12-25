class Admin::GroupsController < ApplicationController

  def show
    @group =Group.find(params[:id])
    @comments = @group.comments
  end
  
  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    @group.update(group_params)
    redirect_to admin_game_group_path(@group.game, @group)
  end

  private

  def group_params
    params.require(:group).permit(:title)
  end

end
