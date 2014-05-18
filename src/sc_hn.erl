
-module(sc_hn).





-export([

    fake_stories/0,
      fake_stories/1,

    fake_story/0

]).





fake_stories() ->

    fake_stories(100).





fake_stories(Count) ->

    [ fake_story() || _I <- lists:seq(1,Count) ].





fake_story() ->

    { sc:rand_between(-20,20) + sc:rand(20) + sc:rand(50),
      sc:unixtime() - sc:rand(400000), % about 5 days
      don_martin:words(),
      don_martin:word(),
      don_martin:word() ++ don_martin:word() ++ sc:random_from([ ".com", ".net", ".org" ]),
      sc:rand(50) + sc:rand(50) + sc:rand(50) + sc:rand(50)
    }.