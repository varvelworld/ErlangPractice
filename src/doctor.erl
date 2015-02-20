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
-export([loop/2]).
-export([start/2]).

loop(F, A) ->
  process_flag(trap_exit, true),
  receive
    new ->
      io:format("Creating and monitoring process.~n"),
      register(A, spawn_link(F)),
      loop(F, A);
    {'EXIT', From, Reason} ->
      io:format("The process ~p died with reson ~p~n", [From, Reason]),
      io:format(" Restarting~n."),
      self() ! new,
      loop(F, A)
  end.

start(F, A) ->
  D = spawn(doctor, loop, [F, A]),
  D ! new,
  D.