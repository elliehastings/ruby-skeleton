require "greeter"
require "ostruct"

describe Greeter do
  describe ".say_hello" do
    context "with a real person" do
      it "says hello to the right person" do
        person = OpenStruct.new(name: "Ellie")

        expect(Greeter.say_hello(person)).to eq("Hello Ellie! 👋")
      end
    end

    context "with a mock person" do
      it "says hello to the right person" do
        mock_greeter = class_double("Greeter")
        allow(mock_greeter).to receive(:say_hello).and_return("Hii Bilbo")

        expect(mock_greeter.say_hello("foo")).to eq("Hii Bilbo")
      end
    end
  end
end
