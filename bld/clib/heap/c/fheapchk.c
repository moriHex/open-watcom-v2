/****************************************************************************
*
*                            Open Watcom Project
*
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
* Description:  Implementation of far _heapchk() and _fheapchk().
*               (16-bit code only)
*
****************************************************************************/


#include "dll.h"        // needs to be first
#include "variety.h"
#include <stddef.h>
#include <malloc.h>
#include "heap.h"
#include "heapacc.h"


#define FRLBPTR     XBPTR( freelistp, seg )

freelistp _WCFAR *__fheapchk_current;

static int checkFreeList( unsigned long *free_size )
{
    __segment           seg;
    FRLBPTR             curr_frl;
    unsigned long       total_size;

    total_size = 0;
    for( seg = __fheapbeg; seg != _NULLSEG; seg = HBPTR( seg )->nextseg ) {
        __fheapchk_current = curr_frl = HBPTR( seg )->freehead.next;
        while( FP_OFF( curr_frl ) != offsetof( heapblk, freehead ) ) {
            total_size += curr_frl->len;
            __fheapchk_current = curr_frl = curr_frl->next;
        }
    }
    *free_size = total_size;
    return( _HEAPOK );
}

static int checkFree( freelistp _WCFAR *p )
{
    __segment   seg;
    FRLBPTR     prev;
    FRLBPTR     next;

    __fheapchk_current = p;
    seg = FP_SEG( p );
    prev = p->prev;
    next = p->next;
    if( prev->next != (FRLBPTR)p || next->prev != (FRLBPTR)p ) {
        return( _HEAPBADNODE );
    }
    if( ((FRLBPTR)prev->prev)->next != prev || ((FRLBPTR)next->next)->prev != next ) {
        return( _HEAPBADNODE );
    }
    return( _HEAPOK );
}

#if defined(__BIG_DATA__)
_WCRTLINK int _heapchk( void )
{
    return( _fheapchk() );
}
#endif


_WCRTLINK int _fheapchk( void )
{
    struct _heapinfo    hi;
    int                 heap_status;
    unsigned long       free_size;

    _AccessFHeap();
    heap_status = checkFreeList( &free_size );
    if( heap_status != _HEAPOK ) {
        _ReleaseFHeap();
        return( heap_status );
    }
    hi._pentry = NULL;
    for( ;; ) {
        heap_status = __HeapWalk( &hi, __fheapbeg, 0 );
        if( heap_status != _HEAPOK )
            break;
        if( hi._useflag == _FREEENTRY ) {
            heap_status = checkFree( hi._pentry );
            if( heap_status != _HEAPOK )
                break;
            free_size -= hi._size;
        }
    }
    if( free_size != 0 ) {
        heap_status = _HEAPBADNODE;
    } else if( heap_status == _HEAPBADPTR ) {
        heap_status = _HEAPBADNODE;
    } else {
        if( heap_status == _HEAPEND ) {
            heap_status = _HEAPOK;
        }
    }
    _ReleaseFHeap();
    return( heap_status );
}
