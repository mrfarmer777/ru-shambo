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
        $("#matches-table").append(`<tr><td>${match.opp.name}</td><td>${match.startDate}</td></tr>`);
    });
}
    