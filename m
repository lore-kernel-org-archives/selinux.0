Message-ID: <4787DD8E.1040502@redhat.com>
Date: Fri, 11 Jan 2008 16:20:14 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Fixes for policycoreutils scripts
Content-Type: multipart/mixed;
 boundary="------------020908000103020601090107"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020908000103020601090107
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Remove python hack to handle lanquage translations on errors.  Python
works properly now.

Fix fixfiles to handle multiple inputs on the command line correctly


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkeH3Y0ACgkQrlYvE4MpobO5HwCg6xLhCuOPYY0NBIVa8XCa/rYN
+t8An3eqHjDNSsGhN9hAEoULsyiWkAqo
=Oasn
-----END PGP SIGNATURE-----

--------------020908000103020601090107
Content-Type: text/plain;
 name="policycoreutils-scripts.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policycoreutils-scripts.patch"

--- nsapolicycoreutils/scripts/chcat	2007-08-23 16:52:26.000000000 -0400
+++ policycoreutils-2.0.35/scripts/chcat	2008-01-11 11:17:46.000000000 -0500
@@ -25,10 +25,6 @@
 import commands, sys, os, pwd, string, getopt, selinux
 import seobject
 import gettext
-import codecs
-import locale
-sys.stderr = codecs.getwriter(locale.getpreferredencoding())(sys.__stderr__, 'replace')
-sys.stdout = codecs.getwriter(locale.getpreferredencoding())(sys.__stdout__, 'replace')
 
 try:
     gettext.install('policycoreutils')
--- nsapolicycoreutils/scripts/fixfiles	2007-12-10 21:42:28.000000000 -0500
+++ policycoreutils-2.0.35/scripts/fixfiles	2008-01-11 11:17:46.000000000 -0500
@@ -126,17 +126,15 @@
     done
     exit $?
 fi
-if [ ! -z "$DIRS" ]; then
+if [ ! -z "$FILEPATH" ]; then
     if [ -x /usr/bin/find ]; then
-	for d in ${DIRS} ; do find $d \
+	/usr/bin/find "$FILEPATH" \
 	    ! \( -fstype ext2 -o -fstype ext3 -o -fstype jfs -o -fstype xfs \) -prune  -o -print | \
 	    ${RESTORECON} ${OUTFILES} ${FORCEFLAG} $* -f - 2>&1 >> $LOGFILE
-	done
     else
-	${RESTORECON} ${OUTFILES} ${FORCEFLAG} -R $* $DIRS 2>&1 >> $LOGFILE
+	${RESTORECON} ${OUTFILES} ${FORCEFLAG} -R $* $FILEPATH 2>&1 >> $LOGFILE
     fi
-
-    exit $?
+    return
 fi
 LogReadOnly
 ${SETFILES} -q ${OUTFILES} ${SYSLOGFLAG} ${FORCEFLAG} $* ${FC} ${FILESYSTEMSRW} 2>&1 >> $LOGFILE
@@ -173,6 +171,20 @@
     fi
 }
 
+process() {
+#
+# Make sure they specified one of the three valid commands
+#
+case "$1" in
+    restore) restore -p ;;
+    check) restore -n -v;;
+    verify) restore -n -o -;;
+    relabel) relabel;;
+    *)
+    usage
+    exit 1
+esac
+}
 usage() {
       	echo $"Usage: $0 [-l logfile ] [-o outputfile ] { check | restore|[-F] relabel } [[dir] ... ] "
 	echo or
@@ -229,22 +241,19 @@
 
 shift 1
 if [ ! -z "$RPMFILES" ]; then
+    process $command
     if [ $# -gt 0 ]; then
 	    usage
     fi
 else
-    DIRS=$*
+    if [ -z "$1" ]; then
+	process $command
+    else
+	while [ -n "$1" ]; do 
+	    FILEPATH=$1
+	    process $command 
+	    shift
+    	done
+    fi
 fi
-
-#
-# Make sure they specified one of the three valid commands
-#
-case "$command" in
-    restore) restore -p ;;
-    check) restore -n -v ;;
-    verify) restore -n -o -;;
-    relabel) relabel;;
-    *)
-    usage
-    exit 1
-esac
+exit $?
--- nsapolicycoreutils/semanage/semanage	2007-10-05 13:09:53.000000000 -0400
+++ policycoreutils-2.0.35/semanage/semanage	2008-01-11 11:17:46.000000000 -0500
@@ -1,5 +1,5 @@
 #! /usr/bin/python -E
-# Copyright (C) 2005 Red Hat 
+# Copyright (C) 2005, 2006, 2007 Red Hat 
 # see file 'COPYING' for use and warranty information
 #
 # semanage is a tool for managing SELinux configuration files
@@ -28,10 +28,6 @@
 import gettext
 gettext.bindtextdomain(PROGNAME, "/usr/share/locale")
 gettext.textdomain(PROGNAME)
-import codecs
-import locale
-sys.stderr = codecs.getwriter(locale.getpreferredencoding())(sys.__stderr__, 'replace')
-sys.stdout = codecs.getwriter(locale.getpreferredencoding())(sys.__stdout__, 'replace')
 
 try:
        gettext.install(PROGNAME,

--------------020908000103020601090107
Content-Type: application/octet-stream;
 name="policycoreutils-scripts.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="policycoreutils-scripts.patch.sig"

iEYEABECAAYFAkeH3Y0ACgkQrlYvE4MpobPnlgCfXEOjiVphPeYM3fesqNZ4E5UNVLgAn1+6
pglLf9dUvXvSgnNUxEO7aC0a
--------------020908000103020601090107--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
