defib_simulation_evaluation.srn

Decription:
This network is similar one of the netowrk provided and described in
the defibrillation tutorial included with SCIRun.  It calculates the
potential field distribution within the torso of an ICD. However, this
network goes further by including a matlab script that will calculate
some statistics of the electric field in the heart.  These statistics
include the voltage and energy needed to have 95% of the myocardium
over 5 V/cm (citical mass hypothesis) and the distribution of the
electric field strength through the myocaridum.

Using this network:

Matlab is needed to fully run this network.  This network is setup to
run with data included in the SCIRunData download.  If you have your
SCIRun Data path setting set properly, the network should find the
data needed to run.  The files needed are a bdl file containing two
fields of the same mesh type that represent the ICD geometries, similar
to the SCIRunData/torso-defib/electrode_bundle.bdl file.  The other
input is a segmentation on a regular grid similar to
SCIRunData/torso-defib/torso_segmentation_si.fld.  

There is also a script included (Run_Defib_Sim.sh) that will
run this network on several *.bdl files in the same directory.  Please
refer to the comments in the Run_Defib_Sim.sh script for more
information. 

