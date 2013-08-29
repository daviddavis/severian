module Severian

  class RPM
    SEPARATOR = '---severian---'

    ATTRIBUTES = [:name, :version, :release, :arch, :install_time, :group,
                  :size, :license, :source_rpm, :build_time, :build_host,
                  :packager, :vendor, :url, :summary, :description, :epoch
    ]
    attr_accessor *ATTRIBUTES, :info, :files, :requires, :provides, :changelog

    def self.extract(filepath)
      data = {}
      data[:info] = %x( rpm -qip #{filepath} )
      data[:files] = parse_list %x( rpm -qlp #{filepath} )
      data[:requires] = parse_list %x( rpm -qp --requires #{filepath} )
      data[:provides] = parse_list %x( rpm -qp --provides #{filepath} )
      data[:changelog] = %x( rpm -qp --changelog #{filepath} )

      info = %x( rpm -qp --qf '#{query_format}' #{filepath} )
      data.merge!(parse_info(info))
      new(data)
    end

    def self.query_format
      ATTRIBUTES.map { |attr| "%{#{attr.to_s.gsub('_', '').upcase}}" }.join(SEPARATOR)
    end

    def self.parse_info(info)
      lines = info.split(SEPARATOR).map(&:strip)
      attrs = {}
      ATTRIBUTES.each_with_index do |attr, i|
        attrs[attr] = lines[i]
      end

      attrs
    end

    def self.parse_list(list)
      list.split(/$/).map(&:strip).reject { |line| line.length == 0 }
    end

    def initialize(options)
      options.reject { |key| key == :info }.each do |key, val|
        send("#{key}=", val)
      end
    end
  end
end