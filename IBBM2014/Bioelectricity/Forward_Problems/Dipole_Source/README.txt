DipoleSourceExample.srn is a network that will compute a forward
simulation of a single dipole source in the torso.  A current dipole
loosely approximates the electrical activity of the heart.  This
network requires two inputs, a torso segementation and some
measurements for the torso surface.  

The segmentation pointed to in this network is
SCIRunData/torso/adult-torso-200x200x250.fld. Input segmentations in
this network should be on a regular grid with nozero values indicating
regions of the torso.

The measurements points in this network is in
IBBM/Bioelectricity/Forward_Problems/Dipole_Source/measurement_locations.fld.
This is a set of 370 points regularly spaced on the surface of the
torso.  This is an optional part of the network which allows for the
viewing and saving of a predicted measurement set.
