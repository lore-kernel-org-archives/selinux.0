Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uAMMOHjv010064
 for <selinux@tycho.nsa.gov>; Tue, 22 Nov 2016 17:24:23 -0500
Received: from localhost.localdomain (81-66-120-207.rev.numericable.fr
 [81.66.120.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 634CA564822
 for <selinux@tycho.nsa.gov>; Tue, 22 Nov 2016 23:24:21 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 4/5] libsepol: make scope_index_destroy() more robust
Date: Tue, 22 Nov 2016 23:23:41 +0100
Message-Id: <20161122222342.16771-4-nicolas.iooss@m4x.org>
In-Reply-To: <20161122222342.16771-1-nicolas.iooss@m4x.org>
References: <20161122222342.16771-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

When scope_index_read() fails while attempting to allocate memory for
scope_index->class_perms_map, scope_index_destroy() gets called with
scope->class_perms_len != 0 and scope->class_perms_map == NULL. This
triggers the following segmentation fault (in semodule_package):

    Program received signal SIGSEGV, Segmentation fault.
    ebitmap_destroy (e=0x10) at ebitmap.c:362
    362     n = e->node;
    => 0x00007ffff79ff7f6 <ebitmap_destroy+134>:    48 8b 3f    mov
    (%rdi),%rdi

    (gdb) bt
    #0  ebitmap_destroy (e=0x10) at ebitmap.c:362
    #1  0x00007ffff79e2c37 in scope_index_destroy (scope=0x608860) at
    avrule_block.c:87
    #2  avrule_decl_destroy (x=0x608830) at avrule_block.c:103
    #3  0x00007ffff7aae99c in avrule_block_read (fp=0x605090,
    num_scope_syms=8, block=0x6054e8, p=0x605360) at policydb.c:3598
    #4  policydb_read (p=0x605360, fp=fp@entry=0x605090,
    verbose=verbose@entry=0) at policydb.c:3946
    #5  0x00007ffff7ab4ab4 in sepol_policydb_read (p=<optimized out>,
    pf=pf@entry=0x605090) at policydb_public.c:174
    #6  0x0000000000401d33 in main (argc=<optimized out>,
    argv=0x7fffffffdc88) at semodule_package.c:220

    (gdb) f 1

    (gdb) p *scope
    $1 = {scope = {{node = 0x0, highbit = 0}, {node = 0x0, highbit = 0},
    {node = 0x0, highbit = 0}, {node = 0x0, highbit = 0}, {node = 0x0,
    highbit = 0}, {node = 0x0, highbit = 0}, {node = 0x0, highbit = 0},
    {node = 0x0, highbit = 0}}, class_perms_map = 0x0, class_perms_len =
    4294934272}

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/src/avrule_block.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/libsepol/src/avrule_block.c b/libsepol/src/avrule_block.c
index 84cfaf8c8201..224e9994110a 100644
--- a/libsepol/src/avrule_block.c
+++ b/libsepol/src/avrule_block.c
@@ -83,8 +83,10 @@ static void scope_index_destroy(scope_index_t * scope)
 	for (i = 0; i < SYM_NUM; i++) {
 		ebitmap_destroy(scope->scope + i);
 	}
-	for (i = 0; i < scope->class_perms_len; i++) {
-		ebitmap_destroy(scope->class_perms_map + i);
+	if (scope->class_perms_map) {
+		for (i = 0; i < scope->class_perms_len; i++) {
+			ebitmap_destroy(scope->class_perms_map + i);
+		}
 	}
 	free(scope->class_perms_map);
 }
-- 
2.10.2
