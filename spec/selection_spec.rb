require 'spec_helper'

describe 'Fhir::Selection' do
  module TestSelection
    def my_selection(selection)
      selection
    end
  end

  let(:graph) do
    Object.new.tap do |g|
      allow(g).to receive(:modules).and_return([TestSelection])
    end
  end

  example do
    initial_selection = Object.new
    selection = Fhir::Selection.new(graph, initial_selection)
    expect(selection).to respond_to(:my_selection)
    expect(selection.my_selection).to eq(selection)
  end

  it 'should add two selections' do
    sum = Fhir::Selection.new(graph, [42]) + Fhir::Selection.new(graph, [7])
    expect(sum).to be_a(Fhir::Selection)
    expect(sum.to_a).to eq([42, 7])
  end

  it 'should flatten' do
    expect(Fhir::Selection.new(graph, [[42]]).flatten.to_a).to eq([42])
  end
end

