# Clear existing data (development only)
if Rails.env.development?
  puts "Clearing existing data..."
  Reflection.destroy_all
  SessionGalaxy.destroy_all
  Session.destroy_all
  Question.destroy_all
  Galaxy.destroy_all
end

puts "Creating Galaxies..."

# 1. Career Star
career = Galaxy.create!(
  name: "Career Star",
  color: "#2563EB",
  icon: "💼",
  description: "Dream job, fulfillment, professional purpose"
)

# 2. Life Purpose Star
purpose = Galaxy.create!(
  name: "Life Purpose Star",
  color: "#7C3AED",
  icon: "🎯",
  description: "Legacy, values, contribution to world"
)

# 3. Relationships & Connection Star
relationships = Galaxy.create!(
  name: "Relationships & Connection Star",
  color: "#EC4899",
  icon: "💕",
  description: "Building authentic bonds, deepening connections"
)

# 4. Creativity & Expression Star
creativity = Galaxy.create!(
  name: "Creativity & Expression Star",
  color: "#F59E0B",
  icon: "🎨",
  description: "Artistic dreams, creative outlet, self-expression"
)

# 5. Health & Vitality Star
health = Galaxy.create!(
  name: "Health & Vitality Star",
  color: "#10B981",
  icon: "💪",
  description: "Wellbeing, energy, physical/mental health"
)

# 6. Adventure & Experiences Star
adventure = Galaxy.create!(
  name: "Adventure & Experiences Star",
  color: "#14B8A6",
  icon: "✈️",
  description: "Travel, experiences, boldness, exploration"
)

# 7. Finances & Wealth Star
finance = Galaxy.create!(
  name: "Finances & Wealth Star",
  color: "#F59E0B",
  icon: "💰",
  description: "Financial freedom, abundance, meaningful wealth"
)

# 8. Learning & Growth Star
learning = Galaxy.create!(
  name: "Learning & Growth Star",
  color: "#0EA5E9",
  icon: "📚",
  description: "Skill development, curiosity, continuous growth"
)

# 9. Community & Impact Star
community = Galaxy.create!(
  name: "Community & Impact Star",
  color: "#8B5CF6",
  icon: "🌍",
  description: "Service, contribution, making a difference"
)

# 10. Spirituality & Inner Life Star
spirituality = Galaxy.create!(
  name: "Spirituality & Inner Life Star",
  color: "#6D28D9",
  icon: "🧘",
  description: "Inner peace, meaning, connection to something greater"
)

# 11. Environment & Home Star
environment = Galaxy.create!(
  name: "Environment & Home Star",
  color: "#92400E",
  icon: "🏡",
  description: "Living space, sanctuary, belonging"
)

puts "Creating Questions..."

# Career Star Questions (12)
[
  "If you could try any job in the world for one year, with guaranteed success, what would it be?",
  "What part of your current or past work has brought you the most joy or satisfaction?",
  "Imagine your career has a \"highlight reel\" in 10 years — what's featured in it?",
  "If you could work with any mentor, leader, or organisation, who would you choose and why?",
  "What is one skill you'd love to master that could change the direction of your career?",
  "If your work had no limits — in resources, time, or recognition — what project would you take on?",
  "What kind of team or colleagues do you dream of working alongside?",
  "If you could design your ideal work environment, what would it look and feel like?",
  "What's one career risk you secretly wish you could take?",
  "Looking ahead, what professional achievement would make you feel \"I've made it\"?",
  "What is one 30-minute action you can take this week that nudges your dream career?",
  "What part of your current work could be reframed into an opportunity if you changed the scope or audience?"
].each { |q| career.questions.create!(content: q) }

# Life Purpose Star Questions (11)
[
  "What do you want to be remembered for by the people closest to you?",
  "If you could contribute to solving one problem in the world, which would it be?",
  "What values feel most important to you, and how do you try to live them out?",
  "Imagine someone writes your life story in 50 years — what's the title of the book?",
  "When do you feel most alive, most \"yourself\"?",
  "If you could leave behind a message or teaching for future generations, what would it be?",
  "What role do kindness, service, or giving play in your life?",
  "If you could design a legacy project that reflects your purpose, what would it look like?",
  "What's one small way you already live in alignment with your deeper purpose?",
  "If you could hear your 90-year-old self-give you advice right now, what would they say?",
  "Which strengths do others reliably notice in you, and how might those point to your purpose?"
].each { |q| purpose.questions.create!(content: q) }

