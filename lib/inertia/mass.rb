module Inertia
  # Mass is a location where code lives. This represents a single location
  # and encapsulates data relating to it.
  class Mass
    def initialize(path:)
      @path = path
    end
    attr_reader :path

    def text?
      @text ||= `file -b --mime #{path}`.match?('text')
    end

    def scss?
      @scss ||= File.extname(path) == '.scss'
    end

    def lines
      return 0 if ignored?

      @lines ||= `wc -l "#{path}" | awk '{print $1}'`.chomp.to_i
    end

    def percent_overall_lines
      (lines / Inertia::Resistance.total_lines.to_f * 100).round(2)
    end

    def <=>(other)
      lines <=> other.lines
    end

    def to_s
      sprintf("%6.2f%%\t%s", percent_overall_lines, path)
    end

    def ignored?
      !text? ||
        scss? && Inertia.config.ignore_scss
    end
  end
end
