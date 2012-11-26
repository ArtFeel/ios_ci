require "classes/base_command.rb"

class BuildCommand < BaseCommand

  # overriding base class methods
  def before_command
    "cd #{@params.source_root} && pod install" if cocoapods?
  end

  def main_command
     "cd #{@params.source_root} && xcodebuild #{build_args} -sdk #{@params.architecture} -configuration #{@params.configuration} clean build CONFIGURATION_BUILD_DIR=#{clean_dir}"
  end

  def after_command
  end

  # private methods
  private

  def build_args
    @params.target? ? "-target '#{@params.target}'" : 
      "-scheme '#{@params.scheme}' -workspace '#{@params.workspace}'"
  end

  def clean_dir
    "#{@params.source_root}/#{@params.build_path}/#{@params.configuration}-#{@params.architecture}"
  end

  def cocoapods?
    File.exist?("#{@params.source_root}/Podfile")
  end

end
