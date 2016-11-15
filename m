Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uAFN7aYX015669
 for <selinux@tycho.nsa.gov>; Tue, 15 Nov 2016 18:07:36 -0500
Received: from localhost.localdomain (81-66-120-207.rev.numericable.fr
 [81.66.120.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 7BB2B564CBF
 for <selinux@tycho.nsa.gov>; Wed, 16 Nov 2016 00:07:33 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/3] libsepol: replace an assert with an error message
Date: Wed, 16 Nov 2016 00:07:21 +0100
Message-Id: <20161115230723.20043-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

When fuzzing hll/pp inputs, a policy module where the value of
scope->decl_ids_len has been modified to zero makes the program abort
(when it has been compiled without -DNDEBUG).

Change the behavior to report an error message instead. This eases
fuzzing functions like policydb_read().

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/src/policydb.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index cdb3cde6b5e2..e36d82f0a1e8 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -3635,7 +3635,10 @@ static int scope_read(policydb_t * p, int symnum, struct policy_file *fp)
 		goto cleanup;
 	scope->scope = le32_to_cpu(buf[0]);
 	scope->decl_ids_len = le32_to_cpu(buf[1]);
-	assert(scope->decl_ids_len > 0);
+	if (scope->decl_ids_len == 0) {
+		ERR(fp->handle, "invalid scope with no declaration");
+		goto cleanup;
+	}
 	if ((scope->decl_ids =
 	     malloc(scope->decl_ids_len * sizeof(uint32_t))) == NULL) {
 		goto cleanup;
-- 
2.10.2
