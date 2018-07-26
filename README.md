## Ru-Sham-bo

Challenge friends to Rock-paper-scissors from anywhere! See if your favorite RPS strategy you learned from your cousin will get you on the top of the 
Ru-Sham-Bo leaderboard. Keep track of your Ru-Rank, win percentage and more. Battle to become the Ru-Sham-Bo Master!

## Motivation

This project was first conceived a few years ago by my students in the [MHS Byte Club](https://www.mhsbyte.org).
Students wanted to create a game with minimal logic that others could play. The goal of the project was to build
community within the school with friendly, low-stakes competition. At the time, this project was VASTLY out of my
ability level. After building it here, I intend to bring the numerous lessons I've learned back to create a copy
with the help of my students. 

It is those students that inspired me to make this project and to them it is dedicated!


## Installation

### Setup
1. Clone [this repository](https://github.com/mrfarmer777/ru-shambo) to your local development environment.
2. `cd` into your ru-shambo director and run `bundle install`.
3. Set up your database by running `rake db:migrate` from the terminal
4. Run `rails s` to start up a server
5. Invite friends
6. Get Ru-sham-bo-ing.

### Notes
* Google login will not function for your cloned workspace, but native user creation will work just fine.

## Built with
* Cloud9 IDE
* Rails 
* bcrypt
* Bootstrap-sass

## Contributing

When contributing to this repository, please first discuss the change you wish to make via issue,
email, or any other method with the owners of this repository before making a change.

### Pull Request Process
1. Update the README.md with details of changes to the interface, this includes new environment
   variables, exposed ports, useful file locations and container parameters.
2. Increase the version numbers in any examples files and the README.md to the new version that this
   Pull Request would represent.
3. For now, I'll perform the merge after I review any pull requests.

## Authors
* [Matt Farmer] (https://www.matt-farmer.com)

## License
This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments
Thanks to the students of the [MHS Byte Club](https://www.mhsbyte.org) for inspiring this and many other projects.
Thanks to Joshua Kovach for his [awesome post](https://collectiveidea.com/blog/author/joshua-kovach) on bi-directional self referential assocations, without which I would have been stuck on Sprint 1.
Thanks to my family for letting me disappear for hours while I code! (3 hr > 1 hr + 1 hr + 1 hr)!


## Current Working Issues
To implement a many-to-many self join, I utilized a strategy outlined by Joshua Kovach [here] (https://collectiveidea.com/blog/archives/2015/07/30/bi-directional-and-self-referential-associations-in-rails). 
This strategy has numerous benefits for the app, but I've also identified the following limitations.
* Two users may only have one active 'match'
* It is hypothetically possible for match collisions to occur if two users instantiate a match within seconds of each other, before each match's inverse has been created. 