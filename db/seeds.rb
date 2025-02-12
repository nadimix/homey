# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Creating a super secure password for all users
password = BCrypt::Password.create("password")

# Creating default users
admin = Admin.find_or_create_by!(
  first_name: "Alice",
  last_name: "Admin",
  email: "alice.admin@example.com",
  password_digest: password
)

client = Client.find_or_create_by!(
  first_name: "Bob",
  last_name: "Client",
  email: "bob.client@example.com",
  password_digest: password
)

agent = Agent.find_or_create_by!(
  first_name: "Charlie",
  last_name: "Agent",
  email: "charlie.agent@example.com",
  password_digest: password
)

vendor = Vendor.find_or_create_by!(
  first_name: "David",
  last_name: "Vendor",
  email: "david.vendor@example.com",
  password_digest: password
)

# Creating default project
project = Project.create!(client: client, agent: agent, vendor: vendor)

# Creating default history entries for a natural timeline
history_entries = [
  { user: client, project: project, entry_type: 'comment', body: "Excited to start searching for my new home!" },
  { user: client, project: project, entry_type: "status_change", body: "shortlisted" },
  { user: agent, project: project, entry_type: 'comment', body: "Hey Bob, let me know if you need more details on the Clapham property." },
  { user: client, project: project, entry_type: "status_change", body: "virtual_viewing_scheduled" },
  { user: client, project: project, entry_type: 'comment', body: "Thanks, Charlie! I love the location. Any updates on the virtual viewing schedule?" },
  { user: agent, project: project, entry_type: 'comment', body: "The vendor confirmed availability for Saturday at 2 PM. Does that work for you?" },
  { user: client, project: project, entry_type: "status_change", body: "virtual_viewing_completed" },
  { user: agent, project: project, entry_type: "status_change", body: "in_person_viewing_scheduled" },
  { user: vendor, project: project, entry_type: 'comment', body: "Hope you like the place! Let me know if you have any questions." },
  { user: client, project: project, entry_type: "status_change", body: "in_person_viewing_completed" },
  { user: client, project: project, entry_type: "comment", body: "Loved the house! I'm ready to make an offer."},
  { user: client, project: project, entry_type: "status_change", body: "offer_submitted" },
  { user: vendor, project: project, entry_type: "status_change", body: "offer_accepted" },
  { user: client, project: project, entry_type: 'comment', body: "Thanks, David! Loved the house. Just waiting on legal checks now." },
  { user: admin, project: project, entry_type: "status_change", body: "mortgage_signed" },
  { user: admin, project: project, entry_type: 'comment', body: "All legal checks are cleared. You're good to go!" },
  { user: admin, project: project, entry_type: "status_change", body: "deposit_paid" },
  { user: client, project: project, entry_type: 'comment', body: "Awesome! Can’t wait to move in." },
  { user: admin, project: project, entry_type: "status_change", body: "legal_checks_completed" },
  { user: admin, project: project, entry_type: "comment", body: "All legal checks cleared. No flood zone, no title issues." },
  { user: client, project: project, entry_type: "status_change", body: "move_in_scheduled"},
  { user: client, project: project, entry_type: "status_change", body: "moved_in" },
  { user: client, project: project, entry_type: 'comment', body: "Just moved in today! The movers were great. Thanks, Homey team!" },
  { user: agent, project: project, entry_type: 'comment', body: "Congrats, Bob! Wishing you all the best in your new home." },
  { user: client, project: project, entry_type: 'comment', body: "Appreciate it, Charlie! By the way, how do I update my billing info for utilities?" },
  { user: client, project: project, entry_type: "status_change", body: "utilities_set_up"},
  { user: agent, project: project, entry_type: 'comment', body: "You can manage all utility payments through the Homey app." },
  { user: client, project: project, entry_type: 'comment', body: "Got it, thanks! Looking forward to setting up my smart home now." },
  { user: client, project: project, entry_type: 'comment', body: "Homey notified me of a better mortgage deal. Switching now!" },
  { user: client, project: project, entry_type: "status_change", body: "renewed" }
]

# Creating history entries in a natural order
history_entries.each do |entry|
  HistoryEntry.create!(entry)
end

project.renewed!

puts "✅ Seed data successfully created!"
