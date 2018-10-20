module Inertia
  # Wrapping functions to provide some intuition on where you may encounter
  # resistance.
  class Resistance
    def self.display
      puts grouped_masses.sort.reverse
    end

    def self.tracked_files
      @tracked_files ||= `git ls-files`.split
    end

    # Git will list all files, this groups the top level direc
    def self.grouped_masses
      @grouped_masses ||= tracked_files.reduce({}) do |memo, file|
        # Grab only the top level directory, or filename.
        root =  /[^\/]*\/?/.match(file).to_s
        memo[root] ||= []
        memo[root].push Inertia::Mass.new(path: file)
        memo
      end.map do |path, masses|
        Inertia::GroupedMass.new(path, masses)
      end
    end

    def self.total_lines
      @total_lines ||= grouped_masses.sum(&:lines)
    end
  end
end
