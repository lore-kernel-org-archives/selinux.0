Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u7R9NOdw006173
 for <selinux@tycho.nsa.gov>; Sat, 27 Aug 2016 05:23:25 -0400
Received: from localhost.localdomain (32.206.133.77.rev.sfr.net
 [77.133.206.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 8DEC95646D3
 for <selinux@tycho.nsa.gov>; Sat, 27 Aug 2016 11:23:15 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/3] checkpolicy: add types associated to a role in the
 current scope when parsing
Date: Sat, 27 Aug 2016 11:21:47 +0200
Message-Id: <20160827092149.9277-2-nicolas.iooss@m4x.org>
In-Reply-To: <20160827092149.9277-1-nicolas.iooss@m4x.org>
References: <20160827092149.9277-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This fixes most of the errors reported in "make -C libsepol test":

    ./libsepol-tests
         CUnit - A unit testing framework for C - Version 2.1-3
         http://cunit.sourceforge.net/
    Suite: cond
      Test: cond_expr_equal ...passed
    Suite: linker
      Test: linker_indexes ...passed
      Test: linker_types ...passed
      Test: linker_roles ...
    role o1_b_role_1 has 0 types, 1 expected
    role o1_b_role_1 has 0 types, 1 expected
    role o1_m1_role_1 has 0 types, 1 expected
    sym g_b_role_2 has 1 decls, 2 expected
    Role o1_b_role_2 had type o1_b_type_1 not in types array
    role o1_b_role_2 has 0 types, 1 expected
    Role g_b_role_4 had type g_m1_type_2 not in types array
    role g_b_role_4 has 0 types, 1 expected
    role o3_b_role_1 has 0 types, 1 expected
    role o3_b_role_1 has 0 types, 1 expected
    role o4_b_role_1 has 0 types, 1 expected
    Role o4_b_role_1 had type g_m1_type_1 not in types array

    FAILED
        1. test-common.c:216  - found == len
        2. test-common.c:216  - found == len
        3. test-common.c:216  - found == len
        4. test-common.c:43  - scope->decl_ids_len == len
        5. test-common.c:52  - found == 1
        6. test-common.c:213  - new == 1
        7. test-common.c:216  - found == len
        8. test-common.c:213  - new == 1
        9. test-common.c:216  - found == len
        10. test-common.c:216  - found == len
        11. test-common.c:216  - found == len
        12. test-common.c:216  - found == len
        13. test-common.c:213  - new == 1
      Test: linker_cond ...passed
    Suite: expander
      Test: expander_indexes ...passed
      Test: expander_attr_mapping ...passed
      Test: expander_role_mapping ...passed
      Test: expander_user_mapping ...passed
      Test: expander_alias ...passed
    Suite: deps
      Test: deps_modreq_global ...passed
      Test: deps_modreq_opt ...passed
    Suite: downgrade
      Test: downgrade ...passed

    Run Summary:    Type  Total    Ran Passed Failed Inactive
                  suites      5      5    n/a      0        0
                   tests     13     13     12      1        0
                 asserts   1269   1269   1256     13      n/a

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 checkpolicy/policy_define.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index 100e517820f9..128869c675be 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -2614,6 +2614,7 @@ int define_role_types(void)
 		free(id);
 		return -1;
 	}
+	role = get_local_role(id, role->s.value, (role->flavor == ROLE_ATTRIB));
 
 	while ((id = queue_remove(id_queue))) {
 		if (set_types(&role->types, id, &add, 0))
-- 
2.9.3
