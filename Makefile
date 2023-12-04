.PHONY: setup download-ruby-dependencies
create-release:
	echo '"bundle exec fastlane android create_new_release"' | xargs -L 1 -P 2 bash -c

setup:
	sudo gem install bundler && bundle install

download-ruby-dependencies:
	bundle check || bundle update && bundle install --path vendor/bundle
