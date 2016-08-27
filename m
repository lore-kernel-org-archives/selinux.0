Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u7R9NOdv006173
 for <selinux@tycho.nsa.gov>; Sat, 27 Aug 2016 05:23:25 -0400
Received: from localhost.localdomain (32.206.133.77.rev.sfr.net
 [77.133.206.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id BD4FA5646D7
 for <selinux@tycho.nsa.gov>; Sat, 27 Aug 2016 11:23:15 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 2/3] libsepol: tests: fix g_b_role_2 test
Date: Sat, 27 Aug 2016 11:21:48 +0200
Message-Id: <20160827092149.9277-3-nicolas.iooss@m4x.org>
In-Reply-To: <20160827092149.9277-1-nicolas.iooss@m4x.org>
References: <20160827092149.9277-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Even though g_b_role_2 is used both in
tests/policies/test-linker/small-base.conf and
tests/policies/test-linker/module1.conf, it seems to only exists in the
scope of the base policy.

This fixes the following failure of "make -C libsepol test":

    ./libsepol-tests
         CUnit - A unit testing framework for C - Version 2.1-3
         http://cunit.sourceforge.net/
    Suite: cond
      Test: cond_expr_equal ...passed
    Suite: linker
      Test: linker_indexes ...passed
      Test: linker_types ...passed
      Test: linker_roles ...sym g_b_role_2 has 1 decls, 2 expected
    FAILED
        1. test-common.c:43  - scope->decl_ids_len == len
        2. test-common.c:52  - found == 1
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
                 asserts   1274   1274   1272      2      n/a

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/tests/test-linker-roles.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/libsepol/tests/test-linker-roles.c b/libsepol/tests/test-linker-roles.c
index 2c4a804704d6..569e2ccf5ee7 100644
--- a/libsepol/tests/test-linker-roles.c
+++ b/libsepol/tests/test-linker-roles.c
@@ -132,8 +132,7 @@ void module_role_tests(policydb_t * base)
 
 	/**** test for type added to base role in module 1 (global) ****/
 	decls[0] = (test_find_decl_by_sym(base, SYM_TYPES, "tag_g_b"))->decl_id;
-	decls[1] = (test_find_decl_by_sym(base, SYM_TYPES, "tag_g_m1"))->decl_id;
-	test_sym_presence(base, "g_b_role_2", SYM_ROLES, SCOPE_DECL, decls, 2);
+	test_sym_presence(base, "g_b_role_2", SYM_ROLES, SCOPE_DECL, decls, 1);
 	/* make sure it has the correct type set (g_m1_type_1, no negset, no flags) */
 	types[0] = "g_b_type_2";	/* added in base when declared */
 	types[1] = "g_m1_type_1";	/* added in module */
-- 
2.9.3