# Relationships & Connection Star Questions (11)
[
  "Who in your life brings out the best in you, and what do they spark?",
  "If you could strengthen one relationship right now, which would you choose and how?",
  "Imagine hosting a dinner with anyone you'd love to connect with — who's at the table?",
  "What's one small act of connection or kindness that would mean a lot to you right now?",
  "Who from your past would you love to reconnect with, and what would you say?",
  "If you could design your \"ideal circle\" of friends or community, what would it feel like?",
  "What kind of relationships do you want to be known for having built in your life?",
  "If distance, time, or money weren't barriers, how would you spend more time with the people you love?",
  "What's one tradition or ritual you'd love to start (or bring back) with others?",
  "Imagine 20 years from now — what kind of connections would make you feel deeply fulfilled?",
  "What boundary would make your connections more energising?"
].each { |q| relationships.questions.create!(content: q) }

# Creativity & Expression Star Questions (11)
[
  "If you could instantly master any creative skill (painting, music, design, writing, etc.), which would you choose?",
  "What's the most creative thing you've done that made you feel proud or alive?",
  "Imagine a gallery, stage, or platform showcasing your work in 10 years — what's on display?",
  "What childhood hobby or interest would you love to revisit as an adult?",
  "If you had a blank canvas and unlimited resources, what would you create first?",
  "Who is a creative figure (artist, innovator, storyteller) that inspires you, and why?",
  "If you could collaborate with anyone in the world on a creative project, who would it be?",
  "What's a wild idea you've had but never pursued?",
  "How do you currently express yourself in everyday life — and how would you love to expand that?",
  "If creativity was your main path in life, what kind of world would you want to build through it?",
  "What is a 'too-perfect' idea you could deliberately 'ship messy' in the next 7 days to create momentum?"
].each { |q| creativity.questions.create!(content: q) }

# Health & Vitality Star Questions (11)
[
  "If you could wake up tomorrow with one new healthy habit fully in place, what would it be?",
  "When in your life have you felt the most energised and alive? What contributed to that?",
  "Imagine yourself at age 90 — what do you want your body and mind to be capable of then?",
  "If you could design your ideal daily routine for health and wellbeing, what would it include?",
  "What kind of movement, sport, or activity makes you feel joyful rather than like a chore?",
  "If stress disappeared from your life for a month, what would you notice about yourself?",
  "What's one small wellbeing practice you'd love to try but haven't yet?",
  "If you could build your perfect \"health sanctuary\" at home, what would it look and feel like?",
  "Who do you admire for the way they take care of themselves, and what can you learn from them?",
  "If health wasn't about fixing problems but about expanding possibilities, what would you do more of?",
  "When stress shows up, what reframe helps you turn it into a cue for replenishment rather than a signal to push harder?"
].each { |q| health.questions.create!(content: q) }

# Adventure & Experiences Star Questions (11)
[
  "If you could wake up anywhere in the world tomorrow, where would it be?",
  "What's one adventure you've always dreamed of but haven't yet taken?",
  "Imagine you had a year off with unlimited resources — how would you spend it?",
  "What's the boldest or most exciting thing you've ever done, and how did it feel?",
  "If you could design the ultimate trip or experience for your friends/family, what would it include?",
  "What's a small adventure you could add into your life this month?",
  "Which culture, place, or tradition would you love to immerse yourself in?",
  "If you could master any adventure skill (diving, climbing, sailing, flying), which would you choose?",
  "What kind of story do you want to tell about your adventures 20 years from now?",
  "If you could combine adventure with purpose (e.g., learning, giving back, creativity), what would you do?",
  "What fear has kept one adventure on hold, and what is a safer 'first rung' version you could try?"
].each { |q| adventure.questions.create!(content: q) }

