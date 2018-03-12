defib_simulation_evaluation.srn
lead_impedance.srn

Decription:
defib_simulation_evaluation.srn is similar to one of the netowrk 
provided and described in the defibrillation tutorial included with 
SCIRun.  It calculates the potential field distribution within the 
torso of an ICD. However, this network goes further by including a 
matlab script that will calculate some statistics of the electric 
field in the heart.  These statistics include the voltage and 
energy needed to have 95% of the myocardium over 5 V/cm (citical 
mass hypothesis) and the distribution of the electric field 
strength through the myocaridum.  There are SCIRun 5 versions of this
example, defib_simulation_evaluation_python.srn5 and 
defib_simulation_evaluation_matlab.srn5 are non-scripted examples of
evaluating the DFT with either matlab or python.  the matlab version
runs the matlab engine in python. defib_simulation_evaluation.srn5
is a scripted version, and uses python to compute the dft.  

lead_impedance.srn is meant to build on the previous network 
(defib_simulation_evaluation.srn) to estimate the lead impedance 
between two stimulating leads.  This estimation is based on the total
current through a surface around the ICD coil.  With Ohm's law and a 
known voltage drop, we can calculate the total resistance between the 
electrodes. 


Using defib_simulation_evaluation.srn:

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


Using lead_impedance.srn:

This network requires a bdl file that contains a computed potential 
field and the ICD geometries, and the segmentation for the patient.  
The bdl files used in this network are assumed to be the same as the 
output of the defib_simulation_evaluation.srn network.  Make sure that 
the field names in the bdl match the expected names in the network.  
The end of the network provides a string that contains the estimated 
resistance of the electrodes.  The units based on the ICD simulation are
Ohms.  This string or the matrix can be saved and run in a script similar 
to the defib script.  

