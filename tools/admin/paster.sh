#! /bin/sh
case "$1" in
  admin) 
    user="$2"
    # known problem with the following command: works only for existing users
    # for non-existing ones prompting will fail because stdin is a here
    # document
    cmd="--plugin=ckan sysadmin add $user --config=/etc/kata.ini"
    ;;
  reindex)
    echo "TODO: this command needs to acquire the reindexing lock"
    echo "      (cf. https://github.com/kata-csc/kata-packaging/commit/35b1e3cc48140136b122129acab9b7ed6b715cd6 )"
    cmd="--plugin=ckan search-index rebuild --config=/etc/kata.ini"
    ;;
  cmd)
    shift
    cmd="$*"
    ;;
  *)
    echo "Usage: $0 <operation> [<param>...]"
    echo 
    echo "   Where <operation> is one of:"
    echo 
    echo "      1.) admin   --- gives sysadmin rights to existing user"
    echo "                      1 mandatory parameter: user id"
    echo "      2.) reindex --- rebuild search index from scratch"
    echo "                      no parameters"
    echo "      3.) cmd     --- any paster command"
    echo "                      command is passed as parameter(s)"
    exit
  esac 
sudo -s -u apache <<EOF
cd /opt/data/ckan/pyenv
source bin/activate
cd src/ckan
paster $cmd
EOF
