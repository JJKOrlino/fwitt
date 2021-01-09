#seed data

#2 users
harry = User.create(name: "harry", email: "harry@harry.com", password: "pass")
shelley = User.create(name: "shelley", email: "shelley@shelley.com", password: "pass")

#journal entries
JournalEntry.create(content: "Today is stressful", user_id: harry.id)

#AR to pre-associate data:
harry.journal_entries.create(content: "we are building with legos!")

shelley_entry = shelley.journal_entries.build(content: "Chik Fil A is amazing!")
shelley_entry.save