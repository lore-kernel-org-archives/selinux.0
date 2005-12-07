Message-ID: <43971BB4.6020408@redhat.com>
Date: Wed, 07 Dec 2005 12:28:20 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: audit2allow long options
References: <1133971559.2366.40.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1133971559.2366.40.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------020904030107040901010901"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020904030107040901010901
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Stephen Smalley wrote:
> I'm not sure how one does long options in python, but the current
> audit2allow script doesn't actually support the ones you've defined
> (e.g. --requires does NOT work, whereas -r does).
>
> audit2allow -a -r => generates requires and allow statements
> audit2allow -a --requires => generates only allow statements
>
> And audit2allow --tefile complains that the option is unrecognized.
>
>   
Missing comma caused the problem.

Update patch for policycoreutils to fix the problem as well as add an 
enhanced version of chcat to allows manipulation of
file categories.


-- 



--------------020904030107040901010901
Content-Type: text/x-patch;
 name="policycoreutils-rhat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policycoreutils-rhat.patch"

diff --exclude-from=exclude -N -u -r nsapolicycoreutils/audit2allow/audit2allow policycoreutils-1.27.37/audit2allow/audit2allow
--- nsapolicycoreutils/audit2allow/audit2allow	2005-12-01 10:11:27.000000000 -0500
+++ policycoreutils-1.27.37/audit2allow/audit2allow	2005-12-07 12:26:00.000000000 -0500
@@ -355,7 +355,7 @@
 					     'lastreload',
 					     'module=',
 					     'output=',
-					     'requires'
+					     'requires',
 					     'tefile',
 					     'verbose'
 					     ])
