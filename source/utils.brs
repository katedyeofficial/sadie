' utils.brs - Utility functions for Stremio Roku App

' Performs an HTTP GET request to the specified URL with optional headers
function HttpGet(url as string, headers as object) as object
    request = CreateObject("roUrlTransfer")
    request.SetUrl(url)
    if headers <> invalid and type(headers) = "roAssociativeArray"
        for each key in headers.Keys()
            request.AddHeader(key, headers[key])
        end for
    end if
    request.SetCertificatesFile("common:/certs/ca-bundle.crt")
    request.InitClientCertificates()
    response = request.GetToString()
    return ParseJson(response)
end function

' Parses a JSON string into a BrightScript object (associative array)
function ParseJson(jsonString as string) as object
    parser = CreateObject("roSGNode", "roSGNode")
    if parser.ParseJson(jsonString) <> invalid
        return parser.ParseJson(jsonString)
    else
        return invalid
    end if
end function

' Simple error logging to the console, can be enhanced to include logging to a server
function LogError(errorMessage as string) as void
    print "Error: "; errorMessage
end function

' Formats date strings from API responses into a more readable format
function FormatDate(dateString as string) as string
    date = CreateObject("roDateTime")
    date.FromISO8601String(dateString)
    return date.AsDateString()
end function
