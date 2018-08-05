let userMatches=[];
let userActGames=[];
let userCompGames=[];
let showIndex=0;

///////DOCUMENT ON LOAD/////////////////////////
$(function(){
    //Initial call to retrieve all user data
    $.get(window.location.href+ "/data").done(function(resp){
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
    
    
    $("#leaderboard-header").on("click",renderLeaderboardData)
    $("#matchboard-header").on("click",renderMatchboard);
    
    
});


function updateUserData(){
    $.get(window.location.href+ "/data").done(function(resp){
        
        //Create userMatches array of JS objects
        let matches=resp.matches;
        
        //Global userMatches variable for use in rendering by other functions
        userMatches=[];
        userMatches=matches.map(function(match){
            let newMatch=new Match(match.id, match.opponent_name, match.active_games_count);
            return newMatch;
        });
        
        
        //Create userActGames array of JS objects
        let games=resp.games;
        userActGames=[];
        userCompGames=[];
        games.forEach(function(game){
            
            let newGame= new Game(game.id, game.opponent_name, game.status, game.result)
            if(newGame.gameStatus==="Completed"){
                //global userCompGames for use by other functions
                userCompGames.push(newGame);
            } else {
                //global userActGames for use by other functions
                userActGames.push(newGame);
            }
        })
        
        
        buildMatchTable(userMatches);
        buildGamesTable(userActGames);
    });
}

/////GAME OBJECT DEFINITION AND PROTOTYPING////////////////
function Game(id, opp_name, gameStatus, gameResult){
    this.id=id;
    this.opp_name=opp_name;
    this.gameStatus=gameStatus;
    this.result=gameResult;
}


function buildGamesTable(games){
    let header=$('<button id="games-header" class="btn btn-primary circle" >Active Games</button>');
    let table=$("<table class='table' id='active-games-table'></table>").html("<tr><th>Opponent</th><th>Game Status</th>");
   
    games.forEach(function(game,index){
        let gameRow=$(`<tr class="game-row" data-id="${game.id}" data-ind="${index}"><td>${game.opp_name}</td><td>${game.gameStatus}</td></tr>`);
        table.append(gameRow);
    });
    $("#main-show").html("").append(header);
    $("#main-show").append(table);
    $(".game-row").on("click",getGame)
    
}


function getGame(e){
    e.preventDefault();
    //ToDo: Handle the scrolling function using showIndex
    
    $.get("/games/"+parseInt(this.dataset.id,10)).done(showGame);
    
}

function showGame(game){
    let template=Handlebars.compile($("#show-game-template").html());
    let output=template(game);
    $("#main-show").html("");
    $("#main-show").append(output);
}


//MATCH OBJECT DEFINITION AND PROTOTYPING//////////////////
function Match(id,opp_name,act_games_ct){
    this.id=id;
    this.opp_name=opp_name;
    this.active_games_count=act_games_ct;
}

Match.prototype.genBadge=function(){
        $("#match-row-"+this.id +" td").append("<span class='badge badge-pill badge-dark'>"+this.active_games_count+"</span>");
};


/////////////INDEX VIEW OF MATCHES/////////////////////////////
function buildMatchTable(matchObjects){
    $("#matchboard-body").append("<table id='matches-table' class='table'><tr><th>Opponent</th></tr></table>");
    matchObjects.forEach(function(match,ind){
        let matchRow= $(`<tr id="match-row-${match.id}"data-id="${match.id}" data-index="${ind}"></tr>`).html(`<td>${match.opp_name}</td>`);
        matchRow.addClass("match-row");
        matchRow.on("click",selectMatch);
        //matchRow.data("id",`${match.id}`);
        $("#matches-table").append(matchRow);
        match.genBadge();
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
    let template=Handlebars.compile($("#show-match-template").html())
    let output=template(match);
    $("#main-show").html("")
    $("#main-show").append(output);
    
    //Add handlers to the scrolling buttons
    $("#show-next").on("click",showNext);
    $("#show-prev").on("click",showPrev);
    
    
    //Add handlers to the throw buttons for a new game
    $("form").submit(newGameWithThrow);
}

function showMatchFromJS(matchJS){
    let template=Handlebars.compile($("#show-match-template-js").html())
    let output=template(matchJS);
    $("#main-show").html("");
    $("#main-show").append(output);
    
    //Add handlers to the scrolling buttons
    $("#show-next").on("click",showNext);
    $("#show-prev").on("click",showPrev);
    
    
    //Add handlers to the throw buttons for a new game
    $("form").submit(newGameWithThrow);
}
////////MAKING A NEW GAME BASED UPON THE THROW BUTTON CHOSEN
function newGameWithThrow(e){
    e.preventDefault();
    
    let values=$(this).serialize();
    
    
    $.post("/games",values).done(function(resp){
        
        updateUserData();
        
    });
    
    
    //Refresh the user data to show the new game
    
    
    //re
    
    
    
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
   

