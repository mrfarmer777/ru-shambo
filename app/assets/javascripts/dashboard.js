$(function(){
    const userData=$.get(window.location.href+"/data");
    
    userData.done(function(resp){
        console.log(resp);
        
        const matches=resp.matches;
        const matchObjs=matches.map(function(match){
            let newMatch=new Match(match.id, match.opponent, match.created_at);
            return newMatch;
        });
        
        
        buildMatchTable(matchObjs);
    });
    
});

function Match(id,opp,startDate){
    this.id=id;
    this.opp=opp;
    this.startDate=startDate;
}

Match.prototype.report=function(){
    let report=`You started playing against ${this.opp.name} on ${this.startDate}.`;
    return report;
};

function buildMatchTable(matchObjects){
    $("#wip").append("<table id='matches-table' class='table'><tr><th>Opponent</th><th>Start Date</th></tr></table>");
    matchObjects.forEach(function(match){
        let matchRow= $(`<tr data-id="${match.id}"></tr>`).html(`<td>${match.opp.name}</td><td>${match.startDate}</td>`);
        matchRow.addClass("match-row");
        matchRow.on("click",getMatchData);
        matchRow.data("id",`${match.id}`);
        $("#matches-table").append(matchRow);
    });
}
    
    
function getMatchData(e){
    e.preventDefault();
    const matchId=this.dataset.id;
    $.get("/matches/"+matchId).done(function(resp){
        console.log(resp);
    });
    
}