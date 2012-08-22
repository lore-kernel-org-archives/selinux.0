Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q7MAgfKi020877
	for <selinux@tycho.nsa.gov>; Wed, 22 Aug 2012 06:42:41 -0400
Message-Id: <201208221042.q7MAgZ8u012821@vivaldi39.register.it>
From: "Guido Trentalancia" <guido@trentalancia.com>
Reply-To: "Guido Trentalancia" <guido@trentalancia.com>
To: dwalsh@redhat.com
Cc: russell@coker.com.au, selinux@tycho.nsa.gov
Subject: [PATCH v2]: dynamically create genhomedircon (was Re: [PATCH] genhomedircon installation and manual page improvements)
Date: Wed, 22 Aug 2012 12:42:35 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello.

The following patch had already been proposed (in a slightly
different and simpler form) on September, 12th 2011.

It dinamically creates the policycoreutils "genhomedircon"
script during the build process in order not to hard-code
the full path to the semodule executable, as in general the
latter could reside in non-standard SBINDIR/USRSBINDIR
locations.

It might not be very stylish or it might appear cumbersome,
but at least the script should not break as easily as the
current static one.

The patch also edits the Makefile for the scripts so that
LOCALEDIR correctly uses $(PREFIX) rather than an absolute
path.

Signed-off-by: Guido Trentalancia <guido@trentalancia.com>
---
 policycoreutils/Makefile              |    2 +-
 policycoreutils/scripts/Makefile      |   12 ++++++++++--
 policycoreutils/scripts/genhomedircon |    2 --
 policycoreutils/semodule/Makefile     |    4 +++-
 4 files changed, 14 insertions(+), 6 deletions(-)

diff -pruN selinux-20072012/policycoreutils/Makefile selinux-20072012-do-not-hardcode-semodule-path-in-genhomedircon/policycoreutils/Makefile
--- selinux-20072012/policycoreutils/Makefile	2012-06-18 18:54:45.709499750 +0200
+++ selinux-20072012-do-not-hardcode-semodule-path-in-genhomedircon/policycoreutils/Makefile	2012-08-22 02:29:16.380289327 +0200
@@ -1,4 +1,4 @@
-SUBDIRS = setfiles semanage load_policy newrole run_init sandbox secon audit2allow audit2why scripts sestatus semodule_package semodule semodule_link semodule_expand semodule_deps sepolgen-ifgen setsebool po man
+SUBDIRS = setfiles semanage load_policy newrole run_init sandbox secon audit2allow audit2why sestatus semodule_package semodule semodule_link semodule_expand semodule_deps sepolgen-ifgen setsebool scripts po man
 
 INOTIFYH = $(shell ls /usr/include/sys/inotify.h 2>/dev/null)
 
diff -pruN selinux-20072012/policycoreutils/scripts/genhomedircon selinux-20072012-do-not-hardcode-semodule-path-in-genhomedircon/policycoreutils/scripts/genhomedircon
--- selinux-20072012/policycoreutils/scripts/genhomedircon	2012-06-18 18:54:45.760500216 +0200
+++ selinux-20072012-do-not-hardcode-semodule-path-in-genhomedircon/policycoreutils/scripts/genhomedircon	1970-01-01 01:00:00.000000000 +0100
@@ -1,2 +0,0 @@
-#!/bin/sh
-/usr/sbin/semodule -Bn
diff -pruN selinux-20072012/policycoreutils/scripts/Makefile selinux-20072012-do-not-hardcode-semodule-path-in-genhomedircon/policycoreutils/scripts/Makefile
--- selinux-20072012/policycoreutils/scripts/Makefile	2012-06-18 18:54:45.759500206 +0200
+++ selinux-20072012-do-not-hardcode-semodule-path-in-genhomedircon/policycoreutils/scripts/Makefile	2012-08-22 02:49:12.073063168 +0200
@@ -4,21 +4,29 @@ BINDIR ?= $(PREFIX)/bin
 USRSBINDIR ?= $(PREFIX)/sbin
 SBINDIR ?= $(DESTDIR)/sbin
 MANDIR ?= $(PREFIX)/share/man
