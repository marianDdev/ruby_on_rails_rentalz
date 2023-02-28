module FormBuilders
  class TailwindFormBuilder < ActionView::Helpers::FormBuilder
   def text_field(method, options = {})
      style_options, custom_options =
        partition_custom_opts(options)

      style = "rounded-md shadow-sm focus:ring focus:ring-indigo-200 focus:ring-opacity-50"
        + " #{style_options[:class]}"

      super(method, options.merge({class: style}))
    end

    def email_field(method, options = {})
      style_options, custom_options =
        partition_custom_opts(options)

      style = "rounded-md shadow-sm focus:ring focus:ring-indigo-200 focus:ring-opacity-50"
        + " #{style_options[:class]}"

      super(method, options.merge({class: style}))
    end

    def password_field(method, options = {})
      style_options, custom_options =
        partition_custom_opts(options)

      style = "rounded-md shadow-sm focus:ring focus:ring-indigo-200 focus:ring-opacity-50"
        + " #{style_options[:class]}"

      super(method, options.merge({class: style}))
    end


    CUSTOM_OPTS = [:class].freeze
    def partition_custom_opts(opts)
      opts.partition { |k, v| CUSTOM_OPTS.include?(k) }.map(&:to_h)
    end

    def label(method, text = nil, options = {})
      default_style = "block text-gray-500 font-bold md:text-right
        mb-1 md:mb-0 pr-4"

      super(method, text, options.merge({class: default_style}))
    end
  end
end