# Finances & Wealth Star Questions (11)
[
  "If money were no object, what's the first thing you would do?",
  "What does \"financial freedom\" look like to you personally?",
  "Imagine you had the resources to fund any project or cause — what would you choose?",
  "What's one thing you'd love to invest in, not just for money but for meaning?",
  "If you designed your ideal lifestyle without money worries, what would it include?",
  "What's a memory of when money gave you joy rather than stress?",
  "If you could learn one financial skill instantly (investing, property, entrepreneurship), what would it be?",
  "What's a luxury or indulgence you secretly dream of enjoying one day?",
  "How would you like to use wealth to support people you care about?",
  "Looking back at the end of your life, what would make you feel you used your money well?",
  "If money felt like a set of choices rather than limits, what new option would appear this year?"
].each { |q| finance.questions.create!(content: q) }

# Learning & Growth Star Questions (10)
[
  "If you could instantly master any subject or skill, what would it be?",
  "What's something you've always wanted to learn but never made time for?",
  "Imagine yourself 10 years from now — what new abilities or knowledge would you love to have?",
  "What's the most valuable thing you've learned outside of school or formal education?",
  "If you could go back to being a beginner at something, what would you choose and why?",
  "Who is someone you admire for their curiosity or commitment to growth, and what inspires you about them?",
  "If learning could feel like pure play, what would you explore?",
  "What's a fear or limitation you'd love to overcome through learning?",
  "How do you most enjoy learning — by doing, reading, listening, creating, or something else?",
  "If you could teach others one thing you know well, what would you share?"
].each { |q| learning.questions.create!(content: q) }

# Community & Impact Star Questions (10)
[
  "If you could make one positive change in your community tomorrow, what would it be?",
  "What's a cause or issue you feel deeply connected to?",
  "Imagine you had unlimited time and resources to give — how would you contribute?",
  "Who has made a lasting impact on your life, and how might you honour or pass that forward?",
  "What role do you dream of playing in your community (e.g., mentor, organiser, creator, supporter)?",
  "If you could volunteer anywhere in the world, where would it be and what would you do?",
  "What's a small act of impact you could start this week?",
  "Imagine a ripple effect of your actions — what do you hope others would carry forward from you?",
  "If you could create a space, group, or initiative for others, what would it look like?",
  "Looking back in old age, how would you want to describe the difference you made to people around you?"
].each { |q| community.questions.create!(content: q) }

# Spirituality & Inner Life Star Questions (10)
[
  "When do you feel most at peace or most connected to yourself?",
  "What practices (meditation, prayer, reflection, time in nature) help you feel centred?",
  "Imagine a sanctuary just for you — what would it look, sound, and feel like?",
  "If you could spend a day with a spiritual teacher, philosopher, or guide (past or present), who would it be?",
  "What values or principles guide the way you try to live your life?",
  "If you could fully trust life or the universe in one area, what would it be?",
  "When have you felt a sense of awe or wonder that took your breath away?",
  "What role do rituals, traditions, or symbols play in your life, if any?",
  "If you could give your future self-one piece of inner wisdom, what would it be?",
  "How do you want to nurture your inner life in the years ahead?"
].each { |q| spirituality.questions.create!(content: q) }

# Environment & Home Star Questions (10)
[
  "If you could live anywhere in the world, where would you choose and why?",
  "What does your ideal home or living space look and feel like?",
  "When have you felt most \"at home\" in your life, and what created that feeling?",
  "If you could design your dream city, town, or neighbourhood, what would it include?",
  "How do you want nature to be part of your daily life?",
  "What's one small change you'd love to make in your current environment?",
  "If sustainability were effortless, how would you like to live differently?",
  "Imagine hosting loved ones in your perfect space — what's happening there?",
  "What objects, colours, or symbols make you feel grounded and inspired at home?",
  "Looking ahead, what kind of environment would best support the life you want to live?"
].each { |q| environment.questions.create!(content: q) }

# Update question counts
Galaxy.find_each do |galaxy|
  galaxy.update(question_count: galaxy.questions.count)
end

puts "Seed data created successfully!"
puts "Galaxies: #{Galaxy.count}"
puts "Questions: #{Question.count}"
