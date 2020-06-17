instalação via jar:
  baixar o jar em https://search.maven.org/search?q=a:robotframework
  criar um diretorio com o jar e copiar o jar para o container:
    oc rsync robot/ jenkins-1-5nq96:/var/lib/jenkins/
  no container do jenkins é só executar:
    java -jar robotframework-3.1.1.jar
cp robotframework-3.1.1.jar teste.robot jobs/temp/jobs/temp-reference-to-git/workspace/

instalar lib do robot (http://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html#extending-the-robot-framework-jar):



{ echo 'GET /healthCheck HTTP/1.0'; echo 'Host: demo-temp.apps.ocp.example.local' ; echo; echo ;sleep 1 ; } | telnet demo-temp.apps.ocp.example.local 80

https://issues.jenkins-ci.org/browse/JENKINS-34469?page=com.atlassian.jira.plugin.system.issuetabpanels%3Acomment-tabpanel&showAll=true
    step([$class: 'RobotPublisher',
        outputPath: '.',
        passThreshold: 0,
        unstableThreshold: 0,
        otherFiles: ""])


aumentar a qtd de recursos do jenkins, com 512mb e 1vcpu o robot ele está crashando o container


================================================================================================================================
TESTE 1
================================================================================================================================
*** Settings ***
Library  Process

*** Test Cases ***

Testing Demo App
    ${out}      Run Process     python  -c     exec("""import urllib2\ncount\=0\nerr\=0\nwhile\ count<1000:\n\ \ try:\n\ \ \ \ contents\=urllib2.urlopen('http://demo-temp.apps.ocp.example.com/healthCheck').getcode()\n\ \ except:\n\ \ \ \ err+\=1\n\ \ finally:\n\ \ \ \ count+\=1\nprint(err)\n""")
    Log to console      ${out.stderr}
    Log to console      ${out.stdout}
    Should Be True      ${out.stdout} > 600

================================================================================================================================
TESTE 2
================================================================================================================================

*** Settings ***
Library  Process

*** Test Cases ***

Testing Demo App
    ${out}      Run Process     python  -c      import urllib2;contents\=urllib2.urlopen("http://demo-temp.apps.ocp.example.local/healthCheck").getcode();print contents
    Log to console      ${out.stdout}
    Should Contain      ${out.stdout}   200


================================================================================================================================
TESTE 3
================================================================================================================================
*** Settings ***
Library  Process

*** Test Cases ***

Testing3 Demo App
    ${out}      Run Process     python  -c     exec("""import urllib2\nimport time\nstart\=time.time()\ntry:\n\ \ urllib2.urlopen("http://demo-temp.apps.ocp.example.com/healthCheck")\nexcept:\n\ \ pass\nfinally:\n\ \ end\=time.time()\nif end-start>1.0:\n\ \ print(1)\nelse:\n\ \ print(0)\n""")
    Log to console      ${out.stderr}
    Log to console      ${out.stdout}
    Should Be True      ${out.stdout} == 0
