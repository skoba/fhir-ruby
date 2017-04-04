require 'spec_helper'

describe Fhir::Datatype do
  before :all do
    Fhir::Datatype.load(DATATYPES_FILE)
  end

  describe 'it should detect simple types' do
    example 'integer should be simple' do
      expect(Fhir::Datatype.find('integer')).to be_simple
    end

    example 'id should be simple' do
      expect(Fhir::Datatype.find('id')).to be_simple
    end

    example 'Element should be simple' do
      expect(Fhir::Datatype.find('Element')).to be_simple
    end

    example 'QuantityCompararator should be simple' do
      expect(Fhir::Datatype.find('QuantityCompararator')).to be_simple
    end

    example 'Extension should be complex' do
      expect(Fhir::Datatype.find('Extension')).to be_complex
    end

    example 'Address should be complex' do
      expect(Fhir::Datatype.find('Address')).to be_complex
    end
  end

  it 'should parse attributes' do
    Fhir::Datatype.all.each do |datatype|
      puts datatype.name
      if datatype.complex?
        datatype.attributes.each do |attribute|
          expect(attribute.type).to be_a Fhir::Datatype if attribute.type
          puts "  #{attribute.name} <#{attribute.type_name}> #{attribute.min}..#{attribute.max}"
        end
      elsif datatype.simple?
        expect(datatype.attributes).to be_nil
      end
      puts
    end
  end

  it 'should detect and parse enum' do
    expect(Fhir::Datatype.find('Address')).not_to be_enum
    datatype = Fhir::Datatype.find('ObservationStatus')

    expect(datatype).to be_enum
    expect(datatype.enum_values).to match_array(%w[registered interim final amended cancelled withdrawn])
  end

  it 'should do something' do
    file_name = File.join(File.dirname(__FILE__), '..', 'fhir-base.xsd')
    document = Nokogiri::XML(File.open(file_name).readlines.join)
    document.remove_namespaces!

    complex_types = document.xpath('//schema/complexType')

    ext_contents = []
    complex_types.each do |type|
      puts type[:name]

      type.xpath('./attribute').each do |attribute|
        puts "  A #{attribute[:name]} <#{attribute[:type]}>"
      end

      type.xpath('./choice').each do |choice|
        puts "  CH #{choice[:minOccurs]}..#{choice[:maxOccurs]}"
        choice.xpath('./element').each do |element|
          puts "    E #{element[:ref]}"
        end
      end

      type.xpath('./sequence/choice').each do |choice|
        puts "  S CH #{choice[:minOccurs]}..#{choice[:maxOccurs]}"
        choice.xpath('./element').each do |element|
          puts "    E #{element[:name]} <#{element[:type]}>"
        end
      end

      type.xpath('./sequence/element').each do |element|
        puts "  S E #{element[:name]} <#{element[:type]}>"
      end

      type.xpath('./resctirction/enumaeration').each do |enumeration|
        puts "  R EN #{enumeration[:value]}"
      end

      type.xpath('./complexContent/extension/attribute').each do |attribute|
        puts "  CO EXT A #{attribute[:name]} <#{attribute[:type]}>"
      end

      type.xpath('./complexContent/extension/sequence/element').each do |element|
        puts "  CO EXT S E #{element[:name]} <#{element[:type]}>"
      end

      type.xpath('./complexContent/restriction/sequence/element').each do |element|
        puts "  CO R S E #{element[:name]} <#{element[:type]}>"
      end
      puts
    end

  end
end
