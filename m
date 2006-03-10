Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k2AGDsR5017497
	for <selinux@tycho.nsa.gov>; Fri, 10 Mar 2006 11:13:58 -0500
Received: from tcsfw4.tcs-sec.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k2AGDq59005467
	for <selinux@tycho.nsa.gov>; Fri, 10 Mar 2006 16:13:52 GMT
Received: (from smmsp@localhost)
	by tcsfw4.tcs-sec.com (8.12.2/8.12.2) id k2AGDlIj013725
	for <selinux@tycho.nsa.gov>; Fri, 10 Mar 2006 11:13:47 -0500 (EST)
Date: Fri, 10 Mar 2006 10:13:34 -0600
From: Chad Hanson <chanson@TrustedCS.com>
To: SELinux List <selinux@tycho.nsa.gov>
Subject: [PATCH] initscripts - restorecon of /dev/pts
Message-ID: <20060310161334.GA2949@dhcp-225.il.tcs-sec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


There has been a recurring of problem of /dev/pts being labeled incorrectly.
This is noted in the thread below:
 
http://marc.theaimsgroup.com/?l=selinux&m=112419712132326&w=2

TCS previously submitted a restorecon patch for the initscripts below:

http://marc.theaimsgroup.com/?l=selinux&m=113155285804603&w=2

I have a patch below which can be applied to initscripts-8.29-1 to fix the
problem of /dev/pts being labeled SystemHigh.

-Chad


--- rc.sysinit.orig	2006-03-09 23:46:29.000000000 +0000
+++ rc.sysinit	2006-03-10 01:10:19.000000000 +0000
@@ -182,6 +182,8 @@
 # may have to do this again after mounting
 RHGB_STARTED=0
 mount -n /dev/pts >/dev/null 2>&1
+# restore MLS range of /dev/pts
+[ -n "$SELINUX" ] && restorecon /dev/pts
 
 if strstr "$cmdline" rhgb && ! strstr "$cmdline" early-login && [ "$BOOTUP" = "color" -a "$GRAPHICAL" = "yes" -a -x /usr/bin/rhgb ]; then
    LC_MESSAGES= /usr/bin/rhgb


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
