class JobsConsumer < ApplicationConsumer
  def consume
    puts "consumed"

    raise Exception.new('error')
  end
end