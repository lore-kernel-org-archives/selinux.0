Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0K7g5Ii003463
	for <selinux@tycho.nsa.gov>; Thu, 20 Jan 2005 02:42:05 -0500 (EST)
Received: from glaurung.internal.golden-gryphon.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j0K7g7Cf005794
	for <selinux@tycho.nsa.gov>; Thu, 20 Jan 2005 07:42:07 GMT
Received: from glaurung.internal.golden-gryphon.com (localhost [127.0.0.1])
	by glaurung.internal.golden-gryphon.com (8.13.2/8.13.2/Debian-1) with ESMTP id j0K7cMMR003601
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <selinux@tycho.nsa.gov>; Thu, 20 Jan 2005 01:38:27 -0600
From: Manoj Srivastava <manoj.srivastava@stdc.com>
To: selinux@tycho.nsa.gov
Subject: plicycoreutils: genhomedircon man page
Date: Thu, 20 Jan 2005 01:38:14 -0600
Message-ID: <873bwwtus9.fsf@glaurung.internal.golden-gryphon.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--=-=-=

Hi,

        Here is the man page for the other script without a man page
 in policycoreutils. 

	manoj


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=genhomedircon-man.patch
Content-Description: man page for genhomedircon 


--- orig/scripts/Makefile
+++ mod/scripts/Makefile
@@ -14,6 +14,7 @@
 	install -m 755 fixfiles $(DESTDIR)/sbin
 	-mkdir -p $(MANDIR)/man8
 	install -m 644 fixfiles.8.gz $(MANDIR)/man8/
+	install -m 644 genhomedircon.8 $(MANDIR)/man8/
 
 clean:
 



--- /dev/null
+++ mod/scripts/genhomedircon.8
@@ -0,0 +1,71 @@
+.\" Hey, Emacs! This is an -*- nroff -*- source file.
+.\" Copyright (c) 2005 Manoj Srivastava <srivasta@debian.org>
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
+.\"
+.TH GENHOMEDIRCON "8" "January 2005" "Security Enhanced Linux" NSA
+.SH NAME
+genhomedircon \- expand HOME_ROOT, HOME_DIR, and ROLE macros in .fc files
+.SH SYNOPSIS
+.B genhomedircon
+.RI POLICYSOURCEDIR FILE_CONTEXTS 
+.SH OPTIONS
+.TP
+.B "\-h"
+Print a short usage message
+.SH DESCRIPTION
+.PP
+This utility replaces the
+.B HOME_ROOT, HOME_DIR,
+and 
+.B ROLE
+macros in .fc files with generic and user-specific values. It reads
+the list of users from the
+.I <<FILECONTEXTDIR>>/users
+file. If a user has more than one role in 
+.I <<FILECONTEXTDIR>>/users,
+.B genhomedircon
+uses the first role in the list. 
+.PP 
+If a user is not listed in 
+.I <<FILECONTEXTDIR>>/users,
+.B genhomedircon
+assumes that the user's home dir will be found in one of the
+HOME_ROOTs. When looking for these users, 
+.B genhomedircon
+only considers real users. "Real" users (as opposed
+to system users) are those whose UID is greater than or equal 
+.I STARTING_UID
+(usually 100) and whose login shell is not "/sbin/nologin", or
+"/bin/false". Users who are explicitly defined in 
+.I <<FILECONTEXTDIR>>/users
+are always "real" (including root, in the default configuration).
+.SH AUTHOR
+This manual page was written by 
+.I Manoj Srivastava <srivasta@debian.org>,
+for the Debian GNU/Linux system, based on the comments and the code
+in the utility. The 
+.B genhomedircon
+utility was written by
+.I Tresys Technology, LLC,
+based on the original script by
+.I Dan Walsh.


--=-=-=


-- 
The best book on programming for the layman is "Alice in Wonderland";
but that's because it's the best book on anything for the layman.
Manoj Srivastava   <manoj.srivastava@stdc.com>    <srivasta@acm.org> 
1024D/BF24424C print 4966 F272 D093 B493 410B  924B 21BA DABB BF24 424C

--=-=-=--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
