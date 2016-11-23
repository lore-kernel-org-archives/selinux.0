Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uANMDbNj025594
 for <selinux@tycho.nsa.gov>; Wed, 23 Nov 2016 17:13:42 -0500
Received: from localhost.localdomain (81-66-120-207.rev.numericable.fr
 [81.66.120.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 58949564A0E
 for <selinux@tycho.nsa.gov>; Wed, 23 Nov 2016 23:07:37 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 4/5] libsepol: check decl_id bounds before using it
Date: Wed, 23 Nov 2016 23:06:45 +0100
Message-Id: <20161123220646.23504-4-nicolas.iooss@m4x.org>
In-Reply-To: <20161123220646.23504-1-nicolas.iooss@m4x.org>
References: <20161123220646.23504-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

When loading an invalid module which uses a declaration ID 0,
semodule_package crashes in policydb_index_decls():

    p->decl_val_to_struct[decl->decl_id - 1] = decl;

gdb shows the following stack trace:

    #0  0x00007ffff7aa1bbd in policydb_index_decls (p=p@entry=0x605360)
    at policydb.c:1034
    #1  0x00007ffff7aaa9fc in policydb_read (p=<optimized out>,
    fp=fp@entry=0x605090, verbose=verbose@entry=0) at policydb.c:3958
    #2  0x00007ffff7ab4764 in sepol_policydb_read (p=<optimized out>,
    pf=pf@entry=0x605090) at policydb_public.c:174
    #3  0x0000000000401d33 in main (argc=<optimized out>,
    argv=0x7fffffffdc88) at semodule_package.c:220

Change policydb_index_decls() to report an error instead:

    libsepol.policydb_index_decls: invalid decl ID 0

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/src/policydb.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index f9b2ec379c33..38c38f42cd2d 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -1011,7 +1011,7 @@ int policydb_index_decls(policydb_t * p)
 {
 	avrule_block_t *curblock;
 	avrule_decl_t *decl;
-	int num_decls = 0;
+	unsigned int num_decls = 0;
 
 	free(p->decl_val_to_struct);
 
@@ -1031,6 +1031,10 @@ int policydb_index_decls(policydb_t * p)
 	for (curblock = p->global; curblock != NULL; curblock = curblock->next) {
 		for (decl = curblock->branch_list; decl != NULL;
 		     decl = decl->next) {
+			if (decl->decl_id < 1 || decl->decl_id > num_decls) {
+				ERR(NULL, "invalid decl ID %u", decl->decl_id);
+				return -1;
+			}
 			p->decl_val_to_struct[decl->decl_id - 1] = decl;
 		}
 	}
-- 
2.10.2
