require 'test/unit'
require 'simple_uuid'
include SimpleUUID

class UUIDTest < Test::Unit::TestCase
  def test_uuid_sort
    ary = []
    5.times { ary << UUID.new(Time.at(rand(2**31))) }
    assert_equal ary.map { |_| _.seconds }.sort, ary.sort.map { |_| _.seconds }
    assert_not_equal ary.sort, ary.sort_by {|_| _.to_guid }
  end

  def test_uuid_equality
    uuid = UUID.new
    assert_equal uuid, UUID.new(uuid)
    assert_equal uuid, UUID.new(uuid.to_s)
    assert_equal uuid, UUID.new(uuid.to_i)
    assert_equal uuid, UUID.new(uuid.to_guid)
  end

  def test_uuid_error
    assert_raises(TypeError) do
      UUID.new("bogus")
    end
  end

  def test_types_behave_well
    assert !(UUID.new() == false)
  end

  def test_uuid_casting_error
    assert_raises(TypeError) do
      UUID.new({})
    end
  end

  def test_equality
    a = UUID.new
    b = a.dup
    assert_equal a, b
  end

  def test_implicit_string_conversion
	a = UUID.new
	assert !(String.try_convert(a) == nil), "Uses of this library require implicit string conversion as it worked in ruby 1.8?"
  end
  def test_size
        a = SimpleUUID::UUID.new(Time.at(2**(24+1)))
        assert_equal a.to_s.length, 16
  end

  def test_less_than
    a = UUID.new(Time.utc(2001, 1, 1, 6)) # Newer in time
    b = UUID.new(Time.utc(2001, 1, 1, 5)) # Older in time
    assert_equal true, a > b
    assert_equal false, b > a


    assert_equal false, a < b
    assert_equal true, b < a
  end
end
