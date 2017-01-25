Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v0PKkcq5013097
 for <selinux@tycho.nsa.gov>; Wed, 25 Jan 2017 15:46:38 -0500
From: Lokesh Mandvekar <lsm5@fedoraproject.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH] libselinux: selinux_restorecon.3 man page typo fix
Date: Wed, 25 Jan 2017 15:46:35 -0500
Message-Id: <20170125204635.13443-1-lsm5@fedoraproject.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Signed-off-by: Lokesh Mandvekar <lsm5@fedoraproject.org>
---
 libselinux/man/man3/selinux_restorecon.3 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libselinux/man/man3/selinux_restorecon.3 b/libselinux/man/man3/selinux_restorecon.3
index 2d8274b..d698818 100644
--- a/libselinux/man/man3/selinux_restorecon.3
+++ b/libselinux/man/man3/selinux_restorecon.3
@@ -26,7 +26,7 @@ containing a directory or file to be relabeled.
 If this is a directory and the
 .IR restorecon_flags
 .B SELINUX_RESTORECON_RECURSE
-has been set (for decending through directories), then
+has been set (for descending through directories), then
 .BR selinux_restorecon ()
 will write an SHA1 digest of the combined specfiles (see the
 .B NOTES
-- 
2.9.3
