#!/bin/bash

# This script will run the defib simulation on all the bdl files in a provided
# directory. This script is meant to run with the
# defib_simulation_evaluation.srn5 network included in
# this exchange repository.  

# The script was written to run on OS X 10.6, but will likely run on
# other versions of OS X and linux.  You will need to ensure that
# SCIrun is installed properly and added to your path environment
# variable.
#
# inputs: 
# directory with bdl files to use in network
# segmentation file to use in network
# (optional) path to directory to move results 
#
# example to use script:
# ./Run_Defib_Sim5.sh ../../trunk/SCIRunData/torso-defib/ ../../trunk/SCIRunData/torso-defib/torso_segmentation_si.fld

# check for inputs
if [ -z $2 ]
then 
echo need at least two inputs
exit
fi

# list all files in input directory
bdlfile=($(ls -1 $1/*.bdl))

#run all bdl files through scirun network
for l in ${bdlfile[@]}
do

# print out file to run
echo -e "\n running file $l \n"

export BDLFILE=$l 
export SEGFILE=$2

# run scirun network output files save automatically
~/software/SCIRun_mine/bin/SCIRun/SCIRun_test -E  defib_simulation_evaluation.srn5 

done

# check for result directory, move ouput files to that directory.
if [ $3 ]
then


echo moving results to $3

mv $1/*simulation.bdl $3
mv $1/*simulation.txt $3
mv $1/*simulation_list.txt $3

fi







