$(function(){
    console.log("JS is running!")
})

$(function nextPlayer() {
    $("#js-next-player").on("click", function(e) {
        e.preventDefault();
        let nextId = parseInt($("#js-next-player").attr("data-id")) + 1;
        $.get("/players/" + nextId + ".json", function(data) {
            let player = data;
            $("#player-name-position").html(player["full_name"] + " - " + player["position"]);
            $("#player-team").html(`<a href="/users/${player["user"]["id"]}">${player["team"]["full_name"]}</a>`)
            $("#player-espn").html(`<a href="${player["espn_page"]}" target="_blank">ESPN Player Page</a>`)
            $("#js-next-player").attr("data-id", player["id"]);
        });
    });
});

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
    return this.firstName + this.lastName
}

Player.prototype.postHTML = function() {
    return(`
        <div>
            <h3>${this.fullName}</h3>
            <p>Position: ${this.position}</p>
            <a href="${this.espnPage}">ESPN Player Page</a>
        </div>
    `)
}

// need (` ?    or can do ` alone
// does prototype fullName need 'return' ?