module Ec2metaStub
  require_relative '../../lib/fluent/plugin/ec2meta_injection_filter/meta_fetcher'

  def stub_instance_id(instance_id)
    allow_any_instance_of(::Fluent::Ec2metaInjectionFilter::MetaFetcher).to \
      receive(:instance_id).and_return(instance_id)
  end

  def stub_vpc_id(vpc_id)
    allow_any_instance_of(::Fluent::Ec2metaInjectionFilter::MetaFetcher).to \
      receive(:vpc_id).and_return(vpc_id)
  end
end
