' main.brs - Entry point for the Stremio Roku app

sub Main()
    ' Initialize the global associative array that will hold the app's global state and configurations
    m.global = CreateObject("roSGNode", "GlobalNode")
    
    ' Setup global configuration such as backend API URL
    m.global.addField("apiUrl", "roString", false)
    m.global.apiUrl = "https://api.stremio.com"
    
    ' Initialize the screen
    screen = CreateObject("roSGScreen")
    screen.SetMessagePort(CreateObject("roMessagePort"))
    
    ' Create and show the initial scene, typically the home or login scene
    scene = screen.CreateScene("HomeScene")
    screen.Show(scene)
    
    ' Event loop to keep the application running and handle user input or other events
    while true
        msg = wait(0, screen.GetMessagePort())
        if type(msg) = "roSGScreenEvent"
            if msg.isScreenClosed() then exit while
        end if
    end while
end sub

' Include utility functions
Library "pkg:/source/utils.brs"

' Start the application
Main()
