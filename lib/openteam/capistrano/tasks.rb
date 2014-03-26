tasks_dir = File.expand_path("../tasks", __FILE__)
Dir.glob("#{tasks_dir}/*.rake").each { |r| load r }
