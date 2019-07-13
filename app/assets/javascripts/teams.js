$(() => {
    createTeam(), viewTeam()
})

const viewTeam = () => {
    $(".js-view-team").on("click", function(e) {
        e.preventDefault()
        let thisId = $(this).data("id")
        $.get("/users/" + thisId + ".json", data => {
            let clickedTeam = new Team(data)
            let postTeam = clickedTeam.viewTeam()
            $("#player-team-info").html(postTeam)
        })
    })
}

const createTeam = () => {
    $('form#new_team').submit(function(e) {
      e.preventDefault()
      let values = $(this).serialize()
      $.post('/teams', values)
        .done(data => 
            $("#new-team-created").html(`${data["full_name"]} created successfully!<br><br>
            Start <a href="/free-agents">adding players</a> now!`)
        )
    })
  }


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

Team.prototype.viewTeam = function() {
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