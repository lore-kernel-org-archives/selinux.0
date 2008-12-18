Message-ID: <494AAF0A.4040109@tycho.nsa.gov>
Date: Thu, 18 Dec 2008 15:14:02 -0500
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Xavier Toth <txtoth@gmail.com>
CC: SELinux List <selinux@tycho.nsa.gov>, James Carter <jwcart2@tycho.nsa.gov>,
        Stephen Smalley <sds@tycho.nsa.gov>, Joe Nall <joe@nall.com>
Subject: Re: [RFC] Add color translation support to mcstransd
References: <4927839F.4070805@tycho.nsa.gov> <cadfc0e40812170850r547f7104p5fa8197ca9f4f84e@mail.gmail.com>
In-Reply-To: <cadfc0e40812170850r547f7104p5fa8197ca9f4f84e@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------040301070706090900080309"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040301070706090900080309
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Xavier Toth wrote:
> Where does mcstrans look for secolor.conf? I can use names (red,
> yellow, etc..) for colors instead of hex values, right?
>
> Ted
>
>   

I pushed two changes to the color-ewalsh branch addressing these issues,
please pull.

/etc/selinux/$POLICYTYPE/secolor.conf  is the location.

You can define names for colors using a new "color" rule in the conf
file.  Hex values are now specified with a leading hash mark to
distinguish them from symbolic names.

The "level" and "category" rules were dropped because, as alluded to in
another thread, SELinux does not expose knowledge of the MLS field to
the end user.  The only call available in the SELinux API is a dominance
check, hence I had to combine those two rules into a single "range" rule.

New example conf file attached.


-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--------------040301070706090900080309
Content-Type: text/plain;
 name="secolor.conf"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="secolor.conf"

#
# Color translation table for SELinux
#
# The color mechanism supports separate foreground/background color pairs for
# each component of the context (user, role, type, and range).
# Shell-style wildcards are supported in user, role, and type patterns.
#
# Colors are specified as hexadecimal RGB values.  Each line must contain
# two colors separated by whitespace: a foreground (text) color and
# background (area) color.
#
# It is not generally necessary to define colors for all five components of
# the context.  The color mechanism will borrow colors from other components
# as necessary.  For example if no user, role, or type statements are present,
# the matching engine will use the range color for all four components.
#

# Color definitions
color red   = #ff0000
color green = #00ff00
color blue  = #0000ff
color yellow = #ffff00
color black = #000000
color white = #ffffff

# Example non-MLS color configuration
#  Display sysadm/system in black-on-red
#role sysadm_r = black red
#role system_r = black red

#  Display staff in black-on-yellow
#role staff_r = black yellow

#  Display everything else in yellow-on-green
#role * = yellow green


# Example MLS color configuration
range s0:c0.c255 = yellow green
range s1:c0.c255 = red yellow
range s2:c0.c255 = yellow red
range s15:c0.c255 = #ffff00 #ff00ff

--------------040301070706090900080309--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
