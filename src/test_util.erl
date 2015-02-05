%%%-------------------------------------------------------------------
%%% @author luzhonghao
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 29. 一月 2015 下午8:11
%%%-------------------------------------------------------------------
-module(test_util).
-author("luzhonghao").

%% API
-export([test/2]).
-export([test/1]).

test(CaseName, CaseFun)->
  io:format("~n=====================~n"),
  io:format("Test:~s", [CaseName]),
  io:format("~n"),
  CaseFun(),
  io:format("~n=====================~n").

test([])->ok;
test([{CaseName, CaseFun} | Cases])->
  test(CaseName, CaseFun),
  test(Cases).