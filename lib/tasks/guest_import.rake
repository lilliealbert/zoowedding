desc "Import guests via CSV"
task :import,[:file] => :environment do |_, args|
  GuestImporter.new(args[:file]).import
end
