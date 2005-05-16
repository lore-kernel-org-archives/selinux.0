Message-ID: <428917F4.6030203@redhat.com>
Date: Mon, 16 May 2005 18:00:20 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SE Linux <selinux@tycho.nsa.gov>, Karl MacMillan <kmacmillan@tresys.com>
Subject: Re: Busted by constraints.
References: <428368FF.2080603@redhat.com>	 <1115908243.32202.114.camel@moss-spartans.epoch.ncsc.mil>	 <42836C4C.6010301@redhat.com>	 <1115996428.3576.47.camel@moss-spartans.epoch.ncsc.mil> <1116269095.28782.102.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1116269095.28782.102.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------070104020001010400030807"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070104020001010400030807
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I think, this patch is needed to export symbols of newly added libsepol 
functions. 

Also policycoreutils-rhat.patch needed to build on 64 bit platforms, 
plus some other stuff.

Dan


-- 



--------------070104020001010400030807
Content-Type: text/x-patch;
 name="libsepol-rhat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsepol-rhat.patch"

diff --exclude-from=exclude -N -u -r nsalibsepol/src/libsepol.map libsepol-1.5.8/src/libsepol.map
--- nsalibsepol/src/libsepol.map	2005-04-14 07:22:14.000000000 -0400
+++ libsepol-1.5.8/src/libsepol.map	2005-05-16 17:43:48.000000000 -0400
@@ -1,4 +1,4 @@
 {
-  global: sepol_genbools*; sepol_set_policydb_from_file; sepol_check_context; sepol_genusers; sepol_debug; sepol_set_delusers;
+  global: sepol_genbools*; sepol_set_policydb_from_file; sepol_check_context; sepol_genusers; sepol_debug; sepol_set_delusers; sepol_context_to_sid; sepol_compute_av_reason;
   local: *;
 };

--------------070104020001010400030807
Content-Type: text/x-patch;
 name="policycoreutils-rhat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policycoreutils-rhat.patch"

diff --exclude-from=exclude -N -u -r nsapolicycoreutils/audit2why/audit2why.1 policycoreutils-1.23.9/audit2why/audit2why.1
--- nsapolicycoreutils/audit2why/audit2why.1	1969-12-31 19:00:00.000000000 -0500
+++ policycoreutils-1.23.9/audit2why/audit2why.1	2005-05-16 17:24:58.000000000 -0400
@@ -0,0 +1,62 @@
+.\" Hey, Emacs! This is an -*- nroff -*- source file.
+.\" Copyright (c) 2005 Dan Walsh <dwalsh@redhat.com>
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
+.TH AUDIT2ALLOW "1" "May 2005" "Security Enhanced Linux" NSA
+.SH NAME
+audit2why \- Translates auditmessages into a description of why the access was denied
+.SH SYNOPSIS
+.B audit2why
+.RI [ options "] "
+.SH OPTIONS
+.TP
+
+.B "\-\-help"
+Print a short usage message
+.TP
+.B "\-p <policyfile>"
+Specify an alternate policy file.
+.SH DESCRIPTION
+.PP
+This utility scans stdin (logfiles) for messages logged when the 
+system denied permission for operations, and generates a reason why the 
+access was denied
+.PP
+.SH EXAMPLE
+$ /usr/sbin/audit2why < /var/log/audit/audit.log
+
+type=KERNEL msg=audit(1115316525.803:399552): avc:  denied  { getattr } for  path=/home/sds dev=hda5 ino=1175041 scontext=root:secadm_r:secadm_t:s0-s9:c0.c127 tcontext=user_u:object_r:user_home_dir_t:s0 tclass=dir
+	Was caused by:
+		Missing TE allow rule for the type pair (use audit2allow).
+
+type=KERNEL msg=audit(1115320071.648:606858): avc:  denied  { append } for  name=.bash_history dev=hda5 ino=1175047 scontext=user_u:user_r:user_t:s1-s9:c0.c127 tcontext=user_u:object_r:user_home_t:s0 tclass=file
+	Was caused by:
+		Constraint violation (add type attribute to domain to satisfy constraints or alter constraint).
+
+
+.PP
+.SH AUTHOR
+This manual page was written by 
+.I Dan Walsh <dwalsh@redhat.com>,
+.B audit2why
+utility was written by Stephen Smalley <sds@tycho.nsa.gov>.
diff --exclude-from=exclude -N -u -r nsapolicycoreutils/audit2why/Makefile policycoreutils-1.23.9/audit2why/Makefile
--- nsapolicycoreutils/audit2why/Makefile	2005-05-16 15:40:11.000000000 -0400
+++ policycoreutils-1.23.9/audit2why/Makefile	2005-05-16 17:26:05.000000000 -0400
@@ -1,6 +1,6 @@
 # Installation directories.
 PREFIX ?= ${DESTDIR}/usr
-BINDIR ?= $(PREFIX)/sbin
+BINDIR ?= $(PREFIX)/bin
 LIBDIR ?= ${PREFIX}/lib
 MANDIR ?= $(PREFIX)/share/man
 LOCALEDIR ?= /usr/share/locale
@@ -8,7 +8,7 @@
 
 CFLAGS = -Werror
 override CFLAGS += -Wall -W
-LDLIBS += ${LIBDIR}/libsepol.a -lselinux
+LDLIBS += -lsepol -lselinux
 
 TARGETS=audit2why
 
@@ -17,6 +17,8 @@
 install: all
 	-mkdir -p $(BINDIR)
 	install -m 755 $(TARGETS) $(BINDIR)
+	-mkdir -p $(MANDIR)/man1
+	install -m 644 audit2why.1 $(MANDIR)/man1/
 
 clean:
 	rm -f $(TARGETS) *.o
diff --exclude-from=exclude -N -u -r nsapolicycoreutils/scripts/fixfiles policycoreutils-1.23.9/scripts/fixfiles
--- nsapolicycoreutils/scripts/fixfiles	2005-04-29 14:11:23.000000000 -0400
+++ policycoreutils-1.23.9/scripts/fixfiles	2005-05-16 17:24:58.000000000 -0400
@@ -164,7 +164,7 @@
 fi
 
 # See how we were called.
-while getopts "C:Fo:R:l:" i; do
+while getopts "C:Ffo:R:l:" i; do
     case "$i" in
 	f)
 		fullFlag=1

--------------070104020001010400030807--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
