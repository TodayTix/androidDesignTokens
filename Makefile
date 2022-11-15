create-release:
	echo '"bundle exec fastlane android create_new_release"' | xargs -L 1 -P 2 bash -c