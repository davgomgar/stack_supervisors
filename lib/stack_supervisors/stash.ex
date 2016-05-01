defmodule Stack.Stash do
  use GenServer

  def start_link(current_stack) do
    {:ok, pid} = GenServer.start_link(__MODULE__, current_stack, name: __MODULE__)
  end

  def save_value(pid, stack) do
    GenServer.cast pid, {:set_value, stack}
  end

  def get_value(pid) do
    GenServer.call(pid, :get_value)
  end

  ####
  # GenServer Implementtion
  ###

  def handle_call(:get_value, _from, state) do
    {:reply, state, state}
  end

  def handle_cast({:set_value, stack}, _current_stack) do
    {:noreply, stack}
  end
end
