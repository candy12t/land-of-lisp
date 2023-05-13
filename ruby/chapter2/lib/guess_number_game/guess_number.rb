class GuessNumberGame::GuessNumber
  def initialize(small = 0, big = 100)
    @small = small
    @big = big
  end

  def guess_my_number
    (@small + @big) >> 1
  end

  def smaller
    @big = guess_my_number - 1
    return guess_my_number
  end

  def bigger
    @small = guess_my_number + 1
    return guess_my_number
  end
end
