Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uBJD4k0k020574
 for <selinux@tycho.nsa.gov>; Mon, 19 Dec 2016 08:04:48 -0500
Received: from localhost.localdomain (32.206.133.77.rev.sfr.net
 [77.133.206.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id E556C564788
 for <selinux@tycho.nsa.gov>; Mon, 19 Dec 2016 14:04:40 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/7] libsemanage/tests: make "make test" fail when a CUnit
 test fails
Date: Mon, 19 Dec 2016 14:03:58 +0100
Message-Id: <20161219130404.11496-2-nicolas.iooss@m4x.org>
In-Reply-To: <20161219130404.11496-1-nicolas.iooss@m4x.org>
References: <20161219130404.11496-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

When modifications to libsemanage functions break the test cases tested
with the CUnit framework, "make test" currently succeeds, even though it
prints an output similar to:

    Suite: semanage_store
      Test: semanage_store_access_check ...passed
      Test: semanage_get_lock ...passed
      Test: semanage_nc_sort ...passed
    Suite: semanage_utilities
      Test: semanage_is_prefix ...passed
      Test: semanage_split_on_space ...FAILED
        1. test_utilities.c:150  - CU_ASSERT_STRING_EQUAL(temp,"baz")
      Test: semanage_split ...passed
      Test: semanage_list ...passed
      Test: semanage_str_count ...passed
      Test: semanage_rtrim ...passed
      Test: semanage_str_replace ...passed
      Test: semanage_findval ...passed
      Test: slurp_file_filter ...passed

Like commit 2489b50a9162 ("libsepol: make "make test" fails when a CUnit
test fails") did for libsepol tests, modify the logic of function
do_tests() to return an error value when there has been at least one
failure. This makes "make test" fail as expected.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsemanage/tests/libsemanage-tests.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/libsemanage/tests/libsemanage-tests.c b/libsemanage/tests/libsemanage-tests.c
index 735d36fd9074..048751b8b172 100644
--- a/libsemanage/tests/libsemanage-tests.c
+++ b/libsemanage/tests/libsemanage-tests.c
@@ -26,6 +26,7 @@
 #include <CUnit/Console.h>
 #include <CUnit/TestDB.h>
 
+#include <stdbool.h>
 #include <stdio.h>
 #include <getopt.h>
 #include <stdlib.h>
@@ -47,9 +48,10 @@ static void usage(char *progname)
 	printf("\t-i, --interactive\t\tinteractive console\n");
 }
 
-static int do_tests(int interactive, int verbose)
+static bool do_tests(int interactive, int verbose)
 {
 	CU_pSuite suite = NULL;
+	unsigned int num_failures;
 
 	/* Initialize the CUnit test registry. */
 	if (CUE_SUCCESS != CU_initialize_registry())
@@ -67,8 +69,9 @@ static int do_tests(int interactive, int verbose)
 		CU_console_run_tests();
 	else
 		CU_basic_run_tests();
+	num_failures = CU_get_number_of_tests_failed();
 	CU_cleanup_registry();
-	return CU_get_error();
+	return CU_get_error() == CUE_SUCCESS && num_failures == 0;
 
 }
 
@@ -101,7 +104,7 @@ int main(int argc, char **argv)
 		}
 	}
 
-	if (do_tests(interactive, verbose))
+	if (!do_tests(interactive, verbose))
 		return -1;
 
 	return 0;
-- 
2.11.0
