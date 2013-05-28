module Geometry

  class Space
    # makes sense only when dimensions >= 2
    def previous_height_ratio
      @previous_dimention_ratio || @previous_dimention_ratio = Math.sqrt(dimensions ** 2 - 1) / dimensions
    end
  end

  class Triangle < Figure
    def height
      height_from_simple_formula
    end

    def height_in_two_dimensions
      side * Math.sqrt(3)/2
    end

    def calc_height precision = 10000
      inc = side / (precision + 0.0)
      previous_height = from_previous_dimension.height
      start = previous_height / side * precision + 1
      (start.to_int).downto(1) do |percent|
        sample = inc * percent
        if Math.hypot(sample, previous_height/space.dimensions) < previous_height
          return sample
        end
      end
      raise RuntimeError, "Unable to calculate height with precision #{precision}, side=#{side}"
    end

    def analize_height
      Math.sqrt( side ** 2 - (side/space.dimensions) ** 2 )
    end

    def over_analize_height
      if space.dimensions < 2
        volume
      else
        from_previous_dimension.over_analize_height * space.previous_height_ratio
        #  Right triangle with previous height as a hypotenuse and current height as a side
        #  height = Math.sqrt( previous_height ** 2 - (previous_height / space.dimensions) ** 2)
      end
    end

    def calc_volume precision = 10000
      previous_volume = 0
      precision.downto(0) do |portion|
        previous_volume += from_previous_dimension(side * portion/precision).volume
      end
      previous_volume * height / precision
    end

    def calc_simplex_formula
      n = space.dimensions
      side ** n * Math.sqrt(n + 1) / Math.sqrt(2 ** n) / factorial(n)
    end

    def height_from_simple_formula
      n = space.dimensions
      n == 0 ? 0 : side * Math.sqrt((n + 1.0) / 2 / n )
    end

    def volume
      case space.dimensions
      when 0, 1
        super
      else
        from_previous_dimension.volume * height / space.dimensions
      end
    end

    private
    def self.previous_class
      Triangle
    end

    def factorial n
      case n
      when 0
        1
      else
        n * factorial(n-1)
      end
    end

  end

end