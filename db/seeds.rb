# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.delete_all
Job.delete_all
Resume.delete_all

User.create!(
  email: "ppgod@live.cn",
  password: "12345678",
  is_admin: true
)

num = 0
wage_lower = 5000
wage_upper = 10000
50.times {
  Job.create!(
    title: "Job " + (num += 1).to_s,
    description: "Job " + num.to_s + " description",
    wage_lower_bound: wage_lower += 1,
    wage_upper_bound: wage_upper -= 1,
    contact_email: "ppgod@live.cn",
    is_hidden: false
  )
}

user = User.first
job = Job.first
5.times {
  Resume.create!(
    content: "Job first resume content.",
    user_id: user.id,
    job_id: job.id
  )
}
