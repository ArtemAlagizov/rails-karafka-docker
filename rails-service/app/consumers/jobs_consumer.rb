class JobsConsumer < ApplicationConsumer
  def consume
    puts "consumed"

    raise "error"
  end
end