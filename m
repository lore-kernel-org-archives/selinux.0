Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q7MAmYQf021112
	for <selinux@tycho.nsa.gov>; Wed, 22 Aug 2012 06:48:34 -0400
Message-Id: <201208221048.q7MAmUT9016614@vivaldi49.register.it>
From: "Guido Trentalancia" <guido@trentalancia.com>
Reply-To: "Guido Trentalancia" <guido@trentalancia.com>
To: dwalsh@redhat.com
Cc: russell@coker.com.au, selinux@tycho.nsa.gov
Subject: [PATCH v2]: genhomedircon manual page improvements (was Re: [PATCH] genhomedircon installation and manual page improvements)
Date: Wed, 22 Aug 2012 12:48:30 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello again.

New version (v3) of a patch for policycoreutils/scripts already posted on September, 12th 2011.

The following patch aims to improve the manual page (section 8) for the
"genhomedircon" script (policycoreutils).

- remove probably redundant GNU licence notice;
- try to further clarify the functionality made available by the
  "genhomedircon" script as well as all the configurable options that
  control its execution and affect its behavior;
- extend the references section (SEE ALSO).
  
Signed-off-by: Guido Trentalancia <guido@trentalancia.com>
---
 policycoreutils/scripts/genhomedircon.8 |   45 ++++++++++++--------------------
 1 file changed, 17 insertions(+), 28 deletions(-)

--- selinux-20072012/policycoreutils/scripts/genhomedircon.8	2012-06-18 18:54:45.760500216 +0200
+++ selinux-20072012-improve-genhomedircon-manual-page-v3/policycoreutils/scripts/genhomedircon.8	2012-08-22 12:27:52.908266342 +0200
@@ -1,37 +1,26 @@
-." Hey, Emacs! This is an -*- nroff -*- source file.
-." Copyright (c) 2010 Dan Walsh <dwalsh@redhat.com>
-."
-." This is free documentation; you can redistribute it and/or
-." modify it under the terms of the GNU General Public License as
-." published by the Free Software Foundation; either version 2 of
-." the License, or (at your option) any later version.
-."
-." The GNU General Public License's references to "object code"
-." and "executables" are to be interpreted as the output of any
-." document formatting or typesetting system, including
-." intermediate and printed output.
-."
-." This manual is distributed in the hope that it will be useful,
-." but WITHOUT ANY WARRANTY; without even the implied warranty of
-." MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-." GNU General Public License for more details.
-."
-." You should have received a copy of the GNU General Public
-." License along with this manual; if not, write to the Free
-." Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139,
-." USA.
-."
-."
-.TH GENHOMEDIRCON "8" "May 2010" "Security Enhanced Linux" "SELinux"
+.TH GENHOMEDIRCON "12" "Sep 2011" "Security Enhanced Linux" "SELinux"
 .SH NAME
 genhomedircon - generate SELinux file context configuration entries for user home directories
 .SH SYNOPSIS
 .B genhomedircon
-is a script that executes semodule to rebuild policy and create the
-labels for HOMEDIRS based on home directories returned by the getpw calls.
+is a script that executes
+.B semodule
+to rebuild the currently active SELinux policy (without reloading it) and to create the
+labels for each user home directory based on directory paths returned by calls to getpwent().
 
-This functionality is enabled via the usepasswd flag in /etc/selinux/semanage.conf.
+The latter functionality depends on the "usepasswd" parameter being set to "true" (default)
+in /etc/selinux/semanage.conf.
+
+This script is usually executed by
+.B semanage
+although this default behavior can be optionally modified by setting to "true" the
+"disable-genhomedircon" in /etc/selinux/semanage.conf.
 
 .SH AUTHOR
 This manual page was written by
 .I Dan Walsh <dwalsh@redhat.com>
+
+The supporting functionality in the semanage library was written by Tresys Technology.
+
+.SH "SEE ALSO"
+semanage.conf(5), semodule(8), semanage(8), getpwent(3), getpwent_r(3)

[cut]

>The manual page does not seem that bad apart from a possibly unwanted
>dump from emacs. However, here is a possible improvement:
>
>--- selinux/policycoreutils/scripts/genhomedircon.8	2011-09-02 04:19:47.356716910 +0200
>+++ selinux-12092011-master-new/policycoreutils/scripts/genhomedircon.8	2011-09-12 06:45:01.206251165 +0200
>@@ -1,37 +1,21 @@
>-." Hey, Emacs! This is an -*- nroff -*- source file.
>-." Copyright (c) 2010 Dan Walsh <dwalsh@redhat.com>
>-."
>-." This is free documentation; you can redistribute it and/or
>-." modify it under the terms of the GNU General Public License as
>-." published by the Free Software Foundation; either version 2 of
>-." the License, or (at your option) any later version.
>-."
>-." The GNU General Public License's references to "object code"
>-." and "executables" are to be interpreted as the output of any
>-." document formatting or typesetting system, including
>-." intermediate and printed output.
>-."
>-." This manual is distributed in the hope that it will be useful,
>-." but WITHOUT ANY WARRANTY; without even the implied warranty of
>-." MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>-." GNU General Public License for more details.
>-."
>-." You should have received a copy of the GNU General Public
>-." License along with this manual; if not, write to the Free
>-." Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139,
>-." USA.
>-."
>-."
>-.TH GENHOMEDIRCON "8" "May 2010" "Security Enhanced Linux" "SELinux"
>+.TH GENHOMEDIRCON "12" "Sep 2011" "Security Enhanced Linux" "SELinux"
> .SH NAME
> genhomedircon - generate SELinux file context configuration entries for user home directories
> .SH SYNOPSIS
> .B genhomedircon
>-is a script that executes semodule to rebuild policy and create the
>-labels for HOMEDIRS based on home directories returned by the getpw calls.
>+is a script that executes
>+.B semodule
>+to rebuild the SELinux policy and to create the
>+labels for each user home directory based on directory paths returned by calls to getpwent().
> 
>-This functionality is enabled via the usepasswd flag in /etc/selinux/semanage.conf.
>+This functionality can be disabled by using the "usepasswd" flag in /etc/selinux/semanage.conf
>+(such flag can either take the value "true" or "false" and by default it is set to "true").
> 
> .SH AUTHOR
> This manual page was written by
> .I Dan Walsh <dwalsh@redhat.com>
>+
>+The supporting functionality in the semanage library was written by Tresys Technology.
>+
>+.SH "SEE ALSO"
>+semodule(8), getpwent(3), getpwent_r(3)
>
>Regards,
>
>Guido
>
>On Thu, 2011-09-01 at 09:42 -0400, Daniel J Walsh wrote:
>> On 09/01/2011 01:09 AM, Russell Coker wrote:
>> > Has anyone written manpages for genhomedircon, sepolgen-ifgen, and
>> > seunshare? If not is there someone with some spare time and man
>> > page writing skill?
>> > 
>> We have man pages for genhomedircon and seunshare.  Although the
>> genhomedircon man page is rather sparse.

Regards,

Guido 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
