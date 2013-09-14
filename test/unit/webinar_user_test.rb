require 'test_helper'
#require File.dirname(__FILE__) + '/test_helper.rb'


class WebinarUserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
#class WebinarUserTest < Test::Unit::TestCase
  self.use_instantiated_fixtures  = true
  fixtures :webinar_users

  def test_auth 
    #check that we can username we a valid WebinarUser 
    assert_equal  @bob, WebinarUser.authenticate("bob", "test")    
    #wrong WebinarUsername
    assert_nil    WebinarUser.authenticate("nonbob", "test")
    #wrong password
    assert_nil    WebinarUser.authenticate("bob", "wrongpass")
    #wrong username and pass
    assert_nil    WebinarUser.authenticate("nonbob", "wrongpass")
  end


  def test_passwordchange
    # check success
    assert_equal @longbob, WebinarUser.authenticate("longbob", "longtest")
    #change password
    @longbob.password = @longbob.password_confirmation = "nonbobpasswd"
    @longbob.email_confirmation = @longbob.email
    assert @longbob.save!
    #new password works
    assert_equal @longbob, WebinarUser.authenticate("longbob", "nonbobpasswd")
    #old pasword doesn't work anymore
    assert_nil   WebinarUser.authenticate("longbob", "longtest")
    #change back again
    @longbob.password = @longbob.password_confirmation = "longtest"
    @longbob.email_confirmation = @longbob.email
    assert @longbob.save!
    assert_equal @longbob, WebinarUser.authenticate("longbob", "longtest")
    assert_nil   WebinarUser.authenticate("longbob", "nonbobpasswd")
  end

  def test_disallowed_passwords
    #check thaat we can't create a WebinarUser with any of the disallowed paswords
    u = WebinarUser.new    
    u.username = "nonbob"
    u.email = "nonbob@mcbob.com"
    #too short
    u.password = u.password_confirmation = "tiny" 
    u.email_confirmation = u.email
    assert !u.save
    assert !u.valid?  #u.errors.invalid?('password')
    #too long
    u.password = u.password_confirmation = "hugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehugehuge"
    u.email_confirmation = u.email
    assert !u.save     
    assert !u.valid? #u.errors.invalid?('password')
    #empty
    u.password = u.password_confirmation = ""
    u.email_confirmation = u.email
    assert !u.save    
    assert !u.valid?# u.errors.invalid?('password')
    #ok
    u.password = u.password_confirmation = "bobs_secure_password"
    u.email_confirmation = u.email
    assert u.save!     
    assert u.errors.empty? 
  end

  def test_bad_usernames
    #check we cant create a WebinarUser with an invalid WebinarUsername
    u = WebinarUser.new  
    u.password = u.password_confirmation = "bobs_secure_password"
    u.email = "okbob@mcbob.com"
    #too short
    u.username = "x"
    u.email_confirmation = u.email
    assert !u.save     
    assert !u.valid? #u.errors.invalid?('username')
    #too long
    u.username = "hugebobhugebobhugebobhugebobhugebobhugebobhugebobhugebobhugebobhugebobhugebobhugebobhugebobhugebobhugebobhugebobhugebobhugebobhugebobhugebobhugebobhugebobhugebobhugebobhugebobhugebobhug"
    assert !u.save   
    assert !u.valid? #u.errors.invalid?('username')
    #empty
    u.username = ""
    assert !u.save
    assert !u.valid? #u.errors.invalid?('username')
    #ok
    u.username = "okbob"
    assert u.save
    assert u.errors.empty?
    #no email
    u.email=nil   
    assert !u.save     
    assert !u.valid? #u.errors.invalid?('email')
    #invalid email
    u.email='notavalidemail'   
    assert !u.save 
    assert !u.valid? #u.errors.invalid?('email')
    #ok
    u.email="validbob@mcbob.com"
    u.email_confirmation = u.email
    assert u.save!  
    assert u.errors.empty?
  end


  def test_collision
    #check can't create new WebinarUser with existing WebinarUsername
    u = WebinarUser.new
    u.username = "existingbob"
    u.password = u.password_confirmation = "bobs_secure_password"
    u.email = "tryingnametwice@mcbob.com"
    u.email_confirmation = u.email
    assert !u.save
  end


  def test_create
    #check create works and we can authenticate after creation
    u = WebinarUser.new
    u.username = "nonexistingbob"
    u.password = u.password_confirmation = "bobs_secure_password"
    u.email="nonexistingbob@mcbob.com"  
    assert_not_nil u.salt
    u.email_confirmation = u.email
    assert u.save!
    assert_equal 10, u.salt.length
    assert_equal u, WebinarUser.authenticate(u.username, u.password)

    u = WebinarUser.new(:username => "newbob", :password => "newpassword", :password_confirmation => "newpassword", :email => "newbob@mcbob.com" )
    assert_not_nil u.salt
    assert_not_nil u.password
    assert_not_nil u.hashed_password
    u.email_confirmation = u.email
    assert u.save! 
    assert_equal u, WebinarUser.authenticate(u.username, u.password)

  end

  def test_send_new_password
    #check WebinarUser authenticates
    assert_equal  @bob, WebinarUser.authenticate("bob", "test")    
    #send new password
    sent = @bob.new_password
    assert_not_nil sent
    @bob.email_confirmation = @bob.email
    @bob.save!
    #old password no longer works
    assert_nil WebinarUser.authenticate("bob", "test")
    #email sent...
    #assert_equal "Your password is ...", sent.subject
    #... to bob
    #assert_equal @bob.email, sent.to[0]
    #assert_match Regexp.new("Your WebinarUsername is bob."), sent.body
    #can authenticate with the new password
    #new_pass = $1 if Regexp.new("Your new password is (\\w+).") =~ sent.body 
    #assert_not_nil new_pass
    assert_equal  @bob, WebinarUser.authenticate("bob", sent)    
  end

  def test_rand_str
    new_pass = WebinarUser.randomize_string(10)
    assert_not_nil new_pass
    assert_equal 10, new_pass.length
  end

  def test_sha1
    u=WebinarUser.new
    u.username      = "nonexistingbob"
    u.email="nonexistingbob@mcbob.com"  
    u.salt="1000"
    u.password = u.password_confirmation = "bobs_secure_password"
    u.email_confirmation = u.email
    assert u.save!   
    assert_equal 'b1d27036d59f9499d403f90e0bcf43281adaa844', u.hashed_password
    assert_equal 'b1d27036d59f9499d403f90e0bcf43281adaa844', WebinarUser.encrypt("bobs_secure_password", "1000")
  end

  def test_protected_attributes
    #check attributes are protected
    
   begin
    u = WebinarUser.new(:username => "badbob", :password => "newpassword", :password_confirmation => "newpassword", :email => "badbob@mcbob.com" )
    u.email_confirmation = u.email
    assert_nil u.update_attributes(:id=>999999, :salt=>"I-want-to-set-my-salt")
    assert u.save!
    assert_not_equal 999999, u.id
    assert_not_equal "I-want-to-set-my-salt", u.salt
    
    rescue ActiveModel::MassAssignmentSecurity::Error, Exception => e
      puts ""
      puts "Problem with your record..."
      puts e.message
   end

   begin
    u.update_attributes(:id=>999999, :salt=>"I-want-to-set-my-salt", :username => "verybadbob")
    assert u.save!
    assert_not_equal 999999, u.id
    assert_not_equal "I-want-to-set-my-salt", u.salt
    assert_equal "verybadbob", u.username
    
    rescue ActiveModel::MassAssignmentSecurity::Error, Exception => e
      puts ""
      puts "Problem with your record..."
      puts e.message
   end
  end
  
end
