class EventEntryService
  def self.bulk_insert(event_entry, params)
    raise TypeError unless event_entry.is_a?(EventEntry) || params.is_a?(Hash)
    status = true
    ActiveRecord::Base.transaction do
      event_entry.event.lock!

      # EventEntry
      event_entry.attributes = { comment: params[:comment] }
      unless event_entry.save
        status = false
        raise ActiveRecord::Rollback
      end

      # OptionEntry
      option_entries = []
      params[:feelings].each do |_, attrs|
        option_entry = event_entry.option_entries.build
        option_entry.option_id = attrs[:option_id]
        option_entry[:feeling] = attrs[:feeling]
        if option_entry.invalid?
          event_entry.errors[:base] << "回答の選択が不正です。"
          status = false
          raise ActiveRecord::Rollback
        end
        option_entries << option_entry
      end
      OptionEntry.import option_entries, validate: false
    end
    status
  end

  def self.bulk_update(event_entry, params)
    raise TypeError unless event_entry.is_a?(EventEntry) || params.is_a?(Hash)
    status = true
    ActiveRecord::Base.transaction do
      event_entry.event.lock!

      # EventEntry
      unless event_entry.update(comment: params[:comment])
        status = false
        raise ActiveRecord::Rollback
      end

      # OptionEntry
      params[:feelings].each do |option_entry_id, attrs|
        option_entry = event_entry.option_entries.find_or_initialize_by(id: option_entry_id) do |option_entry|
          option_entry.attributes = { id: nil, option_id: attrs[:option_id], event_entry_id: event_entry.id }
          option_entry[:feeling] = attrs[:feeling]
        end
        option_entry[:feeling] = attrs[:feeling]
        if option_entry.invalid?
          event_entry.errors[:base] << "回答の選択が不正です。"
          status = false
          raise ActiveRecord::Rollback
        end
        option_entry.save
      end
    end
    status
  end

  def self.bulk_delete(event_entry)
    raise TypeError unless event_entry.is_a?(EventEntry)
    status = true
    ActiveRecord::Base.transaction do
      event_entry.event.lock!

      # EventEntry & OptionEntry
      unless event_entry.destroy
        status = false
        raise ActiveRecord::Rollback
      end
    end
    status
  end
end
