require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build(:user) }

  describe "validations" do
    context "when valid email formats" do
      let(:valid_emails) do
        [ "test@example.com", "user.name+tag@gmail.co.uk", "admin_123@sub.domain.io" ]
      end

      it "allows valid email addresses" do
        valid_emails.each do |valid_email|
          subject.email = valid_email
          expect(subject).to be_valid
        end
      end
    end

    context "when invalid email formats" do
      let(:invalid_emails) do
        [ "plainaddress", "missing@dotcom", "@missinguser.com", "user@.com", "user@com", "user@domain..com" ]
      end

      it "does not allow invalid email addresses" do
        invalid_emails.each do |invalid_email|
          subject.email = invalid_email
          expect(subject).to_not be_valid
        end
      end
    end

    context "when email is not unique" do
      let!(:user) { create(:user, email: "test@email.com") }

      it "does not allow duplicate email addresses" do
        new_user = build(:user, email: "TeSt@email.com")
        expect(new_user).to_not be_valid
      end
    end
  end

  describe "security against SQL Injection & XSS" do
    it "rejects SQL injection attempts" do
      sql_injection_attempts = [
        "test@example.com'; DROP TABLE users; --",
        "test@example.com' OR '1'='1",
        "test@example.com' UNION SELECT null, email FROM users --"
      ]

      sql_injection_attempts.each do |sql_email|
        user = build(:user, email: sql_email)
        expect(user).not_to be_valid, "Expected #{sql_email} to be invalid"
      end
    end

    it "rejects XSS attack attempts" do
      xss_attempts = [
        "test@example.com<script>alert('XSS')</script>",
        "test@example@com<img src=x onerror=alert('XSS')>",
        "test@example.com\" onmouseover=\"alert('XSS')\""
      ]

      xss_attempts.each do |xss_email|
        user = build(:user, email: xss_email)
        expect(user).not_to be_valid, "Expected #{xss_email} to be invalid"
      end
    end
  end
end
