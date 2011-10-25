require 'fileutils'
require 'httparty'
require 'open-uri'

class ScrnShots
  include HTTParty
  base_uri "http://scrnshots.com"

  def initialize(username)
    @username = username
  end

  def all
    page = 1

    while paths = screenshots_for_page(page)
      paths.each do |path|
        yield path
      end
      page += 1
    end
  end

  def screenshots_for_page(page)
    results = self.class.get("/users/#{@username}/screenshots.json?page=#{page}")
    if results.size > 0
      results.collect do |result|
        result["images"]["fullsize"]
      end
    else
      false
    end
  end

  module CLI

    def self.run(args)
      print_banner_and_exit unless args[0] && args[1]
      download(args[0], args[1])
    end

    def self.download(username, directory)
      FileUtils.mkdir_p(directory) unless File.exists?(directory)
      puts "Starting to download screenshots. This may take a while..."

      ScrnShots.new(username).all do |path|
        print(".")
        STDOUT.flush
        filename = File.basename(path)
        File.open(File.join(directory, filename), 'w+') do |f|
          open(path){|image| f << image.read }
        end
      end
    end

    def self.print_banner_and_exit
      puts "Usage: $ scrnshots USERNAME DIR"
      exit(1)
    end

  end

end

