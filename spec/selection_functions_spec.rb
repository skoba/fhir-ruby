require 'spec_helper'

describe Fhir::SelecionFunctions do
  let(:graph) do
    Fhir::Graph.new.tap do |g|
      g.add([1])
      g.add([1, 2])
      g.add([1, 2, 3])
      g.add([1, 4])
    end
  end

  let(:selection) { graph.selection }

  it 'should debug' do
    expect(selection).to respond_to(:debug)
  end

  it 'should select' do
    nodes = selection.select do |node|
      node.path.to_a.include?(2)
    end
    expect(nodes.to_a.size).to eq(2)
  end

  it 'should select branch'  do
    expect(selection.branch([1,4]).to_a.size).to eq(1)
    expect(selection.branch([1,2]).to_a.size).to eq(2)
    expect(selection.branch([1]).to_a.size).to eq(4)
  end

  it 'should select branches'  do
    expect(selection.branches([1,4], [1,2,3])
    .to_a
    .map(&:path)
    .map(&:to_a))
    .to eq([[1,4],[1,2,3]])
  end
end
