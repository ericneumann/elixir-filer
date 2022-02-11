defmodule Filer.Results do

  use GenServer

  @me __MODULE__

  def start_link(hash_map) do
    GenServer.start_link(__MODULE__, hash_map, name: __MODULE__)
  end

  def init(hash_map) do
    {:ok, hash_map}
  end

  def get(hash) do
    GenServer.call(@me, { :get, hash} )
  end

  def get_duplicates do
    GenServer.call(@me, :get_duplicates)
  end

  def add( hash, file ) do
    GenServer.cast(@me, { :add, hash, file } )
  end


  def handle_cast( { :add, hash, file}, hash_map) do
    hash_map =
      Map.update(
        hash_map,
        hash,
        [ file ],
        fn existing ->
          [ file | existing ]
        end)

    { :noreply, hash_map }
  end

  def handle_call( {:get, hash}, _from, hash_map) do
    files = Map.get(hash_map, hash)
    {:reply, files, hash_map}
  end

  def handle_call( :get_duplicates, _from, hash_map) do
    duplicates = find_duplicate_hashes(hash_map)
    {:reply, duplicates, hash_map}
  end

  defp find_duplicate_hashes(hash_map) do
    Enum.filter(hash_map, fn {_k, v} -> length(v) > 1 end)
  end
end
