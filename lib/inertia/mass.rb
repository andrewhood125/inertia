module Inertia
  # Mass is a location where code lives. This represents a single location
  # and encapsulates data relating to it.
  class Mass
    def initialize(path:)
      @path = path
    end
    attr_reader :path

    def text?
      @text ||= File.open(path) { |file| file.read.ascii_only? }
    end

    def scss?
      @scss ||= extension == '.scss'
    end

    def js?
      @js ||= extension == '.js'
    end

    def jsx?
      @jsx ||= extension == '.jsx'
    end

    def ts?
      @ts ||= extension == '.ts'
    end

    def tsx?
      @tsx ||= extension == '.tsx'
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

    def ruby_spec?
      @ruby_spec ||= path.include?('_spec.rb')
    end

    def yml?
      @yml ||= extension == '.yml'
    end

    def extension
      @extension ||= File.extname(path)
    end

    def lines
      return 0 if ignored?

      @lines ||= File.open(path) { |file| file.each_line.count }
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
        jsx? && Inertia.config.ignore_jsx ||
        ts? && Inertia.config.ignore_ts ||
        tsx? && Inertia.config.ignore_tsx ||
        haml? && Inertia.config.ignore_haml ||
        rabl? && Inertia.config.ignore_rabl ||
        erb? && Inertia.config.ignore_erb ||
        ruby_spec? && Inertia.config.ignore_ruby_spec ||
        yml? && Inertia.config.ignore_yml
    end
  end
end
