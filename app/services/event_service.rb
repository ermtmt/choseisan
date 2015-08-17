class EventService
  def self.bulk_save(event, params)
    raise TypeError unless event.is_a?(Event) || params.is_a?(Hash)
    Event.transaction do
      event.attributes = params.slice(:title, :memo)
      event.save
    end
  end
end
