require 'rails_helper'

RSpec.describe Project, type: :model do
  describe 'validations' do
    let(:project) { create(:project, status: :searching) }

    context 'when updating status' do
      it 'allows changing to a different status' do
        project.status = :shortlisted
        expect(project).to be_valid
      end

      it 'adds an error when setting the same status' do
        project.status = :searching
        expect(project).not_to be_valid
        expect(project.errors[:status]).to include("must be different from the current status")
      end
    end
  end
end
