/****************************************************************************
*
*                            Open Watcom Project
*
*  Copyright (c) 2004-2009 The Open Watcom Contributors. All Rights Reserved.
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
* Description: WGML implement :DOCNUM  tag for LAYOUT processing
*
****************************************************************************/


#include "wgml.h"

#include "clibext.h"


/***************************************************************************/
/*   :DOCNUM   attributes                                                  */
/***************************************************************************/
const   lay_att     docnum_att[7] =
    { e_left_adjust, e_right_adjust, e_page_position, e_font, e_pre_skip,
      e_docnum_string, e_dummy_zero };


/***************************************************************************/
/*  lay_docnum                                                             */
/***************************************************************************/

void    lay_docnum( const gmltag * entry )
{
    char            *   p;
    condcode            cc;
    int                 cvterr;
    int                 k;
    lay_att             curr;
    att_name_type       attr_name;
    att_val_type        attr_val;

    (void)entry;

    p = scandata.s;
    cvterr = false;

    if( !GlobalFlags.firstpass ) {
        scandata.s = scandata.e;
        eat_lay_sub_tag();
        return;                         // process during first pass only
    }
    memset( &AttrFlags, 0, sizeof( AttrFlags ) );   // clear all attribute flags
    if( ProcFlags.lay_xxx != el_docnum ) {
        ProcFlags.lay_xxx = el_docnum;
    }
    while( (cc = lay_attr_and_value( &attr_name, &attr_val )) == pos ) {   // get att with value
        cvterr = -1;
        for( k = 0, curr = docnum_att[k]; curr > 0; k++, curr = docnum_att[k] ) {
            if( strcmp( lay_att_names[curr], attr_name.attname.l ) == 0 ) {
                p = attr_val.name;
                switch( curr ) {
                case e_left_adjust:
                    if( AttrFlags.left_adjust ) {
                        xx_line_err_ci( err_att_dup, attr_name.att_name,
                            attr_val.name - attr_name.att_name + attr_val.len);
                    }
                    cvterr = i_space_unit( p, &attr_val,
                                           &layout_work.docnum.left_adjust );
                    AttrFlags.left_adjust = true;
                    break;
                case e_right_adjust:
                    if( AttrFlags.right_adjust ) {
                        xx_line_err_ci( err_att_dup, attr_name.att_name,
                            attr_val.name - attr_name.att_name + attr_val.len);
                    }
                    cvterr = i_space_unit( p, &attr_val,
                                           &layout_work.docnum.right_adjust );
                    AttrFlags.right_adjust = true;
                    break;
                case e_page_position:
                    if( AttrFlags.page_position ) {
                        xx_line_err_ci( err_att_dup, attr_name.att_name,
                            attr_val.name - attr_name.att_name + attr_val.len);
                    }
                    cvterr = i_page_position( p, &attr_val,
                                          &layout_work.docnum.page_position );
                    AttrFlags.page_position = true;
                    break;
                case e_font:
                    if( AttrFlags.font ) {
                        xx_line_err_ci( err_att_dup, attr_name.att_name,
                            attr_val.name - attr_name.att_name + attr_val.len);
                    }
                    cvterr = i_font_number( p, &attr_val, &layout_work.docnum.font );
                    if( layout_work.docnum.font >= wgml_font_cnt ) {
                        layout_work.docnum.font = 0;
                    }
                    AttrFlags.font = true;
                    break;
                case e_pre_skip:
                    if( AttrFlags.pre_skip ) {
                        xx_line_err_ci( err_att_dup, attr_name.att_name,
                            attr_val.name - attr_name.att_name + attr_val.len);
                    }
                    cvterr = i_space_unit( p, &attr_val,
                                           &layout_work.docnum.pre_skip );
                    AttrFlags.pre_skip = true;
                    break;
                case e_docnum_string:
                    if( AttrFlags.docnum_string ) {
                        xx_line_err_ci( err_att_dup, attr_name.att_name,
                            attr_val.name - attr_name.att_name + attr_val.len);
                    }
                    cvterr = i_xx_string( p, &attr_val, layout_work.docnum.string );
                    AttrFlags.docnum_string = true;
                    break;
                default:
                    internal_err( __FILE__, __LINE__ );
                }
                if( cvterr ) {          // there was an error
                    xx_err( err_att_val_inv );
                }
                break;                  // break out of for loop
            }
        }
        if( cvterr < 0 ) {
            xx_err( err_att_name_inv );
        }
        if( ProcFlags.tag_end_found ) {
            break;
        }
    }
    scandata.s = scandata.e;
    return;
}

