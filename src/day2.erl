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
-export([compute_price/1]).
-export([tictactoe/1]).
-export([test_all_cases/0]).

-import_all(test_util).

get_value(Map, Key) ->
  element(2, hd(lists:dropwhile(fun({K, _})-> Key /= K  end, Map) ++ [{[],[]}])). %% ++为列表拼接

compute_price(ShopingList) ->
  [{Item, Quantity * Price} || {Item, Quantity, Price} <- ShopingList].

tictactoe(Board)->
  DealBoard = Board
    ++ fun([[A1, B1, C1],[A2, B2, C2],[A3, B3, C3]])-> [[A1, A2, A3], [B1, B2, B3], [C1, C2, C3]] end(Board)
    ++ fun([[A1, _, C1],[_, B2, _],[A3, _, C3]])-> [[A1, B2, C3], [A3, B2, C1]] end(Board),
   fun
     CheckDealBoard([[x, x, x] | _], _) -> x;
     CheckDealBoard([[o, o, o] | _], _) -> o;
     CheckDealBoard([], true) -> cat;
     CheckDealBoard([], false) -> no_winner;
     CheckDealBoard([Hd | Tail], CanWin)
      ->
       %% if 使用的是哨兵，不能在其中调用函数，以免产生副作用
       if
         CanWin -> CheckDealBoard(Tail, true); %% 匿名函数递归
         true -> CheckDealBoard(Tail, not lists:any(fun(x)-> true; (o)->true; (_)->false end, Hd))
       end
  end(DealBoard, false).

test_all_cases()->
  test_util:test([
    {"get value from a map",
      fun()->
        io:format("~p~n", [get_value([{a,2}, {b,3}, {c,c}], b)]),
        io:format("~p~n", [get_value([{a,2}, {b,3}, {c,"a"}], c)]),
        io:format("~p~n", [get_value([{a,2}, {b,3}, {c, []}], d)])
      end
    },
    {"compute shoping list",
      fun()->
        io:format("~p~n", [compute_price([{"juice", 3, 4}, {"chips", 3, 5.5}, {"coffe", 7, 2.1}])])
      end
    },
    {"tictactoe",
      fun()->
        io:format("~p~n", [tictactoe([
          [o,o,x],
          [x,x,0],
          [0,0,0]
        ])]),
        io:format("~p~n", [tictactoe([
          [x,o,0],
          [o,x,0],
          [0,0,x]
        ])])
      end
    }

  ]).