Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v4UDRDbc002629
 for <selinux@tycho.nsa.gov>; Tue, 30 May 2017 09:27:13 -0400
From: Dan Jurgens <danielj@mellanox.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, Daniel Jurgens <danielj@mellanox.com>
Subject: [PATCH 1/1] semanage: Fix manpage author for ibpkey and ibendport
 pages.
Date: Tue, 30 May 2017 16:26:41 +0300
Message-Id: <1496150801-99207-1-git-send-email-danielj@mellanox.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Daniel Jurgens <danielj@mellanox.com>

Signed-off-by: Daniel Jurgens <danielj@mellanox.com>
---
 python/semanage/semanage-ibendport.8 | 2 +-
 python/semanage/semanage-ibpkey.8    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/python/semanage/semanage-ibendport.8 b/python/semanage/semanage-ibendport.8
index c3753a27..0a29eae1 100644
--- a/python/semanage/semanage-ibendport.8
+++ b/python/semanage/semanage-ibendport.8
@@ -63,4 +63,4 @@ Label mlx4_0 port 2.
 .BR semanage (8)
 
 .SH "AUTHOR"
-This man page was written by Daniel Walsh <dwalsh@redhat.com>
+This man page was written by Daniel Jurgens <danielj@mellanox.com>
diff --git a/python/semanage/semanage-ibpkey.8 b/python/semanage/semanage-ibpkey.8
index 2da4f546..51f455ab 100644
--- a/python/semanage/semanage-ibpkey.8
+++ b/python/semanage/semanage-ibpkey.8
@@ -63,4 +63,4 @@ Label pkey 0x8FFF (limited membership default pkey) as a default pkey type
 .BR semanage (8)
 
 .SH "AUTHOR"
-This man page was written by Daniel Walsh <dwalsh@redhat.com>
+This man page was written by Daniel Jurgens <danielj@mellanox.com>
-- 
2.12.2
