# Homey - Project Conversation History

## Description
Welcome to the Homey Project Conversation History task. This is a simple Rails 8 application that allows users to view the conversation history of a project. The project has a status that can be changed by any user.

The conversation history updates in real-time using Hotwire and ActionCable. You can log in and test the application using pre-seeded users from different incognito sessions in your browser to observe real-time updates.

<img width="775" alt="Captura de pantalla 2025-02-17 a las 17 18 07" src="https://github.com/user-attachments/assets/9c9bd375-78b3-4e25-8d02-2613d98d88ec" />


## Pre-Seeded Users
The project includes four pre-seeded users with different roles for testing purposes:

### **Alice (Admin)**
- **Email:** `alice.admin@example.com`
- **Password:** `password`

### **Bob (Client)**
- **Email:** `bob.client@example.com`
- **Password:** `password`

### **Charlie (Agent)**
- **Email:** `charlie.agent@example.com`
- **Password:** `password`

### **David (Vendor)**
- **Email:** `david.vendor@example.com`
- **Password:** `password`

*Note: These passwords are for testing only and are not secure.*

## Questions to colleagues and to myself

### **Q: Is there a design for this task?**
A: No, there is no provided design.

### **Q: Does the conversation history need real-time updates?**
A: Yes, real-time updates are required. This is implemented using Hotwire and ActionCable.

### **Q: Should project status changes be restricted?**
A: No, all user types can change the project status to any option other than the current one.

### **Q: Do comments support rich text or attachments?**
A: No, only plain text comments are supported.

### **Q: Is pagination needed for the conversation history?**
A: No, pagination is not required at this stage.

### **Q: Is filtering needed for the conversation history?**
A: No, filtering is not required at this stage.

### **Q: Is sorting needed for the conversation history?**
A: No, sorting is not required at this stage.

### **Q: Can comments be edited or deleted?**
A: No, comments cannot be edited or deleted.

### **Q: What are the valid project status values?**
A: Based on the [Homey Playbook](https://allentities.notion.site/Homey-Playbook-Lite-c434d9c252004493aa5a7f8770c87e5a), the valid statuses are:
  - Searching
  - Shortlisted
  - Virtual Viewing
  - In-Person Meeting
  - Offer Submitted
  - Offer Accepted
  - Deposit Paid
  - Move-In Scheduled
  - Moved In
  - Utilities Set Up
  - Renewed

### **Q: Is full user authentication required?**
A: No, basic Rails 8 authentication with pre-seeded users is sufficient.

### **Q: Does the application need to support multiple projects?**
A: No, only one active project is supported at a time.

### **Q: Are multiple user roles required?**
A: Yes. The application includes four roles (`admin`, `agent`, `vendor`, and `client`), implemented using Single Table Inheritance (STI) through the `User` model.

### **Q: Should user permissions be role-based?**
A: No, all users can view all comments and change the project status.

## Technical Details

- **Ruby version:** 3.3.5
- **Rails version:** 8.0.1
- **Database:** SQLite3
- **Testing Framework:** RSpec
- **Frontend:** Hotwire, TailwindCSS, ViewComponent
- **Authentication:** [Rails 8 default authentication generator](https://youtu.be/4q1RWZABhKE?si=eEm3rF2B7gjH2qYQ)
- **Techniques Used:**
  - Single Table Inheritance (STI) for user roles.
  - ActionCable for real-time updates.
  - Hotwire for live updates.
  - ViewComponent for clean and maintainable UI components.
  - RSpec with FactoryBot for testing.
- **Deployment:** Kamal 2 on a DigitalOcean Droplet.

The application is designed to be secure against common vulnerabilities such as SQL Injection, Cross-Site Scripting (XSS), and Cross-Site Request Forgery (CSRF).

## Installation Instructions
1. Clone the repository.
2. Install Ruby 3.3.5 using asdf, rbenv, or rvm.
3. Run `bundle install` to install dependencies.
4. Set up the database:
   ```sh
   bin/rails db:create db:migrate db:seed
   ```

## Running the Application
1. Start the server:
   ```sh
   bin/dev
   ```
2. Open `http://localhost:3000` in your browser.

## Test it Out online
Visit: https://noonandthepencil.ink/