diff --exclude-from=exclude -N -u -r nsapolicycoreutils/debugfiles.list policycoreutils-1.27.37/debugfiles.list
--- nsapolicycoreutils/debugfiles.list	1969-12-31 19:00:00.000000000 -0500
+++ policycoreutils-1.27.37/debugfiles.list	2005-12-07 11:56:28.000000000 -0500
@@ -0,0 +1,14 @@
+/usr/lib/debug/usr/bin/newrole.debug
+/usr/lib/debug/usr/bin/semodule_link.debug
+/usr/lib/debug/usr/bin/semodule_expand.debug
+/usr/lib/debug/usr/bin/semodule_package.debug
+/usr/lib/debug/usr/sbin/sestatus.debug
+/usr/lib/debug/usr/sbin/setfiles.debug
+/usr/lib/debug/usr/sbin/open_init_pty.debug
+/usr/lib/debug/usr/sbin/run_init.debug
+/usr/lib/debug/usr/sbin/load_policy.debug
+/usr/lib/debug/usr/sbin/semodule.debug
+/usr/lib/debug/usr/sbin/audit2why.debug
+/usr/lib/debug/usr/sbin/setsebool.debug
+/usr/lib/debug/sbin/restorecon.debug
+/usr/src/debug/policycoreutils-1.27.37
Binary files nsapolicycoreutils/debugsources.list and policycoreutils-1.27.37/debugsources.list differ
diff --exclude-from=exclude -N -u -r nsapolicycoreutils/policycoreutils.lang policycoreutils-1.27.37/policycoreutils.lang
--- nsapolicycoreutils/policycoreutils.lang	1969-12-31 19:00:00.000000000 -0500
+++ policycoreutils-1.27.37/policycoreutils.lang	2005-12-07 11:56:27.000000000 -0500
@@ -0,0 +1,80 @@
+%defattr (644, root, root, 755)
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+%lang(sv) /usr/share/locale/sv/LC_MESSAGES/policycoreutils.mo
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
diff --exclude-from=exclude -N -u -r nsapolicycoreutils/scripts/chcat policycoreutils-1.27.37/scripts/chcat
--- nsapolicycoreutils/scripts/chcat	1969-12-31 19:00:00.000000000 -0500
+++ policycoreutils-1.27.37/scripts/chcat	2005-12-07 11:56:20.000000000 -0500
@@ -0,0 +1,175 @@
+#! /usr/bin/env python
+# Copyright (C) 2005 Red Hat 
+# see file 'COPYING' for use and warranty information
+#
+#    chcat is a script that allows you modify the Security label on a file
+#
+#`   Author: Daniel Walsh <dwalsh@redhat.com>
+#
+#    This program is free software; you can redistribute it and/or
+#    modify it under the terms of the GNU General Public License as
+#    published by the Free Software Foundation; either version 2 of
+#    the License, or (at your option) any later version.
+#
+#    This program is distributed in the hope that it will be useful,
+#    but WITHOUT ANY WARRANTY; without even the implied warranty of
+#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#    GNU General Public License for more details.
+#
+#    You should have received a copy of the GNU General Public License
+#    along with this program; if not, write to the Free Software
+#    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA     
+#                                        02111-1307  USA
+#
+#  
+import commands, sys, os, pwd, string, getopt, re, selinux
+
+def chcat_add(orig, newcat, files):
+    errors=0
+    cmd='chcon -l '
+    sensitivity=newcat[0]
+    cat=newcat[1]
+    for f in files:
+        (rc, con) = selinux.getfilecon(f)
+        (rc, raw) = selinux.selinux_trans_to_raw_context(con)
+        clist=raw.split(":")[3:]
+        if len(clist) > 1:
+            if clist[0] != sensitivity:
+                print("Can not modify sensitivity levels using '+' on %s" % f)
+                continue
+            cats=clist[1].split(",")
+            if newcat[1] in cats:
+                print "%s is already in %s" % (f, orig)
+                continue
+            cats.append(newcat[1])
+            cats.sort()
+            cat=cats[0]
+            for c in cats[1:]:
+                cat="%s,%s" % (cat, c)
+        cmd='chcon -l %s:%s %s' % (sensitivity, cat, f)
+        rc=commands.getstatusoutput(cmd)
+        if rc[0] != 0:
+            errors+=1
+    return errors
+
+def chcat_remove(orig, newcat, files):
+    errors=0
+    sensitivity=newcat[0]
+    cat=newcat[1]
+    for f in files:
+        (rc, con) = selinux.getfilecon(f)
+        (rc, raw) = selinux.selinux_trans_to_raw_context(con)
+        clist=raw.split(":")[3:]
+        if len(clist) > 1:
+            if clist[0] != sensitivity:
+                print("Can not modify sensitivity levels using '+' on %s" % f)
+                continue
+            cats=clist[1].split(",")
+            if newcat[1] not in cats:
+                print "%s is not in %s" % (f, orig)
+                continue
+            cats.remove(newcat[1])
+            if len(cats) > 0:
+                cat=cats[0]
+                for c in cats[1:]:
+                    cat="%s,%s" % (cat, c)
+            else:
+                cat=""
+        else:
+                print "%s is not in %s" % (f, orig)
+                continue
+        
+        if len(cat) == 0: 
+            cmd='chcon -l %s %s' % (sensitivity, f)
+        else:
+            cmd='chcon -l %s:%s %s' % (sensitivity, cat, f)
+        rc=commands.getstatusoutput(cmd)
+        if rc[0] != 0:
+            errors+=1
+    return errors
+
+def chcat(context, files):
+    errors=0
+    for c in context:
+        if len(c) > 0 and c[0] == "+":
+            (rc, raw) = selinux.selinux_trans_to_raw_context("a:b:c:%s" % c[1:])
+            rlist=raw.split(":")
+            if len(rlist) < 5:
+                print "%s must have a sensitivity and at least one category" % c[1:]
+                continue
+            errors += chcat_add(c[1:], rlist[3:], files)
+            continue
+        if len(c) > 0 and c[0] == "-":
+            (rc, raw) = selinux.selinux_trans_to_raw_context("a:b:c:%s" % c[1:])
+            rlist=raw.split(":")
+            if len(rlist) < 5:
+                print "%s must have a sensitivity and at least one category" % c[1:]
+                continue
+            errors += chcat_remove(c[1:], rlist[3:], files)
+            continue
+
+        cmd='chcon -l "%s"' % c
+        for f in files:
+            cmd = "%s %s" % (cmd, f)
+            
+        rc=commands.getstatusoutput(cmd)
+        if rc[0] != 0:
+            print rc[1]
+            errors += 1
+    return errors
+    
+def usage():
+	print "Usage %s CATEGORY File ..." % sys.argv[0]
+	print "Usage %s [[+|-]CATEGORY],...]q File ..." % sys.argv[0]
+	print "Usage %s -d File ..." % sys.argv[0]
+	sys.exit(1)
+
+def error(msg):
+    print "%s: %s" % (sys.argv[0], msg)
+    sys.exit(1)
+    
+if __name__ == '__main__':
+    if selinux.is_selinux_mls_enabled() != 1:
+        error("Requires a mls enabled system")
+        
+    if selinux.is_selinux_enabled() != 1:
+        error("Requires an SELinux enabled system")
+        
+    delete_ind=0
+    gopts, cmds = getopt.getopt(sys.argv[1:],
+	'dh',
+	['help',
+	    'delete'])
+
+    for o,a in gopts:
+        if o == "-h" or o == "--help":
+            usage()
+        if o == "-d" or o == "--delete":
+            delete_ind=1
+
+    if len(cmds) < 1:
+        usage()
+
+    if delete_ind:
+        sys.exit(chcat([""], cmds))
+
+    if len(cmds) < 2:
+        usage()
+    
+    cats=cmds[0].split(",")
+    set_ind=0
+    mod_ind=0
+    for i in cats:
+        if i[0]=='+' or i[0]=="-":
+            mod_ind=1
+            if set_ind == 1:
+                error("You can not use '%s' with previous categories" % i)
+        else:
+            if mod_ind == 1 or set_ind==1:
+                error("You can not use '%s' with previous categories" % i)
+            set_ind=1
+
+    files=cmds[1:]
+    sys.exit(chcat(cats, files))
+
+
diff --exclude-from=exclude -N -u -r nsapolicycoreutils/scripts/chcat.8 policycoreutils-1.27.37/scripts/chcat.8
--- nsapolicycoreutils/scripts/chcat.8	1969-12-31 19:00:00.000000000 -0500
+++ policycoreutils-1.27.37/scripts/chcat.8	2005-12-07 11:56:20.000000000 -0500
@@ -0,0 +1,29 @@
+.TH CHCAT "8" "September 2005" "chcat" "User Commands"
+.SH NAME
+chcat \- change file security category
+.SH SYNOPSIS
+.B chcat
+\fICATEGORY FILE\fR...
+.br
+.B chcat
+\fI[[+|-]CATEGORY],...]  FILE\fR...
+.br
+.B chcat
+[\fI-d\fR] \fIFILE\fR...
+.br
+.PP
+Change/Remove the security CATEGORY for each FILE.
+.PP
+Use +/- to add/remove categories from a FILE.
+.TP
+\fB\-d\fR
+delete the category from each file.
+.SH "SEE ALSO"
+.TP
+chcon(1), selinux(8)
+.PP
+.br
+This script wraps the chcon command.
+.SH "FILES"
+/etc/selinux/{SELINUXTYPE}/setrans.conf 
+
diff --exclude-from=exclude -N -u -r nsapolicycoreutils/scripts/Makefile policycoreutils-1.27.37/scripts/Makefile
--- nsapolicycoreutils/scripts/Makefile	2005-01-28 15:24:12.000000000 -0500
+++ policycoreutils-1.27.37/scripts/Makefile	2005-12-07 11:56:20.000000000 -0500
@@ -1,20 +1,23 @@
 # Installation directories.
 PREFIX ?= ${DESTDIR}/usr
-BINDIR ?= $(PREFIX)/sbin
+BINDIR ?= $(PREFIX)/bin
+SBINDIR ?= $(PREFIX)/sbin
 MANDIR ?= $(PREFIX)/share/man
 LOCALEDIR ?= /usr/share/locale
 
-TARGETS=genhomedircon
+TARGETS=genhomedircon 
 
 all: $(TARGETS) fixfiles
 
 install: all
 	-mkdir -p $(BINDIR)
-	install -m 755 $(TARGETS) $(BINDIR)
+	install -m 755 $(TARGETS) $(SBINDIR)
+	install -m 755 chcat $(BINDIR)
 	install -m 755 fixfiles $(DESTDIR)/sbin
 	-mkdir -p $(MANDIR)/man8
 	install -m 644 fixfiles.8 $(MANDIR)/man8/
 	install -m 644 genhomedircon.8 $(MANDIR)/man8/
+	install -m 644 chcat.8 $(MANDIR)/man8/
 
 clean:
 

--------------020904030107040901010901--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
