# rails-karafka-docker

Steps to run:
* clone the repo
* run 
  ```
  docker-compose up
  ```
* send POST request to http://localhost:3102/perform
---

* expected:
   * "consumed" message is logged
   * error is thrown
* reality:
   * nothing is logged from consumer
   * no errors are thrown
---
the logs show successful posting message but not consuming:
```
rails-service_1  | Current leader for jobs/0 is node kafka:9092 (node_id=1001)
rails-service_1  | Sending 1 messages to kafka:9092 (node_id=1001)
rails-service_1  | [produce] Opening connection to kafka:9092 with client id client_id...
rails-service_1  | [produce] Sending produce API request 1 to kafka:9092
rails-service_1  | [produce] Waiting for response 1 from kafka:9092
rails-service_1  | [produce] Received response 1 from kafka:9092
rails-service_1  | Successfully appended 1 messages to jobs/0 on kafka:9092 (node_id=1001)
```
------
------
karafka setup is done here:

* [/rail-service/config/environment.rb](rails-service/config/environment.rb)
* [/rails-service/config/initializers/water_drop.rb](/rails-service/config/initializers/water_drop.rb)
* [/rails-service/app/consumers/application_consumer.rb](/rails-service/app/consumers/application_consumer.rb)
* [/rails-service/app/consumers/jobs_consumer.rb](/app/consumers/jobs_consumer.rb)
* [/rails-service/app/responders/application_responder.rb](/rails-service/app/responders/application_responder.rb) 
* [/rails-service/app/responders/jobs_responder.rb](/rails-service/app/responders/jobs_responder.rb)
* [/rails-service/karafka.rb](/rails-service/karafka.rb)

---
the way a message is posted to topic:
```
class PerformController < ApplicationController
  def create
    JobsResponder.call(params[:perform].to_json)

    :ok
  end
end
```
