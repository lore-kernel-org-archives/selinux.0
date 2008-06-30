Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5UG5Wh3018129
	for <selinux@tycho.nsa.gov>; Mon, 30 Jun 2008 12:05:32 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m5UG5VXd006259
	for <selinux@tycho.nsa.gov>; Mon, 30 Jun 2008 16:05:32 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m5UG5VMP030793
	for <selinux@tycho.nsa.gov>; Mon, 30 Jun 2008 12:05:31 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [10.16.255.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m5UG5VdX015496
	for <selinux@tycho.nsa.gov>; Mon, 30 Jun 2008 12:05:31 -0400
Received: from localhost.localdomain (dhcp-10-16-61-233.boston.devel.redhat.com [10.16.61.233])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id m5UG5UnY000917
	for <selinux@tycho.nsa.gov>; Mon, 30 Jun 2008 12:05:30 -0400
Message-ID: <4869044A.3070109@redhat.com>
Date: Mon, 30 Jun 2008 12:05:30 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: fixfiles patch
Content-Type: multipart/mixed;
 boundary="------------060006030102090106080208"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060006030102090106080208
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

This patch adds a function onboot

which creates the /.autorelabel file

It also removes tmp files that map directly to a user.  This fixes the
problem where a user login gets created with the wrong context in /tmp
and then can not login, even after a relabel.

--------------060006030102090106080208
Content-Type: text/plain;
 name="fixfiles.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fixfiles.patch"

--- nsapolicycoreutils/scripts/fixfiles	2008-06-12 23:25:21.000000000 -0400
+++ policycoreutils-2.0.50/scripts/fixfiles	2008-06-30 11:49:38.000000000 -0400
@@ -138,6 +138,9 @@
 fi
 LogReadOnly
 ${SETFILES} -q ${OUTFILES} ${SYSLOGFLAG} ${FORCEFLAG} $* ${FC} ${FILESYSTEMSRW} 2>&1 >> $LOGFILE
+rm -rf /tmp/gconfd-* /tmp/pulse-* /tmp/orbit-*
+find /tmp -context "*:file_t*" -exec chcon -t tmp_t {} \;
+find /var/tmp -context "*:file_t*" -exec chcon -t tmp_t {} \;
 exit $?
 }
 
@@ -180,6 +183,10 @@
     check) restore -n -v;;
     verify) restore -n -o -;;
     relabel) relabel;;
+    onboot)
+	touch /.autorelabel
+	echo "System will relabel on next boot"
+	;;
     *)
     usage
     exit 1
@@ -189,6 +196,7 @@
       	echo $"Usage: $0 [-l logfile ] [-o outputfile ] { check | restore|[-F] relabel } [[dir] ... ] "
 	echo or
       	echo $"Usage: $0 -R rpmpackage[,rpmpackage...] -C PREVIOUS_FILECONTEXT [-l logfile ] [-o outputfile ] { check | restore }"
+      	echo $"Usage: $0 onboot"
 }
 
 if [ $# = 0 ]; then
--- nsapolicycoreutils/scripts/fixfiles.8	2008-06-12 23:25:21.000000000 -0400
+++ policycoreutils-2.0.50/scripts/fixfiles.8	2008-06-30 11:49:38.000000000 -0400
@@ -7,6 +7,8 @@
 
 .B fixfiles [-F] [-l logfile ] [-o outputfile ] { check | restore|[-f] relabel | verify } [[dir/file] ... ] 
 
+.B fixfiles onboot
+
 .SH "DESCRIPTION"
 This manual page describes the
 .BR fixfiles
@@ -20,6 +22,9 @@
 as you expect.  By default it will relabel all mounted ext2, ext3, xfs and 
 jfs file systems as long as they do not have a security context mount 
 option.  You can use the -R flag to use rpmpackages as an alternative.
+.P
+.B fixfiles onboot 
+will setup the machine to relabel on the next reboot.
 
 .SH "OPTIONS"
 .TP 

--------------060006030102090106080208--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
