class EventService
  def self.bulk_update(event, params)
    raise TypeError unless event.is_a?(Event) || params.is_a?(Hash)
    status = true
    ActiveRecord::Base.transaction do
      event.lock!

      # Event
      event.attributes = params.slice(:title, :memo, :options_deletes, :options_text)
      unless event.save
        status = false
        raise ActiveRecord::Rollback
      end

      # Option
      unless Option.destroy(params[:options_deletes].reject(&:blank?))
        event.errors[:base] << "候補日程の削除に失敗しました"
        status = false
        raise ActiveRecord::Rollback
      end
      unless self.add_options(event, params[:options_text])
        status = false
        raise ActiveRecord::Rollback
      end
    end
    return status
  end

  def self.bulk_delete(event)
    raise TypeError unless event.is_a?(Event)
    status = true
    ActiveRecord::Base.transaction do
      event.lock!

      # Event & Option
      unless event.destroy
        status = false
        raise ActiveRecord::Rollback
      end
    end
    return status
  end

  private
    def self.add_options(event, options_text)
      options = []
      options_text.each_line do |line|
        line.strip!
        option = event.options.build(event_id: event)
        option.text = line
        if option.invalid?
          event.errors.add(:options_text, "の各行#{option.errors.messages[:text].first}")
          return false
        end
        options << option
      end
      unless Option.import(options)
        return false
      end
      return true
    end
end
