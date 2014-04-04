require 'minitest/autorun'
require 'strict_konf'

describe StrictKonf do
  it "behaves like Konf" do
    config = StrictKonf.new('test/fixtures/example.yml', 'development', [:foo, :bar])
    config.foo.must_equal 42
    config.bar.must_equal 1024
  end

  it "raises error when required key is missing" do
    lambda {
      StrictKonf.new('test/fixtures/example.yml', 'development', [:baz])
    }.must_raise Konf::NotFound
  end

  it "raises error when config has key that is not a required key" do
    lambda {
      StrictKonf.new('test/fixtures/example.yml', 'development', [:foo])
    }.must_raise StrictKonf::UnknownKeys
  end
end
