/****************************************************************************
*
*                            Open Watcom Project
*
* Copyright (c) 2002-2025 The Open Watcom Contributors. All Rights Reserved.
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
* Description:  Header file for all extern functions in utils.c.
*
****************************************************************************/


typedef enum {
    COPY_NORMAL     = 0x00,
    COPY_APPEND     = 0x01,
    COPY_TEXT_CRLF  = 0x02
} copy_mode;

extern bool             ModifyEnvironment( bool );
extern bool             ModifyStartup( bool );
extern bool             ModifyAssociations( bool );
extern bool             ModifyUninstall( bool );
extern COPYFILE_ERROR   DoCopyFile( const VBUF *src, const VBUF *dst, copy_mode copymode );
extern bool             CopyAllFiles( void );
extern gui_message_return MsgBox( gui_window *, const char *, gui_message_type, ... );
extern bool             CheckFsys( bool );
extern bool             InitInfo( const VBUF *, const VBUF * );
extern bool             GetDirParams( int, char **, VBUF *, VBUF *, VBUF * );
extern bool             FreeDirParams( void );
extern void             CloseDownMessage( bool state );
extern unsigned         GetTargetBlockSize( int target );
extern void             AddInstallName( VBUF *str );
extern const char       *stristr( const char *str, const char *substr, size_t substr_len );
extern void             Log( char *start, ... );
extern void             GetInstallName( VBUF * );
extern bool             PromptUser( const VBUF *name, const char *dlg, const char *skip, const char *replace, bool *resp_replace );
extern void             GetWindowsDirectoryVbuf( VBUF *windir );
extern signed int       IncrementDLLUsageCount( const VBUF *path );
extern signed int       DecrementDLLUsageCount( const VBUF *path );
extern void             ReadVariablesFile( const char * name );
extern void             ConcatDirSep( char *dir );
extern void             RemoveDirSep( char *dir );
extern void             SetupError( const char * );
extern void             DoSpawn( when_time when );
extern void             ResetFsysInfo( void );
extern void             ResetAllFsysInfo( void );
extern void             InitFsysInfo( void );
extern void             FiniFsysInfo( void );
extern void             DeleteObsoleteFiles( void );
