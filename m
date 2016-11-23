Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uANM7eoJ023722
 for <selinux@tycho.nsa.gov>; Wed, 23 Nov 2016 17:07:40 -0500
Received: from localhost.localdomain (81-66-120-207.rev.numericable.fr
 [81.66.120.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 77F92564A0D
 for <selinux@tycho.nsa.gov>; Wed, 23 Nov 2016 23:07:36 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/5] libsepol: do not modify p->p_roles.nprim in
 role_set_expand
Date: Wed, 23 Nov 2016 23:06:42 +0100
Message-Id: <20161123220646.23504-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

There is no reason to modify the number of roles defined in a policy
when no role is being inserted.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/src/expand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index 32df6f8b2ce6..7244e01fb50d 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -2424,7 +2424,7 @@ int role_set_expand(role_set_t * x, ebitmap_t * r, policydb_t * out, policydb_t
 	ebitmap_init(r);
 
 	if (x->flags & ROLE_STAR) {
-		for (i = 0; i < p->p_roles.nprim++; i++)
+		for (i = 0; i < p->p_roles.nprim; i++)
 			if (ebitmap_set_bit(r, i, 1))
 				return -1;
 		return 0;
-- 
2.10.2
