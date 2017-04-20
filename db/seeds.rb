# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.delete_all
Startup.delete_all
Job.delete_all
Resume.delete_all
puts "users/startups/jobs/resumes deleted."

user = User.create!(
  email: "ppgod@live.cn",
  password: "12345678",
  is_admin: true
)
puts "admin user created."

num = 0
50.times {
  startup = Startup.create!(
    name: "Startup " + (num += 1).to_s,
    email: "startup_" + num.to_s + "@email.com",
    description: "Startup description " + num.to_s + " 公司描述信息。",
    is_hidden: num > 25 ? true : false
  )
  job_num = 0
  wage_lower = 5000
  wage_upper = 20000
  10.times {
    Job.create!(
      title: "Job " + (job_num += 1).to_s,
      description: "Job description " + job_num.to_s + " 职位描述信息。",
      wage_lower_bound: wage_lower += 100,
      wage_upper_bound: wage_lower += 1000,
      is_hidden: job_num > 5 ? true : false,
      startup_id: startup.id
    )
  }
  puts "5 hidden jobs and 5 public jobs created."
}
puts "25 hidden startups and 25 public startups created."

Job.all do |job|
  num = 0
  5.time {
    Resume.create!(
      content: "Resume content " + (num += 1).to_s,
      user_id: user.id,
      job_id: job.id
    )
  }
end
puts "5 resumes for each job created."
