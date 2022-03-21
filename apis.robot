*** Settings ***
Library     RequestsLibrary
Library     SeleniumLibrary
Library           RPA.JSON
# instalar rpaframework para poder manipular mejor el json
# pip install rpaframework
*** Variables ***
${base_url}=   http://thetestingworldapi.com/
*** Test Cases ***
GET
    create session   get_data   ${base_url}
    ${response}=   get on session   get_data   api/studentsDetails/1099139
    log to console   ${response.content}
    ${status_code}=   convert to string   ${response.status_code}
    should be equal   ${status_code}   200

POST
    create session   addData   ${base_url}
    ${body}=   create dictionary   first_name=Emiliano    middle_name=asdsa   last_name=Gorgellon   date_of_birth=18/05
    ${response}=   post on session   addData   api/studentsDetails   ${body}
    log to console   ${response.status_code}
    log to console   ${response.content}

POST ON MY PAGE
    create session   addDataFromPost   http://localhost:4000/
    ${body}     create dictionary   email=emilianogorgellon49@gmail.com     password=emi123
    ${response}   post on session   addDataFromPost   api/auth/signin   data=${body}
    log to console   ${response}
    log to console   ${response.content}
    ${status_code}=   convert to string  ${response.status_code}
    should be equal   ${status_code}    200

PUT
    create session   updateData   ${base_url}
    ${body}=   create dictionary   id=1099139   first_name=Roman   middle_name=segundo   last_name=Tortolano   date_of_birth=18/05
    ${response}=   put on session   updateData    api/studentsDetails/1099139   data=${body}
    ${status_code}=   convert to string  ${response.status_code}
    should be equal   ${status_code}    200
    log to console   ${response.json()}
    # Si se mandan los mismos datos se actualiza igual y la prueba es positiva

DELETE
    create session   deleteDataFromDelete   ${base_url}
    ${response}   delete on session   deleteDataFromDelete   api/studentsDetails/1099137
    ${status_code}=     convert to string   ${response.status_code}
    ${status}=   get value from json   ${response.json()}   status
    IF  '${status}'=='true'
        log to console   ELIMINO EFECTIVAMENTE
    END
    # Siempre va a ser la prueba positiva aunque no elimine nada ya que el status_code siempre es 200
    should be equal   ${status_code}   200
