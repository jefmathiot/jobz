require 'spec_helper'

describe Jobz do

    it "should expose configuration" do
        Jobz.must_respond_to :config
    end

    it "should mark classes as deferrable" do
        Jobz.must_respond_to :config
    end

end