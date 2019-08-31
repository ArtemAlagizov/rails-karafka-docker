# rails-karafka-docker

[karafka-issue](https://github.com/karafka/karafka/issues/541)

Steps to run:
* clone the repo
* run 
  ```
  docker-compose up
  ```
* send POST request to http://localhost:3102/perform with the following body:
  ```
  {
	  "perform": {
		  "job_id": 4
	  }
  }
  ```
---

* expected:
   * "consumed" message is logged
   * error is thrown
------
------
karafka setup is done here:

* [/rail-service/config/environment.rb](rails-service/config/environment.rb)
* [/rails-service/config/initializers/water_drop.rb](/rails-service/config/initializers/water_drop.rb)
* [/rails-service/app/consumers/application_consumer.rb](/rails-service/app/consumers/application_consumer.rb)
* [/rails-service/app/consumers/jobs_consumer.rb](/rails-service/app/consumers/jobs_consumer.rb)
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
