require 'spec_helper'
require 'kratom/site'

describe Kratom::Site do
  let(:config) { OpenStruct.new() }

  let(:subject) { described_class.new(config) }

  it 'exposes given resources' do
    expect(subject.pages).to be_kind_of(Kratom::ResourceCollection)
  end
end
