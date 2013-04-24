class AddHandlebarsDependencies < Rake::Pipeline::Filter

    def generate_output(inputs, output)

					contents = <<END
 minispade.require('rsvp');
 minispade.require('container');
 minispade.require('ember-debug');
 minispade.require('ember-metal');
 minispade.require('ember-runtime');
 minispade.require('ember-application');
 minispade.require('ember-views');
 minispade.require('ember-states');
 minispade.require('metamorph');
 minispade.require('ember-handlebars');
END

      output.write contents

      inputs.each do |input|
        output.write input.read
      end

		end

end


# based on ember-dev HandlebarsPrecompiler
class CustomHandlebarsPrecompiler < Rake::Pipeline::Filter
  class << self
    def context
      unless @context
        contents = <<END
exports = {};
function require() {
  #{File.read("app/vendor/precompile/handlebars.1.0.0-rc.3.js")};
  return Handlebars;
}

#{File.read("dist/ember-template-compiler.js")}
function precompileEmberHandlebars(string) {
  return exports.precompile(string).toString();
}
END
        @context = ExecJS.compile(contents)
      end
      @context
    end
  end

  def initialize(options={}, &block)
    super(&block)
    @inline = options[:inline]
    @base_path = options[:base_path]
  end

  def precompile_inline_templates(data)
     data.gsub!(%r{(defaultTemplate(?:\s*=|:)\s*)precompileTemplate\(['"](.*)['"]\)}) do
       "#{$1}Ember.Handlebars.template(#{self.class.context.call("precompileEmberHandlebars", $2)})"
     end
  end

  def precompile_hbs_templates(name, data)
   "\nEmber.TEMPLATES['#{name}'] = Ember.Handlebars.template(#{self.class.context.call("precompileEmberHandlebars", data)});\n"
  end

  def generate_output(inputs, output)

    inputs.each do |input|
      result = File.read(input.fullpath)
      if @inline 
        precompile_inline_templates(result)
      else 
        name = input.path.dup
        name.slice!(@base_path)
        name.slice! ".hbs"
        result = precompile_hbs_templates(name, result)
      end
      output.write result
    end
  end
end
