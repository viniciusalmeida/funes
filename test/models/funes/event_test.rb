require "test_helper"
require "minitest/spec"

class Funes::EventTest < ActiveSupport::TestCase
  extend Minitest::Spec::DSL

  class DummyEvent < Funes::Event
    attribute :value, :integer
  end

  describe "#persisted?" do
    it "returns false for a new event" do
      event = DummyEvent.new(value: 42)

      refute event.persisted?
    end

    it "returns true when _event_entry is set" do
      event = DummyEvent.new(value: 42)
      event._event_entry = Funes::EventEntry.new

      assert event.persisted?
    end

    it "returns false when _event_entry is nil" do
      event = DummyEvent.new(value: 42)
      event._event_entry = nil

      refute event.persisted?
    end
  end
end
