$(function(){
    console.log("JS is running in players!")
})

$(function nextPlayer() {
    $("#js-next-player").on("click", function(e) {
        e.preventDefault();
        let nextId = parseInt($("#js-next-player").attr("data-id")) + 1;
        // let nextId = $(this).data("id") + 1; -- doesn't work
        $.get("/players/" + nextId + ".json", function(data) {
            let player = data;
            $("#player-name-position").html(player["full_name"] + " - " + player["position"]);
            $("#player-team").html(`<a href="/users/${player["user"]["id"]}">${player["team"]["full_name"]}</a>`);
            $("#player-espn").html(`<a href="${player["espn_page"]}" target="_blank">ESPN Player Page</a>`);
            $("#js-next-player").attr("data-id", player["id"]);
        });
    });
});

$(function viewPlayer() {
    $(".js-view-player").on("click", function(e) {
        e.preventDefault();
        // let thisId = parseInt($(".js-view-player").attr("data-id")) -- doesn't work
        let thisId = $(this).data("id");
        $.get("/players/" + thisId + ".json", function(data) {
            let clickedPlayer = new Player(data);
            let postPlayer = clickedPlayer.postHTML();
            $("#player-team-info").html(postPlayer);
            // document.getElementById('player-team-info').innerHTML = postPlayer;
        })
    })
})

class Player {
    constructor(obj) {
        this.id = obj.id
        this.firstName = obj.first_name
        this.lastName = obj.last_name
        this.position = obj.position
        this.espnPage = obj.espn_page
        this.team = obj.team
    }
}

Player.prototype.fullName = function() {
    return this.firstName + " " + this.lastName;
}

Player.prototype.teamName = function() {
    return this.team.full_name;
}

Player.prototype.postHTML = function() {
    return `
        <div>
            <h2 style="display:inline">${this.fullName()}</h2>
            <p>Position: ${this.position}</p>
            <p>${this.teamName()}</p>
            <a href="${this.espnPage}" target="_blank">ESPN Player Page</a>
        </div>
    `
}