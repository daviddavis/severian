require 'test_helper'

class RPMTest < Minitest::Test
  RPM_SYSTEM = system("rpm --version")

  def setup
    @filename = "pulp-katello-plugins-0.2-1.fc18.noarch.rpm"
    @filepath = File.join("test", "data", @filename)
  end

  def test_extract
    skip "Skipping extract test since no rpm found" if !RPM_SYSTEM
    rpm = Severian::RPM.extract(@filepath)

    assert_equal "pulp-katello-plugins", rpm.name
    assert_equal "0.2", rpm.version
    assert_equal "noarch", rpm.arch
    assert_equal "(none)", rpm.epoch
    assert_equal "1.fc18", rpm.release
    assert_equal "Koji", rpm.packager
    assert_equal "1374499921", rpm.build_time
    assert_equal "Provides a collection of platform plugins, client extensions and agent\nhandlers that provide RPM support.",
      rpm.description
  end

  def test_extract_with_stub
    stub_execute(@filename)
    rpm = Severian::RPM.extract(@filepath)

    assert_equal "pulp-katello-plugins", rpm.name
    assert_equal "0.2", rpm.version
    assert_equal "noarch", rpm.arch
    assert_equal "(none)", rpm.epoch
    assert_equal "1.fc18", rpm.release
    assert_equal "Koji", rpm.packager
    assert_equal "1374499921", rpm.build_time
    assert_equal "Provides a collection of platform plugins, client extensions and agent\nhandlers that provide RPM support.",
      rpm.description
  end

  def stub_execute(filename)
    filepath = File.join("test", "data", filename)
    query = File.open(File.join("test", "queries", "#{filename}.txt"), "r") { |f| f.read }

    Severian::RPM.stubs(:`).with(" rpm -qp --qf '#{Severian::RPM.query_format}' #{filepath} ")
      .returns(query)

    # TODO: fill these in
    Severian::RPM.stubs(:`).with(" rpm -qip #{filepath} ").returns("")
    Severian::RPM.stubs(:`).with(" rpm -qlp #{filepath} ").returns("")
    Severian::RPM.stubs(:`).with(" rpm -qp --requires #{filepath} ").returns("")
    Severian::RPM.stubs(:`).with(" rpm -qp --provides #{filepath} ").returns("")
    Severian::RPM.stubs(:`).with(" rpm -qp --changelog #{filepath} ").returns("")
  end
end
