# wcc386 Builder Control file
# ===========================

set PROJNAME=wcc386

set BINTOOL=0

set PROJDIR=<CWD>

[ INCLUDE "<OWROOT>/build/prolog.ctl" ]

[ INCLUDE "<OWROOT>/build/defrule.ctl" ]

[ BLOCK <BLDRULE> rel ]
#======================
    cdsay "<PROJDIR>"

[ BLOCK <BINTOOL> build ]
#========================
    cdsay "<PROJDIR>"
    <CPCMD> <OWOBJDIR>/bwcc386.exe     "<OWROOT>/build/<OWOBJDIR>/bwcc386<CMDEXT>"
    <CCCMD> <OWOBJDIR>/bwccd386<DYEXT> "<OWROOT>/build/<OWOBJDIR>/bwccd386<DYEXT>"

[ BLOCK <BINTOOL> clean ]
#========================
    echo rm -f "<OWROOT>/build/<OWOBJDIR>/bwcc386<CMDEXT>"
    rm -f "<OWROOT>/build/<OWOBJDIR>/bwcc386<CMDEXT>"
    rm -f "<OWROOT>/build/<OWOBJDIR>/bwccd386<DYEXT>"

[ BLOCK <BLDRULE> rel cprel ]
#============================
    <CCCMD> dos386/<OWOBJDIR>/wcc386.exe        "<OWRELROOT>/binw/"
    <CCCMD> dos386/<OWOBJDIR>/wcc386.sym        "<OWRELROOT>/binw/"
    <CCCMD> dos386/<OWOBJDIR>/wcc38601.int      "<OWRELROOT>/binw/"
    <CCCMD> os2386.dll/<OWOBJDIR>/wcc386.exe    "<OWRELROOT>/binp/"
    <CCCMD> os2386.dll/<OWOBJDIR>/wcc386.sym    "<OWRELROOT>/binp/"
    <CCCMD> os2386.dll/<OWOBJDIR>/wccd386.dll   "<OWRELROOT>/binp/dll/"
    <CCCMD> os2386.dll/<OWOBJDIR>/wccd386.sym   "<OWRELROOT>/binp/dll/"
    <CCCMD> os2386.dll/<OWOBJDIR>/wcc38601.int  "<OWRELROOT>/binp/dll/"
    <CCCMD> nt386.dll/<OWOBJDIR>/wcc386.exe     "<OWRELROOT>/binnt/"
    <CCCMD> nt386.dll/<OWOBJDIR>/wcc386.sym     "<OWRELROOT>/binnt/"
    <CCCMD> nt386.dll/<OWOBJDIR>/wccd386.dll    "<OWRELROOT>/binnt/"
    <CCCMD> nt386.dll/<OWOBJDIR>/wccd386.sym    "<OWRELROOT>/binnt/"
    <CCCMD> nt386.dll/<OWOBJDIR>/wcc38601.int   "<OWRELROOT>/binnt/"
    <CCCMD> ntaxp.dll/<OWOBJDIR>/wcc386.exe     "<OWRELROOT>/axpnt/"
    <CCCMD> ntaxp.dll/<OWOBJDIR>/wcc386.sym     "<OWRELROOT>/axpnt/"
    <CCCMD> ntaxp.dll/<OWOBJDIR>/wccd386.dll    "<OWRELROOT>/axpnt/"
    <CCCMD> ntaxp.dll/<OWOBJDIR>/wccd386.sym    "<OWRELROOT>/axpnt/"
    <CCCMD> ntaxp.dll/<OWOBJDIR>/wcc38601.int   "<OWRELROOT>/axpnt/"
    <CCCMD> qnx386/<OWOBJDIR>/wcc386.exe        "<OWRELROOT>/qnx/binq/wcc386"
    <CCCMD> qnx386/<OWOBJDIR>/wcc386.sym        "<OWRELROOT>/qnx/sym/"
    <CCCMD> qnx386/<OWOBJDIR>/wcc38601.int      "<OWRELROOT>/qnx/binq/"
    <CCCMD> linux386/<OWOBJDIR>/wcc386.exe      "<OWRELROOT>/binl/wcc386"
    <CCCMD> linux386/<OWOBJDIR>/wcc386.sym      "<OWRELROOT>/binl/"
    <CCCMD> linux386/<OWOBJDIR>/wcc38601.int    "<OWRELROOT>/binl/"
    <CCCMD> rdos386/<OWOBJDIR>/wcc386.exe       "<OWRELROOT>/rdos/"
    <CCCMD> rdos386/<OWOBJDIR>/wcc386.sym       "<OWRELROOT>/rdos/"

    <CCCMD> bsdx64/<OWOBJDIR>/wcc386.exe        "<OWRELROOT>/binb64/wcc386"
    <CCCMD> bsdx64/<OWOBJDIR>/wcc38601.int      "<OWRELROOT>/binb64/"
    <CCCMD> ntx64.dll/<OWOBJDIR>/wcc386.exe     "<OWRELROOT>/binnt64/"
    <CCCMD> ntx64.dll/<OWOBJDIR>/wccd386.dll    "<OWRELROOT>/binnt64/"
    <CCCMD> ntx64.dll/<OWOBJDIR>/wcc38601.int   "<OWRELROOT>/binnt64/"
    <CCCMD> linuxx64/<OWOBJDIR>/wcc386.exe      "<OWRELROOT>/binl64/wcc386"
    <CCCMD> linuxx64/wcc386.sym                 "<OWRELROOT>/binl64/"
    <CCCMD> linuxx64/<OWOBJDIR>/wcc38601.int    "<OWRELROOT>/binl64/"
    <CCCMD> linuxarm/<OWOBJDIR>/wcc386.exe      "<OWRELROOT>/arml/wcc386"
    <CCCMD> linuxarm/<OWOBJDIR>/wcc38601.int    "<OWRELROOT>/arml/"
    <CCCMD> linuxa64/<OWOBJDIR>/wcc386.exe      "<OWRELROOT>/arml64/wcc386"
    <CCCMD> linuxa64/<OWOBJDIR>/wcc38601.int    "<OWRELROOT>/arml64/"
    <CCCMD> osxx64/<OWOBJDIR>/wcc386.exe        "<OWRELROOT>/bino64/wcc386"
    <CCCMD> osxx64/<OWOBJDIR>/wcc38601.int      "<OWRELROOT>/bino64/"
    <CCCMD> osxarm/<OWOBJDIR>/wcc386.exe        "<OWRELROOT>/armo/wcc386"
    <CCCMD> osxarm/<OWOBJDIR>/wcc38601.int      "<OWRELROOT>/armo/"
    <CCCMD> osxa64/<OWOBJDIR>/wcc386.exe        "<OWRELROOT>/armo64/wcc386"
    <CCCMD> osxa64/<OWOBJDIR>/wcc38601.int      "<OWRELROOT>/armo64/"

[ BLOCK . . ]

[ INCLUDE "<OWROOT>/build/epilog.ctl" ]
