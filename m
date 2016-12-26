Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uBQLBFic016478
 for <selinux@tycho.nsa.gov>; Mon, 26 Dec 2016 16:11:15 -0500
Received: from localhost.localdomain (private.iosenag.net [31.7.184.34])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 92B4056078D
 for <selinux@tycho.nsa.gov>; Mon, 26 Dec 2016 22:11:09 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/2] libsepol/tests: fix -Wsometimes-uninitialized clang
 warnings
Date: Mon, 26 Dec 2016 22:10:43 +0100
Message-Id: <20161226211044.5978-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

When compiling libsepol tests, clang complains about some uninitialized
variables:

    test-common.c:171:14: error: variable 'my_primary' is used
    uninitialized whenever 'if' condition is false
    [-Werror,-Wsometimes-uninitialized]
                    } else if (my_flavor == TYPE_ALIAS) {
                               ^~~~~~~~~~~~~~~~~~~~~~~
    test-common.c:179:30: note: uninitialized use occurs here
                    CU_ASSERT(type->primary == my_primary);
                                               ^~~~~~~~~~
    /usr/include/CUnit/CUnit.h:123:30: note: expanded from macro
    'CU_ASSERT'
      { CU_assertImplementation((value), __LINE__, #value, __FILE__, "", CU_...
                                 ^
    test-common.c:171:10: note: remove the 'if' if its condition is
    always true
                    } else if (my_flavor == TYPE_ALIAS) {
                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    test-common.c:153:25: note: initialize the variable 'my_primary' to
    silence this warning
            unsigned int my_primary, my_flavor, my_value;
                                   ^
                                    = 0
    test-common.c:171:14: error: variable 'my_value' is used
    uninitialized whenever 'if' condition is false
    [-Werror,-Wsometimes-uninitialized]
                    } else if (my_flavor == TYPE_ALIAS) {
                               ^~~~~~~~~~~~~~~~~~~~~~~
    test-common.c:181:30: note: uninitialized use occurs here
                    CU_ASSERT(type->s.value == my_value);
                                               ^~~~~~~~
    /usr/include/CUnit/CUnit.h:123:30: note: expanded from macro
    'CU_ASSERT'
      { CU_assertImplementation((value), __LINE__, #value, __FILE__, "", CU_...
                                 ^
    test-common.c:171:10: note: remove the 'if' if its condition is
    always true
                    } else if (my_flavor == TYPE_ALIAS) {
                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    test-common.c:153:46: note: initialize the variable 'my_value' to
    silence this warning
            unsigned int my_primary, my_flavor, my_value;
                                                        ^
                                                         = 0

This is because the call to CU_FAIL("not an alias") is not fatal in
test_alias_datum(), and variables my_primary and my_value are indeed
used uninitialized in a CU_ASSERT statement later.

Silent the warning by moving the elseif condition to a CU_ASSERT
statement which replaces the CU_FAIL.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/tests/test-common.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/libsepol/tests/test-common.c b/libsepol/tests/test-common.c
index 058b7435890e..dae47df3dd01 100644
--- a/libsepol/tests/test-common.c
+++ b/libsepol/tests/test-common.c
@@ -168,12 +168,11 @@ void test_alias_datum(policydb_t * p, char *id, char *primary_id, char mode, uns
 		if (my_flavor == TYPE_TYPE) {
 			my_primary = 0;
 			my_value = primary->s.value;
-		} else if (my_flavor == TYPE_ALIAS) {
+		} else {
+			CU_ASSERT(my_flavor == TYPE_ALIAS);
 			my_primary = primary->s.value;
 			CU_ASSERT_NOT_EQUAL(type->s.value, primary->s.value);
 			my_value = type->s.value;
-		} else {
-			CU_FAIL("not an alias");
 		}
 
 		CU_ASSERT(type->primary == my_primary);
-- 
2.11.0
