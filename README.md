## Ru-Sham-bo

FINALLY, a way to challenge your friends to Rock-paper-scissors using a Rails app! See if
your classic RPS strategy you learned from your cousin will get you on the top of the 
Ru-Sham-Bo leaderboard. Keep track of your record, win streaks, favorite plays, and more.

## Motivation


## Installation

### Clone

### Setup

## Built with
* Cloud9 IDE
* Rails 

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



## Current Working Issues
To implement a many-to-many self join, I utilized a strategy outlined by Joshua Kovach [here] (https://collectiveidea.com/blog/archives/2015/07/30/bi-directional-and-self-referential-associations-in-rails). 
This strategy has numerous benefits for the app, but I've also identified the following limitations.
* Two users may only have one active 'match'
* It is hypothetically possible for match collisions to occur if two users instantiate a match within seconds of each other, before each match's inverse has been created. 