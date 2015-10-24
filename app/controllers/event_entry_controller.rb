class EventEntryController < ApplicationController
  before_action :set_event
  before_action :set_event_entry, only: [:update, :destroy]

  def create
    @event_entry = @event.event_entries.build(entries_params)
    @event_entry.user = current_user
    if @event_entry.save
      flash[:notice] = "出欠を登録しました。"
      render js: "location.reload()"
    else
      render :errors
    end
  end

  def update
    if @event_entry.update(entries_params)
      flash[:notice] = "出欠を変更しました。"
      render js: "location.reload()"
    else
      render :errors
    end
 end

  def destroy
    if @event_entry.destroy
      flash[:notice] = "出欠を削除しました。"
      render js: "location.reload()"
    else
      render :errors
    end
  end

  private
    def set_event
      @event = Event.find(params[:event_id])
    end

    def set_event_entry
      @event_entry = @event.event_entries.find_by(user_id: current_user)
    end

    def entries_params
      params.require(:event_entry).permit(:comment, feelings: [:option_id, :feeling])
    end
end
