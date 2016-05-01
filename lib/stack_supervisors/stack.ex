defmodule Stack do
  use GenServer

  def start_link(stash_pid) do
    GenServer.start_link(__MODULE__, stash_pid, name: __MODULE__)
  end

  def push(element) do
    GenServer.cast(__MODULE__, {:push, element})
  end

  def pop do
    GenServer.call(__MODULE__, :pop)
  end

  ###
  ### GenServer implementation
  ###

  def init(stash_pid) do
    current_stack = Stack.Stash.get_value stash_pid
    {:ok, {current_stack, stash_pid}}
  end

  def handle_call(:pop, _from,  {[h|t] = stack, stash_pid}) do
    {:reply, h, {t, stash_pid}}
  end

  def handle_cast({:push, element}, {stack, stash_pid}) do
    {:noreply, {[element|stack], stash_pid}}
  end

  def terminate(_reason, {current_stack, stash_pid}) do
    Stack.Stash.save_value stash_pid, current_stack
  end
end
