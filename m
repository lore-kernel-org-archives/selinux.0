Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q0O72nDB014848
	for <selinux@tycho.nsa.gov>; Tue, 24 Jan 2012 02:02:49 -0500
Received: from smtp.sws.net.au (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id q0O72f2G026183
	for <selinux@tycho.nsa.gov>; Tue, 24 Jan 2012 07:02:43 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: sgrubb@redhat.com
Subject: auditd patches from Debian
Date: Tue, 24 Jan 2012 18:02:33 +1100
Cc: "SE-Linux" <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_JelHP27TaDeBtYs"
Message-Id: <201201241802.33340.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_JelHP27TaDeBtYs
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit

add_missing_headers.diff makes libaudit.c include a couple of extra system 
headers to avoid a build failure.  I can't imagine this causing a problem on 
the platforms where such an inclusion isn't needed so it should go upstream.

fix-spelling.diff fixes some small spelling errors and should go in.

manpage-dash.diff escapes some hyphens in man pages, another trivial patch.

mode.diff makes the check for mode 750 a warning.  Presumably whoever wanted 
such checks in the first place will not want that patch.  The patch is a 
little ugly too.


That is 4/7 of the Debian patches for auditd which also includes the vast 
majority of lines changed.  The rest are related to Automake and I don't 
understand them well enough to be confident in sending them upstream.

-- 
My Main Blog         http://etbe.coker.com.au/
My Documents Blog    http://doc.coker.com.au/

--Boundary-00=_JelHP27TaDeBtYs
Content-Type: text/x-patch;
  charset="UTF-8";
  name="add_missing_headers.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="add_missing_headers.diff"

Description: Add missing headers to fix undefined reference to `S_ISREG' linker
 error and hence FTBFS
Author: Bhavani Shankar <bhavi@ubuntu.com>
Bug-Ubuntu: https://bugs.launchpad.net/bugs/600129
diff -ru audit-2.1.3/lib/libaudit.c audit-2.1.3.pat/lib/libaudit.c
--- audit-2.1.3/lib/libaudit.c	2011-08-16 03:31:03.000000000 +1000
+++ audit-2.1.3.pat/lib/libaudit.c	2012-01-24 17:50:36.387133058 +1100
@@ -37,6 +37,8 @@
 #include <sys/stat.h>
 #include <fcntl.h>	/* O_NOFOLLOW needs gnu defined */
 #include <limits.h>	/* for PATH_MAX */
+#include <sys/stat.h>
+#include <sys/types.h>
 
 #include "libaudit.h"
 #include "private.h"

--Boundary-00=_JelHP27TaDeBtYs
Content-Type: text/x-patch;
  charset="UTF-8";
  name="fix-spelling.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="fix-spelling.diff"

Fix several spelling mistakes.
diff -ru audit-2.1.3/audisp/plugins/prelude/audisp-prelude.conf.5 audit-2.1.3.pat/audisp/plugins/prelude/audisp-prelude.conf.5
--- audit-2.1.3/audisp/plugins/prelude/audisp-prelude.conf.5	2011-08-16 03:30:59.000000000 +1000
+++ audit-2.1.3.pat/audisp/plugins/prelude/audisp-prelude.conf.5	2012-01-24 17:32:35.181336505 +1100
@@ -111,7 +111,7 @@
 .IR idmef ".
 .TP
 .I watched_accounts
-This option is a whitespace and comma separated list of accounts to watch. The accounts may be numeric or alphanumeric. If you want to include a range of accounts, separate them with a dash but no spaces. For example, to watch logins from bin to lp, use "bin-lp". Only succesful logins logins are recorded.
+This option is a whitespace and comma separated list of accounts to watch. The accounts may be numeric or alphanumeric. If you want to include a range of accounts, separate them with a dash but no spaces. For example, to watch logins from bin to lp, use "bin-lp". Only successful logins logins are recorded.
 .TP
 .I detect_watched_syscall
 This is an enabler that determines if the IDS should be detecting whenever a user runs a command that issues a syscall that is being watched. The default is 
@@ -145,7 +145,9 @@
 This is an action that determines what response should be taken whenever a user creates a file that is executable. The default is 
 .IR idmef ".
 .SH "SEE ALSO"
-.BR audispd (8), audisp-prelude(8), prelude-manager (1)
+.BR audispd (8),
+.BR audisp-prelude (8),
+.BR prelude-manager (1).
 .SH AUTHOR
 Steve Grubb
 
diff -ru audit-2.1.3/bindings/python/auparse_python.c audit-2.1.3.pat/bindings/python/auparse_python.c
--- audit-2.1.3/bindings/python/auparse_python.c	2011-08-16 03:31:01.000000000 +1000
+++ audit-2.1.3.pat/bindings/python/auparse_python.c	2012-01-24 17:32:30.349525110 +1100
@@ -882,7 +882,7 @@
  * ausearch_clear
  ********************************/
 PyDoc_STRVAR(search_clear_doc,
-"search_clear() Clear search paramters.\n\
+"search_clear() Clear search parameters.\n\
 \n\
 ausearch_clear clears any search parameters stored in the parser\n\
 instance and frees memory associated with it.\n\
diff -ru audit-2.1.3/docs/zos-remote.conf.5 audit-2.1.3.pat/docs/zos-remote.conf.5
--- audit-2.1.3/docs/zos-remote.conf.5	2011-08-16 03:31:01.000000000 +1000
+++ audit-2.1.3.pat/docs/zos-remote.conf.5	2012-01-24 17:32:35.181336505 +1100
@@ -51,7 +51,7 @@
 .I timeout
 The number in seconds that
 .B audispd-zos-remote
-plugin will wait before giving up in connection attemps and event submissions. The default value is 15
+plugin will wait before giving up in connection attempts and event submissions. The default value is 15
 .TP
 .I q_depth
 The
diff -ru audit-2.1.3/tools/aulast/aulast.8 audit-2.1.3.pat/tools/aulast/aulast.8
--- audit-2.1.3/tools/aulast/aulast.8	2011-08-16 03:31:03.000000000 +1000
+++ audit-2.1.3.pat/tools/aulast/aulast.8	2012-01-24 17:32:30.349525110 +1100
@@ -26,7 +26,7 @@
 
 .TP
 .B \-\-proof
-Print out the audit event serial numbers used to determine the preceeding line of the report. A Serial number of 0 is a place holder and not an actual event serial number. The serial numbers can be used to examine the actual audit records in more detail. Also an ausearch query is printed that will let you find the audit records associated with that session.
+Print out the audit event serial numbers used to determine the preceding line of the report. A Serial number of 0 is a place holder and not an actual event serial number. The serial numbers can be used to examine the actual audit records in more detail. Also an ausearch query is printed that will let you find the audit records associated with that session.
 
 .TP
 .B \-\-stdin

--Boundary-00=_JelHP27TaDeBtYs
Content-Type: text/x-patch;
  charset="UTF-8";
  name="manpage-dash.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="manpage-dash.diff"

=46ix lintian warning hyphen-used-as-minus-sign
diff -ru audit-2.1.3/audisp/plugins/prelude/audisp-prelude.8 audit-2.1.3.pa=
t/audisp/plugins/prelude/audisp-prelude.8
=2D-- audit-2.1.3/audisp/plugins/prelude/audisp-prelude.8	2011-08-16 03:30:=
59.000000000 +1000
+++ audit-2.1.3.pat/audisp/plugins/prelude/audisp-prelude.8	2012-01-24 17:3=
7:23.030100626 +1100
@@ -18,11 +18,11 @@
=20
 In one window, type:
=20
=2Dprelude-admin register auditd "idmef:w" localhost --uid 0 --gid 0
+.B prelude\-admin register auditd "idmef:w" localhost \-\-uid 0 \-\-gid 0
=20
 In another, type:
=20
=2Dprelude-admin registration-server prelude-manager
+.B prelude\-admin registration\-server prelude\-manager
=20
 Follow the on-screen instructions to complete the registration.
=20
@@ -31,35 +31,42 @@
=20
 At this point, if you want have audit: forbidden login location, max concu=
rrent sessions, max login failures, and forbidden login time anomalies bein=
g reported, you have to setup pam modules correctly. The pam modules are re=
spectively: pam_access, pam_limits, pam_tally2, and pam_time. Please see th=
e respective pam module man pages for any instructions.
=20
=2DFor performance reasons, some audit events will not produce syscall reco=
rds which contain additional information about events unless there is at le=
ast one audit rule loaded. If you do not have any additional audit rules, e=
dit /etc/audit/audit.rules and add something simple that won't impact perfo=
rmace like this: -w /etc/shadow -p wa. This rule will watch the shadow file=
 for writes or changes to its attributes. The additional audit information =
provided by having at least one rule will allow the plugin to give a more c=
omplete view of the alert it is sending.
+For performance reasons, some audit events will not produce syscall record=
s which contain additional information about events unless there is at leas=
t one audit rule loaded. If you do not have any additional audit rules, edi=
t \fI/etc/audit/audit.rules\fP and add something simple that won't impact p=
erformace like this: \fB\-w /etc/shadow \-p wa\fP. This rule will watch the=
 shadow file for writes or changes to its attributes. The additional audit =
information provided by having at least one rule will allow the plugin to g=
ive a more complete view of the alert it is sending.
=20
=2DIf you are wanting to get alerts on watched syscalls, watched files, wat=
ched execution, or something becoming executable, you need to add some keys=
 to your audit rules. For example, if you have the following audit watch in=
 /etc/audit/audit.rules:
+If you are wanting to get alerts on watched syscalls, watched files, watch=
ed execution, or something becoming executable, you need to add some keys t=
o your audit rules. For example, if you have the following audit watch in \=
fI/etc/audit/audit.rules\fP:
=20
=2D-w /etc/shadow -p wa
+.B \-w /etc/shadow \-p wa
=20
=2Dand you want idmef alerts on this, you need to add -k ids-file-med  or s=
omething appropriate to signal to the plugin that this message is for it. T=
he format of the key has a fixed format of keywords separated by a dash. It=
 follows the form of ids-type-severity. The type can be either sys, file, e=
xec, or mkexe depending on whether you want the event to be considered a wa=
tched_syscall, watched_file, watched_exec, or watched_mk_exe respectively. =
The severity can be either info, low, med, or hi depending on how urgent yo=
u would like it to be.
+and you want idmef alerts on this, you need to add \fB\-k ids\-file\-med\f=
P  or something appropriate to signal to the plugin that this message is fo=
r it. The format of the key has a fixed format of keywords separated by a d=
ash. It follows the form of
+.IB ids \- type \- severity .
+The \fItype\fP can be either \fBsys\fP, \fBfile\fP, \fBexec\fP, or \fBmkex=
e\fP depending on whether you want the event to be considered a watched_sys=
call, watched_file, watched_exec, or watched_mk_exe respectively. The \fIse=
verity\fP can be either \fBinfo\fP, \fBlow\fP, \fBmed\fP, or \fBhi\fP depen=
ding on how urgent you would like it to be.
=20
 .SH EXAMPLE RULES
 To alert on any use of the personality syscall:
=2D-a exit,always -S personality -k ids-sys-med
+.br
+.B \-a exit,always \-S personality \-k ids\-sys\-med
=20
 To alert on a user failing to access the shadow file:
=2D-a always,exit -F path=3D/etc/shadow -F perms=3Dwa -F success=3D0 -k ids=
=2Dfile-med
+.br
+.B \-a always,exit \-F path=3D/etc/shadow \-F perms=3Dwa \-F success=3D0 \=
=2Dk ids\-file\-med
=20
 To alert on the execution of a program:
=2D-w /bin/ping -p x -k ids-exe-info
+.br
+.B \-w /bin/ping \-p x \-k ids\-exe\-info
=20
 To alert on users making exe's in their home dir (takes 2 rules):
=2D-a exit,always -S fchmodat -F dir=3D/home -F a2&0111 -F filetype=3Dfile =
=2Dk ids-mkexe-hi
=2D-a exit,always -S fchmod,chmod -F dir=3D/home -F a1&0111 -F filetype=3Df=
ile -k ids-mkexe-hi
+.br
+.B \-a exit,always \-S fchmodat \-F dir=3D/home \-F a2&0111 \-F filetype=
=3Dfile \-k ids\-mkexe\-hi
+.br
+.B \-a exit,always \-S fchmod,chmod \-F dir=3D/home \-F a1&0111 \-F filety=
pe=3Dfile \-k ids\-mkexe\-hi
=20
 .SH FILES
 /etc/audisp/plugins.d/au-prelude.conf, /etc/audit/auditd.conf, /etc/audisp=
/audispd.conf, /etc/audisp/audisp-prelude.conf
 .SH "SEE ALSO"
 .BR audispd (8),
=2D.BR prelude-manager(1),
=2D.BR auditd.conf(8),
=2D.BR audispd.conf(8),
=2D.BR audisp-prelude.conf(5).
+.BR prelude-manager (1),
+.BR auditd.conf (8),
+.BR audispd.conf (8),
+.BR audisp-prelude.conf (5).
 .SH AUTHOR
 Steve Grubb
diff -ru audit-2.1.3/docs/audispd-zos-remote.8 audit-2.1.3.pat/docs/audispd=
=2Dzos-remote.8
=2D-- audit-2.1.3/docs/audispd-zos-remote.8	2011-08-16 03:31:01.000000000 +=
1000
+++ audit-2.1.3.pat/docs/audispd-zos-remote.8	2012-01-24 17:37:23.014101252=
 +1100
@@ -20,13 +20,13 @@
 .\"
 .TH AUDISP-RACF 8 "Oct 2007" "IBM" "System Administration Utilities"
 .SH NAME
=2Daudispd-zos-remote \- z/OS Remote-services Audit dispatcher plugin
+audispd\-zos\-remote \- z/OS Remote-services Audit dispatcher plugin
 .SH SYNOPSIS
=2D.B audispd-zos-remote [
+.B audispd\-zos\-remote [
 .I config-file
 .B ]
 .SH DESCRIPTION
=2D.B audispd-zos-remote
+.B audispd\-zos\-remote
 is a remote-auditing plugin for the Audit subsystem. It should be started =
by the
 .BR audispd (8)
 daemon and will forward all incoming audit events, as they happen, to a co=
nfigured z/OS SMF (Service Management Facility) database, through an IBM Ti=
voli Directory Server (ITDS) set for Remote Audit service.
@@ -36,44 +36,44 @@
=20
 .BR audispd (8)
 must be configured to start the plugin. This is done by a configuration fi=
le usually located at
=2D.IR /etc/audisp/plugins.d/audispd-zos-remote.conf ,
+.IR /etc/audisp/plugins.d/audispd\-zos\-remote.conf ,
 but multiple instances can be spawned by having multiple configuration fil=
es in
 .I /etc/audisp/plugins.d
 for the same plugin executable (see
 .BR audispd (8)).
=20
 Each instance needs a configuration file, located by default at
=2D.IR /etc/audisp/zos-remote.conf .
+.IR /etc/audisp/zos\-remote.conf .
 Check
=2D.BR zos-remote.conf (5)
+.BR zos\-remote.conf (5)
 for details about the plugin configuration.
=20
 .SH OPTIONS
 .IP config-file
 Use an alternate configuration file instead of
=2D.IR /etc/audisp/zos-remote.conf .
+.IR /etc/audisp/zos\-remote.conf .
=20
 .SH SIGNALS
=2D.B audispd-zos-remote
+.B audispd\-zos\-remote
 reacts to SIGTERM and SIGHUP signals (according to the
 .BR audispd (8)
 specification):
 .TP
 .B SIGHUP
 Instructs the
=2D.B audispd-zos-remote
+.B audispd\-zos\-remote
 plugin to re-read it's configuration and flush existing network connection=
s.
 .TP
 .B SIGTERM
 Performs a clean exit.
=2D.B audispd-zos-remote
+.B audispd\-zos\-remote
 will wait up to 10 seconds if there are queued events to be delivered, dro=
pping any remaining queued events after that time.
=20
 .SH IBM z/OS ITDS Server and RACF configuration
 In order to use this plugin, you must have an IBM z/OS v1R8 (or higher) se=
rver with IBM Tivoli Directory Server (ITDS) configured for Remote Audit se=
rvice. For more detailed information about how to configure the z/OS server=
 for Remote Auditing, refer to
 .B z/OS V1R8.0-9.0 Intergrated Security Services Enterprise Identity Mappi=
ng (EIM) Guide and Reference
 .nf
=2D.RI ( http://publibz.boulder.ibm.com/cgi-bin/bookmgr_OS390/FRAMESET/EIMA=
1140/CCONTENTS?DT=3D20070827115119 ),
+.RI ( http://publibz.boulder.ibm.com/cgi\-bin/bookmgr_OS390/FRAMESET/EIMA1=
140/CCONTENTS?DT=3D20070827115119 ),
 chapter "2.0 - Working with remote services".
 .fi
=20
@@ -90,7 +90,7 @@
=20
 .SS Create/enable RACF user ID to perform Remote Audit requests
 A z/OS RACF user ID is needed by the plugin - Every Audit request performe=
d by the plugin will use a RACF user ID, as configured in the plugin config=
uration
=2D.BR zos-remote.conf (5).
+.BR zos\-remote.conf (5).
 This user ID needs READ access to FACILITY Class resource IRR.LDAP.REMOTE.=
AUDIT. If the user ID is
 .IR BINDUSER ,
 the administrator can configure RACF to enable this user to perform Remote=
 Auditing requests with the following TSO commands:
@@ -103,7 +103,7 @@
=20
 .SS Add @LINUX Class to RACF
 When performing remote auditing requests, the
=2D.B audispd-zos-remote
+.B audispd\-zos\-remote
 plugin will use the special
 .B @LINUX=20
 .I CDT Class=20
@@ -232,10 +232,10 @@
 The plugin currently does remote auditing in a best-effort basis, and will=
 dischard events in case the z/OS server cannot be contacted (network failu=
res) or in any other case that event submission fails.=20
=20
 .SH FILES
=2D/etc/audisp/plugins.d/audispd-zos-remote.conf
=2D/etc/audisp/zos-remote.conf
+/etc/audisp/plugins.d/audispd\-zos\-remote.conf
+/etc/audisp/zos\-remote.conf
 .SH "SEE ALSO"
 .BR auditd (8),
=2D.BR zos-remote.conf (5).
+.BR zos\-remote.conf (5).
 .SH AUTHOR
 Klaus Heinrich Kiwi <klausk@br.ibm.com>
diff -ru audit-2.1.3/docs/audit_add_watch.3 audit-2.1.3.pat/docs/audit_add_=
watch.3
=2D-- audit-2.1.3/docs/audit_add_watch.3	2011-08-16 03:31:01.000000000 +1000
+++ audit-2.1.3.pat/docs/audit_add_watch.3	2012-01-24 17:37:23.030100626 +1=
100
@@ -12,7 +12,7 @@
=20
 .SH "RETURN VALUE"
=20
=2DReturns -1 if an error occurs; otherwise, 0 for success.
+Returns \-1 if an error occurs; otherwise, 0 for success.
=20
 .SH "SEE ALSO"
=20
diff -ru audit-2.1.3/docs/auditctl.8 audit-2.1.3.pat/docs/auditctl.8
=2D-- audit-2.1.3/docs/auditctl.8	2011-08-16 03:31:01.000000000 +1000
+++ audit-2.1.3.pat/docs/auditctl.8	2012-01-24 17:39:45.300547271 +1100
@@ -24,10 +24,10 @@
 Ignore errors when reading rules from a file
 .TP
 .B \-l
=2DList all rules 1 per line. This can take a key option (-k), too.
+List all rules 1 per line. This can take a key option (\-k), too.
 .TP
 .BI \-k\  key
=2DSet a filter key on an audit rule. The filter key is an arbitrary string=
 of text that can be up to 31 bytes long. It can uniquely identify the audi=
t records produced by a rule. Typical use is for when you have several rule=
s that together satisfy a security requirement. The key value can be search=
ed on with ausearch so that no matter which rule triggered the event, you c=
an find its results. The key can also be used on delete all (-D) and list r=
ules (-l) to select rules with a specific key. You may have more than one k=
ey on a rule if you want to be able to search logged events in multiple way=
s or if you have an audispd plugin that uses a key to aid its analysis.
+Set a filter key on an audit rule. The filter key is an arbitrary string o=
f text that can be up to 31 bytes long. It can uniquely identify the audit =
records produced by a rule. Typical use is for when you have several rules =
that together satisfy a security requirement. The key value can be searched=
 on with ausearch so that no matter which rule triggered the event, you can=
 find its results. The key can also be used on delete all (\-D) and list ru=
les (\-l) to select rules with a specific key. You may have more than one k=
ey on a rule if you want to be able to search logged events in multiple way=
s or if you have an audispd plugin that uses a key to aid its analysis.
 .TP
 .BI \-m\  text
 Send a user space message into the audit system. This can only be done if =
you have CAP_AUDIT_WRITE capability (normally the root user has this). The =
resulting event will be the USER type.
@@ -87,7 +87,7 @@
 Delete all rules and watches. This can take a key option (-k), too.
 .TP
 \fB\-S\fP [\fISyscall name or number\fP|\fBall\fP]
=2DAny \fIsyscall name\fP or \fInumber\fP may be used. The word '\fBall\fP'=
 may also be used.  If the given syscall is made by a program, then start a=
n audit record. If a field rule is given and no syscall is specified, it wi=
ll default to all syscalls. You may also specify multiple syscalls in the s=
ame rule by using multiple -S options in the same rule. Doing so improves p=
erformance since fewer rules need to be evaluated. If you are on a bi-arch =
system, like x86_64, you should be aware that auditctl simply takes the tex=
t, looks it up for the native arch (in this case b64) and sends that rule t=
o the kernel. If there are no additional arch directives, IT WILL APPLY TO =
BOTH 32 & 64 BIT SYSCALLS. This can have undesirable effects since there is=
 no guarantee that, for example, the open syscall has the same number on bo=
th 32 and 64 bit interfaces. You will likely want to control this and write=
 2 rules, one with arch equal to b32 and one with b64 to make sure the kern=
el finds the events that you intend. See the arch field discussion for more=
 info.
+Any \fIsyscall name\fP or \fInumber\fP may be used. The word '\fBall\fP' m=
ay also be used.  If the given syscall is made by a program, then start an =
audit record. If a field rule is given and no syscall is specified, it will=
 default to all syscalls. You may also specify multiple syscalls in the sam=
e rule by using multiple \-S options in the same rule. Doing so improves pe=
rformance since fewer rules need to be evaluated. If you are on a bi-arch s=
ystem, like x86_64, you should be aware that auditctl simply takes the text=
, looks it up for the native arch (in this case b64) and sends that rule to=
 the kernel. If there are no additional arch directives, IT WILL APPLY TO B=
OTH 32 & 64 BIT SYSCALLS. This can have undesirable effects since there is =
no guarantee that, for example, the open syscall has the same number on bot=
h 32 and 64 bit interfaces. You will likely want to control this and write =
2 rules, one with arch equal to b32 and one with b64 to make sure the kerne=
l finds the events that you intend. See the arch field discussion for more =
info.
 .TP
 \fB\-F\fP [\fIn\fP\fB=3D\fP\fIv\fP | \fIn\fP\fB!=3D\fP\fIv\fP | \fIn\fP\fB=
<\fP\fIv\fP | \fIn\fP\fB>\fP\fIv\fP | \fIn\fP\fB<=3D\fP\fIv\fP | \fIn\fP\fB=
>=3D\fP\fIv\fP | \fIn\fP\fB&\fP\fIv\fP | \fIn\fP\fB&=3D\fP\fIv\fP]
 Build a rule field: name, operation, value. You may have up to 64 fields p=
assed on a single command line. Each one must start with \fB\-F\fP. Each fi=
eld equation is anded with each other to trigger an audit record. There are=
 8 operators supported - equal, not equal, less than, greater than, less th=
an or equal, and greater than or equal, bit mask, and bit test respectively=
=2E Bit test will "and" the values and check that they are equal, bit mask =
just "ands" the values. Fields that take a user ID may instead have the use=
r's name; the program will convert the name to user ID. The same is true of=
 group names. Valid fields are:
@@ -97,11 +97,11 @@
 Respectively, the first 4 arguments to a syscall. Note that string argumen=
ts are not supported. This is because the kernel is passed a pointer to the=
 string. Triggering on a pointer address value is not likely to work. So, w=
hen using this, you should only use on numeric values. This is most likely =
to be used on platforms that multiplex socket or IPC operations.
 .TP
 .B arch
=2DThe CPU architecture of the syscall. The arch can be found doing 'uname =
=2Dm'. If you do not know the arch of your machine but you want to use the =
32 bit syscall table and your machine supports 32 bit, you can also use
+The CPU architecture of the syscall. The arch can be found doing 'uname \-=
m'. If you do not know the arch of your machine but you want to use the 32 =
bit syscall table and your machine supports 32 bit, you can also use
 .B b32
 for the arch. The same applies to the 64 bit syscall table, you can use
 .B b64.
=2DIn this way, you can write rules that are somewhat arch independent beca=
use the family type will be auto detected. However, syscalls can be arch sp=
ecific and what is available on x86_64, may not be available on ppc. The ar=
ch directive should precede the -S option so that auditctl knows which inte=
rnal table to use to look up the syscall numbers.
+In this way, you can write rules that are somewhat arch independent becaus=
e the family type will be auto detected. However, syscalls can be arch spec=
ific and what is available on x86_64, may not be available on ppc. The arch=
 directive should precede the \-S option so that auditctl knows which inter=
nal table to use to look up the syscall numbers.
 .TP
 .B auid
 The original ID the user logged in with. Its an abbreviation of audit uid.=
 Sometimes its referred to as loginuid. Either the user account text or num=
ber may be used.
diff -ru audit-2.1.3/docs/auditd.8 audit-2.1.3.pat/docs/auditd.8
=2D-- audit-2.1.3/docs/auditd.8	2011-08-16 03:31:01.000000000 +1000
+++ audit-2.1.3.pat/docs/auditd.8	2012-01-24 17:37:23.022100938 +1100
@@ -26,7 +26,7 @@
 no fork. This is useful for running off of inittab
 .TP
 .B \-s=3D\fIENABLE_STATE\fR
=2Dspecify when starting if auditd should change the current value for the =
kernel enabled flag. Valid values for ENABLE_STATE are "disable", "enable" =
or "nochange". The default is to enable (and disable when auditd terminates=
). The value of the enabled flag may be changed during the lifetime of audi=
td using 'auditctl -e'.
+specify when starting if auditd should change the current value for the ke=
rnel enabled flag. Valid values for ENABLE_STATE are "disable", "enable" or=
 "nochange". The default is to enable (and disable when auditd terminates).=
 The value of the enabled flag may be changed during the lifetime of auditd=
 using 'auditctl \-e'.
 .SH SIGNALS
 .TP
 SIGHUP
@@ -54,7 +54,7 @@
 .SH NOTES
 A boot param of audit=3D1 should be added to ensure that all processes tha=
t run before the audit daemon starts is marked as auditable by the kernel. =
Not doing that will make a few processes impossible to properly audit.
=20
=2DThe audit daemon can receive audit events from other audit daemons via t=
he audisp-remote audispd plugin. The audit daemon may be linked with tcp_wr=
appers to control which machines can connect. If this is the case, you can =
add an entry to hosts.allow and deny.
+The audit daemon can receive audit events from other audit daemons via the=
 audisp\-remote audispd plugin. The audit daemon may be linked with tcp_wra=
ppers to control which machines can connect. If this is the case, you can a=
dd an entry to hosts.allow and deny.
=20
 .SH "SEE ALSO"
 .BR auditd.conf (5),
diff -ru audit-2.1.3/docs/auditd.conf.5 audit-2.1.3.pat/docs/auditd.conf.5
=2D-- audit-2.1.3/docs/auditd.conf.5	2011-08-16 03:31:01.000000000 +1000
+++ audit-2.1.3.pat/docs/auditd.conf.5	2012-01-24 17:37:23.022100938 +1100
@@ -247,7 +247,7 @@
 allowed for incoming connections.  If not specified, any port is
 allowed.  Allowed values are 1..65535.  For example, to require the
 client use a priviledged port, specify
=2D.I 1-1023
+.I 1\-1023
 for this parameter. You will also need to set the local_port option in the=
 audisp-remote.conf file. Making sure that clients send from a privileged p=
ort is a security feature to prevent log injection attacks by untrusted use=
rs.
 .TP
 .I tcp_client_max_idle
@@ -279,7 +279,7 @@
 .PP
 Max_log_file and num_logs need to be adjusted so that you get complete use=
 of your partition. It should be noted that the more files that have to be =
rotated, the longer it takes to get back to receiving audit events. Max_log=
_file_action should be set to keep_logs.
 .PP
=2DSpace_left should be set to a number that gives the admin enough time to=
 react to any alert message and perform some maintenance to free up disk sp=
ace. This would typically involve running the \fBaureport \-t\fP report and=
 moving the oldest logs to an archive area. The value of space_left is site=
 dependant since the rate at which events are generated varies with each de=
ployment. The space_left_action is recommended to be set to email. If you n=
eed something like an snmp trap, you can use the exec option to send one.
+Space_left should be set to a number that gives the admin enough time to r=
eact to any alert message and perform some maintenance to free up disk spac=
e. This would typically involve running the \fBaureport \-t\fP report and m=
oving the oldest logs to an archive area. The value of space_left is site d=
ependent since the rate at which events are generated varies with each depl=
oyment. The space_left_action is recommended to be set to email. If you nee=
d something like an snmp trap, you can use the exec option to send one.
 .PP
 Admin_space_left should be set to the amount of disk space on the audit pa=
rtition needed for admin actions to be recorded. Admin_space_left_action wo=
uld be set to single so that use of the machine is restricted to just the c=
onsole.
 .PP
@@ -299,7 +299,7 @@
=20
 .SH "SEE ALSO"
 .BR auditd (8),
=2D.BR audisp-remote.conf (5).
+.BR audisp\-remote.conf (5).
=20
 .SH AUTHOR
 Steve Grubb
diff -ru audit-2.1.3/docs/audit_detect_machine.3 audit-2.1.3.pat/docs/audit=
_detect_machine.3
=2D-- audit-2.1.3/docs/audit_detect_machine.3	2011-08-16 03:31:01.000000000=
 +1000
+++ audit-2.1.3.pat/docs/audit_detect_machine.3	2012-01-24 17:37:23.0181010=
95 +1100
@@ -12,7 +12,7 @@
=20
 .SH "RETURN VALUE"
=20
=2DReturns -1 if an error occurs; otherwise, the return value is the machin=
e's type.
+Returns \-1 if an error occurs; otherwise, the return value is the machine=
's type.
=20
 .SH "SEE ALSO"
=20
diff -ru audit-2.1.3/docs/audit_getloginuid.3 audit-2.1.3.pat/docs/audit_ge=
tloginuid.3
=2D-- audit-2.1.3/docs/audit_getloginuid.3	2011-08-16 03:31:01.000000000 +1=
000
+++ audit-2.1.3.pat/docs/audit_getloginuid.3	2012-01-24 17:37:23.018101095 =
+1100
@@ -11,11 +11,11 @@
=20
 .SH "RETURN VALUE"
=20
=2DThis function returns the loginuid value if it was set. It will return a=
 -1 if loginuid was unset. However, since uid_t is an unsigned type, you wi=
ll see the converted value instead of -1.
+This function returns the loginuid value if it was set. It will return a \=
=2D1 if loginuid was unset. However, since uid_t is an unsigned type, you w=
ill see the converted value instead of \-1.
=20
 .SH "ERRORS"
=20
=2DThis function returns -1 on failure. However, in the event of a real err=
or, errno would be set. The function can set errno based on failures of ope=
n, read, or strtoul.
+This function returns \-1 on failure. However, in the event of a real erro=
r, errno would be set. The function can set errno based on failures of open=
, read, or strtoul.
=20
 .SH "SEE ALSO"
=20
diff -ru audit-2.1.3/docs/audit_get_reply.3 audit-2.1.3.pat/docs/audit_get_=
reply.3
=2D-- audit-2.1.3/docs/audit_get_reply.3	2011-08-16 03:31:01.000000000 +1000
+++ audit-2.1.3.pat/docs/audit_get_reply.3	2012-01-24 17:37:23.018101095 +1=
100
@@ -11,7 +11,7 @@
=20
 .SH "RETURN VALUE"
=20
=2DThis function returns -1 on error, 0 if error response received, and pos=
itive value on success.
+This function returns \-1 on error, 0 if error response received, and posi=
tive value on success.
=20
 .SH "SEE ALSO"
=20
diff -ru audit-2.1.3/docs/audit_log_acct_message.3 audit-2.1.3.pat/docs/aud=
it_log_acct_message.3
=2D-- audit-2.1.3/docs/audit_log_acct_message.3	2011-08-16 03:31:01.0000000=
00 +1000
+++ audit-2.1.3.pat/docs/audit_log_acct_message.3	2012-01-24 17:37:23.01810=
1095 +1100
@@ -31,7 +31,7 @@
=20
 .SH "ERRORS"
=20
=2DThis function returns -1 on failure. Examine errno for more info.
+This function returns \-1 on failure. Examine errno for more info.
=20
 .SH "SEE ALSO"
=20
diff -ru audit-2.1.3/docs/audit_log_user_avc_message.3 audit-2.1.3.pat/docs=
/audit_log_user_avc_message.3
=2D-- audit-2.1.3/docs/audit_log_user_avc_message.3	2011-08-16 03:31:01.000=
000000 +1000
+++ audit-2.1.3.pat/docs/audit_log_user_avc_message.3	2012-01-24 17:37:23.0=
18101095 +1100
@@ -27,7 +27,7 @@
=20
 .SH "ERRORS"
=20
=2DThis function returns -1 on failure. Examine errno for more info.
+This function returns \-1 on failure. Examine errno for more info.
=20
 .SH "SEE ALSO"
=20
diff -ru audit-2.1.3/docs/audit_log_user_command.3 audit-2.1.3.pat/docs/aud=
it_log_user_command.3
=2D-- audit-2.1.3/docs/audit_log_user_command.3	2011-08-16 03:31:01.0000000=
00 +1000
+++ audit-2.1.3.pat/docs/audit_log_user_command.3	2012-01-24 17:37:23.01810=
1095 +1100
@@ -23,7 +23,7 @@
=20
 .SH "ERRORS"
=20
=2DThis function returns -1 on failure. Examine errno for more info.
+This function returns \-1 on failure. Examine errno for more info.
=20
 .SH "SEE ALSO"
=20
diff -ru audit-2.1.3/docs/audit_log_user_comm_message.3 audit-2.1.3.pat/doc=
s/audit_log_user_comm_message.3
=2D-- audit-2.1.3/docs/audit_log_user_comm_message.3	2011-08-16 03:31:01.00=
0000000 +1000
+++ audit-2.1.3.pat/docs/audit_log_user_comm_message.3	2012-01-24 17:37:23.=
018101095 +1100
@@ -32,7 +32,7 @@
=20
 .SH "ERRORS"
=20
=2DThis function returns -1 on failure. Examine errno for more info.
+This function returns \-1 on failure. Examine errno for more info.
=20
 .SH "SEE ALSO"
=20
diff -ru audit-2.1.3/docs/audit_log_user_message.3 audit-2.1.3.pat/docs/aud=
it_log_user_message.3
=2D-- audit-2.1.3/docs/audit_log_user_message.3	2011-08-16 03:31:01.0000000=
00 +1000
+++ audit-2.1.3.pat/docs/audit_log_user_message.3	2012-01-24 17:37:23.01810=
1095 +1100
@@ -29,7 +29,7 @@
=20
 .SH "ERRORS"
=20
=2DThis function returns -1 on failure. Examine errno for more info.
+This function returns \-1 on failure. Examine errno for more info.
=20
 .SH "SEE ALSO"
=20
diff -ru audit-2.1.3/docs/audit_log_user_semanage_message.3 audit-2.1.3.pat=
/docs/audit_log_user_semanage_message.3
=2D-- audit-2.1.3/docs/audit_log_user_semanage_message.3	2011-08-16 03:31:0=
1.000000000 +1000
+++ audit-2.1.3.pat/docs/audit_log_user_semanage_message.3	2012-01-24 17:37=
:23.022100938 +1100
@@ -41,7 +41,7 @@
=20
 .SH "ERRORS"
=20
=2DThis function returns -1 on failure. Examine errno for more info.
+This function returns \-1 on failure. Examine errno for more info.
=20
 .SH "SEE ALSO"
 .BR audit_log_user_message (3),
diff -ru audit-2.1.3/docs/audit_open.3 audit-2.1.3.pat/docs/audit_open.3
=2D-- audit-2.1.3/docs/audit_open.3	2011-08-16 03:31:01.000000000 +1000
+++ audit-2.1.3.pat/docs/audit_open.3	2012-01-24 17:37:23.022100938 +1100
@@ -12,7 +12,7 @@
=20
 .SH "RETURN VALUE"
=20
=2DReturns -1 if an error occurs; otherwise, the return value is a descript=
or referencing the socket.
+Returns \-1 if an error occurs; otherwise, the return value is a descripto=
r referencing the socket.
=20
 .SH "SEE ALSO"
=20
diff -ru audit-2.1.3/docs/audit.rules.7 audit-2.1.3.pat/docs/audit.rules.7
=2D-- audit-2.1.3/docs/audit.rules.7	2011-08-16 03:31:01.000000000 +1000
+++ audit-2.1.3.pat/docs/audit.rules.7	2012-01-24 17:42:18.070584086 +1100
@@ -12,7 +12,7 @@
 File System rules are sometimes called watches. These rules are used to au=
dit access to particular files or directories that you may be interested in=
=2E If the path given in the rule is a directory, then the rule used is rec=
ursive to the bottom of the directory tree excluding any directories that m=
ay be mount points. The syntax of these rules generally follow this format:
=20
 .nf
=2D.B -w path-to-file -p permissions -k keyname
+.B \-w path-to-file \-p permissions \-k keyname
=20
 .if
=20
@@ -44,11 +44,11 @@
 Syscall rules take the general form of:
=20
 .nf
=2D.B -a action,list -S syscall -F field=3Dvalue -k keyname
+.B \-a action,list \-S syscall \-F field=3Dvalue \-k keyname
 .fi
=20
 The
=2D.B -a
+.B \-a
 option tells the kernel's rule matching engine that we want to append a ru=
le and the end of the rule list. But we need to specify which rule list it =
goes on and what action to take when it triggers. Valid actions are:
=20
 .RS
@@ -64,21 +64,21 @@
 .IR task ", " entry ", " exit ", " user ", and " exclude ". There meaning =
was explained earlier.
=20
 Next in the rule would normally be the
=2D.B -S
+.B \-S
 option. This field can either be the syscall name or number. For readabili=
ty, the name is almost always used. You may give more that one syscall in a=
 rule by specifying another
=2D.B -S
=2Doption. When sent into the kernel, all syscall fields are put into a mas=
k so that one compare can determine if the syscall is of interest. So, addi=
ng multiple syscalls in one rule is very efficient. When you specify a sysc=
all name, auditctl will look up the name and get its syscall number. This l=
eads to some problems on bi-arch machines. The 32 and 64 bit syscall number=
s sometimes, but not always, line up. So, to solve this problem, you would =
generally need to break the rule into 2 with one specifying -F arch=3Db32 a=
nd the other specifying -F arch=3Db64. This needs to go in front of the
=2D.B -S
+.B \-S
+option. When sent into the kernel, all syscall fields are put into a mask =
so that one compare can determine if the syscall is of interest. So, adding=
 multiple syscalls in one rule is very efficient. When you specify a syscal=
l name, auditctl will look up the name and get its syscall number. This lea=
ds to some problems on bi-arch machines. The 32 and 64 bit syscall numbers =
sometimes, but not always, line up. So, to solve this problem, you would ge=
nerally need to break the rule into 2 with one specifying \-F arch=3Db32 an=
d the other specifying \-F arch=3Db64. This needs to go in front of the
+.B \-S
 option so that auditctl looks at the right lookup table when returning the=
 number.
=20
 After the syscall is specified, you would normally have one or more
=2D.B -F
+.B \-F
 options that fine tune what to match against. Rather than list all the val=
id field types here, the reader should look at the auditctl man page which =
has a full listing of each field and what it means. But its worth mentionin=
g a couple things.
=20
=2DThe audit system considers uids to be unsigned numbers. The audit system=
 uses the number -1 to indicate that a loginuid is not set. This means that=
 when its printed out, it looks like 4294967295. If you write a rule that y=
ou wanted try to get the valid users over 500, then you would also need to =
take into account that the representation of -1 is higher than 500. So you =
would address this with the following piece of a rule:
+The audit system considers uids to be unsigned numbers. The audit system u=
ses the number \-1 to indicate that a loginuid is not set. This means that =
when its printed out, it looks like 4294967295. If you write a rule that yo=
u wanted try to get the valid users over 500, then you would also need to t=
ake into account that the representation of \-1 is higher than 500. So you =
would address this with the following piece of a rule:
=20
 .nf
=2D-F auid>=3D500 -F auid!=3D4294967295
+\-F auid>=3D500 \-F auid!=3D4294967295
 .fi
=20
 These rules are "anded" and both have to be true.
@@ -91,43 +91,43 @@
 When doing an investigation, you would normally start off with the main au=
report output to just get an idea about what is happening on the system. Th=
is report mostly tells you about events that are hard coded by the audit sy=
stem such as login/out, uses of authentication, system anomalies, how many =
users have been on the machine, and if SE Linux has detected any AVCs.
=20
 .nf
=2Daureport --start this-week
+aureport \-\-start this-week
 .fi
=20
 After looking at the report, you probably want to get a second view about =
what rules you loaded that have been triggering. This is where keys become =
important. You would generally run the key summary report like this:
=20
 .nf
=2Daureport --start this-week --keys --summary
+aureport \-\-start this-week \-\-keys \-\-summary
 .fi
=20
 This will give an ordered listing of the keys associated with rules that h=
ave been triggering. If, for example, you had a syscall audit rule that tri=
ggered on the failure to open files with EPERM that had a key field of acce=
ss like this:
=20
 .nf
=2D-a always,exit -F arch=3Db64 -S open -F exit=3D-EPERM -k access
+\-a always,exit \-F arch=3Db64 \-S open \-F exit=3D\-EPERM \-k access
 .fi
=20
 Then you can isolate these failures with ausearch and pipe the results to =
aureport for display. Suppose your investigation noticed a lot of the acces=
s denied events. If you wanted to see the files that unauthorized access ha=
s been attempted, you could run the following command:
=20
 .nf
=2Dausearch --start this-week -k access --raw | aureport --file --summary
+ausearch \-\-start this-week \-k access \-\-raw | aureport \-\-file \-\-su=
mmary
 .fi
=20
 This will give an ordered list showing which files are being accessed with=
 the EPERM failure. Suppose you wanted to see which users might be having f=
ailed access, you would run the following command:
=20
 .nf
=2Dausearch --start this-week -k access --raw | aureport --user --summary
+ausearch \-\-start this-week \-k access \-\-raw | aureport \-\-user \-\-su=
mmary
 .fi
=20
 If your investigation showed a lot of failed accesses to a particular file=
, you could run the following report to see who is doing it:
=20
 .fi
=2Dausearch --start this-week -k access -f /path-to/file --raw | aureport -=
=2Duser -i
+ausearch \-\-start this-week \-k access \-f /path-to/file \-\-raw | aurepo=
rt \-\-user \-i
 .fi
=20
 This report will give you the individual access attempts by person. If you=
 needed to see the actual audit event that is being reported, you would loo=
k at the date, time, and event columns. Assuming the event was 822 and it o=
ccurred at 2:30 on 09/01/2009 and you use the en_US.utf8 locale, the comman=
d would look something like this:
=20
 .nf
=2Dausearch --start 09/01/2009 02:30 -a 822 -i --just-one
+ausearch \-\-start 09/01/2009 02:30 \-a 822 \-i \-\-just\-one
 .fi
=20
 This will select the first event from that day and time with the matching =
event id and interpret the numeric values into human readable values.
@@ -140,14 +140,14 @@
 If you get a warning from auditctl saying, "32/64 bit syscall mismatch in =
line XX, you should specify an arch". This means that you specified a sysca=
ll rule on a bi-arch system where the syscall has a different syscall numbe=
r for the 32 and 64 bit interfaces. This means that on one of those interfa=
ces you are likely auditing the wrong syscall. To solve the problem, re-wri=
te the rule as two rules specifying the intended arch for each rule. For ex=
ample,
=20
 .nf
=2D-always,exit -S open -k access
+\-always,exit \-S open \-k access
 .fi
=20
 would be rewritten as
=20
 .nf
=2D-always,exit -F arch=3Db32 -S open -k access
=2D-always,exit -F arch=3Db64 -S open -k access
+\-always,exit \-F arch=3Db32 \-S open \-k access
+\-always,exit \-F arch=3Db64 \-S open \-k access
 .fi
=20
 If you get a warning that says, "entry rules deprecated, changing to exit =
rule". This means that you have a rule intended for the entry filter, but t=
hat filter is not going to be available at some point in the future. Auditc=
tl moved your rule to the exit filter so that its not lost. But to solve th=
is so that you do not get the warning any more, you need to change the offe=
nding rule from entry to exit.
@@ -156,10 +156,10 @@
 The following rule shows how to audit failed access to files due permissio=
n problems. Note that it takes two rules for each arch ABI to audit this si=
nce file access can fail with two different failure codes indicating permis=
sion problems.
=20
 .nf
=2D.B -a always,exit -F arch=3Db32 -S open -S openat -F exit=3D-EACCES -k a=
ccess
=2D.B -a always,exit -F arch=3Db32 -S open -S openat -F exit=3D-EPERM -k ac=
cess
=2D.B -a always,exit -F arch=3Db64 -S open -S openat -F exit=3D-EACCES -k a=
ccess
=2D.B -a always,exit -F arch=3Db64 -S open -S openat -F exit=3D-EPERM -k ac=
cess
+.B \-a always,exit \-F arch=3Db32 \-S open \-S openat \-F exit=3D\-EACCES =
\-k access
+.B \-a always,exit \-F arch=3Db32 \-S open \-S openat \-F exit=3D\-EPERM \=
=2Dk access
+.B \-a always,exit \-F arch=3Db64 \-S open \-S openat \-F exit=3D\-EACCES =
\-k access
+.B \-a always,exit \-F arch=3Db64 \-S open \-S openat \-F exit=3D\-EPERM \=
=2Dk access
 .fi
=20
 .SH "SEE ALSO"
diff -ru audit-2.1.3/docs/auparse_feed.3 audit-2.1.3.pat/docs/auparse_feed.3
=2D-- audit-2.1.3/docs/auparse_feed.3	2011-08-16 03:31:01.000000000 +1000
+++ audit-2.1.3.pat/docs/auparse_feed.3	2012-01-24 17:37:23.022100938 +1100
@@ -57,7 +57,7 @@
             const au_event_t *e =3D auparse_get_timestamp(au);
             if (e =3D=3D NULL) return;
             printf("event time: %u.%u:%lu\\n",
=2D                    (unsigned)e->sec, e->milli, e->serial);
+                    (unsigned)e\->sec, e\->milli, e\->serial);
             auparse_first_field(au);
             do {
                 printf("%s=3D%s (%s)\\n", auparse_get_field_name(au),
@@ -98,7 +98,7 @@
=20
 .SH "RETURN VALUE"
=20
=2DReturns -1 if an error occurs; otherwise, 0 for success.
+Returns \-1 if an error occurs; otherwise, 0 for success.
=20
 .SH "SEE ALSO"
=20
diff -ru audit-2.1.3/docs/auparse_first_record.3 audit-2.1.3.pat/docs/aupar=
se_first_record.3
=2D-- audit-2.1.3/docs/auparse_first_record.3	2011-08-16 03:31:01.000000000=
 +1000
+++ audit-2.1.3.pat/docs/auparse_first_record.3	2012-01-24 17:37:23.0221009=
38 +1100
@@ -11,7 +11,7 @@
=20
 .SH "RETURN VALUE"
=20
=2DReturns -1 if an error occurs, 0 if there is no event data, or 1 for suc=
cess.
+Returns \-1 if an error occurs, 0 if there is no event data, or 1 for succ=
ess.
=20
 .SH "SEE ALSO"
=20
diff -ru audit-2.1.3/docs/auparse_flush_feed.3 audit-2.1.3.pat/docs/auparse=
_flush_feed.3
=2D-- audit-2.1.3/docs/auparse_flush_feed.3	2011-08-16 03:31:01.000000000 +=
1000
+++ audit-2.1.3.pat/docs/auparse_flush_feed.3	2012-01-24 17:37:23.022100938=
 +1100
@@ -18,7 +18,7 @@
=20
 .SH "RETURN VALUE"
=20
=2DReturns -1 if an error occurs; otherwise, 0 for success.
+Returns \-1 if an error occurs; otherwise, 0 for success.
=20
 .SH "SEE ALSO"
=20
diff -ru audit-2.1.3/docs/auparse_get_field_int.3 audit-2.1.3.pat/docs/aupa=
rse_get_field_int.3
=2D-- audit-2.1.3/docs/auparse_get_field_int.3	2011-08-16 03:31:01.00000000=
0 +1000
+++ audit-2.1.3.pat/docs/auparse_get_field_int.3	2012-01-24 17:37:23.026100=
782 +1100
@@ -12,7 +12,7 @@
=20
 .SH "RETURN VALUE"
=20
=2DReturns -1 if there is an error with errno set appropriately or the valu=
e if errno is zero.
+Returns \-1 if there is an error with errno set appropriately or the value=
 if errno is zero.
=20
 .SH "SEE ALSO"
=20
diff -ru audit-2.1.3/docs/auparse_next_event.3 audit-2.1.3.pat/docs/auparse=
_next_event.3
=2D-- audit-2.1.3/docs/auparse_next_event.3	2011-08-16 03:31:01.000000000 +=
1000
+++ audit-2.1.3.pat/docs/auparse_next_event.3	2012-01-24 17:37:23.026100782=
 +1100
@@ -12,7 +12,7 @@
=20
 .SH "RETURN VALUE"
=20
=2DReturns -1 if an error occurs, 0 if there's no data, 1 for success.
+Returns \-1 if an error occurs, 0 if there's no data, 1 for success.
=20
 .SH "SEE ALSO"
=20
diff -ru audit-2.1.3/docs/auparse_next_record.3 audit-2.1.3.pat/docs/aupars=
e_next_record.3
=2D-- audit-2.1.3/docs/auparse_next_record.3	2011-08-16 03:31:01.000000000 =
+1000
+++ audit-2.1.3.pat/docs/auparse_next_record.3	2012-01-24 17:37:23.02610078=
2 +1100
@@ -11,7 +11,7 @@
=20
 .SH "RETURN VALUE"
=20
=2DReturns -1 if an error occurs, 0 if no more records in current event, or=
 1 for success.
+Returns \-1 if an error occurs, 0 if no more records in current event, or =
1 for success.
=20
 .SH "SEE ALSO"
=20
diff -ru audit-2.1.3/docs/auparse_node_compare.3 audit-2.1.3.pat/docs/aupar=
se_node_compare.3
=2D-- audit-2.1.3/docs/auparse_node_compare.3	2011-08-16 03:31:01.000000000=
 +1000
+++ audit-2.1.3.pat/docs/auparse_node_compare.3	2012-01-24 17:37:23.0261007=
82 +1100
@@ -12,7 +12,7 @@
=20
 .SH "RETURN VALUE"
=20
=2DReturns -1, 0, or 1 respectively depending on whether e2 is less than, e=
qual to, or greater than e1. Since this is a string compare, it probably on=
ly matter that they are equal or not equal.
+Returns \-1, 0, or 1 respectively depending on whether e2 is less than, eq=
ual to, or greater than e1. Since this is a string compare, it probably onl=
y matter that they are equal or not equal.
=20
 .SH "SEE ALSO"
=20
diff -ru audit-2.1.3/docs/auparse_reset.3 audit-2.1.3.pat/docs/auparse_rese=
t.3
=2D-- audit-2.1.3/docs/auparse_reset.3	2011-08-16 03:31:01.000000000 +1000
+++ audit-2.1.3.pat/docs/auparse_reset.3	2012-01-24 17:37:23.030100626 +1100
@@ -12,7 +12,7 @@
=20
 .SH "RETURN VALUE"
=20
=2DReturns -1 if an error occurs; otherwise, 0 for success.
+Returns \-1 if an error occurs; otherwise, 0 for success.
=20
 .SH "SEE ALSO"
=20
diff -ru audit-2.1.3/docs/auparse_timestamp_compare.3 audit-2.1.3.pat/docs/=
auparse_timestamp_compare.3
=2D-- audit-2.1.3/docs/auparse_timestamp_compare.3	2011-08-16 03:31:01.0000=
00000 +1000
+++ audit-2.1.3.pat/docs/auparse_timestamp_compare.3	2012-01-24 17:37:23.03=
0100626 +1100
@@ -12,7 +12,7 @@
=20
 .SH "RETURN VALUE"
=20
=2DReturns -1, 0, or 1 respectively depending on whether e2 is less than, e=
qual to, or greater than e1.
+Returns \-1, 0, or 1 respectively depending on whether e2 is less than, eq=
ual to, or greater than e1.
=20
 .SH "SEE ALSO"
=20
diff -ru audit-2.1.3/docs/aureport.8 audit-2.1.3.pat/docs/aureport.8
=2D-- audit-2.1.3/docs/aureport.8	2011-08-16 03:31:01.000000000 +1000
+++ audit-2.1.3.pat/docs/aureport.8	2012-01-24 17:37:23.030100626 +1100
@@ -5,7 +5,7 @@
 .B aureport
 .RI [ options ]
 .SH DESCRIPTION
=2D\fBaureport\fP is a tool that produces summary reports of the audit syst=
em logs. The aureport utility can also take input from stdin as long as the=
 input is the raw log data. The reports have a column label at the top to h=
elp with interpretation of the various fields. Except for the main summary =
report, all reports have the audit event number. You can subsequently looku=
p the full event with ausearch \fB-a\fP \fIevent number\fP. You may need to=
 specify start & stop times if you get multiple hits. The reports produced =
by aureport can be used as building blocks for more complicated analysis.
+\fBaureport\fP is a tool that produces summary reports of the audit system=
 logs. The aureport utility can also take input from stdin as long as the i=
nput is the raw log data. The reports have a column label at the top to hel=
p with interpretation of the various fields. Except for the main summary re=
port, all reports have the audit event number. You can subsequently lookup =
the full event with ausearch \fB\-a\fP \fIevent number\fP. You may need to =
specify start & stop times if you get multiple hits. The reports produced b=
y aureport can be used as building blocks for more complicated analysis.
=20
 .SH OPTIONS
 .TP
@@ -42,7 +42,7 @@
 .BR \-if ,\  \-\-input \ \fIfile\fP
 Use the given \fIfile\fP instead if the logs. This is to aid analysis wher=
e the logs have been moved to another machine or only part of a log was sav=
ed.
 .TP
=2D.BR \-\-input-logs=20
+.B \-\-input\-logs
 Use the log file location from auditd.conf as input for analysis. This is =
needed if you are using aureport from a cron job.
 .TP
 .BR \-k ,\  \-\-key
diff -ru audit-2.1.3/docs/ausearch.8 audit-2.1.3.pat/docs/ausearch.8
=2D-- audit-2.1.3/docs/ausearch.8	2011-08-16 03:31:01.000000000 +1000
+++ audit-2.1.3.pat/docs/ausearch.8	2012-01-24 17:37:23.030100626 +1100
@@ -27,7 +27,7 @@
 .BR \-f ,\  \-\-file \ \fIfile-name\fP
 Search for an event based on the given \fIfilename\fP.
 .TP
=2D.BR \-ga ,\  \-\-gid-all \ \fIall-group-id\fP
+.BR \-ga ,\  \-\-gid\-all \ \fIall-group-id\fP
 Search for an event with either effective group ID or group ID matching th=
e given \fIgroup ID\fP.
 .TP
 .BR \-ge ,\  \-\-gid\-effective \ \fIeffective-group-id\fP
@@ -48,16 +48,16 @@
 .BR \-if ,\  \-\-input \ \fIfile-name\fP
 Use the given \fIfile\fP instead of the logs. This is to aid analysis wher=
e the logs have been moved to another machine or only part of a log was sav=
ed.
 .TP
=2D.BR \-\-input-logs
+.BR \-\-input\-logs
 Use the log file location from auditd.conf as input for searching. This is=
 needed if you are using ausearch from a cron job.
 .TP
=2D.BR \-\-just-one
+.BR \-\-just\-one
 Stop after emitting the first event that matches the search criteria.
 .TP
 .BR \-k ,\  \-\-key \ \fIkey-string\fP
 Search for an event based on the given \fIkey string\fP.
 .TP
=2D.BR \-l ,\  \-\-line-buffered
+.BR \-l ,\  \-\-line\-buffered
 Flush output on every line. Most useful when stdout is connected to a pipe=
 and the default block buffering strategy is undesirable. May impose a perf=
ormance penalty.
 .TP
 .BR \-m ,\  \-\-message \ \fImessage-type\fP\ |\ \fIcomma-sep-message-type=
=2Dlist\fP
@@ -117,10 +117,10 @@
 .BR \-tm ,\  \-\-terminal \ \fIterminal\fP
 Search for an event matching the given \fIterminal\fP value. Some daemons =
such as cron and atd use the daemon name for the terminal.
 .TP
=2D.BR \-ua ,\  \-\-uid-all \ \fIall-user-id\fP
+.BR \-ua ,\  \-\-uid\-all \ \fIall-user-id\fP
 Search for an event with either user ID, effective user ID, or login user =
ID (auid) matching the given \fIuser ID\fP.
 .TP
=2D.BR \-ue ,\  \-\-uid-effective \ \fIeffective-user-id\fP
+.BR \-ue ,\  \-\-uid\-effective \ \fIeffective-user-id\fP
 Search for an event with the given \fIeffective user ID\fP.
 .TP
 .BR \-ui ,\  \-\-uid \ \fIuser-id\fP
diff -ru audit-2.1.3/docs/ausearch_add_expression.3 audit-2.1.3.pat/docs/au=
search_add_expression.3
=2D-- audit-2.1.3/docs/ausearch_add_expression.3	2011-08-16 03:31:01.000000=
000 +1000
+++ audit-2.1.3.pat/docs/ausearch_add_expression.3	2012-01-24 17:37:23.0301=
00626 +1100
@@ -16,7 +16,7 @@
 The
 .I expression
 parameter contains an expression, as specified in
=2D.BR ausearch-expression (5).
+.BR ausearch\-expression (5).
=20
 The
 .I how
@@ -48,7 +48,7 @@
 If successful,=20
 .B ausearch_add_expression
 returns 0.
=2DOtherwise, it returns -1, sets
+Otherwise, it returns \-1, sets
 .B errno
 and it may set \fB*\fIerror\fR to an error message;
 the caller must free the error message using
@@ -65,7 +65,7 @@
 .BR ausearch_set_stop (3),
 .BR ausearch_clear (3),
 .BR ausearch_next_event (3),
=2D.BR ausearch-expression (5).
+.BR ausearch\-expression (5).
=20
 .SH AUTHOR
 Miloslav Trmac
diff -ru audit-2.1.3/docs/ausearch_add_interpreted_item.3 audit-2.1.3.pat/d=
ocs/ausearch_add_interpreted_item.3
=2D-- audit-2.1.3/docs/ausearch_add_interpreted_item.3	2011-08-16 03:31:01.=
000000000 +1000
+++ audit-2.1.3.pat/docs/ausearch_add_interpreted_item.3	2012-01-24 17:37:2=
3.030100626 +1100
@@ -43,7 +43,7 @@
=20
 .SH "RETURN VALUE"
=20
=2DReturns -1 if an error occurs; otherwise, 0 for success.
+Returns \-1 if an error occurs; otherwise, 0 for success.
=20
 .SH "SEE ALSO"
=20
@@ -54,7 +54,7 @@
 .BR ausearch_set_stop (3),
 .BR ausearch_clear (3),
 .BR ausearch_next_event (3),
=2D.BR ausearch-expression (5).
+.BR ausearch\-expression (5).
=20
 .SH AUTHOR
 Steve Grubb
diff -ru audit-2.1.3/docs/ausearch_add_item.3 audit-2.1.3.pat/docs/ausearch=
_add_item.3
=2D-- audit-2.1.3/docs/ausearch_add_item.3	2011-08-16 03:31:01.000000000 +1=
000
+++ audit-2.1.3.pat/docs/ausearch_add_item.3	2012-01-24 17:37:23.030100626 =
+1100
@@ -43,7 +43,7 @@
=20
 .SH "RETURN VALUE"
=20
=2DReturns -1 if an error occurs; otherwise, 0 for success.
+Returns \-1 if an error occurs; otherwise, 0 for success.
=20
 .SH "SEE ALSO"
=20
@@ -54,7 +54,7 @@
 .BR ausearch_set_stop (3),=20
 .BR ausearch_clear (3),=20
 .BR ausearch_next_event (3),
=2D.BR ausearch-expression (5).
+.BR ausearch\-expression (5).
=20
 .SH AUTHOR
 Steve Grubb
diff -ru audit-2.1.3/docs/ausearch_add_regex.3 audit-2.1.3.pat/docs/ausearc=
h_add_regex.3
=2D-- audit-2.1.3/docs/ausearch_add_regex.3	2011-08-16 03:31:01.000000000 +=
1000
+++ audit-2.1.3.pat/docs/ausearch_add_regex.3	2012-01-24 17:37:23.030100626=
 +1100
@@ -17,7 +17,7 @@
=20
 .SH "RETURN VALUE"
=20
=2DReturns -1 if an error occurs; otherwise, 0 for success.
+Returns \-1 if an error occurs; otherwise, 0 for success.
=20
 .SH "SEE ALSO"
=20
diff -ru audit-2.1.3/docs/ausearch_add_timestamp_item.3 audit-2.1.3.pat/doc=
s/ausearch_add_timestamp_item.3
=2D-- audit-2.1.3/docs/ausearch_add_timestamp_item.3	2011-08-16 03:31:01.00=
0000000 +1000
+++ audit-2.1.3.pat/docs/ausearch_add_timestamp_item.3	2012-01-24 17:37:23.=
030100626 +1100
@@ -29,7 +29,7 @@
=20
 .SH "RETURN VALUE"
=20
=2DReturns -1 if an error occurs; otherwise, 0 for success.
+Returns \-1 if an error occurs; otherwise, 0 for success.
=20
 .SH APPLICATION USAGE
=20
@@ -51,7 +51,7 @@
 .BR ausearch_set_stop (3),
 .BR ausearch_clear (3),
 .BR ausearch_next_event (3),
=2D.BR ausearch-expression (5).
+.BR ausearch\-expression (5).
=20
 .SH AUTHOR
 Miloslav Trmac
diff -ru audit-2.1.3/docs/ausearch_clear.3 audit-2.1.3.pat/docs/ausearch_cl=
ear.3
=2D-- audit-2.1.3/docs/ausearch_clear.3	2011-08-16 03:31:01.000000000 +1000
+++ audit-2.1.3.pat/docs/ausearch_clear.3	2012-01-24 17:37:23.030100626 +11=
00
@@ -1,6 +1,6 @@
 .TH "AUSEARCH_CLEAR" "3" "Feb 2007" "Red Hat" "Linux Audit API"
 .SH NAME
=2Dausearch_clear \- clear search paramters
+ausearch_clear \- clear search parameters
 .SH "SYNOPSIS"
 .B #include <auparse.h>
 .sp
diff -ru audit-2.1.3/docs/ausearch_next_event.3 audit-2.1.3.pat/docs/ausear=
ch_next_event.3
=2D-- audit-2.1.3/docs/ausearch_next_event.3	2011-08-16 03:31:01.000000000 =
+1000
+++ audit-2.1.3.pat/docs/ausearch_next_event.3	2012-01-24 17:37:23.03010062=
6 +1100
@@ -12,7 +12,7 @@
=20
 .SH "RETURN VALUE"
=20
=2DReturns -1 if an error occurs, 0 if no matches, and 1 for success.
+Returns \-1 if an error occurs, 0 if no matches, and 1 for success.
=20
 .SH "SEE ALSO"
=20
diff -ru audit-2.1.3/docs/ausearch_set_stop.3 audit-2.1.3.pat/docs/ausearch=
_set_stop.3
=2D-- audit-2.1.3/docs/ausearch_set_stop.3	2011-08-16 03:31:01.000000000 +1=
000
+++ audit-2.1.3.pat/docs/ausearch_set_stop.3	2012-01-24 17:37:23.030100626 =
+1100
@@ -24,7 +24,7 @@
=20
 .SH "RETURN VALUE"
=20
=2DReturns -1 if an error occurs; otherwise, 0 for success.
+Returns \-1 if an error occurs; otherwise, 0 for success.
=20
 .SH "SEE ALSO"
=20
diff -ru audit-2.1.3/docs/zos-remote.conf.5 audit-2.1.3.pat/docs/zos-remote=
=2Econf.5
=2D-- audit-2.1.3/docs/zos-remote.conf.5	2012-01-24 17:32:35.181336505 +1100
+++ audit-2.1.3.pat/docs/zos-remote.conf.5	2012-01-24 17:37:23.030100626 +1=
100
@@ -22,17 +22,17 @@
 .SH NAME
 zos\-remote.conf \- the audisp-racf plugin configuration file
 .SH DESCRIPTION
=2D.B zos-remote.conf
+.B zos\-remote.conf
 controls the configuration for the
=2D.BR audispd-zos-remote(8)
+.BR audispd\-zos\-remote (8)
 Audit dispatcher plugin. The default location for this file is
=2D.IR /etc/audisp/zos-remote.conf ,
+.IR /etc/audisp/zos\-remote.conf ,
 however, a different file can be specified as the first argument to the
=2D.B audispd-zos-remote
+.B audispd\-zos\-remote
 plugin. See
=2D.BR audispd-zos-remote(8)
+.BR audispd\-zos\-remote (8)
 and
=2D.BR auditd(8) .
+.BR auditd (8).
 The options available are as follows:
 .TP
 .I server
@@ -42,28 +42,28 @@
 The port number where ITDS is running on the z/OS server. Default is 389 (=
ldap port)
 .TP
 .I user
=2DThe z/OS RACF user ID which the audispd-zos-remote plugin will use to pe=
rform Remote Audit requests. This user needs READ access to FACILITY Class =
resource IRR.LDAP.REMOTE.AUDIT (See
=2D.BR audispd-zos-remote(8) ).
+The z/OS RACF user ID which the audispd\-zos\-remote plugin will use to pe=
rform Remote Audit requests. This user needs READ access to FACILITY Class =
resource IRR.LDAP.REMOTE.AUDIT (See
+.BR audispd\-zos\-remote (8)).
 .TP
 .I password
 The password associated the the z/OS user ID configured above.
 .TP
 .I timeout
 The number in seconds that
=2D.B audispd-zos-remote
+.B audispd\-zos\-remote
 plugin will wait before giving up in connection attempts and event submiss=
ions. The default value is 15
 .TP
 .I q_depth
 The
=2D.B audispd-zos-remote
+.B audispd\-zos\-remote
 plugin will queue inputed events to the maximum of
 .I q_depth
 events while trying to submit those remotely. This can handle burst of eve=
nts or in case of a slow network connection. However, the
=2D.B audispd-zos-remote
+.B audispd\-zos\-remote
 plugin will drop events in case the queue is full. The default queue depth=
 is 64 - Increase this value in case you are experiencing event drop due to=
 full queue
=2D.RB ( audispd-zos-remote
+.RB ( audispd\-zos\-remote
 will log this to syslog).
 .SH "SEE ALSO"
=2D.BR audispd-zos-remote (8)
+.BR audispd\-zos\-remote (8)
 .SH AUTHOR
 Klaus Heinrich Kiwi <klausk@br.ibm.com>
diff -ru audit-2.1.3/tools/aulast/aulast.8 audit-2.1.3.pat/tools/aulast/aul=
ast.8
=2D-- audit-2.1.3/tools/aulast/aulast.8	2012-01-24 17:32:30.349525110 +1100
+++ audit-2.1.3.pat/tools/aulast/aulast.8	2012-01-24 17:37:23.030100626 +11=
00
@@ -21,7 +21,7 @@
 Write raw audit records used to create the displayed report into a file au=
last.log in the current working directory.
=20
 .TP
=2D.B \-f file
+.BI \-f file
 Use the file instead of the audit logs for input.
=20
 .TP
@@ -35,7 +35,7 @@
 .SH "EXAMPLES"
 .nf
 To see this month's logins
=2D.B ausearch --start this-month --raw | aulast --stdin
+.B ausearch \-\-start this-month \-\-raw | aulast \-\-stdin
=20
 .SH "SEE ALSO"
 .BR last (1),
diff -ru audit-2.1.3/tools/ausyscall/ausyscall.8 audit-2.1.3.pat/tools/ausy=
scall/ausyscall.8
=2D-- audit-2.1.3/tools/ausyscall/ausyscall.8	2011-08-16 03:31:02.000000000=
 +1000
+++ audit-2.1.3.pat/tools/ausyscall/ausyscall.8	2012-01-24 17:45:04.7600775=
99 +1100
@@ -4,17 +4,17 @@
 .SH SYNOPSIS
 .B ausyscall [arch] name | number | \-\-dump | \-\-exact
 .SH DESCRIPTION
=2D\fBausyscall\fP is a program that prints out the mapping from syscall na=
me to number and reverse for the given arch. The arch can be anything retur=
ned by uname -m. If arch is not given, the program will take a guess based =
on the running image. You may give the syscall name or number and it will f=
ind the opposite. You can also dump the whole table with the --dump option.=
 By default a syscall name lookup will be a substring match meaning that it=
 will try to match all occurrences of the given name with syscalls. So givi=
ng a name of chown will match both fchown and chown as any other syscall wi=
th chown in its name. If this behavior is not desired, pass the \-\-exact f=
lag and it will do an exact string match.
+\fBausyscall\fP is a program that prints out the mapping from syscall name=
 to number and reverse for the given arch. The arch can be anything returne=
d by `uname \-m`. If arch is not given, the program will take a guess based=
 on the running image. You may give the syscall name or number and it will =
find the opposite. You can also dump the whole table with the \-\-dump opti=
on. By default a syscall name lookup will be a substring match meaning that=
 it will try to match all occurrences of the given name with syscalls. So g=
iving a name of chown will match both fchown and chown as any other syscall=
 with chown in its name. If this behavior is not desired, pass the \-\-exac=
t flag and it will do an exact string match.
=20
 This program can be used to verify syscall numbers on a biarch platform fo=
r rule optimization. For example, suppose you had an auditctl rule:
=20
=2D.B -a always, exit -S open -F exit=3D-EPERM -k fail-open
+.B \-a always, exit \-S open \-F exit=3D\-EPERM \-k fail\-open
=20
 If you wanted to verify that both 32 and 64 bit programs would be audited,=
 run "ausyscall i386 open" and then "ausyscall x86_64 open". Look at the re=
turned numbers. If they are different, you will have to write two auditctl =
rules to get complete coverage.
=20
 .nf
=2D.B -a always,exit -F arch=3Db32 -S open -F exit=3D-EPERM -k fail-open
=2D.B -a always,exit -F arch=3Db64 -S open -F exit=3D-EPERM -k fail-open
+.B \-a always,exit \-F arch=3Db32 \-S open \-F exit=3D\-EPERM \-k fail\-op=
en
+.B \-a always,exit \-F arch=3Db64 \-S open \-F exit=3D\-EPERM \-k fail\-op=
en
 .fi
 .SH OPTIONS
 .TP

--Boundary-00=_JelHP27TaDeBtYs
Content-Type: text/x-patch;
  charset="UTF-8";
  name="mode.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="mode.diff"

Change permittions-checking-errors into warning, so custom administrator has
enougth rope to "shoot himself in the foot".
--- a/src/auditd-config.c
+++ b/src/auditd-config.c
@@ -545,9 +545,11 @@ static int log_file_parser(struct nv_pai
 		return 1;
 	}
 	if ( (buf.st_mode & (S_IXUSR|S_IWGRP|S_IXGRP|S_IRWXO)) ) {
-		audit_msg(LOG_ERR, "%s permissions should be 0600 or 0640",
+		audit_msg(LOG_WARNING, "%s permissions should be 0600 or 0640",
 				nv->value);
+#if 0
 		return 1;
+#endif
 	}
 	if ( !(buf.st_mode & S_IWUSR) ) {
 		audit_msg(LOG_ERR, "audit log is not writable by owner");
@@ -670,8 +672,10 @@ static int dispatch_parser(struct nv_pai
 	}
 	if ((buf.st_mode & (S_IRWXU|S_IRWXG|S_IRWXO)) !=
 			   (S_IRWXU|S_IRGRP|S_IXGRP)) {
-		audit_msg(LOG_ERR, "%s permissions should be 0750", nv->value);
+		audit_msg(LOG_WARNING, "%s permissions should be 0750", nv->value);
+#if 0
 		return 1;
+#endif
 	}
 bypass:
 	free((void *)config->dispatcher);
@@ -919,9 +923,11 @@ static int check_exe_name(const char *va
 	}
 	if ((buf.st_mode & (S_IRWXU|S_IRWXG|S_IRWXO)) !=
 			   (S_IRWXU|S_IRGRP|S_IXGRP)) {
-		audit_msg(LOG_ERR, "%s permissions should be 0750 - line %d",
+		audit_msg(LOG_WARNING, "%s permissions should be 0750 - line %d",
 			val, line);
+#if 0
 		return -1;
+#endif
 	}
 	return 0;
 }

--Boundary-00=_JelHP27TaDeBtYs--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
