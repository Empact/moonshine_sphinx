require File.join(File.dirname(__FILE__), 'spec_helper.rb')

class SphinxManifest < Moonshine::Manifest::Rails
  plugin :sphinx
end

describe "A manifest with the Sphinx plugin" do

  before do
    @manifest = SphinxManifest.new
  end

  it "allows god to be specified explicitly" do
    @manifest.sphinx
    @manifest.sphinx_god
    @manifest.should exec_command("god restart #{@manifest.configuration[:application]}-sphinx")
    @manifest.packages.keys.should include('god')
  end

end
