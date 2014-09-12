#!/bin/bash

# This script will run the defib simulation on all the bdl files in a provided
# directory. 
# inputs: 
# directory with bdl files to use in network
# segmentation file to use in network
# (optional) path to directory to move results 
#
# example to use script:
# ./Run_Defib_Sim.sh ../../SCIRunData/torso-defib/ ../../SCIRunData/torso-defib/torso_segmentation_si.fld

if [ -z $2 ]
then 
echo need at least two inputs
exit
fi

seg=$2
bdlfile=($(ls -1 $1/*.bdl))

for l in ${bdlfile[@]}
do

echo file 

echo $l

scirun -E ../SCIRun_Networks/defib_simulation_evaluation.srn +BDLFILE=$l +SEGFILE=$2

done


if [ $3 ]
then

resdir=$3
echo copying results to $resdir

mv $1/*simulation.bdl $3
mv $1/*simulation.txt $3
mv $1/*simulation_list.txt $3

fi







