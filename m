Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v15FwipJ005432
 for <selinux@tycho.nsa.gov>; Sun, 5 Feb 2017 10:58:46 -0500
Received: from localhost.localdomain (32.206.133.77.rev.sfr.net
 [77.133.206.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 66982564780
 for <selinux@tycho.nsa.gov>; Sun,  5 Feb 2017 16:58:43 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 8/8] libsemanage/tests: fix -Wwrite-strings warnings
Date: Sun,  5 Feb 2017 16:58:20 +0100
Message-Id: <20170205155820.29157-8-nicolas.iooss@m4x.org>
In-Reply-To: <20170205155820.29157-1-nicolas.iooss@m4x.org>
References: <20170205155820.29157-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsemanage/src/utilities.c        | 2 +-
 libsemanage/src/utilities.h        | 2 +-
 libsemanage/tests/test_utilities.c | 8 ++++----
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/libsemanage/src/utilities.c b/libsemanage/src/utilities.c
index 0d50d99026db..ba6dc85ab23b 100644
--- a/libsemanage/src/utilities.c
+++ b/libsemanage/src/utilities.c
@@ -199,7 +199,7 @@ int semanage_cmp_plist_t(const semanage_list_t ** x, const semanage_list_t ** y)
 	return strcmp((*x)->data, (*y)->data);
 }
 
-int semanage_str_count(char *data, char what)
+int semanage_str_count(const char *data, char what)
 {
 	int count = 0;
 
diff --git a/libsemanage/src/utilities.h b/libsemanage/src/utilities.h
index f2ff31f0f5b6..ba1ed0297ed7 100644
--- a/libsemanage/src/utilities.h
+++ b/libsemanage/src/utilities.h
@@ -105,7 +105,7 @@ int semanage_cmp_plist_t(const semanage_list_t ** x,
  * @param      what  a charachter
  * @returns    the number of times the char appears in the string
  */
-int semanage_str_count(char *data, char what);
+int semanage_str_count(const char *data, char what);
 /**
  * @param      - a string
  * @param            the charachter to trim to
diff --git a/libsemanage/tests/test_utilities.c b/libsemanage/tests/test_utilities.c
index 30ac7f5823e6..601508c2c386 100644
--- a/libsemanage/tests/test_utilities.c
+++ b/libsemanage/tests/test_utilities.c
@@ -122,9 +122,9 @@ int semanage_utilities_add_tests(CU_pSuite suite)
 
 void test_semanage_is_prefix(void)
 {
-	char *str = "some string";
-	char *pre = "some";
-	char *not_pre = "not this";
+	const char *str = "some string";
+	const char *pre = "some";
+	const char *not_pre = "not this";
 
 	CU_ASSERT_TRUE(semanage_is_prefix(str, pre));
 	CU_ASSERT_TRUE(semanage_is_prefix(str, ""));
@@ -239,7 +239,7 @@ void test_semanage_list(void)
 
 void test_semanage_str_count(void)
 {
-	char *test_string = "abaababbaaaba";
+	const char *test_string = "abaababbaaaba";
 
 	CU_ASSERT_EQUAL(semanage_str_count(test_string, 'z'), 0);
 	CU_ASSERT_EQUAL(semanage_str_count(test_string, 'a'), 8);
-- 
2.11.0
