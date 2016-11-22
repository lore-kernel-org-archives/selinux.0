Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uAMMOHju010064
 for <selinux@tycho.nsa.gov>; Tue, 22 Nov 2016 17:24:22 -0500
Received: from localhost.localdomain (81-66-120-207.rev.numericable.fr
 [81.66.120.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 38C2856481F
 for <selinux@tycho.nsa.gov>; Tue, 22 Nov 2016 23:24:20 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 3/5] libsepol: do not crash when block->branch_list is NULL
Date: Tue, 22 Nov 2016 23:23:40 +0100
Message-Id: <20161122222342.16771-3-nicolas.iooss@m4x.org>
In-Reply-To: <20161122222342.16771-1-nicolas.iooss@m4x.org>
References: <20161122222342.16771-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

When fuzzing hll/pp, the fuzzer created a policy module with a block
which has no declaration. With block->branch_list = NULL,
typealias_list_create() triggered a NULL pointer dereference when
computing max_decl_id.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/src/module_to_cil.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index 1c2c51c614ab..51a478434805 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -374,7 +374,7 @@ static int typealias_list_create(struct policydb *pdb)
 
 	for (block = pdb->global; block != NULL; block = block->next) {
 		decl = block->branch_list;
-		if (decl->decl_id > max_decl_id) {
+		if (decl != NULL && decl->decl_id > max_decl_id) {
 			max_decl_id = decl->decl_id;
 		}
 	}
-- 
2.10.2
