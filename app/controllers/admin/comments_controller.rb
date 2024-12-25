class Admin::CommentsController < ApplicationController
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to admin_game_group_path(@comment.group.game, @comment.group), notice: 'コメントが削除されました'
  end
end
