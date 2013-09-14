# A script which uses the Mechanize gem to grab and trim HTML from our clickwebinar page.
# And yes, I do realize it's highly dependent on the current structure of the page,
# making maintanence necessary for future use.



require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'mechanize'

require 'active_record'
require 'pg'

# Change the following to reflect your database settings
#ActiveRecord::Base.establish_connection(
#  adapter:  'postgresql',
#  host:     'localhost',
#  database: 'my_dev_db',
#  username: 'gabriel',
#  password: ''
#)

# define the class
class Webinar < ActiveRecord::Base
  has_and_belongs_to_many :webinar_users
  attr_accessible :edit_url, :embed_url, :status, :title, :view_url

	def self.update_data
	  agent = Mechanize.new
    login_page = agent.get('https://panel.clickmeeting.com/conferences.html')

    loginform = login_page.form('loginForm')

    # loop through login fields, getting user input
    len = loginform.fields.length 
    len.times do |i|
      loginfield = loginform.fields[i].name
      puts "Please enter the following login info: " + loginfield
      loginvalue = gets.chomp  # You gotta chomp it, baby!  But seriously, for the newlines.
      loginform.set_fields({loginfield => loginvalue})
    end
  
    # submit login info, grab body from dashboard page
    dashboard_page = agent.submit(loginform, loginform.field_with(:value => 'Login'))
  
    html_text = ""
    # get the relevant rows
    rows_item = dashboard_page.search("table#conferencesListNew").search('tr')
    # convert to rows and trim header/footer
    rows = rows_item.to_a
    rows.delete_at(rows.length-1)
    rows.delete_at(0)

    @webinars = []
    @invites = []
    rows.each do |row|
      title = row.search("h5").text
      @webinars << title
      invites = []
  
      links = row.search('a')      
      invite_url = links[0]['href'] + "#invitationList"
      invite_page = agent.get(invite_url)
      invite_rows = invite_page.search("table#invitations_list").search('tr').to_a
      invite_rows.delete_at(invites.length-1)
      invite_rows.delete_at(0)
      invite_rows.each do | invite_row |
        invite_item = invite_row.search('td')[0]
        invite = invite_item.to_s
        invites << invite
        puts invite + "##########################################################################"
      end
      @invites << invites 
        
    end
    
    puts "the length of invites is:   " + @invites.length.to_s
    puts "the first member of index is:   " + @invites[0].to_s
    puts "the second member of index is:   " + @invites[1].to_s
    
    @webinars.each_with_index do | webinar, i| 
      x = Webinar.where(:title => webinar).first
      if x
        @invites[i].each do |invite|
          name = ActionView::Base.full_sanitizer.sanitize(invite.to_s).delete("\n")
          puts name + "we have the name once #################################"
          if !x.webinar_users.where(:username => name).first
            puts name + "we have the name twice #################################"
            y = WebinarUser.create!(:username => name, :email => name, :email_confirmation => name, :password => "password", :password_confirmation => "password")
            y.save!
            x.webinar_users << y
            x.save!
          end
        end
      else
        x = Webinar.create(:title => webinar)
        x.save!
        @invites[i].each do |invite|
          name = ActionView::Base.full_sanitizer.sanitize(invite.to_s).delete("\n")
          y = WebinarUser.create!(:username => name, :email => name, :email_confirmation => name, :password => "password", :password_confirmation => "password")
          y.save!
          x.webinar_users << y
          x.save!
        end
      end
    end
    
	end
	
  def self.users(title, invites)
    webs = []
    puts title
    invites.each do |invite|
      puts "  " + invite.search('td').to_a[0].text
    end
    w = Webinar.first
    #w = Webinar.where(:title => title)
    w
  end

  def self.utilize
    agent = Mechanize.new
    login_page = agent.get('https://panel.clickmeeting.com/conferences.html')

    loginform = login_page.form('loginForm')

    # loop through login fields, getting user input
    len = loginform.fields.length 
    len.times do |i|
      loginfield = loginform.fields[i].name
      puts "Please enter the following login info: " + loginfield
      loginvalue = gets.chomp  # You gotta chomp it, baby!  But seriously, for the newlines.
      loginform.set_fields({loginfield => loginvalue})
    end
  
    # submit login info, grab body from dashboard page
    dashboard_page = agent.submit(loginform, loginform.field_with(:value => 'Login'))
  
    html_text = ""
    # get the relevant rows
    rows_item = dashboard_page.search("table#conferencesListNew").search('tr')
    # convert to rows and trim header/footer
    rows = rows_item.to_a
    rows.delete_at(rows.length-1)
    rows.delete_at(0)

    @webs = []
    rows.each do |row|
      title = row.search("h5").text
      links = row.search('a')
      
      invite_url = links[0]['href'] + "#invitationList"
      invite_page = agent.get(invite_url)
      invites_item = invite_page.search("table#invitations_list").search('tr')
      invites = invites_item.to_a
      invites.delete_at(invites.length-1)
      invites.delete_at(0)

      @webs << users(title, invites)
      
    end
    return @webs
  end
  
  def test
    puts '4'
  end

  
end
