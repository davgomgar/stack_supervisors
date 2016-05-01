defmodule StackSupervisors do
  use Application

  # for more information on OTP Applications
  def start(_type, _args) do
    {:ok, _pid} = Stack.Supervisor.start_link(["abc", 123])
  end
end
