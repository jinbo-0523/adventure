require 'pry'
# binding.pry

class Character
  attr_accessor :name, :max_hp, :hp, :offense, :defence, :money
  def initialize(name:, max_hp:, offense:, defence:, money:)
    @name = name
    @max_hp = max_hp 
    @hp = max_hp
    @offense = offense
    @defence = defence
    @money = money

  end
end

class Brave < Character
  def attack(monster)
    monster_damage = @offense - monster.defence
    monster_damage = 0 if monster_damage < 0
    monster.hp -= monster_damage
    monster.hp = 0 if monster.hp < 0
    
    puts <<~text
    勇者の攻撃 #{monster_damage}のダメージ
    #{monster.name}のHPは残り#{monster.hp}！
    text
  end
end

class Monster < Character
  def attack(brave)
    brave_damage = @offense - brave.defence
    brave_damage = 0 if brave_damage < 0
    brave.hp = brave.hp - brave_damage
    brave.hp = 0 if brave.hp < 0
    puts <<~text
    #{@name}の攻撃 #{brave_damage}のダメージ
    勇者のHPは残り#{brave.hp}！
    text
  end
end

def input_place
    puts <<~text
  ど こ に 行 き ま す か ？
    1. となりの街
    2. 大きな港
    3. となりの国
    4. 果ての山脈
    5. 山脈の古城
  text

  place = gets.to_i
end

def Appearance_monster(place)
  case place
  when  1
    monsterA = Monster.new(name:"monsterA", max_hp: 10, offense: 5,defence: 3, money: 10) 
  when  2
    monsterB = Monster.new(name:"monsterB", max_hp: 20, offense: 10,defence: 5, money: 20) 
  when  3
    monsterB = Monster.new(name:"monsterC", max_hp: 30, offense: 15,defence: 8, money: 40)
  when  4
    middle_monsnter = Monster.new(name:"middle_mosnter", max_hp: 40, offense: 20,defence: 10, money: 50)
  when  5
    boss = Monster.new(name:"boss", max_hp: 80, offense: 40,defence: 20, money: 100)  
  end
end


def battle(brave,monster)
  loop do
    brave.attack(monster)
    if  monster.hp <= 0
      puts "勇者はモンスターを倒した！"
      puts "ステータスアップ！"
      status_up(brave,monster)
      brave.hp = brave.max_hp
      brave
      break
    end
    monster.attack(brave)
    if brave.hp <= 0
      puts <<~text
      勇者は負けた...
      モンスターを倒してレベルアップしよう！！！
      text
      brave.hp = brave.max_hp
      brave
      break
    end
  end
end

def status_up(brave,monster)
  brave.max_hp += (monster.max_hp * 0.2).ceil
  brave.hp = brave.max_hp
  brave.offense+= (monster.offense * 0.2).ceil
  brave.defence += (monster.defence * 0.2).ceil
  brave.money += (monster.money * 0.2).ceil  
  brave
end

brave = Brave.new(name:"勇者", max_hp: 15, offense: 5, defence: 3, money:50)

loop do
  place = input_place
  monster = Appearance_monster(place)
  battle(brave,monster)
  binding.pry
  if monster.name == "boss" && monster.hp == 0
    puts "#{monster.name}は倒れ、世界は平和になった"
  break
  end
end