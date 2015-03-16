Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t2GAXHjV001891
 for <selinux@tycho.nsa.gov>; Mon, 16 Mar 2015 06:33:17 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
 (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
 by mx1.redhat.com (Postfix) with ESMTPS id A841BC40B3
 for <selinux@tycho.nsa.gov>; Mon, 16 Mar 2015 10:33:15 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] libsemanage: fix fname[] initialization in test_utilities.c
Date: Mon, 16 Mar 2015 11:33:07 +0100
Message-Id: <1426501987-12646-1-git-send-email-plautrba@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

There's no guaranty that last item in "char fname[]" will be a null character.
Fixes segfault on some systems:

  Test: semanage_nc_sort ...passedtest_semanage_findval: : Invalid argument
libsemanage-tests: TestRun.c:160: CU_assertImplementation: Assertion `((void *)0) != f_pCurTest' failed.
make[1]: *** [test] Aborted (core dumped)

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 libsemanage/tests/test_utilities.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsemanage/tests/test_utilities.c b/libsemanage/tests/test_utilities.c
index 4d25b07..32cc33c 100644
--- a/libsemanage/tests/test_utilities.c
+++ b/libsemanage/tests/test_utilities.c
@@ -45,7 +45,7 @@ void test_slurp_file_filter(void);
 
 char fname[] = {
 	'T', 'E', 'S', 'T', '_', 'T', 'E', 'M', 'P', '_', 'X', 'X', 'X', 'X',
-	'X', 'X'
+	'X', 'X', '\0'
 };
 int fd;
 FILE *fptr;
-- 
2.3.1
