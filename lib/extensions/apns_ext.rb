module APNS
  class << self
    attr_accessor :connections, :cert_directory
  end

  def self.bundle_specific(bundle_id)
    return APNS if bundle_id.nil? || bundle_id.empty?

    klass_name = class_name_from_bundle_id(bundle_id)
    if eval("defined? #{klass_name}")
      eval(klass_name)
    else
      klass = eval("::#{klass_name} = APNS.dup")
      klass.connections = {}
      klass.pem = "#{cert_directory}#{bundle_id}.pem"
      if bundle_id.end_with? '.dev'
        klass.host = 'gateway.sandbox.push.apple.com'
      end
      klass
    end 
  end

  def self.class_name_from_bundle_id(bundle_id)
    bundle_id.split(".").map{|w| w.capitalize}.join("")
  end
end
