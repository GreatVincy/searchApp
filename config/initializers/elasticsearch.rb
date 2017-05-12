begin
  file_handle = YAML.load(File.new("config/elasticsearch.yml"))
  hashes = file_handle.each {|value| value.inspect}
rescue
  Logger.new(STDOUT).info "No configuration for elasticsearch found in config/elasticsearch.yml - Using Elasticsearch::Client.new without parameters"
else
  hosts = Array.new
  hashes.each do |i, hash|
    host = { host: hash['host'],
          port: hash['port'],
        }

    host[:host] ||= 'localhost'
    host[:port] ||= 9200

    hosts << host
  end

ensure
  Elasticsearch::Model.client = Elasticsearch::Client.new hosts: hosts
end

