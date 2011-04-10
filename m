Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p3AGPHr9000788
	for <selinux@tycho.nsa.gov>; Sun, 10 Apr 2011 12:25:17 -0400
Received: from nm3-vm0.bt.bullet.mail.ird.yahoo.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with SMTP id p3AGPGEV007272
	for <selinux@tycho.nsa.gov>; Sun, 10 Apr 2011 16:25:16 GMT
Message-ID: <703187.86923.qm@web87016.mail.ird.yahoo.com>
Date: Sun, 10 Apr 2011 17:25:15 +0100 (BST)
From: Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH 1/1] Add libselinux man pages for colour functions
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Add man pages for selinux_raw_context_to_color(5), selinux_colors_path(3) and secolors.conf(5).

Signed-off-by: root Richard Haines <richard_c_haines@btinternet.com>
---
 libselinux/man/man3/selinux_colors_path.3          |   36 ++++
 libselinux/man/man3/selinux_raw_context_to_color.3 |  124 +++++++++++++
 libselinux/man/man5/secolors.conf.5                |  181 ++++++++++++++++++++
 3 files changed, 341 insertions(+), 0 deletions(-)
 create mode 100644 libselinux/man/man3/selinux_colors_path.3
 create mode 100644 libselinux/man/man3/selinux_raw_context_to_color.3
 create mode 100644 libselinux/man/man5/secolors.conf.5

