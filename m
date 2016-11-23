Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uANM7eoI023722
 for <selinux@tycho.nsa.gov>; Wed, 23 Nov 2016 17:07:40 -0500
Received: from localhost.localdomain (81-66-120-207.rev.numericable.fr
 [81.66.120.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id D8B72564A0E
 for <selinux@tycho.nsa.gov>; Wed, 23 Nov 2016 23:07:36 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 2/5] libsepol: do not check decl->symtab[i].nprim
Date: Wed, 23 Nov 2016 23:06:43 +0100
Message-Id: <20161123220646.23504-2-nicolas.iooss@m4x.org>
In-Reply-To: <20161123220646.23504-1-nicolas.iooss@m4x.org>
References: <20161123220646.23504-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Commit 02a7d77ef2bf ("libsepol: make parsing symbol table headers more
robust") broke refpolicy build, because checkmodule generates avrule
decl blocks with "decl->symtab[i].nprim = 0" for all possible i, even
when decl->symtab[SYM_ROLES] and decl->symtab[SYM_TYPES] are not
empty.

More precisely, decl->symtab[i].nprim seems to be only updated in
libsepol/src/link.c (in *_copy_callback() functions).

Revert the buggy part of commit 02a7d77ef2bf to fix this regression.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/src/policydb.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index d1019e42de16..f9b2ec379c33 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -3510,10 +3510,6 @@ static int avrule_decl_read(policydb_t * p, avrule_decl_t * decl,
 			return -1;
 		nprim = le32_to_cpu(buf[0]);
 		nel = le32_to_cpu(buf[1]);
-		if (nel && !nprim) {
-			ERR(fp->handle, "unexpected items in decl symbol table with no symbol");
-			return -1;
-		}
 		for (j = 0; j < nel; j++) {
 			if (read_f[i] (p, decl->symtab[i].table, fp)) {
 				return -1;
-- 
2.10.2
