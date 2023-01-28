*** Settings ***

Library    RequestsLibrary
Library    Collections

*** Variables ***

${base_url}    http://localhost:8080


*** Test Cases ***
Test №1: Get Request

       Create Session    mysession    ${base_url}
       ${respons}=      GET On Session    mysession     /app/videogames

       ${status_code}=      Convert To String    ${respons.status_code}
       Should Be Equal      ${status_code}      200
       Log To Console    ${status_code}

       ${headers}=      Get From Dictionary    ${respons.headers}       Content-Type
       Should Be Equal    ${headers}    application/xml


Test №2: Post Request

         Create Session    mysession    ${base_url}

         ${body}=       create dictionary       id=12  name=Sert   releaseDate=2022-01-27T00:02:45.749Z    reviewScore=34  category=Driving    rating=Universal

         ${header}=     create dictionary   Content-Type=application/json

         ${response}=    Post Request           mysession    /app/videogames  data=${body}    headers=${header}

         ${status_code}=      Convert To String    ${response.status_code}
         Should Be Equal      ${status_code}      200
         ${content}     Convert To String       ${response.content}
         Should Contain      ${content}    Record Added Successfully

         Log To Console    ${response.status_code}

Test №3: Get Request (We get a get request created by us via Post)

        Create Session    mysession    ${base_url}
        ${respons}=   GET On Session          mysession       /app/videogames/12

        Log To Console    ${respons.status_code}

        ${status_code}=        Convert To String       ${respons.status_code}
        Should Be Equal     ${status_code}     200




Test №4: Delete Request(Delete the request we created)

    Create Session    mysession    ${base_url}

    ${delete}=     DELETE On Session    mysession      /app/videogames/12

    Log To Console    ${delete.status_code}

    ${status_code}      Convert To String    ${delete.status_code}
    Should Be Equal     ${status_code}      200

    ${status_colection}=         Convert To String    ${delete.content}
    Should Contain    ${status_colection}       Record Deleted Successfully


Test №5: Put Request(Let's change our created request)
     Create Session    mysession    ${base_url}

     ${body}=       create dictionary       id=2  name=Pacman   releaseDate=2022-01-27T00:02:45.749Z    reviewScore=23  category=Driving    rating=Universal

     ${header}=     create dictionary   Content-Type=application/json

     ${response}=    Put Request    mysession    /app/videogames/2  data=${body}    headers=${header}

     Log To Console    ${response.status_code}
     Log To Console    ${response.content}

     ${status_code}=      Convert To String    ${response.status_code}
     Should Be Equal      ${status_code}      200

     ${contents}     Convert To String       ${response.content}
     Should Contain      ${contents}    Pacman
