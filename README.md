# Time Logger for Redmine 7

Time logger is a Redmine plugin to ease time tracking when working on an issue: start a timer on an issue, pause and resume it, then stop it and log the spent time.

This fork is based on [speedy32129/time_logger](https://github.com/speedy32129/time_logger) and the Redmine 4/5 version by [red-soft-ru/time_logger](https://github.com/red-soft-ru/time_logger) (archived), adapted to Redmine 7.

## Requirements

* Redmine 7.0 or later. Tested with Redmine 7.0.2 and Ruby 3.4.
* For Redmine 4.x and 5.x use version 2022.05.0 from [red-soft-ru/time_logger](https://github.com/red-soft-ru/time_logger).

## Changes for Redmine 7 (2026.10.0)

* Redmine 7 renders the account menu inside the avatar dropdown, so the time logger is no longer an account menu item: it is shown in the top menu bar right before the user menu, and in the flyout menu under the avatar on narrow screens
* Time logger in the top menu: bold text and 16px icons, aligned with the Redmine 7 header
* Time logger items in the issue context menu are aligned with the core items
* The time logger list and the plugin settings use Redmine's SVG sprite icons (the old `icon-*` CSS classes were removed in Redmine 7)
* Deleting another user's time logger from the list no longer fails with HTTP 406

## Changes by red-soft-ru (2022.05.0)

* Plugin structure is overhauled
* Adapted to Rails 6
* Periodically ajax requests replaced with pure javascript timer
* Added functional tests

Preview (Redmine 5 layout):

![](https://github.com/red-soft-ru/time_logger/raw/41516d258daaaabcf6813761c452d670fde87799/1552138058249.gif)

## Install

1. Clone the plugin to your redmine root directory/plugins

    ```
    git clone https://github.com/midnightdim/time_logger.git redmine_directory/plugins/time_logger
    ```
2. Setup the database using the migrations

    ```
    bundle exec bin/rails redmine:plugins:migrate RAILS_ENV=production NAME=time_logger
    ```
3. Login to your Redmine install as an Administrator
4. Setup the 'log time' permissions for your roles
5. Enable a "Time tracking" module in the project settings
6. The time logger should appear in the top menu bar, next to the user menu

## Running tests

Inside your redmine root directory run command:


    bundle exec bin/rails redmine:plugins:test RAILS_ENV=test NAME=time_logger

## Uninstall 

1. Clean up a database: 

    ```
    bundle exec bin/rails redmine:plugins:migrate RAILS_ENV=production NAME=time_logger VERSION=0
    ```
2. Delete plugin folder: 

    ```
    rm -rf <redmine_root>/plugins/time_logger
    ```
