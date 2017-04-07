Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v37Mdvxr007527
 for <selinux@tycho.nsa.gov>; Fri, 7 Apr 2017 18:39:57 -0400
Received: from localhost.localdomain (81-66-120-207.rev.numericable.fr
 [81.66.120.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 82A2D564670
 for <selinux@tycho.nsa.gov>; Fri,  7 Apr 2017 22:44:55 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/6] libselinux: do not dereference a NULL pointer when
 calloc() fails
Date: Fri,  7 Apr 2017 22:44:26 +0200
Message-Id: <20170407204431.8572-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

selabel_is_digest_set() contains the following code:

        digest = calloc(1, sizeof(*digest));
        if (!digest)
            goto err;

    /* ... */

    err:
        free(digest->digest);

If calloc() failed, digest is NULL but is dereferenced when the
execution jumps to label err.

Check that digest is not NULL before freeing its fields.

This issue has been found using clang's static analyzer.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libselinux/src/label.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/libselinux/src/label.c b/libselinux/src/label.c
index 60639cfcfb74..3300ddc0ab31 100644
--- a/libselinux/src/label.c
+++ b/libselinux/src/label.c
@@ -191,9 +191,11 @@ static inline struct selabel_digest *selabel_is_digest_set
 	return NULL;
 
 err:
-	free(digest->digest);
-	free(digest->specfile_list);
-	free(digest);
+	if (digest) {
+		free(digest->digest);
+		free(digest->specfile_list);
+		free(digest);
+	}
 	return NULL;
 }
 
-- 
2.12.0
