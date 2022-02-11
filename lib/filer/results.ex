defmodule Filer.Results do

  use GenServer

  @me __MODULE__

  def start_link(hash_list) do
    GenServer.start_link(__MODULE__, hash_list, name: __MODULE__)
  end

  def init(hash_list) do
    {:ok, hash_list}
  end

  def get(hash) do
    GenServer.call(@me, { :get, hash} )
  end

  def add( {hash, file} ) do
    GenServer.cast(@me, { :add, {hash, file} } )
  end

  def handle_call( {:get, hash}, _from, hash_list) do
    hash = String.to_atom(hash)
    files = Keyword.get_values(hash_list, hash)
    {:reply, files, hash_list}
  end

  def handle_cast( { :add, {hash, file}}, hash_list) do
    hash = String.to_atom(hash)
    hash_list = Keyword.merge(hash_list, [{hash, file}])
    { :noreply, hash_list }
  end
end
