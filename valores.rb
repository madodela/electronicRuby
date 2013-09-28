class DiodeCurrent

  def initialize io, n, vd
    @vd = vd
    @io = io
    @n = n
    @k = 1.38e-23
	@q = 1.6e-19
	@t = 298.15
	@v_t = 52e-3
	@values = {}
  end
  
  def vdIncrease
  	@vd = @vd + 0.1
  end

  def currentCalculusSilicon
  	vdIncrease()
  	insideExp = (@q * @vd) / (@n * @k * @t)
	@id = @io * (Math.exp(insideExp) - 1)
	saveDiodeCurrent()
	return @id
  end
  def currentCalculusGermanium
  	vdIncrease
  	insideExp = @vd / (@n * @v_t)
	@id = @io * (Math.exp(insideExp) - 1)
	saveDiodeCurrent()
	return @id
  end
  
  def saveDiodeCurrent
  	@values[@vd.round(1)] = @id
  end

  def vonValue
  	showValues
  	puts " El diodo se enciende en #{@vd.round(1)} V"
  end

  def showValues
  	puts "  Voltaje (V)    -->    Current(A)"
  	puts "_______________________________"
  	@values.each do |key, value|
  		puts "  #{key} --> #{value} "
    end
    puts "_______________________________"
  end

  def currentComparationSilicon
  	id = currentCalculusSilicon()
  	id2 = currentCalculusSilicon()
  	while ((id2 - id) < 5) do
        id = id2
        id2 = currentCalculusSilicon()
  	end
    vonValue
  end

  def currentComparationGermanium
  	id = currentCalculusGermanium()
  	id2 = currentCalculusGermanium()
  	while ((id2 - id) < 0.5) do
        id = id2
        id2 = currentCalculusGermanium()
  	end
    vonValue
  end
end

puts "Diodo de silicio"
calculate = DiodeCurrent.new 0.01e-6, 1.5, 0
calculate.currentComparationSilicon
puts "\n\nDiodo de germanio"
germcalculate = DiodeCurrent.new 0.01e-3, 2, 0
germcalculate.currentComparationGermanium