-LOCALEDIR ?= /usr/share/locale
+LOCALEDIR ?= $(PREFIX)/share/locale
 
 all: fixfiles genhomedircon chcat
 
+genhomedircon:
+	@echo "#!/bin/sh" > genhomedircon
+	@echo >> genhomedircon
+	@if [ ! -e semodule_path ]; then echo -n "$(USRSBINDIR)/" >> genhomedircon; fi
+	@if [ -e semodule_path ]; then echo -n "`cat semodule_path`/" >> genhomedircon; fi
+	@echo "semodule -Bn" >> genhomedircon
+
 install: all
 	-mkdir -p $(BINDIR)
 	install -m 755 chcat $(BINDIR)
 	install -m 755 fixfiles $(SBINDIR)
-	install -m 755 genhomedircon  $(USRSBINDIR)
+	install -m 755 genhomedircon $(USRSBINDIR)
 	-mkdir -p $(MANDIR)/man8
 	install -m 644 fixfiles.8 $(MANDIR)/man8/
 	install -m 644 genhomedircon.8 $(MANDIR)/man8/
 	install -m 644 chcat.8 $(MANDIR)/man8/
 
 clean:
+	rm -f genhomedircon
 
 indent:
 
diff -pruN selinux-20072012/policycoreutils/semodule/Makefile selinux-20072012-do-not-hardcode-semodule-path-in-genhomedircon/policycoreutils/semodule/Makefile
--- selinux-20072012/policycoreutils/semodule/Makefile	2012-06-18 18:54:45.761500225 +0200
+++ selinux-20072012-do-not-hardcode-semodule-path-in-genhomedircon/policycoreutils/semodule/Makefile	2012-08-22 12:45:23.479737622 +0200
@@ -13,6 +13,8 @@ SEMODULE_OBJS = semodule.o
 all: semodule
 
 semodule: $(SEMODULE_OBJS)
+	$(CC) $(LDFLAGS) -o $@ $^ $(LDLIBS)
+	@echo -n $(SBINDIR) > ../scripts/semodule_path
 
 install: all
 	-mkdir -p $(SBINDIR)
@@ -23,7 +25,7 @@ install: all
 relabel:
 
 clean:
-	-rm -f semodule *.o
+	-rm -f semodule *.o ../scripts/semodule_path
 
 indent:
 	../../scripts/Lindent $(wildcard *.[ch])

>Hello,
>
>the very first thing I would suggest for genhomedircon is to make the
>installation a bit more robust as follows:
>
>Do not hard-code the path to semodule in the genhomedircon script but
>rather generate it during each installation according to the value of
>the SBINDIR environment variable.
>
>--- selinux/policycoreutils/scripts/Makefile	2011-09-02 04:19:47.355716903 +0200
>+++ selinux-12092011-master-new/policycoreutils/scripts/Makefile	2011-09-12 05:52:41.334996312 +0200
>@@ -11,7 +11,10 @@ install: all
> 	-mkdir -p $(BINDIR)
> 	install -m 755 chcat $(BINDIR)
> 	install -m 755 fixfiles $(DESTDIR)/sbin
>-	install -m 755 genhomedircon  $(SBINDIR)
>+	@echo "#!/bin/sh" > genhomedircon
>+	@echo >> genhomedircon
>+	@echo "$(SBINDIR)/semodule -Bn" >> genhomedircon
>+	install -m 755 genhomedircon $(SBINDIR)
> 	-mkdir -p $(MANDIR)/man8
> 	install -m 644 fixfiles.8 $(MANDIR)/man8/
> 	install -m 644 genhomedircon.8 $(MANDIR)/man8/

A new version has been created for the manual page too and it will be attached in a separate message to follow.

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

See following message for the manual page patch.

Regards,

Guido 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
