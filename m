Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v0FD4ofn000632
 for <selinux@tycho.nsa.gov>; Sun, 15 Jan 2017 08:04:50 -0500
Received: from localhost.localdomain (32.206.133.77.rev.sfr.net
 [77.133.206.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id F11D356481B
 for <selinux@tycho.nsa.gov>; Sun, 15 Jan 2017 14:04:19 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 2/5] libsepol: verify the right variable after calling calloc()
Date: Sun, 15 Jan 2017 14:03:56 +0100
Message-Id: <20170115130359.6108-2-nicolas.iooss@m4x.org>
In-Reply-To: <20170115130359.6108-1-nicolas.iooss@m4x.org>
References: <20170115130359.6108-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

After "otype = calloc(1, sizeof(*otype))", it is reasonable to check the
value of otype, not ft.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/src/policydb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index 3f9b1f3fd2ac..5b9b9f02f0b5 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -2558,7 +2558,7 @@ int filename_trans_read(policydb_t *p, struct policy_file *fp)
 		if (!ft)
 			goto err;
 		otype = calloc(1, sizeof(*otype));
-		if (!ft)
+		if (!otype)
 			goto err;
 		rc = next_entry(buf, fp, sizeof(uint32_t));
 		if (rc < 0)
-- 
2.11.0
