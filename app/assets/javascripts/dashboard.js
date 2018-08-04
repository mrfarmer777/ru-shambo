let user;
let userMatches;
let showIndex;


$(function(){
    //Initial call to retrieve user data
    let userData=$.get(window.location.href+"/data");
    
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
    
    $("#show-next").on("click",scrollMatches(1));
    $("#show-prev").on("click",scrollMatches(-1));
    
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
    $("#wip").append("<table id='matches-table' class='table'><tr><th>Opponent</th><th>Start Date</th></tr></table>");
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
    showIndex=this.dataset.index;
    getMatchData(userMatches[showIndex].id);
}

function scrollMatches(num){
    showIndex+=num;
    if(showIndex<0){
        showIndex=0;
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
    $("#show-next").data("id",matchId+1);
    $("#show-next").on("click",getMatchData);
    $("#show-prev").data("id",matchId-1);
    $("#show-next").on("click",getMatchData);
}
   

