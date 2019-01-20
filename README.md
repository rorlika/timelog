Timelog
======


Installation
-----------------
### Installing PostgreSQL ubuntu 18.04

```
 sudo apt update
 sudo apt install postgresql postgresql-contrib
```
### Install ruby 2.4.5
```
sudo apt-get install libgdbm-dev libncurses5-dev automake libtool bison libffi-dev
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
curl -sSL https://get.rvm.io | bash -s stable
source ~/.rvm/scripts/rvm
rvm install 2.4.5
rvm use 2.4.5
gem install bundler
```
#### Clone project
```
 git clone git@github.com:rorlika/timelog.git
 cd timelog
```
#### Install dependencies
```
 bundle install
```
#### Run migrations
```
 rake db:migrate
```

#### Run seed
```
 rake db:seed
```

#### Run server
```
 rails s
```

### Test app
```
# get access_token
curl -X POST \
  http://localhost:3000/auth/login \
  -H 'Content-Type: application/json' \
  -d '{ "email": "testuser@test.com", "password": "12345" }'
  
# add timelog
curl -X POST \
  http://localhost:3000/log/create \
  -H 'Authorization: eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1NDgwMjI4NDh9.EEfAO0OFNoZzbcW4lVE-Ly882rnwH75wBuzwChjyHIs' \
  -H 'Content-Type: application/json' \
  -d '{ "project_id": "1", "hours": 2, "log_date": "2019-01-20 11:00" }'
  
# get reports
curl -X GET \
  'http://localhost:3000/reports?project_id=1' \
  -H 'Authorization: eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE1NDgwNjI2ODB9.EBHJmx-Cob9eZhZV9HNIpQKhyEjceZrhl-_A2GlhhMY' \
  -H 'Content-Type: application/json'
```

## Requirements 
* rails version >= 5.0.7
* ruby version >=  2.4.5
* postgresql 


