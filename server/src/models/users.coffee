mongoose = require "mongoose"

userSchema = mongoose.Schema
    username: String
    password_hash: String
    dateCreated:
        type: Date
        default: Date.now()
    admin:
        type: Boolean
        default: false

module.exports = User = mongoose.model "User", userSchema
