module RefineHash
  refine Hash do
    def method_missing(mtd, *args, &block)
      return self["#{m}"]
    end
  end
end
