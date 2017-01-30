class GeneratableResourceCollection < ResourceCollection
  def generate_all
    resources.each(&:generate)
  end
end
