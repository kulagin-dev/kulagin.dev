watch:
	@bundle exec foreman start

build:
	@bundle exec rake build:github

deploy:
	@bundle exec rake deploy:github
