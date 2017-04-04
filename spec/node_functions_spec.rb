require 'spec_helper'

describe 'NodeFunctions' do
  let(:graph) do
    Fhir::Graph.new.tap do |g|
      g.add([1])
      g.add([1, 2])
      g.add([1, 2, 3])
      g.add([1, 2, 3, 4])
      g.add([1, 2, 3, 4, 5])
      g.add([1, 6])
    end
  end

  let(:selection) { graph.selection }
  let(:node) { selection.select { |n| n.path.to_a == [1, 2, 3] }.to_a.first }

  it 'should get children' do
    expect(node.children.to_a.map(&:path).map(&:to_a)).to match_array([[1, 2, 3, 4]])
  end

  it 'should get parents' do
    expect(node.parent.path.to_a).to eq([1, 2])
  end

  it 'should get ancestors' do
    expect(node.ancestors.to_a.map(&:path).map(&:to_a)).to match_array([[1], [1, 2]])
  end

  it 'should get descendants' do
    expect(node.descendants.to_a.map(&:path).map(&:to_a)).to match_array(
    [[1, 2, 3, 4], [1, 2, 3, 4, 5]]
    )
  end
end
