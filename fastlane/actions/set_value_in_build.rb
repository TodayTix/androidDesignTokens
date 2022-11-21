require 'tempfile'
require 'fileutils'

module Fastlane
  module Actions
    class SetValueInBuildAction < Action
      def self.run(params)
        app_project_dir ||= params[:app_project_dir]
        key = params[:key]
        regex = Regexp.new(/(?<key>#{key})(?<middle>\s)(?<value>\S+)/)
        found = false
        Dir.glob("#{app_project_dir}/build.gradle") do |path|
          begin
            temp_file = Tempfile.new("versioning")
            File.open(path, "r") do |file|
              file.each_line do |line|
                unless line.match(regex) and !found
                  temp_file.puts line
                  next
                end
                line = line.gsub regex, "#{key}\\k<middle>#{params[:value]}"
                found = true
                temp_file.puts line
              end
              file.close    
            end
            temp_file.rewind
            temp_file.close
            FileUtils.mv(temp_file.path, path)
            temp_file.unlink
          end
        end
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Set the value of your project"
      end

      def self.details
        # Optional:
        # this is your chance to provide a more detailed description of this action
        "This action will set the value directly in build.gradle.kts."
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
                             default_value: "designTokens"),
          FastlaneCore::ConfigItem.new(key: :key,
                               description: "The property key",
                                      type: String),
          FastlaneCore::ConfigItem.new(key: :value,
                               description: "The property value",
                                      type: String)
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
