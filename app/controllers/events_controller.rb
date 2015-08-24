class EventsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]
  before_action :set_event, only: [:edit, :update, :destroy]

  helper_method :owner?

  def index
    @events = current_user.created_events.page(params[:page])
  end

  def show
    # ログインせずにアクセス可能なため
    @event = Event.find_by!(hash_id: params[:id])
  end

  def new
    @event = current_user.created_events.build
  end

  def edit
  end

  def create
    @event = current_user.created_events.build
    if EventService.bulk_insert(@event, event_params)
      redirect_to event_path(@event.hash_id), notice: 'イベントを作成しました。'
    else
      render :new
    end
  end

  def update
    if EventService.bulk_update(@event, event_params)
      redirect_to event_path(@event.hash_id), notice: 'イベント情報を変更しました。'
    else
      render :edit
    end
  end

  def destroy
    @event.destroy
    redirect_to events_url, notice: 'イベントを削除しました。'
  end

  def owner?
    return false if current_user.nil? || @event.nil?
    result = current_user.id == @event.owner.id
  end

  private
    def set_event
      @event = current_user.created_events.find(params[:id])
    end

    def event_params
      params.require(:event).permit(:title, :memo, :options_text, options_deletes: [])
    end
end
