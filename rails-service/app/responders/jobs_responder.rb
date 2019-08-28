# frozen_string_literal: true

class JobsResponder < ApplicationResponder
  topic :jobs

  def respond(event_payload)
    respond_to :jobs, event_payload
  end
end
