class Public::CommentsController < ApplicationController
  before_action :set_group
  before_action :set_comment, only: [:edit, :update, :destroy]
  before_action :restrict_guest_user, only: [:create, :update, :destroy]


  def create
    @comment = @group.comments.new(comment_params)
    @comment.user = current_user
    if @comment.save
      respond_to do |format|
        format.html { redirect_to game_group_path(@group.game, @group), notice: 'コメントを投稿しました。' }
        format.js   # create.js.erb に処理を渡す
      end
    else
      respond_to do |format|
        format.html { redirect_to game_group_path(@group.game, @group), alert: 'コメント投稿に失敗しました。' }
        format.js   # エラーを表示するJSを記述する場合
      end
    end
  end

  def edit
    @comment = @group.comments.find(params[:id])
  end

  def update
    if @comment.update(comment_params)
      respond_to do |format|
        format.html { redirect_to game_group_path(@group.game, @group), notice: 'コメントを更新しました。' }
        format.js   # update.js.erb に処理を渡す
      end
    else
      respond_to do |format|
        format.html { redirect_to game_group_path(@group.game, @group), alert: 'コメントの更新に失敗しました。' }
        format.js   # エラー処理などを表示するJSを記述する場合
      end
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to game_group_path(@group.game, @group), notice: 'コメントを削除しました。' }
      format.js   # destroy.js.erb に処理を渡す
    end
  end

  private

  def restrict_guest_user
    if current_user.guest?
      redirect_to root_path, alert: 'ゲストユーザーはこの操作を行えません。'
    end
  end

  def set_group
    @group = Group.find(params[:group_id])
  end

  def set_comment
    @comment = @group.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
