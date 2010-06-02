require File.join(File.dirname(__FILE__), 'spec_helper.rb')

class SphinxManifest < Moonshine::Manifest::Rails
  plugin :sphinx
end

describe "A manifest with the Sphinx plugin" do

  before do
    @manifest = SphinxManifest.new
  end

  it "should use monit if specified explicitly" do
    @manifest.sphinx
    @manifest.sphinx_monit
    @manifest.should exec_command("monit restart #{@manifest.configuration[:application]}-sphinx")
    @manifest.packages.keys.should include('monit')
  end

end
