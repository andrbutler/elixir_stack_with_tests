defmodule StackTest do
  use ExUnit.Case
  doctest Stack


  test "start_link/1 - default state" do
    {:ok, pid} = Stack.start_link("test")
    assert :sys.get_state(pid) == []
  end
  test "start_link/1 - default configuration" do
    {:ok, pid} = Stack.start_link(["test1", "test2"])
    assert :sys.get_state(pid) == ["test1", "test2"]
  end
  test "pop/1 - remove one element from stack" do
    {:ok, pid} = Stack.start_link(["test1", "test2"])
    Stack.pop(pid)
    assert :sys.get_state(pid) == ["test2"]
  end
  test "pop/1 - remove multiple elements from stack" do
    {:ok, pid} = Stack.start_link(["test1", "test2", "test3", "test4", "test5"])
    Stack.pop(pid)
    Stack.pop(pid)
    assert :sys.get_state(pid) == ["test3", "test4", "test5"]
  end
  test "pop/1 - remove element from empty stack" do
    {:ok, pid} = Stack.start_link([])
    assert Stack.pop(pid) == nil
  end
  test "push/2 - add element to empty stack" do
    {:ok, pid} = Stack.start_link([])
    Stack.push(pid, "test")
    assert :sys.get_state(pid) == ["test"]
  end
  test "push/2 - add element to stack with multiple elements" do
    {:ok, pid} = Stack.start_link(["test1", "test2", "test3", "test4", "test5"])
    Stack.push(pid, "test6")
    assert :sys.get_state(pid) == ["test6", "test1", "test2", "test3", "test4", "test5"]
  end


end
