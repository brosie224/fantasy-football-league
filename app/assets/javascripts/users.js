$(() => {
    console.log("users loading")
    viewUsers()
})

const viewUsers = () => {
    $("#view-users").on("click", e => {
        e.preventDefault();
        $.get("/users.json", users => {
            history.pushState(null, null, "users")
            $("#page-content-container").html(`<h1>All Users</h1>`)
            users.forEach(user => {
                let newUser = new User(user)
                let postHtml = newUser.postUser()
                $("#page-content-container").append(postHtml)
            })
        })
    })
}

class User {
    constructor(obj) {
        this.name = obj.name
        this.email = obj.email
        if (obj.team) {
            this.teamName = obj.team.full_name
        } else {
            this.teamName = `<i>No team created</i>`
        }
    }
}

User.prototype.postUser = function() {
    return `
        <strong>${this.name}</strong><br>
        <a href="mailto:${this.email}">${this.email}</a><br>
        ${this.teamName}
        <br><br>
    `
}