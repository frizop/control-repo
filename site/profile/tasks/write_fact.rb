#!/opt/puppetlabs/puppet/bin/ruby
require 'json'
require 'open3'
require 'puppet'

def write_fact(key, value)
  begin
    # we should consider checking the directory exists
    stdout, _stderr, _status = Open3.capture3('facter', '-p', 'osfamily')
    osfamily = stdout.strip
    fact_location = if osfamily == 'windows'
        "C:\ProgramData\PuppetLabs\facter\facts.d\#{key}.txt"
    else
        "/opt/puppetlabs/facter/facts.d/#{key}.txt"
    end

    file = File.open("#{fact_location}", "w")
    file.write("#{key}=#{value}") 
  rescue IOError => e
    #some error occur, dir not writable etc.
  ensure
    file.close unless file.nil?
  end
end

params = JSON.parse(STDIN.read)
key = params['key']
value = params['value']

begin
  result = write_fact(key, value)
  puts result.to_json
  exit 0
rescue Puppet::Error => e
  puts({ status: 'failure', error: e.message }.to_json)
  exit 1
end
