class RunTestJob < ApplicationJob
  queue_as :default

  def perform(test_run_detail)
    test_run_detail.update!(status: 'running')
    output = generate(test_run_detail)
    test_run_detail.update!(output: output, status: 'complete')
    test_run_detail.test_run.check_and_update_status
  rescue StandardError => e
    puts "Error: #{e}"
    test_run_detail.update!(status: 'error')
    test_run_detail.test_run.check_and_update_status
  end

  private

  def generate(test_run_detail)
    system_message = test_run_detail.prompt_version.text
    user_message = test_run_detail.input.text
    full_prompt = "#{system_message}/n/n#{user_message}"
    response_format = test_run_detail.test_run.test_suite.response_format
    org = test_run_detail.test_run.test_suite.account.organization
    client = OpenAI::Client.new(access_token: org.openai_api_key)

    response = client.chat(
      parameters: {
        model: test_run_detail.model.name,
        response_format: {
          type: response_format == 'json' ? 'json_object' : nil
        },
        messages: [
          {
            "role": "system",
            "content": full_prompt
          }
        ]
      })
    response["choices"][0]["message"]["content"]

  end

end
