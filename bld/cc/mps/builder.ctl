# wccmps Builder Control file
# ===========================

set PROJNAME=wccmps

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
    <CPCMD> <OWOBJDIR>/bwccmps.exe      "<OWROOT>/build/<OWOBJDIR>/bwccmps<CMDEXT>"
    <CCCMD> <OWOBJDIR>/bwccdmps<DYEXT>  "<OWROOT>/build/<OWOBJDIR>/bwccdmps<DYEXT>"

[ BLOCK <BINTOOL> clean ]
#========================
    echo rm -f "<OWROOT>/build/<OWOBJDIR>/bwccmps<CMDEXT>"
    rm -f "<OWROOT>/build/<OWOBJDIR>/bwccmps<CMDEXT>"
    rm -f "<OWROOT>/build/<OWOBJDIR>/bwccdmps<DYEXT>"

[ BLOCK <BLDRULE> rel cprel ]
#============================
    <CCCMD> dos386/<OWOBJDIR>/wccmps.exe        "<OWRELROOT>/binw/"
    <CCCMD> dos386/<OWOBJDIR>/wccmps.sym        "<OWRELROOT>/binw/"
    <CCCMD> dos386/<OWOBJDIR>/wccmps01.int      "<OWRELROOT>/binw/"
    <CCCMD> os2386.dll/<OWOBJDIR>/wccmps.exe    "<OWRELROOT>/binp/"
    <CCCMD> os2386.dll/<OWOBJDIR>/wccmps.sym    "<OWRELROOT>/binp/"
    <CCCMD> os2386.dll/<OWOBJDIR>/wccdmps.dll   "<OWRELROOT>/binp/dll/"
    <CCCMD> os2386.dll/<OWOBJDIR>/wccdmps.sym   "<OWRELROOT>/binp/dll/"
    <CCCMD> os2386.dll/<OWOBJDIR>/wccmps01.int  "<OWRELROOT>/binp/dll/"
    <CCCMD> nt386.dll/<OWOBJDIR>/wccmps.exe     "<OWRELROOT>/binnt/"
    <CCCMD> nt386.dll/<OWOBJDIR>/wccmps.sym     "<OWRELROOT>/binnt/"
    <CCCMD> nt386.dll/<OWOBJDIR>/wccdmps.dll    "<OWRELROOT>/binnt/"
    <CCCMD> nt386.dll/<OWOBJDIR>/wccdmps.sym    "<OWRELROOT>/binnt/"
    <CCCMD> nt386.dll/<OWOBJDIR>/wccmps01.int   "<OWRELROOT>/binnt/"
    <CCCMD> ntaxp.dll/<OWOBJDIR>/wccmps.exe     "<OWRELROOT>/axpnt/"
    <CCCMD> ntaxp.dll/<OWOBJDIR>/wccmps.sym     "<OWRELROOT>/axpnt/"
    <CCCMD> ntaxp.dll/<OWOBJDIR>/wccdmps.dll    "<OWRELROOT>/axpnt/"
    <CCCMD> ntaxp.dll/<OWOBJDIR>/wccdmps.sym    "<OWRELROOT>/axpnt/"
    <CCCMD> ntaxp.dll/<OWOBJDIR>/wccmps01.int   "<OWRELROOT>/axpnt/"
    <CCCMD> qnx386/<OWOBJDIR>/wccmps.exe        "<OWRELROOT>/qnx/binq/wccmps"
    <CCCMD> qnx386/<OWOBJDIR>/wccmps.sym        "<OWRELROOT>/qnx/sym/"
    <CCCMD> qnx386/<OWOBJDIR>/wccmps01.int      "<OWRELROOT>/qnx/binq/"
    <CCCMD> linux386/<OWOBJDIR>/wccmps.exe      "<OWRELROOT>/binl/wccmps"
    <CCCMD> linux386/<OWOBJDIR>/wccmps.sym      "<OWRELROOT>/binl/"
    <CCCMD> linux386/<OWOBJDIR>/wccmps01.int    "<OWRELROOT>/binl/"

    <CCCMD> bsdx64/<OWOBJDIR>/wccmps.exe        "<OWRELROOT>/binb64/wccmps"
    <CCCMD> bsdx64/<OWOBJDIR>/wccmps01.int      "<OWRELROOT>/binb64/"
    <CCCMD> ntx64.dll/<OWOBJDIR>/wccmps.exe     "<OWRELROOT>/binnt64/"
    <CCCMD> ntx64.dll/<OWOBJDIR>/wccdmps.dll    "<OWRELROOT>/binnt64/"
    <CCCMD> ntx64.dll/<OWOBJDIR>/wccmps01.int   "<OWRELROOT>/binnt64/"
    <CCCMD> linuxx64/<OWOBJDIR>/wccmps.exe      "<OWRELROOT>/binl64/wccmps"
    <CCCMD> linuxx64/wccmps.sym                 "<OWRELROOT>/binl64/"
    <CCCMD> linuxx64/<OWOBJDIR>/wccmps01.int    "<OWRELROOT>/binl64/"
    <CCCMD> linuxarm/<OWOBJDIR>/wccmps.exe      "<OWRELROOT>/arml/wccmps"
    <CCCMD> linuxarm/<OWOBJDIR>/wccmps01.int    "<OWRELROOT>/arml/"
    <CCCMD> linuxa64/<OWOBJDIR>/wccmps.exe      "<OWRELROOT>/arml64/wccmps"
    <CCCMD> linuxa64/<OWOBJDIR>/wccmps01.int    "<OWRELROOT>/arml64/"
    <CCCMD> osxx64/<OWOBJDIR>/wccmps.exe        "<OWRELROOT>/bino64/wccmps"
    <CCCMD> osxx64/<OWOBJDIR>/wccmps01.int      "<OWRELROOT>/bino64/"
    <CCCMD> osxarm/<OWOBJDIR>/wccmps.exe        "<OWRELROOT>/armo/wccmps"
    <CCCMD> osxarm/<OWOBJDIR>/wccmps01.int      "<OWRELROOT>/armo/"
    <CCCMD> osxa64/<OWOBJDIR>/wccmps.exe        "<OWRELROOT>/armo64/wccmps"
    <CCCMD> osxa64/<OWOBJDIR>/wccmps01.int      "<OWRELROOT>/armo64/"

[ BLOCK . . ]

[ INCLUDE "<OWROOT>/build/epilog.ctl" ]
