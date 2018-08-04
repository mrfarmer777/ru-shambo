$(function(){
    const userData=$.get(window.location.href+"/data");
    
    userData.done(function(resp){
        console.log(resp);
        
        const matches=resp.matches;
        matches.forEach(function(match){
            let newMatch=new Match(match.id, match.opponent, match.created_at);
            console.log("Match Report: "+ newMatch.report());
        });
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
    