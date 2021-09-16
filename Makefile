include .env

start:
	PORT=${PORT} ruby app/application.rb

install:
	bundle install
