require_relative '../../lib/arguments'

module ValidatesSubset
  describe Arguments do

    let(:attribute_name) { :foo }
    let(:superset)       { %w(bar qux) }
    let(:options)        { { extra: :options } }

    subject { described_class.new(attribute_name, superset, options) }

    describe '#to_validation_attributes' do
      context 'all pertinent attributes are present' do
        specify do
          expect(subject.to_validation_attributes).to eq([attribute_name, { subset: superset }.merge(options)])
        end
      end

      context 'superset is nil' do
        let(:superset) { nil }

        specify do
          expect(subject.to_validation_attributes).to eq([attribute_name, { subset: superset }.merge(options)])
        end
      end

      context 'attribute_name is nil' do
        let(:attribute_name) { nil }

        specify do
          expect(subject.to_validation_attributes).to eq([attribute_name, { subset: superset }.merge(options)])
        end
      end

      context 'options is nil' do
        let(:options) { nil }

        specify do
          expect(subject.to_validation_attributes).to eq([attribute_name, { subset: superset }])
        end
      end
    end

    describe '#subset' do
      context 'subset is given' do
        specify do
          expect(subject.send(:subset)).to eq({ subset: superset })
        end
      end

      context 'subset is nil' do
        let(:superset) { nil }

        specify do
          expect(subject.send(:subset)).to eq({ subset: nil })
        end
      end
    end

    describe '#merged_options' do
      context 'options are present' do
        specify do
          expect(subject.send(:merged_options)).to eq({ subset: superset }.merge(options))
        end
      end

      context 'options is nil' do
        let(:options) { nil }

        specify do
          expect(subject.send(:merged_options)).to eq({ subset: superset })
        end
      end

      context 'options is a blank hash' do
        let(:options) { {} }

        specify do
          expect(subject.send(:merged_options)).to eq({ subset: superset })
        end
      end
    end
  end
end
