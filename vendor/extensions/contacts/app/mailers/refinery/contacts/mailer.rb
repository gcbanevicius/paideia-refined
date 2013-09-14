module Refinery
  module Contacts
    class Mailer < ActionMailer::Base

      def confirmation(contact, request)
        @contact = contact
        mail :subject  => Refinery::Contacts::Setting.confirmation_subject,
             :to       => contact.email,
             :from     => "\"#{Refinery::Core.site_name}\" <no-reply@#{request.domain}>",
             :reply_to => Refinery::Contacts::Setting.notification_recipients.split(',').first
      end

      def notification(contact, request)
        @contact = contact
        mail :subject  => Refinery::Contacts::Setting.notification_subject,
             :to       => Refinery::Contacts::Setting.notification_recipients,
             :from     => "\"#{Refinery::Core.site_name}\" <no-reply@#{request.domain}>"
      end

    end
  end
end
