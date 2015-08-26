class EntriesController < ApplicationController
  before_action :set_event
  
  def create
    event_entry = @event.event_entries.build(entries_params)
    event_entry.user = current_user
    if event_entry.save
      flash[:notice] = "出欠を登録しました。"
      render js: "location.reload()"
    else
      flash[:error] = "出欠の登録に失敗しました。"
      render js: "location.reload()"
    end
  end

  def update
    event_entry = @event.event_entries.find_by(user_id: current_user)
    if event_entry.update(entries_params)
      flash[:notice] = "出欠を変更しました。"
      render js: "location.reload()"
    else
      flash[:error] = "出欠の変更に失敗しました。"
      render js: "location.reload()"
    end
 end

  def destroy
  end

  private
    def set_event
      @event = Event.find(params[:event_id])
    end

    def entries_params
      params.require(:event_entry).permit(:comment)
    end
end
