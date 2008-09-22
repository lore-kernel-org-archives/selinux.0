Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m8MHq9O8023248
	for <selinux@tycho.nsa.gov>; Mon, 22 Sep 2008 13:52:09 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m8MHq90N003320
	for <selinux@tycho.nsa.gov>; Mon, 22 Sep 2008 17:52:09 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m8MHq9we015574
	for <selinux@tycho.nsa.gov>; Mon, 22 Sep 2008 13:52:09 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [10.16.255.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m8MHq8pj011898
	for <selinux@tycho.nsa.gov>; Mon, 22 Sep 2008 13:52:08 -0400
Received: from localhost.localdomain (redsox.boston.devel.redhat.com [10.16.60.53])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id m8MHq8ut025806
	for <selinux@tycho.nsa.gov>; Mon, 22 Sep 2008 13:52:08 -0400
Message-ID: <48D7DB4D.8020806@redhat.com>
Date: Mon, 22 Sep 2008 13:52:13 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Man page fixes for libselinux.
Content-Type: multipart/mixed;
 boundary="------------060306060000060301010707"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060306060000060301010707
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


--------------060306060000060301010707
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/fgetfilecon.3 libselinux-2.0.71/man/man3/fgetfilecon.3
--- nsalibselinux/man/man3/fgetfilecon.3	1969-12-31 19:00:00.000000000 -0500
+++ libselinux-2.0.71/man/man3/fgetfilecon.3	2008-09-22 13:25:36.000000000 -0400
@@ -0,0 +1 @@
+.so man3/getfilecon.3
diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/getkeycreatecon.3 libselinux-2.0.71/man/man3/getkeycreatecon.3
--- nsalibselinux/man/man3/getkeycreatecon.3	1969-12-31 19:00:00.000000000 -0500
+++ libselinux-2.0.71/man/man3/getkeycreatecon.3	2008-09-22 13:25:36.000000000 -0400
@@ -0,0 +1,38 @@
+.TH "getkeycreatecon" "3" "9 September 2008" "dwalsh@redhat.com from russell@coker.com.au" "SELinux API documentation"
+.SH "NAME"
+getkeycreatecon, setkeycreatecon \- get or set the SELinux security context used for creating a new kernel keyrings.
+
+.SH "SYNOPSIS"
+.B #include <selinux/selinux.h>
+.sp
+.BI "int getkeycreatecon(security_context_t *" con );
+
+.BI "int setkeycreatecon(security_context_t "context );
+
+.SH "DESCRIPTION"
+.B getkeycreatecon
+retrieves the context used for creating a new kernel keyring.
+This returned context should be freed with freecon if non-NULL.  
+getkeycreatecon sets *con to NULL if no keycreate context has been explicitly 
+set by the program (i.e. using the default policy behavior).
+
+.B setkeycreatecon
+sets the context used for creating a new kernel keyring.
+NULL can be passed to
+setkeycreatecon to reset to the default policy behavior.  
+The keycreate context is automatically reset after the next execve, so a
+program doesn't need to explicitly sanitize it upon startup.  
+
+setkeycreatecon can be applied prior to library
+functions that internally perform an file creation,
+in order to set an file context on the objects.
+
+
+Note: Signal handlers that perform an setkeycreate must take care to
+save, reset, and restore the keycreate context to avoid unexpected behavior.
+.SH "RETURN VALUE"
+On error -1 is returned.
+On success 0 is returned.
+
+.SH "SEE ALSO"
+.BR selinux "(8), " freecon "(3), " getcon "(3), " getexeccon "(3)"
diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/lgetfilecon.3 libselinux-2.0.71/man/man3/lgetfilecon.3
--- nsalibselinux/man/man3/lgetfilecon.3	1969-12-31 19:00:00.000000000 -0500
+++ libselinux-2.0.71/man/man3/lgetfilecon.3	2008-09-22 13:25:36.000000000 -0400
@@ -0,0 +1 @@
+.so man3/getfilecon.3
diff --exclude-from=exclude -N -u -r nsalibselinux/man/man3/setkeycreatecon.3 libselinux-2.0.71/man/man3/setkeycreatecon.3
--- nsalibselinux/man/man3/setkeycreatecon.3	1969-12-31 19:00:00.000000000 -0500
+++ libselinux-2.0.71/man/man3/setkeycreatecon.3	2008-09-22 13:25:36.000000000 -0400
@@ -0,0 +1 @@
+.so man3/getkeycreatecon.3

--------------060306060000060301010707
Content-Type: application/octet-stream;
 name="diff.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="diff.sig"

iEYEABECAAYFAkjX200ACgkQrlYvE4MpobOz3wCfV5e8uk1kKJRUaMvW1MkSDjfdsxoAoNCL
6LVO7J+RCgOBu0MZCf+uzdPa
--------------060306060000060301010707--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
