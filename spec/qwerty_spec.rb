RSpec.describe '123' do
  it do
    cli = Hanami::CLI.new(Hanami::Scaffold)
    cli.call
    #output = `foo hello`
    #expect(output).to match("world")
  end
end
