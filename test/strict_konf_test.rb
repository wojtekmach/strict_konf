require 'minitest/autorun'
require 'strict_konf'

describe StrictKonf do
  it "behaves like Konf" do
    config = StrictKonf.new({'development' => {'foo' => 1, 'bar' => 2}}, 'development', [:foo, :bar])
    config.foo.must_equal 1
    config.bar.must_equal 2
  end

  it "raises error when required key is missing" do
    lambda {
      StrictKonf.new({'foo' => 1}, nil, [:foo, :baz])
    }.must_raise Konf::NotFound
  end

  it "raises error when config has key that is not a required key" do
    lambda {
      StrictKonf.new({'foo' => 1, 'bar' => 2}, nil, [:foo])
    }.must_raise StrictKonf::UnknownKeys
  end
end
