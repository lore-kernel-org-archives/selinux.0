Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u9RBuRBg011312
 for <selinux@tycho.nsa.gov>; Thu, 27 Oct 2016 07:57:35 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
 (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C05DC90907
 for <selinux@tycho.nsa.gov>; Thu, 27 Oct 2016 11:53:10 +0000 (UTC)
From: Vit Mojzis <vmojzis@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] libselinux: fix pointer handling in realpath_not_final
Date: Thu, 27 Oct 2016 13:52:36 +0200
Message-Id: <1477569156-12380-1-git-send-email-vmojzis@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: vmojzis <vmojzis@redhat.com>

Loop designed for stripping leading "//" was changing
the only pointer referencing block of memory allocated
by "strdup", resulting in "free()" failure. The loop
had no effect because "realpath" is used later on.

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1376598

Signed-off-by: vmojzis <vmojzis@redhat.com>
---
 libselinux/src/matchpathcon.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/libselinux/src/matchpathcon.c b/libselinux/src/matchpathcon.c
index 724eb65..58b4144 100644
--- a/libselinux/src/matchpathcon.c
+++ b/libselinux/src/matchpathcon.c
@@ -389,12 +389,6 @@ int realpath_not_final(const char *name, char *resolved_path)
 		goto out;
 	}
 
-	/* strip leading // */
-	while (tmp_path[len] && tmp_path[len] == '/' &&
-	       tmp_path[len+1] && tmp_path[len+1] == '/') {
-		tmp_path++;
-		len++;
-	}
 	last_component = strrchr(tmp_path, '/');
 
 	if (last_component == tmp_path) {
-- 
2.7.4
