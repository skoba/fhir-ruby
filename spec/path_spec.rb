require 'spec_helper'

describe Fhir::Path do
  let(:path) { Fhir::Path.new %w(a b c) }
  let(:subpath) { Fhir::Path.new %w(a b c d e) }
  let(:relative_path) {Fhir::Path.new %w(d e) }

  example 'path sould be concatinated by "." as string' do
    expect(path.to_s).to eq 'a.b.c'
  end

  example 'subpath is subpath of path' do
    expect(path).to be_subpath subpath
  end

  example 'a.b.c.d.e is include in a.b.c' do
    expect(path).to be_include subpath
  end

  example 'subpath is lesser than path' do
    expect(subpath < path).to be_truthy
  end

  example 'subpath is not greater than path' do
    expect(subpath > path).to be_falsey
  end

  example 'subpath is relative to relative_path' do
    expect(subpath.relative path).to eq relative_path
  end

  example 'path is not relative to relative_path' do
    expect {path.relative(subpath) == relative_path}.to raise_error RuntimeError
  end

  example 'subpath - path should be relative_path' do
    expect(subpath - path).to eq relative_path
  end

  example 'path cancatinated with relative_path should be subpath' do
    expect(path.concat relative_path).to eq subpath
  end

  example 'path + relative_path should subpath' do
    expect(path + relative_path).to eq subpath
  end

  example 'path.dup should copy path' do
    new_path  = path.dup
    expect(new_path.to_a).to eq path.to_a
  end

  it 'should initialize by both array and another path' do
    path1 = Fhir::Path.new([1, 2, 3])
    path2 = Fhir::Path.new(path1)
    expect(path1).to eq path2
  end
end
