Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0K1gEIi002329
	for <selinux@tycho.nsa.gov>; Wed, 19 Jan 2005 20:42:14 -0500 (EST)
Received: from glaurung.internal.golden-gryphon.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j0K1e7sw014009
	for <selinux@tycho.nsa.gov>; Thu, 20 Jan 2005 01:40:08 GMT
Received: from glaurung.internal.golden-gryphon.com (localhost [127.0.0.1])
	by glaurung.internal.golden-gryphon.com (8.13.2/8.13.2/Debian-1) with ESMTP id j0K1bQau010533
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <selinux@tycho.nsa.gov>; Wed, 19 Jan 2005 19:37:37 -0600
From: Manoj Srivastava <manoj.srivastava@stdc.com>
To: selinux@tycho.nsa.gov
Subject: Manual Page for audit2allow
Date: Wed, 19 Jan 2005 19:37:06 -0600
Message-ID: <87ekggubi5.fsf@glaurung.internal.golden-gryphon.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--=-=-=

Hi,

        While packaging policycoreutils for Debian, I've come across a
 couple of utilities without manual pages (which is against d4ebian
 technical policy), so I'm writing up pages as I go along. Here is a
 manual page for audit2allow; perhaps it can be incorporated upstream.

	manoj


--=-=-=
Content-Type: application/x-troff-man
Content-Disposition: attachment; filename=audit2allow.1
Content-Description: audit2allow.1 manual page

.\" Hey, Emacs! This is an -*- nroff -*- source file.
.\" Copyright (c) 2005 Manoj Srivastava <srivasta@debian.org>
.\"
.\" This is free documentation; you can redistribute it and/or
.\" modify it under the terms of the GNU General Public License as
.\" published by the Free Software Foundation; either version 2 of
.\" the License, or (at your option) any later version.
.\"
.\" The GNU General Public License's references to "object code"
.\" and "executables" are to be interpreted as the output of any
.\" document formatting or typesetting system, including
.\" intermediate and printed output.
.\"
.\" This manual is distributed in the hope that it will be useful,
.\" but WITHOUT ANY WARRANTY; without even the implied warranty of
.\" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
.\" GNU General Public License for more details.
.\"
.\" You should have received a copy of the GNU General Public
.\" License along with this manual; if not, write to the Free
.\" Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139,
.\" USA.
.\"
.\"
.TH AUDIT2ALLOW "1" "January 2005" "Security Enhanced Linux" NSA
.SH NAME
audit2allow \- generate policy allow rules from logs of denied operations
.SH SYNOPSIS
.B audit2allow
.RI [ options "] "
.SH OPTIONS
.TP
.B "\-\-help"
Print a short usage message
.TP
.B "\-d"
Read input from output of 
.I /bin/dmesg
.TP
.B "\-v"
Turn on verbose output
.TP
.B "\-l"
read input only after last 
.BI \"load_policy\"
.TP
.B "\-i <inputfile>"
read input from 
.I <inputfile>
.TP
.B "\-o <outputfile>"
append output to 
.I <outputfile>
.SH DESCRIPTION
.PP
This utility scans the logs for messages logged when the system denied
permission for operations, and generates a snippet of policy rules
which, if loaded into policy, would ahve allowed those operations to
succeed. 
.PP
Care must be exercised while acting on the outpu of this utility to
ensure that the operations being permitted do not pose a secureity
threat. Often it is better to define new domains, or make other
structural changes to narrowly allow an optimal set of operations to
succeed, as opposed to blindly implementing the sometimes broad
changes recommended by this utility.
.SH AUTHOR
This manual page was written by 
.I Manoj Srivastava <srivasta@debian.org>,
for the Debian GNU/Linux system. The 
.B audit2allow
utility has contributions from several people, including 
.I Justin R. Smith 
and 
.I Yuichi Nakamura.

--=-=-=


-- 
Being owned by someone used to be called slavery -- now it's called
commitment.
Manoj Srivastava   <manoj.srivastava@stdc.com>    <srivasta@acm.org> 
1024D/BF24424C print 4966 F272 D093 B493 410B  924B 21BA DABB BF24 424C

--=-=-=--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
