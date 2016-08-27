Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u7R9X3FS007125
 for <selinux@tycho.nsa.gov>; Sat, 27 Aug 2016 05:33:03 -0400
Received: from localhost.localdomain (32.206.133.77.rev.sfr.net
 [77.133.206.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 082B45646DB
 for <selinux@tycho.nsa.gov>; Sat, 27 Aug 2016 11:23:16 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 3/3] libsepol: make "make test" fails when a CUnit test fails
Date: Sat, 27 Aug 2016 11:21:49 +0200
Message-Id: <20160827092149.9277-4-nicolas.iooss@m4x.org>
In-Reply-To: <20160827092149.9277-1-nicolas.iooss@m4x.org>
References: <20160827092149.9277-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/tests/libsepol-tests.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/libsepol/tests/libsepol-tests.c b/libsepol/tests/libsepol-tests.c
index 9302f7206d54..544c792d2ab5 100644
--- a/libsepol/tests/libsepol-tests.c
+++ b/libsepol/tests/libsepol-tests.c
@@ -28,6 +28,7 @@
 #include <CUnit/Console.h>
 #include <CUnit/TestDB.h>
 
+#include <stdbool.h>
 #include <stdio.h>
 #include <getopt.h>
 #include <stdlib.h>
@@ -51,9 +52,10 @@ static void usage(char *progname)
 	printf("\t-i, --interactive\t\tinteractive console\n");
 }
 
-static int do_tests(int interactive, int verbose)
+static bool do_tests(int interactive, int verbose)
 {
 	CU_pSuite suite = NULL;
+	unsigned int num_failures;
 
 	if (CUE_SUCCESS != CU_initialize_registry())
 		return CU_get_error();
@@ -73,8 +75,9 @@ static int do_tests(int interactive, int verbose)
 		CU_console_run_tests();
 	else
 		CU_basic_run_tests();
+	num_failures = CU_get_number_of_tests_failed();
 	CU_cleanup_registry();
-	return CU_get_error();
+	return CU_get_error() == CUE_SUCCESS && num_failures == 0;
 
 }
 
@@ -106,12 +109,12 @@ int main(int argc, char **argv)
 
 	/* first do the non-mls tests */
 	mls = 0;
-	if (do_tests(interactive, verbose))
+	if (!do_tests(interactive, verbose))
 		return -1;
 
 	/* then with mls */
 	mls = 1;
-	if (do_tests(interactive, verbose))
+	if (!do_tests(interactive, verbose))
 		return -1;
 
 	return 0;
-- 
2.9.3
