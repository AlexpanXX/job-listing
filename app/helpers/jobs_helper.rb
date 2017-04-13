module JobsHelper
  def render_job_description(job)
    simple_format(job.description)
  end

  def render_job_states(job)
    if job.is_hidden
      "(Hidden)"
    else
      "(Public)"
    end
  end
end
