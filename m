Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p8C4mxU0032536
	for <selinux@tycho.nsa.gov>; Mon, 12 Sep 2011 00:48:59 -0400
Received: from cp-out8.libero.it (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p8C4mvHp006274
	for <selinux@tycho.nsa.gov>; Mon, 12 Sep 2011 04:48:57 GMT
Subject: [PATCH] genhomedircon installation and manual page improvements
 (was Re: policycoreutils manpages needed)
From: Guido Trentalancia <guido@trentalancia.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: russell@coker.com.au, SE-Linux <selinux@tycho.nsa.gov>
Date: Mon, 12 Sep 2011 06:48:29 +0200
In-Reply-To: <4E5F8BAA.6060208@redhat.com>
References: <201109011509.05872.russell@coker.com.au>
	 <4E5F8BAA.6060208@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1315802909.2209.31.camel@vortex>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

the very first thing I would suggest for genhomedircon is to make the
installation a bit more robust as follows:

Do not hard-code the path to semodule in the genhomedircon script but
rather generate it during each installation according to the value of
the SBINDIR environment variable.

--- selinux/policycoreutils/scripts/Makefile	2011-09-02 04:19:47.355716903 +0200
+++ selinux-12092011-master-new/policycoreutils/scripts/Makefile	2011-09-12 05:52:41.334996312 +0200
@@ -11,7 +11,10 @@ install: all
 	-mkdir -p $(BINDIR)
 	install -m 755 chcat $(BINDIR)
 	install -m 755 fixfiles $(DESTDIR)/sbin
-	install -m 755 genhomedircon  $(SBINDIR)
+	@echo "#!/bin/sh" > genhomedircon
+	@echo >> genhomedircon
+	@echo "$(SBINDIR)/semodule -Bn" >> genhomedircon
+	install -m 755 genhomedircon $(SBINDIR)
 	-mkdir -p $(MANDIR)/man8
 	install -m 644 fixfiles.8 $(MANDIR)/man8/
 	install -m 644 genhomedircon.8 $(MANDIR)/man8/

The manual page does not seem that bad apart from a possibly unwanted
dump from emacs. However, here is a possible improvement:

--- selinux/policycoreutils/scripts/genhomedircon.8	2011-09-02 04:19:47.356716910 +0200
+++ selinux-12092011-master-new/policycoreutils/scripts/genhomedircon.8	2011-09-12 06:45:01.206251165 +0200
@@ -1,37 +1,21 @@
-.\" Hey, Emacs! This is an -*- nroff -*- source file.
-.\" Copyright (c) 2010 Dan Walsh <dwalsh@redhat.com>
-.\"
-.\" This is free documentation; you can redistribute it and/or
-.\" modify it under the terms of the GNU General Public License as
-.\" published by the Free Software Foundation; either version 2 of
-.\" the License, or (at your option) any later version.
-.\"
-.\" The GNU General Public License's references to "object code"
-.\" and "executables" are to be interpreted as the output of any
-.\" document formatting or typesetting system, including
-.\" intermediate and printed output.
-.\"
-.\" This manual is distributed in the hope that it will be useful,
-.\" but WITHOUT ANY WARRANTY; without even the implied warranty of
-.\" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-.\" GNU General Public License for more details.
-.\"
-.\" You should have received a copy of the GNU General Public
-.\" License along with this manual; if not, write to the Free
-.\" Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139,
-.\" USA.
-.\"
-.\"
-.TH GENHOMEDIRCON "8" "May 2010" "Security Enhanced Linux" "SELinux"
+.TH GENHOMEDIRCON "12" "Sep 2011" "Security Enhanced Linux" "SELinux"
 .SH NAME
 genhomedircon \- generate SELinux file context configuration entries for user home directories
 .SH SYNOPSIS
 .B genhomedircon
-is a script that executes semodule to rebuild policy and create the
-labels for HOMEDIRS based on home directories returned by the getpw calls.
+is a script that executes
+.B semodule
+to rebuild the SELinux policy and to create the
+labels for each user home directory based on directory paths returned by calls to getpwent().
 
-This functionality is enabled via the usepasswd flag in /etc/selinux/semanage.conf.
+This functionality can be disabled by using the "usepasswd" flag in /etc/selinux/semanage.conf
+(such flag can either take the value "true" or "false" and by default it is set to "true").
 
 .SH AUTHOR
 This manual page was written by
 .I Dan Walsh <dwalsh@redhat.com>
+
+The supporting functionality in the semanage library was written by Tresys Technology.
+
+.SH "SEE ALSO"
+semodule(8), getpwent(3), getpwent_r(3)

Regards,

Guido

On Thu, 2011-09-01 at 09:42 -0400, Daniel J Walsh wrote:
> On 09/01/2011 01:09 AM, Russell Coker wrote:
> > Has anyone written manpages for genhomedircon, sepolgen-ifgen, and
> > seunshare? If not is there someone with some spare time and man
> > page writing skill?
> > 
> We have man pages for genhomedircon and seunshare.  Although the
> genhomedircon man page is rather sparse.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
