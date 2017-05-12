Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v4CKFwL6019700
 for <selinux@tycho.nsa.gov>; Fri, 12 May 2017 16:15:59 -0400
Received: from localhost.localdomain (32.206.133.77.rev.sfr.net
 [77.133.206.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 4D8F25646B4
 for <selinux@tycho.nsa.gov>; Fri, 12 May 2017 22:15:55 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 2/2] libselinux: close the subs file if fstat failed
Date: Fri, 12 May 2017 22:13:57 +0200
Message-Id: <20170512201357.4091-2-nicolas.iooss@m4x.org>
In-Reply-To: <20170512201357.4091-1-nicolas.iooss@m4x.org>
References: <20170512201357.4091-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

selabel_subs_init() returned without closing cfg when a call to fstat()
failed. Fix this.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libselinux/src/label.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libselinux/src/label.c b/libselinux/src/label.c
index 0e43474c352e..71a273bdeb2a 100644
--- a/libselinux/src/label.c
+++ b/libselinux/src/label.c
@@ -104,7 +104,7 @@ struct selabel_sub *selabel_subs_init(const char *path,
 		return list;
 
 	if (fstat(fileno(cfg), &sb) < 0)
-		return list;
+		goto out;
 
 	while (fgets_unlocked(buf, sizeof(buf) - 1, cfg)) {
 		char *ptr = NULL;
-- 
2.12.2