diff --git a/libselinux/man/man3/selinux_colors_path.3 b/libselinux/man/man3/selinux_colors_path.3
new file mode 100644
index 0000000..2a117d1
--- /dev/null
+++ b/libselinux/man/man3/selinux_colors_path.3
@@ -0,0 +1,36 @@
+.TH "selinux_colors_path" "3" "08 April 2011" "SELinux API documentation"
+
+.SH "NAME"
+selinux_colors_path \- Return a path to the active SELinux policy color configuration file.
+.SH "SYNOPSIS"
+.B #include <selinux/selinux.h>
+.sp
+.B const char *selinux_colors_path(void);
+
+.SH "DESCRIPTION"
+.B selinux_colors_path
+returns the path to the active policy color configuration file. 
+.sp
+The path is built from the path returned by 
+.BR selinux_policy_root "(3)"
+with 
+.B /secolor.conf
+appended.
+.sp
+This optional configuration file whose format is shown in 
+.BR secolor.conf "(5),"
+controls the colors to be associated with the 
+.I raw
+context components of the
+.BR selinux_raw_context_to_color "(3)"
+function when information is to be displayed by an SELinux color-aware application.
+
+.SH "RETURN VALUE"
+On success, the path to the active policy color configuration file is returned. If a path is not available NULL is returned.
+
+.SH "ERRORS"
+None.
+
+.SH "SEE ALSO"
+.BR selinux "(8), " selinux_policy_root "(3), " selinux_config "(5), " selinux_raw_context_to_color "(3), " secolor.conf  "(5)"
+
diff --git a/libselinux/man/man3/selinux_raw_context_to_color.3 b/libselinux/man/man3/selinux_raw_context_to_color.3
new file mode 100644
index 0000000..af12877
--- /dev/null
+++ b/libselinux/man/man3/selinux_raw_context_to_color.3
@@ -0,0 +1,124 @@
+.TH "selinux_raw_context_to_color" "3" "08 April 2011" "SELinux API documentation"
+
+.SH "NAME"
+selinux_raw_context_to_color \- Return RGB color string for an SELinux security context.
+
+.SH "SYNOPSIS"
+.B #include <selinux/selinux.h>
+.sp
+.BI "int selinux_raw_context_to_color(security_context_t " raw ", "
+.RS
+.BI "char **" color_str ");"
+.RE
+
+.SH "DESCRIPTION"
+.B selinux_raw_context_to_color
+returns a 
+.I color_str
+associated to the raw context 
+.I raw
+provided that the 
+.BR mcstransd "(8)"
+daemon is running, the policy is an MLS type policy (MCS or MLS) and there is a color configuration file
+.BR secolors.conf "(5)"
+(see the
+.B FILES
+section).
+.sp
+The 
+.I color_str
+string is a space separated list of eight hexadecimal RGB triples, each prefixed by a hash character (#). These represent the user:role:type:range components of the foreground and background colors. An example string is shown in the 
+.B EXAMPLE
+section.
+
+The returned
+.I color_str
+string must be freed with 
+.BR free "(3)." 
+
+If a color has not been configured for a specific user, role, type and/or range component of context 
+.IR raw ","
+then
+.B selinux_raw_context_to_color
+will select the color returned in 
+.I color_str
+in order of precedence as follows:
+.RS
+role, type, range
+.br
+user, type, range
+.br
+user, role, range 
+.br
+user, role, type 
+.br
+.RE
+
+If there are no entries in the 
+.B secolor.conf
+file for any of the components of context 
+.I raw
+(or the file is not present), then the default string returned in 
+.I color_str
+is:
+.sp
+.RS
+----- user ---- ---- role ----  ---- type ----  ---- range ----
+.br
+#000000 #ffffff #000000 #ffffff #000000 #ffffff #000000 #ffffff
+.sp
+.RE
+
+.SH "RETURN VALUE"
+On success, zero is returned.
+.br
+On failure, \-1 is returned with 
+.I errno
+set appropriately.
+
+.SH "ERRORS"
+.B ENOENT
+If the 
+.BR mcstransd "(8)"
+daemon is not running. 
+
+.SH "FILES"
+.B selinux_raw_context_to_color
+obtains the translated entry from the active policy 
+.BR secolors.conf "(5)"
+file as returned by
+.BR selinux_colors_path "(3)."
+The file format is described in 
+.BR secolors.conf "(5)."
+
+.SH "NOTES"
+1. The primary use of 
+.B selinux_raw_context_to_color
+is to return a color that corresponds to a range, that can then be used to highlight information at different MLS levels.
+.sp
+2. The 
+.BR mcstransd "(8)"
+daemon process security level must dominate the 
+.I raw
+security level passed to it by the 
+.B selinux_raw_context_to_color
+function. If not, the range color selected will be as defined by the order of precedence.
+
+.SH "EXAMPLE"
+.B selinux_raw_context_to_color
+returns the foreground and background colors of the context string components (user:role:type:range) as RGB triples as follows:
+.sp
+
+      user     :       role      :      type      :      range
+.br
+  fg       bg  :   fg       bg   :  fg       bg   :  fg       bg  
+.br
+#000000 #ffffff  #ffffff #000000  #d2b48c #ffa500  #000000 #008000
+.br
+ black   white :  white   black  : tan    orange  : black   green 
+.br
+
+.SH "SEE ALSO"
+.BR selinux "(8), " selinux_colors_path "(3), " mcstransd "(8), " secolor.conf "(5), " selinux_raw_to_trans_context "(3), " selinux_trans_to_raw_context "(3), " free "(3)"
+
+
diff --git a/libselinux/man/man5/secolors.conf.5 b/libselinux/man/man5/secolors.conf.5
new file mode 100644
index 0000000..91cb4cb
--- /dev/null
+++ b/libselinux/man/man5/secolors.conf.5
@@ -0,0 +1,181 @@
+.TH "secolors.conf" "5" "08 April 2011" "SELinux API documentation"
+
+.SH "NAME"
+secolors.conf \- The SELinux color configuration file.
+
+.SH "DESCRIPTION"
+This optional file controls the color to be associated to the context components associated to the 
+.I raw
+context passed by 
+.BR selinux_raw_context_to_color "(3),"
+when context related information is to be displayed in color by an SELinux-aware application. 
+.sp
+.BR selinux_raw_context_to_color "(3)"
+obtains this color information from the active policy 
+.B secolor.conf
+file as returned by 
+.BR selinux_colors_path "(3)."
+
+.SH "FILE FORMAT"
+The file format is as follows:
+.RS
+.B color
+.I color_name
+.BI "= #"color_mask
+.br
+[...]
+.sp
+.I context_component string
+.B =
+.I fg_color_name bg_color_name
+.br
+[...]
+.sp 
+.RE
+
+Where:
+.br
+.B color
+.RS
+The color keyword. Each color entry is on a new line.
+.RE
+.I color_name
+.RS
+A single word name for the color (e.g. red).
+.RE
+.I color_mask
+.RS
+A color mask starting with a hash (#) that describes the hexadecimal RGB colors with black being #ffffff and white being #000000.
+.RE
+.I context_component
+.RS
+The context component name that must be one of the following:
+.br
+.RS
+user, role, type or range 
+.RE
+Each
+.IR context_component " " string " ..."
+entry is on a new line.
+.RE
+.I string
+.RS
+This is the 
+.I context_component
+string that will be matched with the 
+.I raw
+context component passed by
+.BR selinux_raw_context_to_color "(3)."
+.br
+A wildcard '*' may be used to match any undefined string for the user, role and type 
+.I context_component
+entries only.
+.RE
+
+.I fg_color_name
+.RS
+The color_name string that will be used as the foreground color.
+A 
+.I color_mask
+may also be used.
+.RE
+.I bg_color_name
+.RS
+The color_name string that will be used as the background color.
+A 
+.I color_mask
+may also be used.
+.RE
+
+.SH "EXAMPLES"
+Example 1 entries are:
+.RS
+color black  = #000000
+.br
+color green  = #008000
+.br
+color yellow = #ffff00
+.br
+color blue   = #0000ff
+.br
+color white  = #ffffff
+.br
+color red    = #ff0000
+.br
+color orange = #ffa500
+.br
+color tan    = #D2B48C
+.sp
+user * = black white
+.br
+role * = white black
+.br
+type * = tan orange
+.br
+range s0-s0:c0.c1023 = black green
+.br
+range s1-s1:c0.c1023 = white green
+.br
+range s3-s3:c0.c1023 = black tan
+.br
+range s5-s5:c0.c1023 = white blue
+.br
+range s7-s7:c0.c1023 = black red
+.br
+range s9-s9:c0.c1023 = black orange
+.br
+range s15:c0.c1023   = black yellow
+.RE
+
+.sp
+Example 2 entries are:
+.RS
+color black  = #000000
+.br
+color green  = #008000
+.br
+color yellow = #ffff00
+.br
+color blue   = #0000ff
+.br
+color white  = #ffffff
+.br
+color red    = #ff0000
+.br
+color orange = #ffa500
+.br
+color tan    = #d2b48c
+.sp
+user unconfined_u = #ff0000 green
+.br
+role unconfined_r = red #ffffff
+.br
+type unconfined_t = red orange
+.br
+user user_u       = black green
+.br
+role user_r       = white black
+.br
+type user_t       = tan red
+.br
+user xguest_u     = black yellow
+.br
+role xguest_r     = black red
+.br
+type xguest_t     = black green
+.br
+user sysadm_u     = white black
+.br
+range s0:c0.c1023 = black white
+.br
+user *            = black white
+.br
+role *            = black white
+.br
+type *            = black white
+.RE
+
+.SH "SEE ALSO"
+.BR selinux "(8), " selinux_raw_context_to_color "(3), " selinux_colors_path "(3)"
+
+
-- 
1.7.3.2


Richard


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
