
FactoryGirl.define do
  factory :testimonial, :class => Refinery::Testimonials::Testimonial do
    sequence(:program) { |n| "refinery#{n}" }
  end
end

