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
      @scss ||= extension == '.scss'
    end

    def js?
      @js ||= extension == '.js'
    end

    def haml?
      @haml ||= extension == '.haml'
    end

    def rabl?
      @rabl ||= extension == '.rabl'
    end

    def erb?
      @erb ||= extension == '.erb'
    end

    def extension
      @extension ||= File.extname(path)
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
        scss? && Inertia.config.ignore_scss ||
        js? && Inertia.config.ignore_js ||
        haml? && Inertia.config.ignore_haml ||
        rabl? && Inertia.config.ignore_rabl ||
        erb? && Inertia.config.ignore_erb
    end
  end
end
