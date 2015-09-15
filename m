Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t8FDpOdL025718
 for <selinux@tycho.nsa.gov>; Tue, 15 Sep 2015 09:51:24 -0400
From: Richard Haines <richard_c_haines@btinternet.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] libselinux: Free memory when processing media and x specfiles
Date: Tue, 15 Sep 2015 14:51:15 +0100
Message-Id: <1442325075-5178-1-git-send-email-richard_c_haines@btinternet.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Ensure all memory is freed - checked using valgrind

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 libselinux/src/label_media.c | 2 +-
 libselinux/src/label_x.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/libselinux/src/label_media.c b/libselinux/src/label_media.c
index 725d5bd..c589ca3 100644
--- a/libselinux/src/label_media.c
+++ b/libselinux/src/label_media.c
@@ -161,7 +161,7 @@ static void close(struct selabel_handle *rec)
 	if (spec_arr)
 	    free(spec_arr);
 
-	memset(data, 0, sizeof(*data));
+	free(data);
 }
 
 static struct selabel_lookup_rec *lookup(struct selabel_handle *rec,
diff --git a/libselinux/src/label_x.c b/libselinux/src/label_x.c
index 3f2ee1c..3d13b23 100644
--- a/libselinux/src/label_x.c
+++ b/libselinux/src/label_x.c
@@ -188,7 +188,7 @@ static void close(struct selabel_handle *rec)
 	if (spec_arr)
 	    free(spec_arr);
 
-	memset(data, 0, sizeof(*data));
+	free(data);
 }
 
 static struct selabel_lookup_rec *lookup(struct selabel_handle *rec,
-- 
2.4.3
