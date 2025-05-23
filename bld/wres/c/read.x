/****************************************************************************
*
*                            Open Watcom Project
*
* Copyright (c) 2025      The Open Watcom Contributors. All Rights Reserved.
*    Portions Copyright (c) 1983-2002 Sybase, Inc. All Rights Reserved.
*
*  ========================================================================
*
*    This file contains Original Code and/or Modifications of Original
*    Code as defined in and that are subject to the Sybase Open Watcom
*    Public License version 1.0 (the 'License'). You may not use this file
*    except in compliance with the License. BY USING THIS FILE YOU AGREE TO
*    ALL TERMS AND CONDITIONS OF THE LICENSE. A copy of the License is
*    provided with the Original Code and Modifications, and is also
*    available at www.sybase.com/developer/opensource.
*
*    The Original Code and all software distributed under the License are
*    distributed on an 'AS IS' basis, WITHOUT WARRANTY OF ANY KIND, EITHER
*    EXPRESS OR IMPLIED, AND SYBASE AND ALL CONTRIBUTORS HEREBY DISCLAIM
*    ALL SUCH WARRANTIES, INCLUDING WITHOUT LIMITATION, ANY WARRANTIES OF
*    MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, QUIET ENJOYMENT OR
*    NON-INFRINGEMENT. Please see the License for the specific language
*    governing rights and limitations under the License.
*
*  ========================================================================
*
* Description:  Routines to read in the various structures used in WRes files.
*
****************************************************************************/


#include <string.h>
#include "filefmt.h"
#include "resfmt.h"
#include "mresfmt.h"
#include "wresrtns.h"
#include "varstr.h"
#include "layer0.h"
#include "read.h"


int ResReadUint8( uint_8 * newint, WResFileID handle )
/****************************************************/
{
    int numread;

    numread = WRESREAD( handle, newint, sizeof(uint_8) );
    return( numread != sizeof(uint_8) );
}

int ResReadUint16( uint_16 * newint, WResFileID handle )
/******************************************************/
{
    int numread;

    numread = WRESREAD( handle, newint, sizeof(uint_16) );
    return( numread != sizeof(uint_16) );
}

int ResReadUint32( uint_32 * newint, WResFileID handle )
/******************************************************/
{
    int numread;

    numread = WRESREAD( handle, newint, sizeof(uint_32) );
    return( numread != sizeof(uint_32) );
}

WResIDName * WResReadWResIDName( WResFileID handle )
/**************************************************/
{
    WResIDName      newname;
    WResIDName *    newptr;
    int             numread;
    int             error;

    /* read the size of the name in */
    error = ResReadUint8( &(newname.NumChars), handle );

    /* alloc the space for the new record */
    if (!error) {
        /* -1 because one of the chars in the name is declared in the struct */
        newptr = WRESALLOC( sizeof(WResIDName) +
                        newname.NumChars - 1 );
    }

    /* read in the characters */
    if (newptr != NULL) {
        newptr->NumChars = newname.NumChars;
        numread = WRESREAD( handle, newptr->Name, newptr->NumChars );
        if (numread != newptr->NumChars) {
            WRESFREE( newptr );
            newptr = NULL;
        }
    }

    return( newptr );
} /* WResReadWResIDName */

int WResReadExtraWResID( WResID * name, WResFileID handle )
/**********************************************************
 * reads the extra bytes into the end of the structure
 * assumes that the fixed portion has just been read in and is in name and
 * that name is big enough to hold the extra bytes
 */
{
    int     numread;
    int     extrabytes;

    if (name->IsName) {
        extrabytes = name->ID.Name.NumChars - 1;
        if (extrabytes > 0) {
            numread = WRESREAD( handle, &(name->ID.Name.Name[1]),
                        extrabytes );
            return( numread != extrabytes );
        } else {
            return( FALSE );
        }
    } else {
        return( FALSE );
    }
}

int WResReadFixedWResID( WResID * name, WResFileID handle )
/**********************************************************
 * reads the fixed part of a WResID
 */
{
    int         numread;

    numread = WRESREAD( handle, name, sizeof(WResID) );
    return( numread != sizeof(WResID) );
} /* WResReadFixedWResID */

