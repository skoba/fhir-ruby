require 'spec_helper'

describe Fhir::Graph do
  let(:graph) {  Fhir::Graph.new(modules: Module.new, node_modules: Module.new) }
  let(:node) { graph.nodes.first }

  describe 'graph should add nodes' do
    before { graph.add(['one', 'two', 'three']) }

    example 'node is Fhir::node' do
      expect(node).to be_a(Fhir::Node)
    end

    example 'node can be added nodes' do
      expect(node.path).to eq(['one', 'two', 'three'])
    end
  end

  it 'should apply rules' do
    graph.add([42], max: 7)
    graph.rule([42], max: -1)
    expect(node.max).to eq(-1)
  end
end
