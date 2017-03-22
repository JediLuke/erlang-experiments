-module(mynif).
-export([start/0, hello/3]).

% Automatically load native code module
-on_load(start/0).

start() ->
    erlang:load_nif("./mynif", 0).

hello(_A, _B, _C) ->
      "NIF library not loaded".