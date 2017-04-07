Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v37Niv27025756
 for <selinux@tycho.nsa.gov>; Fri, 7 Apr 2017 19:44:58 -0400
Received: from localhost.localdomain (81-66-120-207.rev.numericable.fr
 [81.66.120.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 0B544564678
 for <selinux@tycho.nsa.gov>; Fri,  7 Apr 2017 22:45:00 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 6/6] libsepol: do not wrap integers when checking bound
Date: Fri,  7 Apr 2017 22:44:31 +0200
Message-Id: <20170407204431.8572-6-nicolas.iooss@m4x.org>
In-Reply-To: <20170407204431.8572-1-nicolas.iooss@m4x.org>
References: <20170407204431.8572-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Some invalid policies might have p->p_types.nprim = 0. When parsing
such a policy, "i > p->p_types.nprim - 1" is always false even though
reading p->type_val_to_struct[i] triggers a segmentation fault.

Make type_set_expand() return an error when parsing such a policy by
handling correctly when p->p_types.nprim is zero.

This issue has been found while fuzzing semodule_package with the
American Fuzzy Lop.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/src/expand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index 315fc65cfd7e..54bf781d335f 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -2527,7 +2527,7 @@ int type_set_expand(type_set_t * set, ebitmap_t * t, policydb_t * p,
 				 * invalid policies might have more types set in the ebitmap than
 				 * what's available in the type_val_to_struct mapping
 				 */
-				if (i > p->p_types.nprim - 1)
+				if (i >= p->p_types.nprim)
 					goto err_types;
 
 				if (!p->type_val_to_struct[i]) {
-- 
2.12.0
