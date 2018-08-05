let user;
let userMatches=[];
let showIndex=0;

///////DOCUMENT ON LOAD/////////////////////////
$(function(){
    //Initial call to retrieve user data
    let userData=$.get(window.location.href+ "/data");
    
    //When it comes back
    userData.done(function(resp){
        user=resp;
        let matches=resp.matches;
        userMatches=matches.map(function(match){
            let newMatch=new Match(match.id, match.opponent, match.created_at);
            return newMatch;
        });
        
        //Renders the index view using AJAX data
        buildMatchTable(userMatches);
    });
    
    $("#show-next").on("click",showNext);
    $("#show-prev").on("click",showPrev);
    $("#leaderboard-header").on("click",renderLeaderboardData)
    
    
});




//Match object definition and Prototyping//////////////////
function Match(id,opp,startDate){
    this.id=id;
    this.opp=opp;
    this.startDate=startDate;
}

Match.prototype.report=function(){
    let report=`You started playing against ${this.opp.name} on ${this.startDate}.`;
    return report;
};



/////////////INDEX VIEW OF MATCHES/////////////////////////////
function buildMatchTable(matchObjects){
    $("#matchboard-body").append("<table id='matches-table' class='table'><tr><th>Opponent</th><th>Start Date</th></tr></table>");
    matchObjects.forEach(function(match,ind){
        let matchRow= $(`<tr data-id="${match.id}" data-index="${ind}"></tr>`).html(`<td>${match.opp.name}</td><td>${match.startDate}</td>`);
        matchRow.addClass("match-row");
        matchRow.on("click",selectMatch);
        //matchRow.data("id",`${match.id}`);
        $("#matches-table").append(matchRow);
    });
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
   

