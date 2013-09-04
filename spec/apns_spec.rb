require File.expand_path('../spec_helper', __FILE__)

describe APNS do

  APNS.port = 2195
  APNS.host = "gateway.push.apple.com"
  APNS.feedback_port = 2196
  APNS.feedback_host = "feedback.push.apple.com"
  APNS.pem = "/some_directory/some_cert.pem"     
  APNS.cache_connections = true
  APNS.cert_directory = "/some_directory/apple_certs/"     
  APNS.pass = ""


  it "has been setup normally" do
    APNS.host.should == "gateway.push.apple.com"
    APNS.port.should == 2195
    APNS.feedback_host.should == "feedback.push.apple.com"
    APNS.feedback_port.should == 2196
    APNS.cache_connections.should == true
    APNS.pem.should == "/some_directory/some_cert.pem"
    APNS.pass.should == ""
    APNS.cert_directory.should == "/some_directory/apple_certs/"
  end

  it "#bundle_specific given a nil parameter will return the origin APNS module" do
    apns = APNS.bundle_specific(nil)
     apns.pem.should == "/some_directory/some_cert.pem"
  end

  it "#bundle_specific given a blank string parameter will return the origin APNS module" do
    apns = APNS.bundle_specific("")
    apns.pem.should == "/some_directory/some_cert.pem"
  end

  it "#bundle_specific will create a new module instance named from the bundle id" do
    apns = APNS.bundle_specific("com.somecool.app")
    defined?(ComSomecoolApp).should_not == nil
    ComSomecoolApp.pem.should == "/some_directory/apple_certs/com.somecool.app.pem"
    #make sure the new module has a new connections variable
    ComSomecoolApp.connections.object_id.should_not be_equal(APNS.connections.object_id) 
  end

end
