require File.dirname(__FILE__)+ '/../spec_helper.rb'

describe Geometry::Space do

  context "four dimensional simplex" do
    before :all do
      @four_dimensions = Geometry::Space.new(4)
      @pentachoron = @four_dimensions.simplex(1)
    end

    context "#simplex" do
      it "#vertices" do
        @pentachoron.vertices.should == 5
      end

      it "#volume" do
        @four_dimensions.simplex(2).volume.should == 16 * @pentachoron.volume

        @pentachoron.volume.should be_very_close(0.0232923747656228)
      end

      it "#calc_simplex_formula" do
        # See formular at http://en.wikipedia.org/wiki/Simplex
        # http://upload.wikimedia.org/math/1/0/4/10457cdca57c10861902004469b9cf02.png
        @pentachoron.calc_simplex_formula.should be_very_close(@pentachoron.volume)
      end

      it "#calc_volume" do
        @pentachoron.calc_volume(1000).should be_within(0.001).of(@pentachoron.volume)
      end

      it "#height" do
        height = @pentachoron.height
        height.should be_very_close(0.790569415042095)
        @pentachoron.calc_height(10000).should be_within(0.0001).of(height)
      end

      it "#height_from_simple_formula" do
        @pentachoron.height_from_simple_formula.should be_very_close(@pentachoron.height)
        @four_dimensions.simplex(2).height_from_simple_formula.should be_within(2 * ::Float::EPSILON).of(2 * @pentachoron.height)
      end
    end

    context "#cube" do
      it "#vertices" do
        @four_dimensions.cube(7).vertices.should == 16
      end

      it "#volume" do
        @four_dimensions.cube(1).volume.should == 1
        @four_dimensions.cube(10).volume.should == 16 * @four_dimensions.cube(5).volume
      end
    end
  end


end