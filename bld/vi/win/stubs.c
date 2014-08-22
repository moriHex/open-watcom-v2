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
* Description:  WHEN YOU FIGURE OUT WHAT THIS FILE DOES, PLEASE
*               DESCRIBE IT HERE!
*
****************************************************************************/


#include "vi.h"
#include <dos.h>

#if defined( __WATCOMC__ )
#pragma off( unreferenced );
#endif

void RedrawMouse( int p1, int p2 ) { p1=p1;p2=p2;}
bool DisplayMouse( bool p1 ) { p1=p1; return( false ); }
void TurnOffCapsLock( void ) {}
vi_rc HandleMouseEvent( void ) { return( ERR_NO_ERR ); }
void SwapAllWindows( void ) {}
void SetMouseSpeed( int i ) {}
void GetClockStart( void ) {}
void GetSpinStart( void ) {}
void WindowAuxUpdate( window_id id, int x, int y ) { id=id;x=x;y=y; }
void DrawBorder( window_id id ) { id=id; }
void PushMouseEventHandler( mouse_callback cb ) { cb=cb; }
void PopMouseEventHandler( void ) {}
void WindowBorderData( window_id id, char *c, int x ) { id=id;c=c;x=x; }
vi_rc ResizeWindowRelative( window_id id, int p1, int p2, int p3, int p4, bool flags ) {
    id=id;p1=p1;p2=p2;p3=p3;p4=p4;flags=flags;
    return( ERR_NO_ERR );
}
vi_rc ResizeWindow( window_id id, int p1, int p2, int p3, int p4, bool flags ) {
    id=id;p1=p1;p2=p2;p3=p3;p4=p4;flags=flags;
    return( ERR_NO_ERR );
}
void RestoreInterrupts( void ) {}
void WindowSwapFileClose( void ) {}
void FiniMouse( void ) {}
void ScreenFini( void ) {}
vi_rc ResizeCurrentWindowWithKeys( void ) { return( ERR_NO_ERR ); }
vi_rc MoveCurrentWindowWithKeys( void ) { return( ERR_NO_ERR ); }
drive_type DoGetDriveType( int i ) { i=i; return( DRIVE_NONE ); }
void ClearScreen( void ) {}
vi_rc ResetWindow( window_id *id ) { id=id; return( ERR_NO_ERR ); }
bool WindowIsVisible( window_id id ) { id=id; return( true ); }
void ScreenInit( void ) {}
void SetInterrupts( void ) {}
void ChkExtendedKbd( void ) {}
void InitMouse( void ) {}
void SetBorderGadgets( window_id id, bool how ) { id=id;how=how; }
void NewWindow( void ) {}
vi_rc GetNewValueDialog( char *value ) { value=value; return( ERR_NO_ERR ); }
void DisplayCrossLineInWindow( window_id id, int line ) { id=id;line=line; }
int SetCharInWindowWithColor( window_id wn, int line, int col, char text, type_style *style ) {
    wn=wn;line=line;col=col;text=text;style=style;
    return( ERR_NO_ERR );
}
void DisplayLineWithHilite( window_id id, int line, char *text, int start, int end, int ignore ) {
    id=id;line=line;text=text;start=start;end=end;ignore=ignore;
}
void SetPosToMessageLine( void ) {}
void HideCursor( void ) {}

#if defined( __WATCOMC__ )
#pragma on( unreferenced );
#endif
