class ModuleGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  def copy_module_files

  	# Model
    copy_file "models/module.rb", "app/models/#{file_name.singularize}.rb"
    # Controller
    copy_file "controllers/module_controller.rb", "app/controllers/#{file_name}_controller.rb"
  end

end
