defmodule Lube.Templates do

  require EEx

  @dir Path.join([File.cwd!(), Application.get_env(:lube, :template_dir)])

  EEx.function_from_file :def, :redirect, Path.join([@dir, "redirect.html.eex"]),
    []

end
