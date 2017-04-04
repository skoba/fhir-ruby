require 'spec_helper'

describe 'Fhir::Node' do
  module NodeRole
    def children(node, selection, *args)
      node
    end
  end

  example do
    graph = Object.new
    allow(graph).to receive(:node_modules).and_return([NodeRole])
    allow(graph).to receive(:selection).and_return([NodeRole])

    node = Fhir::Node.new(graph, ['a','b'], prop: 'val')

    expect(node.name).to eq('b')
    expect(node.path).to be_a(Fhir::Path)

    expect(node).to respond_to(:children)

    expect(node.children).to eq(node)
  end
end

