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

  describe "with nested hash" do
    let(:data) {
      {
        'a' => {
          'aa' => 1,
          'ab' => 2,
          'ac' => {
            'aca' => 3
          }
        },
        'b' => 4,
      }
    }

    it "behaves like Konf" do
      config = StrictKonf.new(data, nil, a: [:aa, :ab, {ac: [:aca]}], b: true)
      config.a.aa.must_equal 1
      config.a.ab.must_equal 2
      config.a.ac.aca.must_equal 3
      config.b.must_equal 4
    end

    it "raises error when required key is missing" do
      lambda {
        StrictKonf.new(data, nil, a: [:aa, :ab, {ac: [:aca]}, :ad], b: true)
      }.must_raise Konf::NotFound
    end

    it "raises error when config has key that is not a required key" do
      lambda {
        StrictKonf.new(data, nil, a: [:aa], b: true)
      }.must_raise StrictKonf::UnknownKeys
    end
  end
end
