class EventsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]
  before_action :set_event, only: [:show, :tagging]
  before_action :set_my_event, only: [:edit, :update, :destroy]
  before_action :set_event_entry, only: [:show]
  before_action :set_option_entries, only: [:show]
  before_action :set_tag, only: [:tagging]
  before_action :set_tagging, only: [:tagging]
  before_action :check_created_events_count, only: [:new, :create]

  def index
    @events = Event.related_events(current_user).order(id: :desc).page(params[:page])
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

  def tagging
    if @tagging
      @tagging.destroy
    else
      @tagging = Tagging.create(event: @event, tag: @tag)
    end
  end

  private
    def set_event
      @event = Event.find_by!(hash_id: params[:id])
    end

    def set_my_event
      @event = current_user.created_events.find(params[:id])
    end

    def set_event_entry
      @event_entry = EventEntry.find_or_initialize_by(event_id: @event, user_id: current_user) do |event_entry|
        event_entry.attributes = { event: @event, user: current_user }
      end
    end

    def set_option_entries
      @option_entries = OptionEntry.option_entries(@event.options, @event_entry)
    end

    def set_tag
      @tag = Tag.find(params[:tag_id])
    end

    def set_tagging
      @tagging = @event.taggings.find_by(tag: @tag)
    end

    def event_params
      params.require(:event).permit(:title, :memo, :options_text, options_deletes: [])
    end

    def check_created_events_count
      if current_user.created_events.count >= Settings.max_count.events
        redirect_to events_path, alert: "イベントは#{Settings.max_count.events}個までしか作成できません。"
      end
    end
end
