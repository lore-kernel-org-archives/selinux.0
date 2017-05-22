Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v4MLkcSs022842
 for <selinux@tycho.nsa.gov>; Mon, 22 May 2017 17:46:41 -0400
Received: from localhost.localdomain (81-66-120-207.rev.numericable.fr
 [81.66.120.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 59F625646F4
 for <selinux@tycho.nsa.gov>; Mon, 22 May 2017 23:46:14 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/1] libsepol: make role_list_destroy() do nothing when
 role_list is NULL
Date: Mon, 22 May 2017 23:45:55 +0200
Message-Id: <20170522214555.9052-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

When a function called by sepol_module_policydb_to_cil() fails before
role_list_create() has been called, role_list is still NULL but is
dereferenced in role_list_destroy(). Here is a gdb session on hll/pp:

    Unknown value for handle-unknown: 6

    Program received signal SIGSEGV, Segmentation fault.
    0x00007ffff7a68a37 in role_list_destroy () at module_to_cil.c:215
    215     struct list_node *curr = role_list->head;

    (gdb) bt
    #0  0x00007ffff7a68a37 in role_list_destroy () at
    module_to_cil.c:215
    #1  sepol_module_policydb_to_cil (fp=fp@entry=0x7ffff79925e0
    <_IO_2_1_stdout_>, pdb=<optimized out>, linked=linked@entry=0) at
    module_to_cil.c:4060
    #2  0x00007ffff7a6ac75 in sepol_module_package_to_cil
    (fp=fp@entry=0x7ffff79925e0 <_IO_2_1_stdout_>, mod_pkg=0x604280) at
    module_to_cil.c:4080
    #3  0x0000000000401a58 in main (argc=<optimized out>,
    argv=<optimized out>) at pp.c:150

This issue has been found while fuzzing hll/pp with the American Fuzzy
Lop.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/src/module_to_cil.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index 7d8eb204d2fd..c989830a198c 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -211,7 +211,12 @@ static void list_destroy(struct list **list)
 
 static void role_list_destroy(void)
 {
-	struct list_node *curr = role_list->head;
+	struct list_node *curr;
+
+	if (role_list == NULL) {
+		return;
+	}
+	curr = role_list->head;
 
 	while (curr != NULL) {
 		free(curr->data);
-- 
2.13.0
