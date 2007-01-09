Message-ID: <45A3B265.2010508@redhat.com>
Date: Tue, 09 Jan 2007 10:19:01 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Fixfiles patch for creating logfile fixed.
Content-Type: multipart/mixed;
 boundary="------------080008050603000802030204"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080008050603000802030204
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------080008050603000802030204
Content-Type: text/x-patch;
 name="policycoreutils-fixfiles.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="policycoreutils-fixfiles.patch"

--- nsapolicycoreutils/scripts/fixfiles	2006-11-16 17:14:27.000000000 -0500
+++ policycoreutils-1.33.10/scripts/fixfiles	2007-01-09 10:09:19.000000000 -0500
@@ -29,6 +29,9 @@
 RPMILES=""
 OUTFILES=""
 LOGFILE=`tty`
+if [ $? != 0 ]; then
+    LOGFILE="/dev/null"
+fi
 SYSLOGFLAG="-l"
 LOGGER=/usr/sbin/logger
 SETFILES=/sbin/setfiles

--------------080008050603000802030204--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
