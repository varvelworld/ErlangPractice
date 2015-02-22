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
    start ->
      io:format("Start and monitoring process.~n"),
      Found = lists:member(A, registered()) andalso erlang:is_process_alive(whereis(A)),
      if
        Found ->
          io:format("Reattaching to running process ~p.~n", [A]),
          link(whereis(A));
        true ->
          io:format("Creating and monitoring process, attaching to atom ~p.~n", [A]),
          register(A, spawn_link(F))
      end,
      loop(F, A);
    die ->
      io:format("I'm died~n"),
      exit({die, at, time, erlang:time()});
    {'EXIT', From, Reason} ->
      io:format("The process ~p died with reson ~p~n", [From, Reason]),
      io:format(" Restarting~n."),
      self() ! start,
      loop(F, A)
  end.

start(F, A) ->
  D = spawn(doctor, loop, [F, A]),
  D ! start,
  D.