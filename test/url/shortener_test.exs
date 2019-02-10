defmodule URL.ShortenerTest do
  use ExUnit.Case, async: true

  setup do
    url = "http://teste.com"
    %{url: url}
  end

  test "it saves urls and returns a hash", %{url: url} do
    assert {:ok, hash} = URL.Shortener.encode(url)
  end

  test "it returns the original url if given its hash", %{url: url} do
    {:ok, hash} = URL.Shortener.encode(url)
    {returned_url, hits} = URL.Shortener.decode(hash)
    assert returned_url == url 
  end
end
