
-module(sc_hn).





-export([

    general_hn_score/7,

    fake_stories/0,
      fake_stories/1,

    fake_story/0

]).





-type story() :: {

    story,
    Points::integer(),
    Timestamp::non_neg_integer(),
    Title::binary(),
    Poster::binary(),
    Site::binary(),
    CommentCount::binary()

}.





-record(story, {

    points        :: integer(),
    timestamp     :: non_neg_integer(),
    title         :: binary(),
    poster        :: binary(),
    site          :: binary(),
    comment_count :: binary()

} ).





fake_stories() ->

    fake_stories(100).





fake_stories(Count) ->

    [ fake_story() || _I <- lists:seq(1,Count) ].





-spec fake_story() -> story().

fake_story() ->

    #story {
        points        = sc:rand_between(-20,20) + sc:rand(20) + sc:rand(50),
        timestamp     = sc:unixtime() - sc:rand(400000), % about 5 days
        title         = list_to_binary(don_martin:words()),
        poster        = list_to_binary(don_martin:word()),
        site          = list_to_binary(don_martin:word() ++ don_martin:word() ++ sc:random_from([ ".com", ".net", ".org" ])),
        comment_count = sc:rand(50) + sc:rand(50) + sc:rand(50) + sc:rand(50)
    }.





%% @doc Calculates one Hacker News style ranking entry with coefficients removed, for ordering by 
%% age and score.  Follows the algorithm claimed in 
%% http://www.righto.com/2013/11/how-hacker-news-ranking-really-works.html .

general_hn_score(Votes, Age, Penalty, VoteOffset, AgeOffset, VoteDecay, Gravity) ->

    (math:pow(Votes + VoteOffset, VoteDecay) / math:pow(Age + AgeOffset, Gravity)) * Penalty.
