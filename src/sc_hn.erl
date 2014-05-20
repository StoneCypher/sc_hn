
-module(sc_hn).





-export([

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
        sc:rand_between(-20,20) + sc:rand(20) + sc:rand(50),
        sc:unixtime() - sc:rand(400000), % about 5 days
        list_to_binary(don_martin:words()),
        list_to_binary(don_martin:word()),
        list_to_binary(don_martin:word() ++ don_martin:word() ++ sc:random_from([ ".com", ".net", ".org" ])),
        sc:rand(50) + sc:rand(50) + sc:rand(50) + sc:rand(50)
    }.