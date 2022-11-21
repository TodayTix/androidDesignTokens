require "fileutils"

module Fastlane
  module Actions
    class GetVersionNameAction < Action
      def self.run(params)
        GetValueFromBuildAction.run(
          app_project_dir: params[:app_project_dir],
          key: "version"
        )
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Get the version name of your project"
      end

      def self.details
        [
          "This action will return the current version name set on your project's build.gradle.kts."
        ]
      end

      def self.available_options
        # Define all options your action supports. 
        
        # Below a few examples
        [
          FastlaneCore::ConfigItem.new(key: :app_project_dir,
                                    env_name: "ANDROID_VERSIONING_APP_PROJECT_DIR",
                                 description: "The path to the application source folder in the Android project (default: designTokens)",
                                    optional: true,
                                        type: String,
                               default_value: "designTokens")
        ]
      end

      def self.output
        # Define the shared values you are going to provide
        # Example
        [
          ['VERSION_NAME', 'The version name']
        ]
      end

      def self.is_supported?(platform)
        # you can do things like
        # 
        #  true
        # 
        #  platform == :ios
        # 
        #  [:ios, :mac].include?(platform)
        # 

        platform == :android
      end
    end
  end
end
