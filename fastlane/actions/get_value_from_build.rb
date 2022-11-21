require "fileutils"

module Fastlane
  module Actions
    class GetValueFromBuildAction < Action
      def self.run(params)
        app_project_dir ||= params[:app_project_dir]
        regex = Regexp.new(/(?<key>#{params[:key]})(?<middle>\s)(?<value>\S+)/)
        # (?<key>versionCode\s+)(?<left>[\'\"]?)(?<value>[a-zA-Z0-9\.\_]*)(?<right>[\'\"]?)(?<comment>.*)
        value = ""
        found = false
        Dir.glob("#{app_project_dir}/build.gradle") do |path|
          begin
            File.open(path, "r") do |file|
              file.each_line do |line|
                unless line.match(regex) and !found
                  next
                end
                key, middle, value = line.match(regex).captures
                break
              end
              file.close
            end
          end
        end
        return value.gsub '"', ''
      end

      #####################################################
      # @!group Documentation
      #####################################################

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
