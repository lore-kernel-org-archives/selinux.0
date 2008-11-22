Message-ID: <4927839F.4070805@tycho.nsa.gov>
Date: Fri, 21 Nov 2008 22:59:27 -0500
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: SELinux List <selinux@tycho.nsa.gov>
CC: James Carter <jwcart2@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>,
        Ted X Toth <txtoth@gmail.com>, Joe Nall <joe@nall.com>
Subject: [RFC] Add color translation support to mcstransd
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The proposal is to add 2 new functions to mcstransd:
RAW_CONTEXT_TO_COLOR and TRANS_CONTEXT_TO_COLOR, and to add a new
configuration file "secolor.conf", similar to setrans.conf, which
contains mappings from security context components into colors.

The purpose of this facility is to service SELinux-aware graphical
applications which display security contexts.  Standard color schemes
are often associated with security levels or categories.  The proposed
color facility allows color policy to be expressed in the same manner as
the existing human-readable translation strings in setrans.conf. 
Example uses include security labels in a window manager,
headers/footers in documents or printouts, or downgrade dialogs in
selection managers.

The proposed color lookup operation supports up to 10 colors: a
foreground/background pair for each component of the security context
(user, role, type, level, and category).  If all five components are not
specified in the configuration file, the matching engine will copy from
other components to fill out the 10 colors according to fallback rules. 
For example, if colors are only specified for levels, the other four
color pairs will be set to the value specified for the level.  This
allows maximum flexibility while supporting the common case of only
displaying a single foreground/background or even just a background color.

Below is a sample secolor.conf file.  Comments appreciated.


#
# Color translation table for SELinux
#
# The color mechanism supports separate foreground/background color pairs for
# each component of the context (user, role, type, level, and category).
# Shell-style wildcards are supported in user, role, and type patterns.
#
# Colors are specified as hexadecimal RGB values.  Each line must contain
# two colors separated by whitespace: a foreground (text) color and
# background (area) color.
#
# It is not generally necessary to define colors for all five components of
# the context.  The color mechanism will borrow colors from other components
# as necessary.  For example if no user, role, or type statements are present,
# the matching engine will use the level color for all four components.
#

# Example non-MLS color configuration
#  Display sysadm/system in black-on-red
role sysadm_r = 000000 ff0000
role system_r = 000000 ff0000

#  Display staff in black-on-yellow
role staff_r = 000000 ffff00

#  Display everything else in white-on-green
role * = ffffff 00ff00


# Example MLS color configuration
level s0 = ffff00 00ff00
level s1 = ff0000 ffff00
level s2 = ffff00 ff0000
level s15 = 0000ff ff0000

category c0 = ffffff 0000ff
category c1 = ffffff 00ff00
category c0.c1 = ffffff 00ffff
category c0.c255 = 0000ff ff0000





-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
