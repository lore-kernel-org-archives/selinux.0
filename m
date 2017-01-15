Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v0FD4ofo000632
 for <selinux@tycho.nsa.gov>; Sun, 15 Jan 2017 08:04:51 -0500
Received: from localhost.localdomain (32.206.133.77.rev.sfr.net
 [77.133.206.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 71ACA56481B
 for <selinux@tycho.nsa.gov>; Sun, 15 Jan 2017 14:04:21 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 4/5] libselinux: always free catalog in db_init()
Date: Sun, 15 Jan 2017 14:03:58 +0100
Message-Id: <20170115130359.6108-4-nicolas.iooss@m4x.org>
In-Reply-To: <20170115130359.6108-1-nicolas.iooss@m4x.org>
References: <20170115130359.6108-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This variable may be leaked in some error paths.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libselinux/src/label_db.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/libselinux/src/label_db.c b/libselinux/src/label_db.c
index 1155bcc84031..c46d0a1de9a7 100644
--- a/libselinux/src/label_db.c
+++ b/libselinux/src/label_db.c
@@ -281,9 +281,12 @@ db_init(const struct selinux_opt *opts, unsigned nopts,
 		free(catalog);
 		return NULL;
 	}
-	if (fstat(fileno(filp), &sb) < 0)
+	if (fstat(fileno(filp), &sb) < 0) {
+		free(catalog);
 		return NULL;
+	}
 	if (!S_ISREG(sb.st_mode)) {
+		free(catalog);
 		errno = EINVAL;
 		return NULL;
 	}
-- 
2.11.0
