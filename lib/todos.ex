defmodule Todos do
  def create_todos do
    # number_of_tasks = IO.gets("Enter the number of tasks you want to add: ")
    # {number_of_tasks, _q} = Integer.parse(number_of_tasks)
    # number_of_tasks

    # cool-code: pipeline operator
    # |>
    {number_of_tasks, _q} = IO.gets("Enter the number of tasks you want to add: ") |> Integer.parse
    # number_of_tasks

    #list comprehension
    for _i <- 1..number_of_tasks, do: IO.gets("Enter the task: ") |> String.trim # to remove extra spaces
  end

  def temp_todos do
    ["eat apple", "exercise", "read book", "avoid junk food", "go to gym", "write a book"]
  end

  #delete a completed task
  def completed_task(tasks, task) do
    if contains?(tasks, task) do
      List.delete(tasks, task)
      #execute this block
    else
      #otherwise this block
      :not_found_error
    end
  end

  #add new task
  def add_new_task(tasks, new_task) do
    List.insert_at(tasks, -1, new_task) # -1 because the task should be entered at the end
  end

  #to check is a task is present in todo_list
  def contains?(tasks, task) do
    Enum.member?(tasks, task)
  end

  #to select task randomly
  def random_task(tasks) do
    [task] = Enum.take_random(tasks, 1)
    task #we don't want a list to be returned
  end

  #search using a keyword
  def keyword_search(tasks, keyword) do
    for task <- tasks, String.contains?(task, keyword) do
      task
    end
  end

  def save(tasks, filename) do
    #invoking erlang code
    #converting our list so that it can be written to our file system
    binary = :erlang.term_to_binary(tasks)
    File.write(filename, binary)
  end

  def show_tasks(filename) do
    case File.read(filename) do #read function always returns a tuple in which first element is always an atom
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _} -> :file_does_not_exist  #we don't care much about the second element so we are ignoring it
    end

    ##!!!!!! To avoid error message we are going to use case statement
    # #retrieve the data from the file
    # {_, binary} = File.read(filename)

    # #converting binary file into the original form
    # :erlang.binary_to_term(binary)
  end
end
