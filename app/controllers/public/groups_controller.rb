class Public::GroupsController < ApplicationController
  before_action :set_game
  before_action :set_group, only: [:show, :join, :leave]

  def new
    @group = @game.groups.new
  end

  def create
    @group = @game.groups.new(group_params)
    # cerator_idにcurrent_user.idを登録する手順
    @group.creator_id = current_user.id

    if @group.save
      redirect_to game_group_path(@game, @group), notice: 'グループを作成しました。'
    else
      render :new, alert: 'グループ作成に失敗しました。'
    end
  end

  def show
  end

  def join
    if @group.users.include?(current_user)
      redirect_to game_group_path(@game, @group), alert: '既にこのグループに参加しています。'
    else
      @group_membership = GroupMembership.new(user: current_user, group: @group)
      
      if @group_membership.save
        redirect_to game_group_path(@game, @group), notice: 'グループに参加しました。'
      else
        # 参加できなかった場合game/showページに遷移する
        redirect_to game_path(@game), alert: 'グループ参加に失敗しました。'
      end
    end
  end

  def leave
    if @group.users.include?(current_user)
      @group_membership = @group.group_memberships.find_by(user: current_user)
      @group_membership.destroy

      # 退出後はgame/showページに遷移
      redirect_to game_path(@game), notice: 'グループから退出しました。'
    else
      # 参加していない時はgroup内は見れないようにするつもりだが万が一この処理が行われてしまった時(多分処理が終わる前にもう一度退出を押した時など)はgames/showページへ
      redirect_to game_path(@game), alert: 'このグループに参加していません。'
    end
  end

  private

  def set_game
    @game = Game.find(params[:game_id])
  end

  def set_group
    @group = @game.groups.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:title)
  end

end
