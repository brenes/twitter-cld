# Twitter language detection

This project aims to mix [kermit](http://rubygems.org/gems/cld) and [cld](http://rubygems.org/gems/cld) gems to accomplish an awesome goal, performing real language detection over tweets using Google Chrome's compact language detection library.

## What does it do?

Right now it just print some statistics on screen with the amount of tweets per language.

## How to Install

Clone this repository

```
git clone git://github.com/brenes/twitter-cld.git
```

Bundle it

```
bundle
```

And that's it.

## How to Use

First we need to config kermit (we can use the config.yml.example file at config folder).

Tipically we will only modify lines 25 (for tracking a different keyword on twitter), 27 and 29 (for twitter credentials).

Once we have configured kermit we run it:

```
kermit config/kermit.yml
```

Then we run the twitter language detection library

```
ruby twitter-cld.rb
```

If we have modified webscokets server's host or port we must set the new values to the twitter-cld.rv script. Just run

```
ruby twitter-cld.rb help
```

And if you want to check the fnordmetrics integration, just run

```
ruby twitter-cld.rb metrics
```