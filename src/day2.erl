%%%-------------------------------------------------------------------
%%% @author luzhonghao
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 29. 一月 2015 下午7:32
%%%-------------------------------------------------------------------
-module(day2).
-author("luzhonghao").

%% API
-export([get_value/2]).
-export([test_all_cases/0]).

-import_all(test_util).

get_value(Map, Key) ->
  element(2, hd(lists:dropwhile(fun({K, _})-> Key /= K  end, Map) ++ [{[],[]}])). %% ++为列表拼接

test_all_cases()->
  test_util:test([
    {"get value from a map",
      fun()->
        io:format("~p~n", [get_value([{a,2}, {b,3}, {c,c}], b)]),
        io:format("~p~n", [get_value([{a,2}, {b,3}, {c,"a"}], c)]),
        io:format("~p~n", [get_value([{a,2}, {b,3}, {c, []}], d)])
      end
    }
  ]).