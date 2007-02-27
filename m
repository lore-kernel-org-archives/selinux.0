Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1REE3sZ023409
	for <selinux@tycho.nsa.gov>; Tue, 27 Feb 2007 09:14:03 -0500
Received: from web51505.mail.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l1REFPc4008797
	for <selinux@tycho.nsa.gov>; Tue, 27 Feb 2007 14:15:25 GMT
Date: Tue, 27 Feb 2007 06:15:25 -0800 (PST)
From: Steve G <linux_4ever@yahoo.com>
Subject: [PATCH] restorecond init cleanup
To: SE Linux <selinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1361539293-1172585725=:14975"
Message-ID: <587425.14975.qm@web51505.mail.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0-1361539293-1172585725=:14975
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Hi,

The following patch changes restorecond to follow LSB return codes and most
importantly, start after the audit daemon so that anything it changes gets
recorded.

Signed-off-by: Steve Grubb <linux_4ever@yahoo.com>


 
____________________________________________________________________________________
Never Miss an Email
Stay connected with Yahoo! Mail on your mobile.  Get started!
http://mobile.yahoo.com/services?promote=mail
--0-1361539293-1172585725=:14975
Content-Type: text/x-patch; name="policycoreutils-2.0.6-restorecond.patch"
Content-Description: 3986159082-policycoreutils-2.0.6-restorecond.patch
Content-Disposition: inline; filename="policycoreutils-2.0.6-restorecond.patch"

diff -ur policycoreutils-2.0.6.orig/restorecond/restorecond.init policycoreutils-2.0.6/restorecond/restorecond.init
--- policycoreutils-2.0.6.orig/restorecond/restorecond.init	2007-02-27 08:42:20.000000000 -0500
+++ policycoreutils-2.0.6/restorecond/restorecond.init	2007-02-27 08:58:31.000000000 -0500
@@ -1,43 +1,68 @@
 #!/bin/sh
 #
-# restorecond:		Daemo used to maintain path file context
+# restorecond:		Daemon used to maintain path file context
 #
-# chkconfig:	2345 10 90
+# chkconfig:	2345 12 87
 # description:	restorecond uses inotify to look for creation of new files \
 # listed in the /etc/selinux/restorecond.conf file, and restores the \
 # correct security context.
 #
+# processname: /usr/sbin/restorecond
+# config: /etc/selinux/restorecond.conf 
+# pidfile: /var/run/restorecond.pid
+#
+# Return values according to LSB for all commands but status:
+# 0 - success
+# 1 - generic or unspecified error
+# 2 - invalid or excess argument(s)
+# 3 - unimplemented feature (e.g. "reload")
+# 4 - insufficient privilege
+# 5 - program is not installed
+# 6 - program is not configured
+# 7 - program is not running
+
+PATH=/sbin:/bin:/usr/bin:/usr/sbin
 
 # Source function library.
 . /etc/rc.d/init.d/functions
 
 [ -x /usr/sbin/selinuxenabled ] && /usr/sbin/selinuxenabled || exit 0
 
+# Check that we are root ... so non-root users stop here
+test $EUID = 0  || exit 4
+
+test -x /usr/sbin/restorecond  || exit 5
+test -f /etc/selinux/restorecond.conf  || exit 6
+
+RETVAL=0
+
 start() 
 {
         echo -n $"Starting restorecond: "
+	unset HOME MAIL USER USERNAME
         daemon /usr/sbin/restorecond 
-
+	RETVAL=$?
 	touch /var/lock/subsys/restorecond
         echo
+	return $RETVAL
 }
 
 stop() 
 {
         echo -n $"Shutting down restorecond: "
 	killproc restorecond
-
+	RETVAL=$?
 	rm -f  /var/lock/subsys/restorecond
         echo
+	return $RETVAL
 }
+
 restart() 
 {
     stop
     start
 }
 
-[ -f /usr/sbin/restorecond ] || exit 0
-
 # See how we were called.
 case "$1" in
   start)
@@ -57,7 +82,8 @@
 	;;
   *)
         echo $"Usage: $0 {start|stop|restart|reload|condrestart}"
-        exit 1
+        RETVAL=3
 esac
 
-exit 0
+exit $RETVAL
+

--0-1361539293-1172585725=:14975--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
