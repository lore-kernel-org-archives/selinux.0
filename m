Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uAMMOHjt010064
 for <selinux@tycho.nsa.gov>; Tue, 22 Nov 2016 17:24:20 -0500
Received: from localhost.localdomain (81-66-120-207.rev.numericable.fr
 [81.66.120.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 2A8FF56481F
 for <selinux@tycho.nsa.gov>; Tue, 22 Nov 2016 23:24:18 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 2/5] libsepol: do not crash when a symbol does not exist
Date: Tue, 22 Nov 2016 23:23:39 +0100
Message-Id: <20161122222342.16771-2-nicolas.iooss@m4x.org>
In-Reply-To: <20161122222342.16771-1-nicolas.iooss@m4x.org>
References: <20161122222342.16771-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

When hll/pp reads an invalid policy module where some scopes use
required symbols which are not defined, the program crashes with a
segmentation fault in required_scopes_to_cil():

    Program received signal SIGSEGV, Segmentation fault.
    required_scopes_to_cil (decl_stack=0x6040b0, block=0x607780,
    pdb=0x6042e0, indent=0) at module_to_cil.c:3479
    3479                for (j = 0; j < scope_datum->decl_ids_len; j++)
    {
    => 0x00007ffff7a7b1a8 <block_to_cil+5224>:  44 8b 58 10 mov
    0x10(%rax),%r11d

    (gdb) bt
    #0  required_scopes_to_cil (decl_stack=0x6040b0, block=0x607780,
    pdb=0x6042e0, indent=0) at module_to_cil.c:3479
    #1  block_to_cil (pdb=pdb@entry=0x6042e0,
    block=block@entry=0x607780, stack=stack@entry=0x6040b0,
    indent=indent@entry=0) at module_to_cil.c:3622
    #2  0x00007ffff7a85a18 in global_block_to_cil (stack=0x6040b0,
    block=0x607780, pdb=0x6042e0) at module_to_cil.c:3738
    #3  blocks_to_cil (pdb=0x6042e0) at module_to_cil.c:3764
    #4  sepol_module_policydb_to_cil (fp=fp@entry=0x7ffff79d05e0
    <_IO_2_1_stdout_>, pdb=0x6042e0, linked=linked@entry=0) at
    module_to_cil.c:4051
    #5  0x00007ffff7a86b55 in sepol_module_package_to_cil
    (fp=fp@entry=0x7ffff79d05e0 <_IO_2_1_stdout_>, mod_pkg=0x604280) at
    module_to_cil.c:4080
    #6  0x0000000000401acc in main (argc=<optimized out>,
    argv=<optimized out>) at pp.c:150

    (gdb) p scope_datum
    $1 = (struct scope_datum *) 0x0

Detect such errors and exit with an error return value.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/src/module_to_cil.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index ab3ac03d7895..1c2c51c614ab 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -3469,6 +3469,10 @@ static int required_scopes_to_cil(int indent, struct policydb *pdb, struct avrul
 			key = pdb->sym_val_to_name[sym][i];
 
 			scope_datum = hashtab_search(pdb->scope[sym].table, key);
+			if (scope_datum == NULL) {
+				rc = -1;
+				goto exit;
+			}
 			for (j = 0; j < scope_datum->decl_ids_len; j++) {
 				if (scope_datum->decl_ids[j] == decl->decl_id) {
 					break;
-- 
2.10.2
