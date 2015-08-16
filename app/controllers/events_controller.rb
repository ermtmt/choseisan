class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  helper_method :owner?

  def index
    @events = current_user.created_events
  end

  def show
  end

  def new
    @event = current_user.created_events.build
  end

  def edit
  end

  def create
    @event = current_user.created_events.build(event_params)
    if @event.save
      redirect_to @event, notice: 'イベントを作成しました。'
    else
      render :new
    end
  end

  def update
    if @event.update(event_params)
      redirect_to @event, notice: 'イベント情報を変更しました。'
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
      params.require(:event).permit(:title, :memo)
    end
end
