#
# test/unit/bio/db/kegg/test_reaction.rb - Unit test for Bio::KEGG::REACTION
#
# Copyright::  Copyright (C) 2009 Kozo Nishida <kozo-ni@is.naist.jp>
# License::    The Ruby License

# loading helper routine for testing bioruby
require 'pathname'
load Pathname.new(File.join(File.dirname(__FILE__), ['..'] * 4,
                            'bioruby_test_helper.rb')).cleanpath.to_s

# libraries needed for the tests
require 'test/unit'
require 'bio/db/kegg/reaction'

module Bio
  class TestKeggReaction < Test::Unit::TestCase

    def setup
      testdata_kegg = Pathname.new(File.join(BioRubyTestDataPath, 'KEGG')).cleanpath.to_s
      entry = File.read(File.join(testdata_kegg, "R00006.reaction"))
      @obj = Bio::KEGG::REACTION.new(entry)
    end

    def test_entry_id
      assert_equal('R00006', @obj.entry_id)
    end

    def test_name
      assert_equal('pyruvate:pyruvate acetaldehydetransferase (decarboxylating); 2-acetolactate pyruvate-lyase (carboxylating)', @obj.name)
    end

    def test_definition
      assert_equal('2-Acetolactate + CO2 <=> 2 Pyruvate', @obj.definition)
    end

    def test_equation
      assert_equal('C00900 + C00011 <=> 2 C00022', @obj.equation)
    end

    def test_rpairs
      assert_equal([{"name"=>"C00022_C00900", "type"=>"main", "entry"=>"RP00440"}, {"name"=>"C00011_C00022", "type"=>"leave", "entry"=>"RP05698"}, {"name"=>"C00022_C00900", "type"=>"trans", "entry"=>"RP12733"}], @obj.rpairs)
    end

    def test_pathways
      assert_equal([ "PATH: rn00770  Pantothenate and CoA biosynthesis" ],
                   @obj.pathways)
    end

    def test_pathways_as_hash
      assert_equal({ "rn00770" => "Pantothenate and CoA biosynthesis" },
                   @obj.pathways_as_hash)
    end

    def test_enzymes
      assert_equal(["2.2.1.6"], @obj.enzymes)
    end

    def test_orthologs
      assert_equal(["KO: K01652  acetolactate synthase I/II/III large subunit [EC:2.2.1.6]", "KO: K01653  acetolactate synthase I/III small subunit [EC:2.2.1.6]"], @obj.orthologs)
    end

    def test_orthologs_as_hash
      expected = {
        'K01652'=>"acetolactate synthase I/II/III large subunit [EC:2.2.1.6]",
        'K01653'=>"acetolactate synthase I/III small subunit [EC:2.2.1.6]"
      }
      assert_equal(expected, @obj.orthologs_as_hash)
    end

  end
end