class TagsController < ApplicationController
  before_action :set_tag, only: [:edit, :update, :destroy]
  before_action :check_tags_count, only: [:new, :create]

  def index
    @tags = current_user.tags.all
  end

  def new
    @tag = current_user.tags.build
  end

  def edit
  end

  def create
    # collection_radio_buttons を修正してこれで動くようにしたい
    # @tag = current_user.tags.build(tag_params)
    @tag = current_user.tags.build
    @tag.attributes = { label: tag_params[:label] }
    @tag[:color] = tag_params[:color]
    if @tag.save
      redirect_to tags_path, notice: 'タグを作成しました。'
    else
      render :new
    end
  end

  def update
    @tag.attributes = { label: tag_params[:label] }
    @tag[:color] = tag_params[:color]
    if @tag.save
      redirect_to tags_path, notice: 'タグを更新しました。'
    else
      render :edit
    end
  end

  def destroy
    @tag.destroy
    redirect_to tags_url, notice: 'タグを削除しました。'
  end

  private
    def set_tag
      @tag = Tag.find(params[:id])
    end

    def tag_params
      params.require(:tag).permit(:label, :color)
    end

    # insert実行も新規画面への進入も止める
    def check_tags_count
      if current_user.max_tags_created?
        redirect_to tags_path, alert: "タグは#{Settings.max_count.tags}つまでしか作成できません。"
      end
    end
end
