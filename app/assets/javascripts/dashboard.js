$(function(){
    const userData=$.get("/users/"+@user.id+"/data");
    
    userData.done(function(resp){
        console.log(resp);
    });
    
}
    