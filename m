Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uAFN7aYY015669
 for <selinux@tycho.nsa.gov>; Tue, 15 Nov 2016 18:07:37 -0500
Received: from localhost.localdomain (81-66-120-207.rev.numericable.fr
 [81.66.120.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 2E292564CBF
 for <selinux@tycho.nsa.gov>; Wed, 16 Nov 2016 00:07:35 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 2/3] libsepol: test for ebitmap_read() negative return value
Date: Wed, 16 Nov 2016 00:07:22 +0100
Message-Id: <20161115230723.20043-2-nicolas.iooss@m4x.org>
In-Reply-To: <20161115230723.20043-1-nicolas.iooss@m4x.org>
References: <20161115230723.20043-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

While fuzzing hll/pp, the fuzzer (AFL) crafted a policy which triggered
the following message without making the policy loading fail (the
program crashed with a segmentation fault later):

    security: ebitmap: map size 192 does not match my size 64 (high bit
    was 0)

This is because ebitmap_read() returned -EINVAL and this value was
handled as a successful return value by scope_index_read() because it
was not -1.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/src/policydb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index e36d82f0a1e8..b112fd5465b5 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -3447,7 +3447,7 @@ static int scope_index_read(scope_index_t * scope_index,
 	int rc;
 
 	for (i = 0; i < num_scope_syms; i++) {
-		if (ebitmap_read(scope_index->scope + i, fp) == -1) {
+		if (ebitmap_read(scope_index->scope + i, fp) < 0) {
 			return -1;
 		}
 	}
@@ -3465,7 +3465,7 @@ static int scope_index_read(scope_index_t * scope_index,
 		return -1;
 	}
 	for (i = 0; i < scope_index->class_perms_len; i++) {
-		if (ebitmap_read(scope_index->class_perms_map + i, fp) == -1) {
+		if (ebitmap_read(scope_index->class_perms_map + i, fp) < 0) {
 			return -1;
 		}
 	}
-- 
2.10.2
