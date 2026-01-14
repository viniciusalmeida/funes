module Funes
  class EventEntry < ApplicationRecord
    self.table_name = "event_entries"

    def to_klass_instance
      event = klass.constantize.new(props.symbolize_keys)
      event._event_entry = self
      event
    end
  end
end
