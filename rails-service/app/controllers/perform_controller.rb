# frozen_string_literal: true

class PerformController < ApplicationController
  def create
    JobsResponder.call(params[:perform].to_json)

    :ok
  end
end