WResID * WResReadWResID( WResFileID handle )
/******************************************/
{
    WResID      newid;
    WResID *    newidptr;
    int         numread;
    int         extrabytes;     /* chars to be read beyond the fixed size */
    int         error;

    /* read in the fixed part of the record */
    error = WResReadFixedWResID( &newid, handle );
    if (error) {
        return( NULL );
    }

    if (newid.IsName) {
        extrabytes = newid.ID.Name.NumChars - 1;
    } else {
        extrabytes = 0;
    }

    newidptr = WRESALLOC( sizeof(WResID) + extrabytes );
    if (newidptr != NULL) {
        memcpy( newidptr, &newid, sizeof(WResID) );
        if (extrabytes != 0) {
            numread = WRESREAD( handle, &(newidptr->ID.Name.Name[1]),
                                extrabytes );
            if (numread != extrabytes) {
                WRESFREE( newidptr );
                newidptr = NULL;
            }
        }
    }

    return( newidptr );
} /* WResReadWResID */

int WResReadFixedTypeRecord( WResTypeInfo * newtype, WResFileID handle )
/***********************************************************************
 * read the fixed part of a Type info record
 */
{
    int                 numread;

    numread = WRESREAD( handle, newtype, sizeof(WResTypeInfo) );
    return( numread != sizeof(WResTypeInfo) );
} /* WResReadFixedTypeRecord */

WResTypeInfo * WResReadTypeRecord( WResFileID handle )
/*****************************************************
 * reads in the fields of a type info record from the current position in
 * the file identified by fp
 */
{
    WResTypeInfo        newtype;
    WResTypeInfo *      newptr;
    int                 numread;
    int                 numcharsleft;
    int                 error;

    error = WResReadFixedTypeRecord( &newtype, handle );
    if (error) {
        return( NULL );
    }

    if (newtype.TypeName.IsName) {
        numcharsleft = newtype.TypeName.ID.Name.NumChars - 1;
    } else {
        numcharsleft = 0;
    }
    newptr = WRESALLOC( sizeof(WResTypeInfo) + numcharsleft );
    if (newptr != NULL) {
        memcpy( newptr, &newtype, sizeof(WResTypeInfo) );
        if (numcharsleft != 0) {
            numread = WRESREAD( handle, &(newptr->TypeName.ID.Name.Name[1]), numcharsleft );
            if (numread != numcharsleft) {
                WRESFREE( newptr );
                newptr = NULL;
            }
        }
    }

    return( newptr );
} /* WResReadTypeRecord */

int WResReadFixedResRecord( WResResInfo * newres, WResFileID handle )
/********************************************************************
 * reads the fixed part of a Res info record
 */
{
    int             numread;

    numread = WRESREAD( handle, (uint_8 *)newres + sizeof(void *), sizeof(WResResInfo) - sizeof(void *) );
    newres->ResData = NULL;
    return( numread != ( sizeof(WResResInfo) - sizeof (void *) ) );
} /* WResReadFixedResRecord */

WResResInfo * WResReadResRecord( WResFileID handle )
/***************************************************
 * reads in the fields of a res info record from the current position in
 * the file identified by fp
 */
{
    WResResInfo     newres;
    WResResInfo *   newptr;
    int             numread;
    int             numcharsleft;
    int             error;

    error = WResReadFixedResRecord( &newres, handle );
    if (error) {
        return( NULL );
    }

    if (newres.ResName.IsName) {
        numcharsleft = newres.ResName.ID.Name.NumChars - 1;
    } else {
        numcharsleft = 0;
    }
    newptr = WRESALLOC( sizeof(WResResInfo) + numcharsleft );
    if (newptr != NULL) {
        memcpy( newptr, &newres, sizeof(WResResInfo) );
        if (numcharsleft != 0) {
            numread = WRESREAD( handle, &(newptr->ResName.ID.Name.Name[1]), numcharsleft );
            if (numread != numcharsleft) {
                WRESFREE( newptr );
                newptr = NULL;
            }
        }
    }

    return( newptr );
} /* WResReadResRecord */

int WResReadHeaderRecord( WResHeader * header, WResFileID handle )
/****************************************************************/
{
    int     numread;
    uint_32 currpos;

    currpos = WRESSEEK( handle, 0, SEEK_SET );
    numread = WRESREAD( handle, header, sizeof(WResHeader) );
    WRESSEEK( handle, currpos, SEEK_SET );

    return( numread != sizeof(WResHeader) );
}

