Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u7R9X3FT007125
 for <selinux@tycho.nsa.gov>; Sat, 27 Aug 2016 05:33:03 -0400
Received: from localhost.localdomain (32.206.133.77.rev.sfr.net
 [77.133.206.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 587CA5646CF
 for <selinux@tycho.nsa.gov>; Sat, 27 Aug 2016 11:23:15 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 0/3] Make libsepol tests pass again
Date: Sat, 27 Aug 2016 11:21:46 +0200
Message-Id: <20160827092149.9277-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hello,

A few months ago I saw that "make -C libsepol test" succeeded even
though it displayed what looked like a failure:

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
    Elapsed time =    1.420 seconds

I can see 3 reasons behind such a failure report:

* there is a bug somewhere in libsepol and the tests detect it,
* the tests are out-dated and they need to be either removed or updated, or
* my test system is configured in a way that make the tests fail even
  though they should not.

Moreover, even though the tests are failing, it is quite disturbing that
"make test" is succeeding.  This is because the CUnit tests only exit
with a failed error code when an error occured in the CUnit framework,
not in tests.  The last patch of this series fixes this.

As I did not understood anything at first when I read the code of
libsepol tests, I wrote some code to dump some tables of the loaded
policy (p->symtab[SYM_ROLES], and
p->decl_val_to_struct[...]->symtab[SYM_ROLES])
Here is an extract of this dump:

    p->p_roles[object_r]: scope 2 {1, 9, 14},
        types { }
    p->p_roles[g_b_role_1]: scope 2 {1},
        types { g_b_type_1 },
        dominates g_b_role_1
    p->p_roles[o1_b_role_1]: scope 2 {2},
        types { o1_b_type_1 }
    p->p_roles[o3_b_role_1]: scope 2 {4, 12},
        types { o3_b_type_1 o3_m1_type_1 }
    p->p_roles[o4_b_role_1]: scope 2 {5, 9, 14},
        types { g_m1_type_1 g_m1_type_2 g_m2_type_1 },
        dominates o4_b_role_1
    p->p_roles[g_b_role_3]: scope 2 {1, 9, 14},
        types { g_b_type_2 g_m1_type_2 g_m2_type_2 },
        dominates g_b_role_3
    p->p_roles[g_b_role_2]: scope 2 {1},
        types { g_b_type_2 g_m1_type_1 },
        dominates g_b_role_2
    p->p_roles[o1_b_role_2]: scope 2 {2, 9},
        types { o1_b_type_1 g_m1_type_1 },
        dominates o1_b_role_2
[...]
    decl[2]->p_roles[o1_b_role_1]: scope 2 {2},
        types { }, dominates o1_b_role_1
    decl[2]->p_roles[o1_b_role_2]: scope 2 {2, 9},
        types { }, dominates o1_b_role_2
    decl[4]->p_roles[o3_b_role_1]: scope 2 {4, 12},
        types { }, dominates o3_b_role_1
    decl[5]->p_roles[o4_b_role_1]: scope 2 {5, 9, 14},
        types { }, dominates o4_b_role_1

It seems strange that "p->p_roles" hashmap handles all role-types
associations but that the domination information lies in
"p->decl_val_to_struct[scope-1]->p_roles" for roles in optional blocks.
This association is performed in define_role_types() function in
checkpolicy/policy_define.c.  Using the "local role" (result of
get_local_role function) there fixes most asserion failures.  This is
what the first patch does.

Afterwards the only failure which remains is:

    sym g_b_role_2 has 1 decls, 2 expected

Even though g_b_role_2 is used both in
tests/policies/test-linker/small-base.conf and
tests/policies/test-linker/module1.conf, it seems to only exists in the
scope of the base policy.  The second patch updates the test
accordingly.


Nicolas Iooss (3):
  checkpolicy: add types associated to a role in the current scope when
    parsing
  libsepol: tests: fix g_b_role_2 test
  libsepol: make "make test" fails when a CUnit test fails

 checkpolicy/policy_define.c        |  1 +
 libsepol/tests/libsepol-tests.c    | 11 +++++++----
 libsepol/tests/test-linker-roles.c |  3 +--
 3 files changed, 9 insertions(+), 6 deletions(-)

-- 
2.9.3
