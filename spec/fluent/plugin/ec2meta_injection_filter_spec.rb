require 'spec_helper'
require 'ec2_meta'

RSpec.describe Fluent::Ec2metaInjectionFilter do
  include Ec2metaStub

  before(:all) { Fluent::Engine.init }

  let(:instance_id) { 'idxxxx' }
  let(:vpc_id) { 'vpc-yyyy' }

  let(:plugin) { driver.configure(conf).instace }

  let(:conf) do
    %(
<meta>
  vpc_id
  instance_id
</meta>
    )
  end

  let(:tag) { 'test' }

  let(:driver) do
    Fluent::Test::FilterTestDriver.new(
      Fluent::Ec2metaInjectionFilter, tag
    ).configure(conf)
  end

  describe 'without meta element' do
    let(:conf) { %() }
    let(:record) { { 'a' => 1 } }

    it 'does not inject any meta data' do
      driver.run { driver.emit(record) }

      records = driver.filtered_as_array.map { |v| v[2] }
      expect(records).to eq([record])

      driver.run
    end
  end

  describe 'with invalid meta element' do
    let(:conf) do
      %(
<meta>
  invalid_key
</meta>
      )
    end

    let(:record) { { 'a' => 1 } }

    it 'raise error' do
      expect { driver }.to raise_error(Fluent::ConfigError)
    end
  end

  describe 'with a meta element' do
    let(:conf) do
      %(
<meta>
  vpc_id
</meta>
      )
    end
    let(:record) { { 'a' => 1 } }

    before do
      stub_vpc_id(vpc_id)
    end

    it 'inject a meta data' do
      driver.run { driver.emit(record) }

      records = driver.filtered_as_array.map { |v| v[2] }
      expect(records).to eq(
        [
          record.merge('vpc_id' => vpc_id)
        ]
      )

      driver.run
    end
  end

  describe 'with two meta element' do
    let(:conf) do
      %(
<meta>
  instance_id
  vpc_id
</meta>
      )
    end
    let(:record) { { 'a' => 1 } }

    before do
      stub_vpc_id(vpc_id)
      stub_instance_id(instance_id)
    end

    it 'inject two meta data' do
      driver.run { driver.emit(record) }

      records = driver.filtered_as_array.map { |v| v[2] }
      expect(records).to eq(
        [
          record.merge(
            'instance_id' => instance_id,
            'vpc_id'      => vpc_id
          )
        ]
      )
    end
  end
end
