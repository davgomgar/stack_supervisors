defmodule Stack.Supervisor do
  use Supervisor

  def start_link(default_stack \\ []) do
    result = {:ok, supervisor_pid} = Supervisor.start_link(__MODULE__, [default_stack], name: __MODULE__)

    start_workers(supervisor_pid, default_stack)

    result
  end

  def start_workers(pid, default_stack) do
    #Start stash worker
    {:ok, stash_pid} = Supervisor.start_child(pid, worker(Stack.Stash, [default_stack]))
    #Start sub supervisor
    Supervisor.start_child(pid, supervisor(Stack.SubSupervisor, [stash_pid]))
  end

  def init(_) do
    supervise [], strategy: :one_for_one
  end
end
