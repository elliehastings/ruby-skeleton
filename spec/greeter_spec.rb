require "greeter"

describe Greeter do
  describe ".say_hello" do
    it "says hello to the right person" do
      expect(Greeter.say_hello("Ellie")).to eq("Hello Ellie! 👋")
    end
  end
end
