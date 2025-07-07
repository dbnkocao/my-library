puts 'Cleaning up database...'
system 'rails db:truncate_all'

puts 'Creating default user and library...'
User.create!([
  { email_address: "user@email.com", password_digest: "$2a$12$rypFL/ohuRKmlLpAWp0gHOQVDwZzgmX8/yE9F8txZcfaQEsZwoHxy" }
])
Library.create!([
  { user: User.last }
])
library = Library.last
isbns = [ "6580309318", "9786584956230", "8550801488", "8532530788", "9788575422397" ]
isbns.each do |isbn|
  puts "Creating book with ISBN: #{isbn}"
  result = CreateBookByIsbnService.call(isbn: isbn)
end

Book.all.each do |book|
  puts "Adding book '#{book.title}' to library"
  library.books << book
end
