defmodule Phoenix.LiveView.UploadChannel do
  @moduledoc false
  use GenServer

  require Logger

  alias Phoenix.LiveView
  alias Phoenix.LiveView.{Socket, View, Diff}

  alias Phoenix.LiveView.UploadFrame

  def start_link({auth_payload, from, phx_socket}) do
    GenServer.start_link(__MODULE__, {auth_payload, from, phx_socket})
  end

  @impl true
  def init(triplet) do
    send(self(), {:join, __MODULE__})
    {:ok, triplet}
  end

  @impl true
  def handle_info({:join, __MODULE__}, {_, from, _} = state) do
    GenServer.reply(from, {:ok, %{}})
    {:noreply, state}
  end

  def handle_info(%Phoenix.Socket.Message{topic: topic, payload: payload} = msg, state) do
    IO.inspect {:payload, payload}
    {:noreply, state}
  end

  def handle_info(_, state) do
    {:noreply, state}
  end
end
