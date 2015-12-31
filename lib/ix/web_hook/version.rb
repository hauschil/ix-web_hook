module IX

  module WebHook

    module VERSION

      MAJOR = 0
      MINOR = 0
      PATCH = 3
      BUILD = nil

      STRING = [MAJOR, MINOR, PATCH, BUILD].compact.join('.')

      def self.version
        STRING
      end
    end

  end
end
