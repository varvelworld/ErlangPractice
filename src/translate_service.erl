%%%-------------------------------------------------------------------
%%% @author Hao
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 16. 二月 2015 15:53
%%%-------------------------------------------------------------------
-module(translate_service).
-author("Hao").

%% API
-export([loop/0, translate/2]).

loop() ->
    receive
    {From, "casa"} ->
      From ! "house",
      loop();
    {From, "blance"} ->
      From ! "white",
      loop();
    {From, _} ->
      From ! "I don't understand",
      exit({translate_service, die, at, erlang:time()}),
      loop()
  end.

translate(To, Word) ->
  To ! {self(), Word},
  receive
    Translation -> Translation
  end.