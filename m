Message-ID: <461F7D36.2070602@redhat.com>
Date: Fri, 13 Apr 2007 08:53:10 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: [Fwd: policycoreutils patches]
Content-Type: multipart/mixed;
 boundary="------------030303040608080502070809"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030303040608080502070809
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Moved audit2allow to sbin to match audit2why.

Fix chcat to handle case where there are no categories.

Change fixfiles to run setfiles in quiet mode

Change genhomedircon to verify context before setting homedir file
context. This can happen if you have different user types, where one
type has a homedir file context while another one does not.

restorecond init script does not return status properly

Fix output of restorecon.c errors to show correct error message.




--------------030303040608080502070809
Content-Type: text/x-patch;
 name="audit2allow.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="audit2allow.patch"

--- nsapolicycoreutils/audit2allow/Makefile	2007-02-07 12:11:49.000000000 -0500
+++ policycoreutils-2.0.7/audit2allow/Makefile	2007-03-23 09:03:56.000000000 -0400
@@ -1,6 +1,6 @@
 # Installation directories.
 PREFIX ?= ${DESTDIR}/usr
-BINDIR ?= $(PREFIX)/bin
+BINDIR ?= $(PREFIX)/sbin
 LIBDIR ?= $(PREFIX)/lib
 MANDIR ?= $(PREFIX)/share/man
 LOCALEDIR ?= /usr/share/locale


--------------030303040608080502070809
Content-Type: text/x-patch;
 name="chcat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="chcat.patch"

--- nsapolicycoreutils/scripts/chcat	2007-02-22 08:53:22.000000000 -0500
+++ policycoreutils-2.0.7/scripts/chcat	2007-03-23 09:03:56.000000000 -0400
@@ -74,9 +74,11 @@
             if i not in cats:
                 cats.append(i)
 
-        new_serange = "%s-%s:%s" % (serange[0], top[0], string.join(cats, ","))
-        if new_serange[-1:] == ":":
-            new_serange = new_serange[:-1]
+            
+        if len(cats) > 0:
+            new_serange = "%s-%s:%s" % (serange[0], top[0], ",".join(cats))
+        else
+            new_serange = "%s-%s" % (serange[0], top[0])
             
         if add_ind:
             cmd = "semanage login -a -r %s -s %s %s" % (new_serange, user[0], u)
@@ -151,10 +153,11 @@
             if i in cats:
                 cats.remove(i)
 
-        new_serange = "%s-%s:%s" % (serange[0], top[0], string.join(cats, ","))
-        if new_serange[-1:] == ":":
-            new_serange = new_serange[:-1]
-        
+        if len(cats) > 0:
+            new_serange = "%s-%s:%s" % (serange[0], top[0], ",".join(cats))
+        else
+            new_serange = "%s-%s" % (serange[0], top[0])
+            
         if add_ind:
             cmd = "semanage login -a -r %s -s %s %s" % (new_serange, user[0], u)
         else:


--------------030303040608080502070809
Content-Type: text/x-patch;
 name="fixfiles.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fixfiles.patch"

--- nsapolicycoreutils/scripts/fixfiles	2007-01-11 08:56:30.000000000 -0500
+++ policycoreutils-2.0.7/scripts/fixfiles	2007-03-23 14:24:15.000000000 -0400
@@ -138,7 +138,7 @@
     exit $?
 fi
 LogReadOnly
-${SETFILES} ${OUTFILES} ${SYSLOGFLAG} ${FORCEFLAG} $* ${FC} ${FILESYSTEMSRW} 2>&1 >> $LOGFILE
+${SETFILES} -q ${OUTFILES} ${SYSLOGFLAG} ${FORCEFLAG} $* ${FC} ${FILESYSTEMSRW} 2>&1 >> $LOGFILE
 exit $?
 }
 


--------------030303040608080502070809
Content-Type: text/x-patch;
 name="genhomedircon.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="genhomedircon.patch"

--- nsapolicycoreutils/scripts/genhomedircon	2006-11-28 09:24:33.000000000 -0500
+++ policycoreutils-2.0.7/scripts/genhomedircon	2007-04-09 15:44:47.000000000 -0400
@@ -26,6 +26,7 @@
 
 import sys, os, pwd, string, getopt, re
 from semanage import *;
+import selinux
 import gettext
 gettext.install('policycoreutils')
 
@@ -249,7 +250,10 @@
 				i = i.replace("HOME_DIR", home)
 				i = i.replace("ROLE", prefix)
 				i = i.replace("system_u", seuser)
-				ret = ret+i
+				# Validate if the generated context exists.  Some user types may not exist
+				scon = i.split()[-1]
+				if selinux.security_check_context(scon) == 0:
+					ret = ret+i
 		fd.close()
 		return ret


--------------030303040608080502070809
Content-Type: text/x-patch;
 name="restorecon.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="restorecon.patch"

--- nsapolicycoreutils/restorecon/restorecon.c	2006-11-16 17:14:26.000000000 -0500
+++ policycoreutils-2.0.7/restorecon/restorecon.c	2007-03-23 09:03:56.000000000 -0400
@@ -336,8 +336,8 @@
 				if (!file_exist && errno == ENOENT)
 					return;
 				fprintf(stderr,
-					"%s:  error while labeling files under %s\n",
-					progname, buf);
+					"%s: %s: %s\n",
+					progname, buf, strerror(errno));
 				errors++;
 			}
 		}


--------------030303040608080502070809
Content-Type: text/x-patch;
 name="restorecond.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="restorecond.patch"

--- nsapolicycoreutils/restorecond/restorecond.init	2007-03-01 17:23:40.000000000 -0500
+++ policycoreutils-2.0.7/restorecond/restorecond.init	2007-03-23 09:03:56.000000000 -0400
@@ -73,6 +73,7 @@
         ;;
   status)
 	status restorecond
+	RETVAL=$?
 	;;
   restart|reload)
 	restart


--------------030303040608080502070809--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
