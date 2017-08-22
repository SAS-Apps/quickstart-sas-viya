#!/bin/bash -e

# make sure we have at least java8 and ansible 2.2.1.0

install_java () {
   echo Install java 1.8
   sudo yum -y install java-1.8.0
}

if type -p java; then
    echo found java executable in PATH
    _java=java
elif [[ -n "$JAVA_HOME" ]] && [[ -x "$JAVA_HOME/bin/java" ]];  then
    echo found java executable in JAVA_HOME
    _java="$JAVA_HOME/bin/java"
else
    install_java
fi


if [[ "$_java" ]]; then
    version=$("$_java" -version 2>&1 | awk -F '"' '/version/ {print $2}')
    echo version "$version"
    if [[ "$version" < "1.8" ]]; then
        sudo yum -y remove java
        install_java
    else
        echo version 1.8 or greater
    fi
fi


if ! [ type -p ansible ]; then
   # install Ansible
   /usr/local/bin/pip install 'ansible==2.2.1.0'
fi



