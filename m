Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2CM60Do014989
	for <selinux@tycho.nsa.gov>; Sat, 12 Mar 2005 17:06:01 -0500 (EST)
Received: from glaurung.internal.golden-gryphon.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2CM0YqN017697
	for <selinux@tycho.nsa.gov>; Sat, 12 Mar 2005 22:00:35 GMT
Received: from glaurung.internal.golden-gryphon.com (srivasta@localhost [127.0.0.1])
	by glaurung.internal.golden-gryphon.com (8.13.3/8.13.3/Debian-8) with ESMTP id j2CLqHJO023331
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <selinux@tycho.nsa.gov>; Sat, 12 Mar 2005 15:52:32 -0600
From: Manoj Srivastava <manoj.srivastava@stdc.com>
To: selinux@tycho.nsa.gov
Subject: Manual pages for utilities in libsepol
Date: Sat, 12 Mar 2005 15:52:01 -0600
Message-ID: <87r7iksfb2.fsf@glaurung.internal.golden-gryphon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

        While packaging the new version of sepol-utils for Debian, I
 noticed that the utilities chkcon and genpolusers had no manual
 pages. I have added the following (trivial) man pages for them (patch
 appended).

        manoj

--- /dev/null
+++ new-files-archive/man/man8/chkcon.8
@@ -0,0 +1,41 @@
+.\" Hey, Emacs! This is an -*- nroff -*- source file.
+.\" Copyright (c) 1997 Manoj Srivastava <srivasta@debian.org>
+.\"
+.\" This is free documentation; you can redistribute it and/or
+.\" modify it under the terms of the GNU General Public License as
+.\" published by the Free Software Foundation; either version 2 of
+.\" the License, or (at your option) any later version.
+.\"
+.\" The GNU General Public License's references to "object code"
+.\" and "executables" are to be interpreted as the output of any
+.\" document formatting or typesetting system, including
+.\" intermediate and printed output.
+.\"
+.\" This manual is distributed in the hope that it will be useful,
+.\" but WITHOUT ANY WARRANTY; without even the implied warranty of
+.\" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+.\" GNU General Public License for more details.
+.\"
+.\" You should have received a copy of the GNU General Public
+.\" License along with this manual; if not, write to the Free
+.\" Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139,
+.\" USA.
+.\"
+.TH CHKCON 8 "Mar 12 2005" "SELinux" "SELinux Command Line documentation"
+.SH NAME
+chkcon \-  determine if a security context is valid for a given binary policy
+.SH SYNOPSIS
+chkcon policy_file context
+.SH DESCRIPTION
+This utility validates (the string representation of) a security context
+specified by the argument
+.I context
+against configuration data read in from a policy database binary
+representation file specified by the argument
+.I policy_file.
+.SH FILES
+policy file
+.SH AUTHOR
+This manual page (and just the manual page) was written by Manoj
+Srivastava <srivasta@debian.org>.
+
--- /dev/null
+++ new-files-archive/man/man8/genpolusers.8
@@ -0,0 +1,42 @@
+.\" Hey, Emacs! This is an -*- nroff -*- source file.
+.\" Copyright (c) 1997 Manoj Srivastava <srivasta@debian.org>
+.\"
+.\" This is free documentation; you can redistribute it and/or
+.\" modify it under the terms of the GNU General Public License as
+.\" published by the Free Software Foundation; either version 2 of
+.\" the License, or (at your option) any later version.
+.\"
+.\" The GNU General Public License's references to "object code"
+.\" and "executables" are to be interpreted as the output of any
+.\" document formatting or typesetting system, including
+.\" intermediate and printed output.
+.\"
+.\" This manual is distributed in the hope that it will be useful,
+.\" but WITHOUT ANY WARRANTY; without even the implied warranty of
+.\" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+.\" GNU General Public License for more details.
+.\"
+.\" You should have received a copy of the GNU General Public
+.\" License along with this manual; if not, write to the Free
+.\" Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139,
+.\" USA.
+.\"
+.TH GENPOLUSERS 8 "Mar 12 2005" "SELinux" "SELinux Command Line documentation"
+.SH NAME
+genpolusers \- Generate new binary policy with updated user configuration
+.SH SYNOPSIS
+genpolusers in-policy usersdir out-policy
+.SH DESCRIPTION
+Given an existing binary policy file 
+.I in\-policy, 
+generate a new binary policy 
+.I out\-policy 
+with an updated user configuration based on any 
+.B system.users 
+and
+.B local.users 
+files in the specified 
+.I usersdir.
+.SH AUTHOR
+This manual page (and just the manual page) was written by Manoj
+Srivastava <srivasta@debian.org>.



-- 
Law of Computability Applied to Social Sciences: If at first you don't
succeed, transform your data set.
Manoj Srivastava   <manoj.srivastava@stdc.com>    <srivasta@acm.org> 
1024D/BF24424C print 4966 F272 D093 B493 410B  924B 21BA DABB BF24 424C

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
