defmodule Stack do
  @moduledoc """
  Documentation for `Stack`.
  Genserver based implementation of a stack data structure. after starting server, after starting server, user can add items to stack and
  retreive them in last in first out order.
  """
  use GenServer

  #Client Functions

  @doc """
  starts the server
  """
  def start_link(init_state) when is_list(init_state) do
    GenServer.start_link(__MODULE__, init_state)
  end

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, [])
  end

  @doc """
  adds a new element to server

  ## Examples
  iex> {:ok, pid} = Stack.start_link([])
  iex> Stack.push(pid, "test")
  :ok
  iex> :sys.get_state(pid)
  ["test"]
  """
  def push(pid, element) do
    GenServer.cast(pid, {:push, element})
  end


  @doc """
  removes last element from  server and returns it.

  ## Examples
  iex> {:ok, pid} = Stack.start_link([])
  iex> Stack.push(pid, "test")
  :ok
  iex> Stack.push(pid, "test2")
  :ok
  iex> Stack.pop(pid)
  "test2"
  iex> Stack.pop(pid)
  "test"
  iex> Stack.pop(pid)
  nil
  """
  def pop(pid) do
    GenServer.call(pid, :pop)
  end

  #Server Functions
  @impl true
  def init(inital_state) do
    {:ok, inital_state}
  end

  @impl true
  def handle_cast({:push, element}, state) do
    {:noreply, [element | state]}
  end

  @impl true
  def handle_call(:pop, _from, state) do
    {element, state} = List.pop_at(state, 0)
    {:reply, element, state}
  end
end
