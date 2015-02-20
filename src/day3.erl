%%%-------------------------------------------------------------------
%%% @author Hao
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 21. 二月 2015 0:04
%%%-------------------------------------------------------------------
-module(day3).
-author("Hao").

%% API
-export([start/0]).
-export([translate/1]).
-import_all(doctor).
-import_all(translate_service).

start() ->
  doctor:start(fun translate_service:loop/0, translate).
translate(Word) ->
  translate_service:translate(translate, Word).
