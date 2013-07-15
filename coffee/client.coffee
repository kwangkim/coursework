client = new Dropbox.Client
    key: 'vmtobv6ojlapzfg'
    sandbox: yes

auth = ->
    if client.isAuthenticated()
        alert 'Already connected to Dropbox.'
        return

    client.authDriver new Dropbox.AuthDriver.Redirect rememberUser: yes

    client.authenticate (error, authed_client) ->
        if error
            alert "Error: could not connect to Dropbox."
            console.log error
            return

        authed_client.getUserInfo (error, info) ->
            console.log info.name

# If a token from a previous session is saved in localStorage, the client
# can be silently and automatically authenticated.
for key of localStorage
    if key.indexOf('dropbox-auth') isnt -1
        auth()
        break

cw.client = client
cw.auth = auth
