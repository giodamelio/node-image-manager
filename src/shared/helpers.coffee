module.exports.base64 = base64 =
    encode: (text) ->
        return new Buffer(text, "utf8").toString("base64")

    decode: (base64) ->
        return new Buffer(base64, "base64").toString("utf8")

module.exports.base64Auth = 
    encode: (username, password) ->
        return base64.encode username + ":" + password

    decode: (authstring) ->
        return base64.decode(authstring).split ":"

