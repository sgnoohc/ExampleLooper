
# Setup ROOT
source /code/osgcode/cmssoft/cmsset_default.sh  > /dev/null 2>&1
export SCRAM_ARCH=slc6_amd64_gcc530   # or whatever scram_arch you need for your desired CMSSW release
export CMSSW_VERSION=CMSSW_9_2_4
echo Setting up CMSSW for CMSSW_9_2_4 for slc6_amd64_gcc530
cd /cvmfs/cms.cern.ch/slc6_amd64_gcc530/cms/cmssw/CMSSW_9_2_4/src
eval `scramv1 runtime -sh`
cd -

# Setup a utility functions when using ROOT.
source /home/users/phchang/public_html/tasutil/thistasutil.sh

# Setup "CORE" which our group has compiled several physics related functions
# for analyzing the data from the experiment.
if [ -d CORE ]; then
    :
else
    git clone https://github.com/cmstas/CORE.git
fi
