require_relative '../lib/game'
require 'rspec'
require 'unicode'

RSpec.describe Game do
  before do
    @game = described_class.new('крокодил')
  end

  it 'user wins the game' do
    expect(@game.status).to eq :in_progress

    @game.next_step('к')
    @game.next_step('р')
    @game.next_step('о')
    @game.next_step('д')
    @game.next_step('и')
    @game.next_step('л')

    expect(@game.errors).to eq 0
    expect(@game.status).to eq :won
  end

  it 'user loses the game' do
    @game.next_step('а')
    @game.next_step('у')
    @game.next_step('ш')
    @game.next_step('п')
    @game.next_step('е')
    @game.next_step('ч')
    @game.next_step('щ')

    expect(@game.errors).to eq 7
    expect(@game.status).to eq :lost
  end
end
