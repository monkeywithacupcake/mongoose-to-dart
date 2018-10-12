#!/bin/bash -e

#################################
#
# translate.sh is for translating mongoose.js models to dart models
# if you have a node/mongoose db based api that provides input to
# a dart application
# such as a mobile application produced in flutter
#
#################################

# the inputs will be two file paths
# $1 a file path for the mongoose model we want to translate
# $2 a dir path for the dart model that will be created

# the output is a dart file with the same name

input=${1:-"${HOME}/Desktop/model.js"}
outDir=${2:-"${HOME}/Desktop"}

# HELP

if [[ $input = '-h' ]]; then
 echo "translate.sh is for translating mongoose.js models to dart models"
 echo "1st param is path/to/model | default $HOME/Desktop/model.js"
 echo "2nd param is path/to/output | default $HOME/Desktop"
 echo "---------EXAMPLE------------"
 echo "bash translate.sh mydir/model.js myapp/models"
 echo "-----------------------------"
 exit
fi
 # THE SCRIPT

 title=${input##*/}
 title=${title%.*}

 # get what is being modeled - should be between '' after mongoose.model(

 # these approaches do not work
 #while IFS="mongoose.model(''" read a b; do echo "$b"; done < $input
 #echo "mongoose.model('User'" | grep -o -P '(?<=mongoose.model\\(\\').*(?=\\')'
 #echo "mongoose.model('User'" | sed -e 's/.*mongoose.model(\'\(.*\)/'.*/\1/'
 #sed -e 's/.*one is\(.*\)String.*/\1/'
 printf -v x `grep "module.exports = mongoose.model(*" $input`
 echo $x
 #awk -F"['']" '{print $2}' $x

# get the variables and their types

 # we can start making the file
 echo "creating new file at ${outDir}/${title}.dart"

 echo "class" >> "${outDir}/${title}.dart"


# expected output model.dart
  # class User {
  # String email;
  # String password;
  # String name;
  # List<String> colors;
  #
  # User({this.email, this.password, this.name, this.colors});
  #
  # factory User.fromJson(Map<String, dynamic> json) {
  #   return User(
  #     email: json['email'],
  #     name: json['name'],
  #     password: json['password'],
  #     colors: json['colors'].cast<String>(),
  #   );
  # }
