class EventsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]
  before_action :set_event, only: [:show]
  before_action :set_my_event, only: [:edit, :update, :destroy]
  before_action :set_event_entry, only: [:show]

  helper_method :owner?, :entered?

  def index
    @events = Event.related_events(current_user).page(params[:page])
  end

  def show
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
    return false if !current_user || !@event
    current_user == @event.owner
  end

  def entered?
    current_user && @event.event_entries.exists?(user_id: current_user)
  end

  private
    def set_event
      @event = Event.find_by!(hash_id: params[:id]) # ログインレスでアクセス可能にするため
    end

    def set_my_event
      @event = current_user.created_events.find(params[:id])
    end

    def set_event_entry
      @event_entry = @event.event_entry(current_user)
    end

    def event_params
      params.require(:event).permit(:title, :memo, :options_text, options_deletes: [])
    end
end
