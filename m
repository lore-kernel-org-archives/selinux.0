Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u2PDgV3V003603
 for <selinux@tycho.nsa.gov>; Fri, 25 Mar 2016 09:42:31 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
 (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
 by mx1.redhat.com (Postfix) with ESMTPS id 01FBD3B716
 for <selinux@tycho.nsa.gov>; Fri, 25 Mar 2016 13:42:27 +0000 (UTC)
Received: from dhcp-10-19-62-196.boston.devel.redhat.com
 (vpn-232-132.phx2.redhat.com [10.3.232.132])
 by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id
 u2PDgQr7004824
 for <selinux@tycho.nsa.gov>; Fri, 25 Mar 2016 09:42:27 -0400
To: SELinux <selinux@tycho.nsa.gov>
From: Daniel J Walsh <dwalsh@redhat.com>
Subject: Just sent a small patch to github to fix the selinuxfs man pages.
Message-ID: <56F54042.9090506@redhat.com>
Date: Fri, 25 Mar 2016 09:42:26 -0400
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020607010708040308050000"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is a multi-part message in MIME format.
--------------020607010708040308050000
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

A few man pages still refer to selinuxfs being mounted at /selinux, I 
changed these references to /sys/fs/selinux

--------------020607010708040308050000
Content-Type: text/x-patch;
 name="0001-Fix-location-of-selinuxfs-mount-point.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-Fix-location-of-selinuxfs-mount-point.patch"

>From d600fbf110bd73a57ff5a6a99e0f14eaac4483a4 Mon Sep 17 00:00:00 2001
From: Dan Walsh <dwalsh@redhat.com>
Date: Fri, 25 Mar 2016 09:29:32 -0400
Subject: [PATCH] Fix location of selinuxfs  mount point

---
 libselinux/man/man3/security_disable.3    | 2 +-
 libselinux/man/man3/selinux_status_open.3 | 4 ++--
 libselinux/man/man8/avcstat.8             | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/libselinux/man/man3/security_disable.3 b/libselinux/man/man3/security_disable.3
index c75ce0d..072923c 100644
--- a/libselinux/man/man3/security_disable.3
+++ b/libselinux/man/man3/security_disable.3
@@ -12,7 +12,7 @@ security_disable \- disable the SELinux kernel code at runtime
 disables the SELinux kernel code, unregisters selinuxfs from
 .IR /proc/filesystems ,
 and then unmounts
-.IR /selinux .
+.IR /sys/fs/selinux .
 .sp
 This function can only be called at runtime and prior to the initial policy
 load. After the initial policy load, the SELinux kernel code cannot be disabled,
diff --git a/libselinux/man/man3/selinux_status_open.3 b/libselinux/man/man3/selinux_status_open.3
index f779dd9..2d44be5 100644
--- a/libselinux/man/man3/selinux_status_open.3
+++ b/libselinux/man/man3/selinux_status_open.3
@@ -23,7 +23,7 @@ without invocation of system calls
 .SH "DESCRIPTION"
 Linux 2.6.37 or later provides a SELinux kernel status page; being mostly
 placed on
-.I /selinux/status
+.I /sys/fs/selinux/status
 entry. It enables userspace applications to mmap this page with read-only
 mode, then it informs some status without system call invocations.
 .sp
@@ -38,7 +38,7 @@ without system-call invocation or worker thread for monitoring.
 .BR selinux_status_open ()
 tries to
 .BR open (2)
-.I /selinux/status
+.I /sys/fs/selinux/status
 and
 .BR mmap (2)
 it in read-only mode. The file-descriptor and pointer to the page shall
diff --git a/libselinux/man/man8/avcstat.8 b/libselinux/man/man8/avcstat.8
index 204687d..2c4bce1 100644
--- a/libselinux/man/man8/avcstat.8
+++ b/libselinux/man/man8/avcstat.8
@@ -25,7 +25,7 @@ Display the cumulative values.
 .TP
 .B \-f
 Specifies the location of the AVC statistics file, defaulting to
-.IR /selinux/avc/cache_stats .
+.IR /sys/fs/selinux/avc/cache_stats .
 .
 .SH AUTHOR
 This manual page was written by Dan Walsh <dwalsh@redhat.com>.
-- 
2.7.3


--------------020607010708040308050000--
