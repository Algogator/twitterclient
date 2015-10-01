require 'jumpstart_auth'

class MicroBlogger
	attr_reader :client

  def run
    cmd = ""
    while cmd != 'q'
      puts "What do you want to do?"
      input = gets.chomp
      part = input.split(" ")
      cmd = part[0]

      case cmd
        when "quit" then break
        when "tweet" then tweet(part[1..-1].join(" "))
        when "@" then dm(part[1], part[2..-1].join(" "))
        when "search" then search(part[1])
        #when "f" then followers
        else puts "Error!!!"
      end
    end
  end

  def dm(user, msg)
    #followers = @client.followers.collect {|x| @client.user(x).screen_name}
    #if followers.include?(user)
      puts "Tweeting..."
      msg = "@#{user} #{msg}"
      tweet(msg)
    #else
    #  puts "Error!!!"
    #end
  end

  def search(search)
    @client.search("#{search}", :result_type => "recent").take(3).collect do |x| puts "#{x.user.screen_name}: #{x.text}"
    end
  end



	def initialize
		puts "Intialized"
    @client = JumpstartAuth.twitter
	end

  def tweet(msg)
    msg = msg [ 0..140 ]
    @client.update(msg)
  end
end

user = MicroBlogger.new
user.run
