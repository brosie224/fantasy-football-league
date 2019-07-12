$(function(){
    console.log("JS is running in teams!")
})

$(function viewTeam() {
    $(".js-view-team").on("click", function(e) {
        e.preventDefault();
        let thisId = $(this).data("id");
        $.get("/users/" + thisId + ".json", function(data) {
            let clickedTeam = new Team (data);
            let postTeam = clickedTeam.postHTML();
            $("#player-team-info").html(postTeam);
        })
    })
})

class Team {
    constructor(obj) {
        let team = obj.team
        this.id = team.id
        this.name = team.full_name
        this.conference = team.conference
        this.division = team.division
        this.players = obj.players
    }
}

Team.prototype.fullDivision = function() {
    return this.conference + " " + this.division;
}

Team.prototype.postHTML = function() {
    let players = this.players.map(player => {
        return player.position + " " + player.full_name + "<br>"
    }).join('')

    return `
        <div>
            <h2 style="display:inline">${this.name}</h2><br>
            <p style="display:inline">${this.fullDivision()}</p>
            <p>${players}</p>
        </div>
    `
}
