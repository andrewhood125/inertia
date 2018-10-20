module Inertia
  # A group of masses, probably a directory.
  class GroupedMass < Mass
    def initialize(path, masses)
      @path = path
      @masses = masses
    end
    attr_reader :path, :masses

    def lines
      masses.sum(&:lines)
    end
  end
end
