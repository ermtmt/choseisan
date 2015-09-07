class EventEntryController < ApplicationController
  before_action :set_event
  
  def create
    @event_entry = @event.event_entries.build
    @event_entry.user = current_user
    if EventEntryService.bulk_insert(@event_entry, entries_params)
      flash[:notice] = "出欠を登録しました。"
      render js: "location.reload()"
    else
      render :errors
    end
  end

  def update
    @event_entry = @event.event_entries.find_by(user_id: current_user)
    if EventEntryService.bulk_update(@event_entry, entries_params)
      flash[:notice] = "出欠を変更しました。"
      render js: "location.reload()"
    else
      render :errors
    end
 end

  def destroy
  end

  private
    def set_event
      @event = Event.find(params[:event_id])
    end

    def entries_params
      params.require(:event_entry).permit(:comment, feelings: [:option_id, :feeling])
    end
end
