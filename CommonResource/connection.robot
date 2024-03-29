*** Settings ***
Library                         QForce
Library                         String
*** Variables ***
# IMPORTANT: Please read the readme.txt to understand needed variables and how to handle them!!
${BROWSER}                      chrome
${login_url}                    https://www.amazon.in/
${Home_url}                     https://www.amazon.in/

*** Keywords ***
Setup Browser
    # Setting search order is not really needed here, but given as an example
    # if you need to use multiple libraries containing keywords with duplicate names
    Set Library Search Order    QForce                      QWeb
    Open Browser                about:blank                 ${BROWSER}
    SetConfig                   LineBreak                   ${EMPTY}       #\ue000
    SetConfig                   DefaultTimeout              20s            #sometimes salesforce is slow
    Evaluate                    random.seed()               random         # initialize random generator
End suite
    Close All Browsers
Login
    [Documentation]             Login to Amazon instance
    GoTo                        ${login_url}
    ClickText                   //*[@id\='nav-link-accountList-nav-line-1']
    TypeText                    //input[@id\='ap_email']    ${username}    delay=1
    ClickText                   //input[@id\='continue']
    TypeText                    //input[@id\='ap_password']                ${password}                 delay=1
    ClickText                   //input[@id\='signInSubmit']
Home
    [Documentation]             Navigate to homepage, login if needed
    GoTo                        ${home_url}
    ${login_status} =           IsText                      Sign in
    Run Keyword If              ${login_status}             Login