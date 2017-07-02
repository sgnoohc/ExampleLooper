# Simple Example Looper

## Description of contents in this repository

The bash scripts

    setup.sh         # Source this everytime you login to UAF to setup ROOT and other environments.
                     # Must source it in command line like,
                     #
                     #     $ source setup.sh
                     #
                     # or
                     #
                     #     $ . setup.sh
                     #
    compile.sh       # Execute this to compile your code.
                     # (This uses ACLiC in ROOT to compile the code. It doesn't use the usual "gcc")
                     # Background information on ACLiC: https://root.cern.ch/root/html534/guides/users-guide/CINT.html#aclic---the-automatic-compiler-of-libraries-for-cint
    run.sh           # Execute this to run your code.
    run_batch.sh     # Execute this to run your code in batches. (like run 20 jobs at a time.)
    clean.sh         # Execute this to remove compiled code for a fresh start.
                     # (sort of like "make clean")

The directories

    output/          # Where outputs will be stored.
    log/             # Where log of batch jobs will be stored. If something goes wrong while submitting batch jobs, you can look here to debug.

The source code

    ScanChain.C      # The actual looper that loops over data and do something with it.
    doAll.C          # A small piece of script that receives input data file, and calls ScanChain on it.

The "job list" file for running the code in batch

    joblist          # A file that has a list of "jobs" to run to perform an analysis.
                     # Each line in the file will be executed in parallel with ~20 cores.
                     # So each line in this file must be a valid command line.

## How to run the code

0. Check out this code on UAF

```
    # login to UAF
    git clone https://github.com/sgnoohc/ExampleLooper.git Looper
    cd Looper
```

1. First setup the environment

```
    source setup.sh
```

2. Clean and then compile the code

```
    ./clean.sh
    ./compile.sh
```

3. Then, run a job on one of the monte carlo root file

```
    ./run.sh /hadoop/cms/store/group/snt/run2_moriond17/DYJetsToLL_M-50_TuneCUETP8M1_13TeV-madgraphMLM-pythia8_RunIISummer16MiniAODv2-PUMoriond17_80X_mcRun2_asymptotic_2016_TrancheIV_v6_ext1-v2/V08-00-16/merged_ntuple_9.root     DYJetsToLL_M_50_TuneCUETP8M1_13TeV_madgraphMLM_pythia8_RunIISummer16MiniAODv2_PUMoriond17_80X_mcRun2_asymptotic_2016_TrancheIV_v6_ext1_v2_V08_00_16_merged_ntuple_9.root &> log/DYJetsToLL_M_50_TuneCUETP8M1_13TeV_madgraphMLM_pythia8_RunIISummer16MiniAODv2_PUMoriond17_80X_mcRun2_asymptotic_2016_TrancheIV_v6_ext1_v2_V08_00_16_merged_ntuple_9.log
```

4. Observe that the output is located here:

```
    ls output/DYJetsToLL_M_50_TuneCUETP8M1_13TeV_madgraphMLM_pythia8_RunIISummer16MiniAODv2_PUMoriond17_80X_mcRun2_asymptotic_2016_TrancheIV_v6_ext1_v2_V08_00_16_merged_ntuple_9.root
```

5. Create a pdf file of the histogram.

```
    root -l output/DYJetsToLL_M_50_TuneCUETP8M1_13TeV_madgraphMLM_pythia8_RunIISummer16MiniAODv2_PUMoriond17_80X_mcRun2_asymptotic_2016_TrancheIV_v6_ext1_v2_V08_00_16_merged_ntuple_9.root
    root [0] hist_dilepton_mass->SaveAs("hist.pdf");
    root [1] .q
```

6. scp over to your ```~/public_html/``` and open up the file in web browser.

```
    mkdir -p ~/public_html/
    cp hist.pdf ~/public_html/

    # Go to your web browser and open (NOTE: REPLACE phchang with your username. I suppose it's grmercad?)
    uaf-7.t2.ucsd.edu/~phchang/hist.pdf
    uaf-7.t2.ucsd.edu/~grmercad/hist.pdf
```

7. Now just for an example, let's run over several files now. We are not
   running over properly on all data or all MC events. So the weighting is sort
   of off, but if we run over them all properly it will take eons to finish. So I
   am giving you just about ~20 root files (instead of many thousands) as an
   illustration of how things will scale up.

```
    ./run_batch.sh
    # wait a while until the linux command line prompts up. This will take a bit.
```

8. Combining invidivual outputs into one file each for data, and Z boson MC events.
   (FYI, "Drell-Yan" (DY or dy) is single on or off-shell Z boson physics process.)
   (https://en.wikipedia.org/wiki/Drell%E2%80%93Yan_process)

```
    hadd -f output/data.root output/Run*root
    hadd -f output/dy.root output/DY*root
```

9. Follow same step as 5. to create two different pdf files one for data one for Drell-Yan.

## Homework

Now plot the two histogram from 9. on a same TCanvas, one as a data point marker style, the other as a box histogram.
See here for an example. (http://uaf-10.t2.ucsd.edu/~phchang/analysis/www/studies/chargeflip/plots/mee_os.png)

## 24h rule.

If you get stuck at any point in working on these steps including the homework,
follow the "24h rule". It's good for your education to bang your head against
the problem googling around to solve the problem yourself. But if you get stuck
on one particular error or a problem for over 24h, it's better to just ask me
and get things going.

## Some ROOT reference

http://th-www.if.uj.edu.pl/~erichter/dydaktyka/Dydaktyka2012/LAB-2012/HASCO_RootTutorial_FirstLecture.pdf
