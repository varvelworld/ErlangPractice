%%%-------------------------------------------------------------------
%%% @author hao
%%% @copyright (C) 2014, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 25. 十二月 2014 14:46
%%%-------------------------------------------------------------------
-module(day1).
-author("hao").

%% API
-export([number_of_word/1]).
-export([count10/0]).
-export([handler/1]).
-export([test_all_cases/0]).
-export([test_cases/1]).
-export([test_case/2]).

%% 递归统计单词数
number_of_word(Text)->length(recur_count_word(Text,[],[])).
%% 递归统计单词
append_new_word(Words, Word)->(lists:append(Words, [Word]));
append_new_word(Words, [])->Words.
recur_count_word([], Word, Words)->append_new_word(Words, [Word]);
recur_count_word([First|Text] , Word, Words)->
  if
    (hd("a") =< First) and (First =< hd("z")) or (hd("A") =< First) and (First =< hd("Z"))
      -> recur_count_word(Text, lists:append(Word, [First]), Words);
    true
      -> recur_count_word(Text, [], append_new_word(Words, [Word]))
  end.

count(0)->ok;
count(N)->count(N - 1), io:format("~p ", [N]).
count10()->count(10), io:format("~n").

handler(success)->io:format("~p~n", [success]);
handler({error, Message})->io:format("error:~p~n", [Message]).

test_case(CaseName, CaseFun)-> io:format("~n=====================~n"),
  io:format("Test:~s", [CaseName]),
  io:format("~n"),
  CaseFun(),
  io:format("~n=====================~n").

test_cases([])->ok;
test_cases([{CaseName, CaseFun} | Cases])->
  test_case(CaseName, CaseFun),
  test_cases(Cases).

test_all_cases()->
  test_cases([
    {"number_of_word", fun()->
      io:format("~p~n", [number_of_word("Ha    Ha  Ha , Hello!")])
    end},
    {"coutn 10", fun()->
      count10()
    end},
    {"input success", fun()->
      handler(success)
    end},
    {"input error", fun()->
      handler({error, "Errrrrrror"})
    end}
  ]).