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
-export([start_doctor_v1/0]).
-export([start_translate_service/0]).
-export([translate/1]).
-import_all(doctor_v1).
-import_all(translate_service).

start_translate_service() ->
  register(translate, spawn(fun translate_service:loop/0)).
start_doctor_v1() ->
  doctor_v1:start(fun translate_service:loop/0, translate).


translate(Word) ->
  translate_service:translate(translate, Word).
