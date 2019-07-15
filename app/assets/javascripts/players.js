$(() => {
    viewPlayer(), nextPlayer()
})

// const nextPlayer = () => {
//     $("#js-next-player").on("click", function(e) {
//         e.preventDefault();
//         let nextId = parseInt($("#js-next-player").attr("data-id")) + 1;
//         // let nextId = $(this).data("id") + 1;
//         history.pushState(null, null, nextId)
//         $.get("/players/" + nextId + ".json", data => {
//             let clickedPlayer = new Player(data);
//             let postPlayer = clickedPlayer.postHtml();
//             $("#player-page").html(postPlayer);
//             $("#js-next-player").attr("data-id", clickedPlayer.id);
//         });
//     });
// };

const nextPlayer = () => {
    $("#js-next-player").on("click", function(e) {
        e.preventDefault();
        let thisId = parseInt($("#js-next-player").attr("data-id"));
        // let thisId = $(this).data("id");
        $.get("/players/" + thisId + "/next.json", data => {
            let clickedPlayer = new Player(data);
            let postPlayer = clickedPlayer.postHtml();
            $("#player-page").html(postPlayer);
            $("#js-next-player").attr("data-id", clickedPlayer.id);
            history.pushState(null, null, clickedPlayer.id)
        });
    });
};

const viewPlayer = () => {
    $(".js-view-player").on("click", function(e) {
        e.preventDefault();
        let thisId = $(this).data("id");
        $.get("/players/" + thisId + ".json", data => {
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