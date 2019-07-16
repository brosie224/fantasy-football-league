$(() => {
    viewPlayer(), prevPlayer(), nextPlayer()
})

const prevPlayer = () => {
    $("#js-prev-player").on("click", e => {
        e.preventDefault();
        let id = parseInt($("#js-prev-player").attr("data-id"));
        $.get("/players/" + id + "/previous.json", data => {
            let clickedPlayer = new Player(data);
            let postPlayer = clickedPlayer.postHtml();
            $("#player-page").html(postPlayer);
            $("#js-prev-player").attr("data-id", clickedPlayer.id);
            $("#js-next-player").attr("data-id", clickedPlayer.id);
            history.pushState(null, null, clickedPlayer.id)
        });
    });
};

const nextPlayer = () => {
    $("#js-next-player").on("click", e => {
        e.preventDefault();
        let id = parseInt($("#js-next-player").attr("data-id"));
        // let id = $(this).data("id");
        $.get("/players/" + id + "/next.json", data => {
            let clickedPlayer = new Player(data);
            let postPlayer = clickedPlayer.postHtml();
            $("#player-page").html(postPlayer);
            $("#js-prev-player").attr("data-id", clickedPlayer.id);
            $("#js-next-player").attr("data-id", clickedPlayer.id);
            history.pushState(null, null, clickedPlayer.id)
        });
    });
};

const viewPlayer = () => {
    $(".js-view-player").on("click", function(e) {
        e.preventDefault();
        let id = $(this).data("id");
        $.get("/players/" + id + ".json", data => {
            let clickedPlayer = new Player(data);
            let postPlayer = clickedPlayer.postHtml();
            $("#player-team-info").html(postPlayer);
            // document.getElementById('player-team-info').innerHTML = postPlayer;
        })
    })
}

class Player {
    constructor(obj) {
        this.id = obj.id
        this.firstName = obj.first_name
        this.lastName = obj.last_name
        this.position = obj.position
        this.espnPage = obj.espn_page
        this.team = obj.team
        this.userId = obj.user.id
    }
}

Player.prototype.fullName = function() {
    return this.firstName + " " + this.lastName;
}

Player.prototype.teamName = function() {
    return this.team.full_name;
}

Player.prototype.postHtml = function() {
    let teamLink = `<a href="/users/${this.userId}">`
    
    if (this.userId === 7) {
        teamLink = `<a href="/free-agents">`
    }

    return `
        <h2>${this.fullName()}</h2>
        <p>Position: ${this.position}</p>
        <p>${teamLink} ${this.teamName()}</a></p>
        <p><a href="${this.espnPage}" target="_blank">ESPN Player Page</a></p>
 
    `
}