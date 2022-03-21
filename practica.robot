*** Settings ***
Library   RequestsLibrary

*** Variables ***
${url}   https://jsonplaceholder.typicode.com/users
${apiUsers}     users
${apiPosts}    posts
*** Test Cases ***

Quick Get Request Test
    ${response}=    GET  https://www.google.com
    log to console   ${response}

Quick Get Request With Parameters Test
    ${response}=    GET  https://www.google.com/search  params=query=ciao  expected_status=200
    log to console   ${response.status_code}
    log to console   ${response.content}

Quick Get A JSON Body Test
    ${response}=    GET  https://jsonplaceholder.typicode.com/${apiPosts}
    Should Be Equal As Strings    1  ${response.json()}[id]