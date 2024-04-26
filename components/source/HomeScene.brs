sub init()
    m.top.setFocus(true)
    m.loginButton = m.top.findNode("loginButton")
    m.contentButton = m.top.findNode("contentButton")

    m.loginButton.observeField("buttonSelected", "onLoginButtonSelected")
    m.contentButton.observeField("buttonSelected", "onContentButtonSelected")

    ' Initially hide content button until session is verified
    m.contentButton.visible = false
    checkSession()
end sub

sub checkSession()
    ' Check if a valid token exists and update UI accordingly
    if m.top.token <> ""
        m.contentButton.visible = true
    else
        m.contentButton.visible = false
    end if
end sub

function onLoginButtonSelected()
    if m.top.token = ""
        showLoginScreen()
    else
        showUserProfile()
    end if
end function

function onContentButtonSelected()
    if m.top.token <> ""
        showContentScreen()
    else
        showErrorMessage("Please log in to view content.")
    end if
end function
