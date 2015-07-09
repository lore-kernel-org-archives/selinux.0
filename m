Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t698GNqE017225
 for <selinux@tycho.nsa.gov>; Thu, 9 Jul 2015 04:16:23 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
 (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
 by mx1.redhat.com (Postfix) with ESMTPS id 790E0C03FD
 for <selinux@tycho.nsa.gov>; Thu,  9 Jul 2015 08:16:20 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] Fix typo in semanage args for minimum policy store
Date: Thu,  9 Jul 2015 10:16:16 +0200
Message-Id: <1436429776-32450-1-git-send-email-plautrba@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

---
 policycoreutils/semanage/semanage | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/policycoreutils/semanage/semanage b/policycoreutils/semanage/semanage
index dd63010..dd1010a 100644
--- a/policycoreutils/semanage/semanage
+++ b/policycoreutils/semanage/semanage
@@ -788,7 +788,7 @@ def createCommandParser():
 
 def make_io_args(args):
     # import/export backward compability
-    args_origin = ["-S", "-o", "-i", "targeted", "minumum", "mls"]
+    args_origin = ["-S", "-o", "-i", "targeted", "minimum", "mls"]
     args_file = []
     args_ie = []
     args_subcommand = []
-- 
2.4.3
