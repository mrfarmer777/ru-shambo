let user;
let userMatches=[];
let userActGames=[];
let userCompGames=[];
let showIndex=0;

///////DOCUMENT ON LOAD/////////////////////////
$(function(){
    //Initial call to retrieve all user data
    $.get(window.location.href+ "/data").done(function(resp){
        user=resp;
        let matches=resp.matches;
        userMatches=matches.map(function(match){
            let newMatch=new Match(match.id, match.opponent_name, match.active_games_count);
            return newMatch;
        });
        //Renders the index view using AJAX data
        buildMatchTable(userMatches);
        
        let games=resp.games
        games.forEach(function(game){
            
            let newGame= new Game(game.id, game.opponent_name, game.status, game.result)
            if(newGame.gameStatus==="Completed"){
                userCompGames.push(newGame);
            } else {
                userActGames.push(newGame);
            }
        })
        
        buildGamesTable(userActGames);
        
        
    });
    
    $("#show-next").on("click",showNext);
    $("#show-prev").on("click",showPrev);
    $("#leaderboard-header").on("click",renderLeaderboardData)
    $("#matchboard-header").on("click",renderMatchboard);
    
    
});

/////GAME OBJECT DEFINITION AND PROTOTYPING////////////////
function Game(id, opp_name, gameStatus, gameResult){
    this.id=id;
    this.opp_name=opp_name;
    this.gameStatus=gameStatus;
    this.result=gameResult;
}


function buildGamesTable(games){
    let table=$("<table class='table' id='active-games-table'></table>").html("<tr><th>Opponent</th><th>Game Status</th>");
   
    games.forEach(function(game,index){
        let gameRow=$(`<tr data-id"${game.id}" data-ind="${index}"><td>${game.opp_name}</td><td>${game.gameStatus}</td></tr>`);
        table.append(gameRow);
    });
    $("#main-show").html("").append(table);
    
}


//MATCH OBJECT DEFINITION AND PROTOTYPING//////////////////
function Match(id,opp_name,act_games_ct){
    this.id=id;
    this.opp_name=opp_name;
    this.active_games_count=act_games_ct;
}





/////////////INDEX VIEW OF MATCHES/////////////////////////////
function buildMatchTable(matchObjects){
    $("#matchboard-body").append("<table id='matches-table' class='table'><tr><th>Opponent</th><th>Active Games</th></tr></table>");
    matchObjects.forEach(function(match,ind){
        let matchRow= $(`<tr data-id="${match.id}" data-index="${ind}"></tr>`).html(`<td>${match.opp_name}</td><td>${match.active_games_count}</td>`);
        matchRow.addClass("match-row");
        matchRow.on("click",selectMatch);
        //matchRow.data("id",`${match.id}`);
        $("#matches-table").append(matchRow);
    });
}


function renderMatchboard(){
    $.get(window.location.href+"/matches")
}
    

////////////SHOW VIEW OF MATCHES////////////////////////////////    
function selectMatch(e){
    e.preventDefault();
    showIndex=parseInt(this.dataset.index,10);
    getMatchData(userMatches[showIndex].id);
}

function showNext(e){
    e.preventDefault();
    if(showIndex<userMatches.length-1){
        showIndex+=1;
    }
    getMatchData(userMatches[showIndex].id);
}

function showPrev(e){
    e.preventDefault();
    if(showIndex>0){
        showIndex-=1;
    }
    getMatchData(userMatches[showIndex].id);
}

function getMatchData(id){
    $.get("/matches/"+id).done(showMatch)
}


function showMatch(match){
    let oppName=match.opponent.name;
    let oppImage=match.opponent.image;
    let userName=user.name;
    let userImage=user.image;
    let matchId=match.id;
    let gameCount=match.games.length;
    let main=$("<div></div>").html(`${userName} vs. ${oppName}`);
    let stats=$("<div></div>").html(`Games: ${gameCount}`);
    $("#main-show").html("");
    $("#main-show").append(main).append(stats);
}


////////RENDERING THE LEADERBOARD//////////////////////

function renderLeaderboardData(){
    $.get("/leaders").done(function(resp){
        $("#leaderboard-table").html('<tr><th>Rank</th><th>Title</th><th>Name</th><th>Overall Record</th><th>Win Percentage</th></tr>').addClass("table");
        resp.forEach(function(leader,index){
            $("#leaderboard-table").append(`<tr><td>${index+1}</td><td></td><td>${leader.name}</td><td>${leader.record}</td><td>${leader.win_percentage}%</td></tr>`);
        });
    });
}
   

