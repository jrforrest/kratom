require 'spec_helper'
require 'kratom/meta_data'

describe Kratom::MetaData do
  let(:data) { {'title' => 'Hello!'} }
  let(:resource) { double(:resource, name: 'home', type: 'Page') }
  subject { described_class.new(data, resource) }

  it 'returns defined values' do
    expect(subject[:title]).to eql('Hello!')
  end

  it 'raises an error for undefined values' do
    expect{subject[:derp]}.to raise_error(Kratom::MissingMetaData)
  end
end
