Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uBLIMCXl021001
 for <selinux@tycho.nsa.gov>; Wed, 21 Dec 2016 13:22:22 -0500
Received: from localhost.localdomain (32.206.133.77.rev.sfr.net
 [77.133.206.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 9B4795647EF
 for <selinux@tycho.nsa.gov>; Wed, 21 Dec 2016 19:22:11 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH v2 3/7] libsemanage/tests: test more cases of semanage_split*()
Date: Wed, 21 Dec 2016 19:21:00 +0100
Message-Id: <20161221182104.16967-4-nicolas.iooss@m4x.org>
In-Reply-To: <20161221182104.16967-1-nicolas.iooss@m4x.org>
References: <20161221182104.16967-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Before modifying semanage_split_on_space() and semanage_split(), test in
test_utilities.c how these functions behave for example when several
delimiter tokens are concatenated in the input string.

While at it, fix the memory leaks which were present in libsemanage
tests.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsemanage/tests/test_utilities.c | 51 ++++++++++++++++++++++++--------------
 1 file changed, 33 insertions(+), 18 deletions(-)

diff --git a/libsemanage/tests/test_utilities.c b/libsemanage/tests/test_utilities.c
index 32cc33c1b510..b46f18db2a99 100644
--- a/libsemanage/tests/test_utilities.c
+++ b/libsemanage/tests/test_utilities.c
@@ -129,7 +129,7 @@ void test_semanage_is_prefix(void)
 
 void test_semanage_split_on_space(void)
 {
-	char *str = strdup("foo bar baz");
+	char *str = strdup("   foo   bar    baz");
 	char *temp;
 
 	if (!str) {
@@ -137,24 +137,24 @@ void test_semanage_split_on_space(void)
 		    ("semanage_split_on_space: unable to perform test, no memory");
 	}
 	temp = semanage_split_on_space(str);
-	if (strncmp(temp, "bar", 3)) {
-		CU_FAIL("semanage_split_on_space: token did not match");
-	}
-	temp = semanage_split_on_space(temp);
-	if (strncmp(temp, "baz", 3)) {
-		CU_FAIL("semanage_split_on_space: token did not match");
-	}
-	temp = semanage_split_on_space(temp);
-	if (strcmp(temp, "")) {
-		CU_FAIL("semanage_split_on_space: token did not match");
-	}
+	CU_ASSERT_STRING_EQUAL(temp, "bar    baz");
+	free(str);
+	str = temp;
+
+	temp = semanage_split_on_space(str);
+	CU_ASSERT_STRING_EQUAL(temp, "baz");
+	free(str);
+	str = temp;
 
+	temp = semanage_split_on_space(str);
+	CU_ASSERT_STRING_EQUAL(temp, "");
 	free(str);
+	free(temp);
 }
 
 void test_semanage_split(void)
 {
-	char *str = strdup("foo1 foo2 foo:bar");
+	char *str = strdup("foo1 foo2   foo:bar:");
 	char *temp;
 
 	if (!str) {
@@ -163,13 +163,24 @@ void test_semanage_split(void)
 		return;
 	}
 	temp = semanage_split(str, NULL);
-	CU_ASSERT_NSTRING_EQUAL(temp, "foo2", 4);
-	temp = semanage_split(temp, "");
-	CU_ASSERT_NSTRING_EQUAL(temp, "foo", 3);
-	temp = semanage_split(temp, ":");
-	CU_ASSERT_NSTRING_EQUAL(temp, "bar", 3);
+	CU_ASSERT_STRING_EQUAL(temp, "foo2   foo:bar:");
+	free(str);
+	str = temp;
 
+	temp = semanage_split(str, "");
+	CU_ASSERT_STRING_EQUAL(temp, "foo:bar:");
 	free(str);
+	str = temp;
+
+	temp = semanage_split(str, ":");
+	CU_ASSERT_STRING_EQUAL(temp, "bar:");
+	free(str);
+	str = temp;
+
+	temp = semanage_split(str, ":");
+	CU_ASSERT_STRING_EQUAL(temp, "");
+	free(str);
+	free(temp);
 }
 
 void test_semanage_list(void)
@@ -242,6 +253,8 @@ void test_semanage_rtrim(void)
 	CU_ASSERT_STRING_EQUAL(str, "/blah/foo/bar/b");
 	semanage_rtrim(str, '/');
 	CU_ASSERT_STRING_EQUAL(str, "/blah/foo/bar");
+
+	free(str);
 }
 
 void test_semanage_findval(void)
@@ -252,6 +265,7 @@ void test_semanage_findval(void)
 	}
 	tok = semanage_findval(fname, "one", NULL);
 	CU_ASSERT_STRING_EQUAL(tok, "");
+	free(tok);
 	rewind(fptr);
 	tok = semanage_findval(fname, "one", "");
 	CU_ASSERT_STRING_EQUAL(tok, "");
@@ -259,6 +273,7 @@ void test_semanage_findval(void)
 	rewind(fptr);
 	tok = semanage_findval(fname, "sigma", "=");
 	CU_ASSERT_STRING_EQUAL(tok, "foo");
+	free(tok);
 }
 
 int PREDICATE(const char *str)
-- 
2.11.0
