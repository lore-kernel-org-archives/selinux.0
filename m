Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id qAKHtXoj019371
	for <selinux@tycho.nsa.gov>; Tue, 20 Nov 2012 12:55:34 -0500
Received: from gaara.hadrons.org (85.137.229.25) by resmaa12.ono.com (8.6.048.02) (authenticated as guillemj@ono.com)
        id 5052D7630150E78B for selinux@tycho.nsa.gov; Tue, 20 Nov 2012 15:31:56 +0100
Received: from guillem by gaara.hadrons.org with local (Exim 4.80)
	(envelope-from <guillemj@ono.com>)
	id 1TantJ-00022M-MS
	for selinux@tycho.nsa.gov; Tue, 20 Nov 2012 14:29:29 +0100
From: Guillem Jover <guillem@debian.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 3/4] libselinux: Fix typo in man page
Date: Tue, 20 Nov 2012 14:25:29 +0100
Message-Id: <1353417930-7707-4-git-send-email-guillem@debian.org>
In-Reply-To: <1353417930-7707-1-git-send-email-guillem@debian.org>
References: <1353417930-7707-1-git-send-email-guillem@debian.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Signed-off-by: Guillem Jover <guillem@debian.org>
---
 libselinux/man/man3/selinux_status_open.3 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libselinux/man/man3/selinux_status_open.3 b/libselinux/man/man3/selinux_status_open.3
index 014314e..f779dd9 100644
--- a/libselinux/man/man3/selinux_status_open.3
+++ b/libselinux/man/man3/selinux_status_open.3
@@ -27,7 +27,7 @@ placed on
 entry. It enables userspace applications to mmap this page with read-only
 mode, then it informs some status without system call invocations.
 .sp
-In some cases that a userspace application tries to apply heavy frequest
+In some cases that a userspace application tries to apply heavy frequent
 access control; such as row-level security in databases, it will face
 unignorable cost to communicate with kernel space to check invalidation
 of userspace avc.
-- 
1.8.0


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