int WResIsWResFile( WResFileID handle )
/**************************************
 * Checks the start of the file identified by fp for the Magic number then
 * resets the postion in the file. Returns true is this is a WRes file
 */
{
    uint_32     savepos;
    uint_32     Magic[ 2 ];
    int         error;


    savepos = WRESSEEK( handle, 0, SEEK_SET );
    if (savepos == -1) {
        return( FALSE );        /* if an error occurs this is not a WRes file */
    }

    error = ResReadUint32( Magic, handle );

    if (!error) {
        error = ResReadUint32( Magic + 1, handle );
    }

    WRESSEEK( handle, savepos, SEEK_SET );

    return( !error && Magic[0] == WRESMAGIC0 && Magic[1] == WRESMAGIC1 );
} /* WResIsWResFile */

char * ResReadString( WResFileID handle, int * strlen )
/*****************************************************/
{
    VarString *         newstring;
    int                 error;
    uint_8              nextchar;
    char *              retstring;

    newstring = VarStringStart();
    error = ResReadUint8( &nextchar, handle );
    while (!error && nextchar != '\0') {
        VarStringAddChar( newstring, nextchar );
        error = ResReadUint8( &nextchar, handle );
    }

    retstring = VarStringEnd( newstring, strlen );

    if (error && retstring != NULL ) {
        WRESFREE(retstring);
        retstring = NULL;
    }

    return( retstring );
} /* ResReadString */

ResNameOrOrdinal * ResReadNameOrOrdinal( WResFileID handle )
/**********************************************************/
{
    ResNameOrOrdinal    newname;
    ResNameOrOrdinal *  newptr;
    int                 error;
    int                 stringlen;
    char *              restofstr;

    error = ResReadUint8( &(newname.ord.fFlag), handle );

    /* read the rest of the Name or Ordinal */
    stringlen = 0;
    if (!error) {
        if (newname.ord.fFlag == 0xff) {
            error = ResReadUint16( &(newname.ord.wOrdinalID), handle );
        } else if (newname.ord.fFlag != 0) {
            restofstr = ResReadString( handle, &stringlen );
            stringlen += 1; /* for the '\0' */
            error = (restofstr == NULL);
        }
    }

    /* allocate space for the new Name or Ordinal */
    if (error) {
        newptr = NULL;
    } else {
        newptr = WRESALLOC( sizeof(ResNameOrOrdinal) + stringlen );
        error = (newptr == NULL);
    }

    /* copy the new new Name or Ordinal into the correct place */
    if (!error) {
        if (newname.ord.fFlag == 0xff) {
            newptr->ord.fFlag = 0xff;
            newptr->ord.wOrdinalID = newname.ord.wOrdinalID;
        } else if (newname.ord.fFlag == 0) {
            newptr->name[0] = '\0';
        } else {
            memcpy( newptr->name + 1, restofstr, stringlen );
            WRESFREE( restofstr );
        }
    }

    return( newptr );
}

MResResourceHeader * MResReadResourceHeader( WResFileID handle )
/**************************************************************/
{
    MResResourceHeader *    newhead;
    int                     error;

    newhead = WRESALLOC( sizeof(MResResourceHeader) );
    error = (newhead == NULL);

    if (!error) {
        newhead->Type = ResReadNameOrOrdinal( handle );
        error = (newhead->Type == NULL);
    }
    if (!error) {
        newhead->Name = ResReadNameOrOrdinal( handle );
        error = (newhead->Name == NULL);
    }
    if (!error) {
        error = ResReadUint16( &(newhead->MemoryFlags), handle);
    }
    if (!error) {
        error = ResReadUint32( &(newhead->Size), handle );
    }

    if (error && newhead != NULL) {
        WRESFREE( newhead );
        newhead = NULL;
    }

    return( newhead );
} /* MResReadResourceHeader */

long ResTell( WResFileID handle )
/********************************
 * cover function for tell
 */
{
    return( WRESTELL( handle ) );
}

long ResSeek( WResFileID handle, long offset, int origin )
/*********************************************************
 * cover function for seek
 */
{
    return( WRESSEEK( handle, offset, origin ) );
}
