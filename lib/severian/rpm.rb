
module Severian

  class RPM

    attr_accessor :name, :version, :release, :architecture, :install_date,
      :group, :size, :license, :signature, :source_rpm, :build_date,
      :build_host, :relocations, :packager, :vendor, :url, :summary,
      :description

    def self.extract(filepath)
      data = %x( rpm -qip #{filepath} )
      new(data)
    end

    def initialize(data)
      parse(data)
    end

    def parse(data)
      lines = data.split(/$/)
      lines.each_with_index do |line, i|
        if line =~ /^.*:.*$/
          field, value = line.split(":").map(&:strip)
          field = field.gsub(" ", "_").downcase.to_sym

          if field == :description
            self.description = lines[(i + 1)...-1].join
          elsif methods.include?(field)
            send("#{field}=", value)
          end
        end
      end
    end
  end
end