require 'spec_helper'

describe 'Graph sources' do
  let(:graph) { Fhir.graph }
  let(:selection) { Fhir.graph.selection }

  describe 'parsing xml data' do
    let(:node) { selection.node(['Condition']) }

    example 'max of node should be 1' do
      p graph
      p selection
      expect(node.max).to eq('1')
    end

    # expect(node.min).to eq('1')
    # expect(node.attributes[:comment]).not_to be_empty

    # expect(node.children.to_a.length).to eq(22)
  end

  xit 'should expand datatypes' do
    node = selection.node(%w[Practitioner address])
    expect(node.children.to_a).not_to be_empty
  end

  it 'should expand datatypes' do
    selection.node(%w[MedicationStatement identifier])
  end
end
