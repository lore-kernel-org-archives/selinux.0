Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id qAKHrsrq019131
	for <selinux@tycho.nsa.gov>; Tue, 20 Nov 2012 12:53:54 -0500
Received: from gaara.hadrons.org (85.137.229.25) by resmaa12.ono.com (8.6.048.02) (authenticated as guillemj@ono.com)
        id 5052D7630150E784 for selinux@tycho.nsa.gov; Tue, 20 Nov 2012 15:31:56 +0100
Received: from guillem by gaara.hadrons.org with local (Exim 4.80)
	(envelope-from <guillemj@ono.com>)
	id 1TanxO-00023i-8y
	for selinux@tycho.nsa.gov; Tue, 20 Nov 2012 14:33:42 +0100
From: Guillem Jover <guillem@debian.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH] libselinux: Use ENOTSUP instead of EOPNOTSUPP for getfilecon functions
Date: Tue, 20 Nov 2012 14:33:35 +0100
Message-Id: <1353418415-7884-1-git-send-email-guillem@debian.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

EOPNOTSUPP means "operation not supoorted on socket", and ENOTSUP means
"not supported", although per POSIX they can be alised to the same
value and on Linux they do, ENOTSUP seems the more correct error code.
In addition these functions are documented as returning ENOTSUP, and
given that they are implemented in means of getxattr(2) which does
return ENOTSUP too, this just consolidates their behaviour.

Signed-off-by: Guillem Jover <guillem@debian.org>
---
 libselinux/src/fgetfilecon.c | 2 +-
 libselinux/src/getfilecon.c  | 2 +-
 libselinux/src/lgetfilecon.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/libselinux/src/fgetfilecon.c b/libselinux/src/fgetfilecon.c
index c88d515..3395c9f 100644
--- a/libselinux/src/fgetfilecon.c
+++ b/libselinux/src/fgetfilecon.c
@@ -39,7 +39,7 @@ int fgetfilecon_raw(int fd, security_context_t * context)
       out:
 	if (ret == 0) {
 		/* Re-map empty attribute values to errors. */
-		errno = EOPNOTSUPP;
+		errno = ENOTSUP;
 		ret = -1;
 	}
 	if (ret < 0)
diff --git a/libselinux/src/getfilecon.c b/libselinux/src/getfilecon.c
index 67e4463..eb2ce8a 100644
--- a/libselinux/src/getfilecon.c
+++ b/libselinux/src/getfilecon.c
@@ -39,7 +39,7 @@ int getfilecon_raw(const char *path, security_context_t * context)
       out:
 	if (ret == 0) {
 		/* Re-map empty attribute values to errors. */
-		errno = EOPNOTSUPP;
+		errno = ENOTSUP;
 		ret = -1;
 	}
 	if (ret < 0)
diff --git a/libselinux/src/lgetfilecon.c b/libselinux/src/lgetfilecon.c
index a53f56e..58dc807 100644
--- a/libselinux/src/lgetfilecon.c
+++ b/libselinux/src/lgetfilecon.c
@@ -39,7 +39,7 @@ int lgetfilecon_raw(const char *path, security_context_t * context)
       out:
 	if (ret == 0) {
 		/* Re-map empty attribute values to errors. */
-		errno = EOPNOTSUPP;
+		errno = ENOTSUP;
 		ret = -1;
 	}
 	if (ret < 0)
-- 
1.8.0


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
