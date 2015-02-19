%%%-------------------------------------------------------------------
%%% @author Hao
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 16. 二月 2015 18:07
%%%-------------------------------------------------------------------
-module(doctor).
-author("Hao").

%% API
-export([loop/0]).

loop() ->
  process_flag(trap_exit, true),
  receive
    new ->
      io:format("Creating and monitoring process.~n"),
      register(translate, spawn_link(fun translate_service:loop/0)),
      loop();
    {'EXIT', From, Reason} ->
      io:format("The translage service ~p died with reson ~p~n", [From, Reason]),
      self() ! new,
      loop()
  end.
