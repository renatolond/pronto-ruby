RBS and Steep
---

This branch contains some experimentation using RBS + RBS inline and Steep.

I generated some RBS files using `rbs prototype rb` from the pronto project to be able to re-use them here. Those are `sig/pronto/formatter.rbs`, `sig/pronto/formatter/base.rbs`, `sig/pronto/message.rbs`. They are really barebones and mostly just there so steep can find the definitions of the classes and not error out with `[warning] Cannot find the declaration of constant: xxx`.

Then, I added type definitions using rbs inline to `src/annotation.rb` and `src/github_action_check_run_formatter.rb`. Following rbs-inline recommendations, I've been using rerun to do `bundle exec rerun -- bundle exec rbs-inline --output src`. This generates the needed signatures for steep to be able to check the files.

I also tried using rbs collection for missing definitions, which improves some stuff, but it seems for OpenStruct rbs gets a bit lost?
