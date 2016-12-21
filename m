Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uBLIMCXm021001
 for <selinux@tycho.nsa.gov>; Wed, 21 Dec 2016 13:22:22 -0500
Received: from localhost.localdomain (32.206.133.77.rev.sfr.net
 [77.133.206.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 220695647EF
 for <selinux@tycho.nsa.gov>; Wed, 21 Dec 2016 19:22:13 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH v2 5/7] libsemanage: add semanage_str_replace() utility
 function
Date: Wed, 21 Dec 2016 19:21:02 +0100
Message-Id: <20161221182104.16967-6-nicolas.iooss@m4x.org>
In-Reply-To: <20161221182104.16967-1-nicolas.iooss@m4x.org>
References: <20161221182104.16967-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This function will be used in the next commit.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsemanage/src/utilities.c        | 55 ++++++++++++++++++++++++++++++++++++++
 libsemanage/src/utilities.h        | 10 +++++++
 libsemanage/tests/test_utilities.c | 34 +++++++++++++++++++++++
 3 files changed, 99 insertions(+)

diff --git a/libsemanage/src/utilities.c b/libsemanage/src/utilities.c
index fa86cc77dc56..0d50d99026db 100644
--- a/libsemanage/src/utilities.c
+++ b/libsemanage/src/utilities.c
@@ -230,6 +230,61 @@ void semanage_rtrim(char *str, char trim_to)
 	}
 }
 
+char *semanage_str_replace(const char *search, const char *replace,
+			   const char *src, size_t lim)
+{
+	size_t count = 0, slen, rlen, newsize;
+	char *p, *pres, *result;
+	const char *psrc;
+
+	slen = strlen(search);
+	rlen = strlen(replace);
+
+	/* Do not support empty search strings */
+	if (slen == 0)
+		return NULL;
+
+	/* Count the occurences of search in src and compute the new size */
+	for (p = strstr(src, search); p != NULL; p = strstr(p + slen, search)) {
+		count++;
+		if (lim && count >= lim)
+			break;
+	}
+	if (!count)
+		return strdup(src);
+
+	/* Allocate the result string */
+	newsize = strlen(src) + 1 + count * (rlen - slen);
+	result = malloc(newsize);
+	if (!result)
+		return NULL;
+
+	/* Fill the result */
+	psrc = src;
+	pres = result;
+	for (p = strstr(src, search); p != NULL; p = strstr(psrc, search)) {
+		/* Copy the part which has not been modified */
+		if (p != psrc) {
+			size_t length = (size_t)(p - psrc);
+			memcpy(pres, psrc, length);
+			pres += length;
+		}
+		/* Copy the replacement part */
+		if (rlen != 0) {
+			memcpy(pres, replace, rlen);
+			pres += rlen;
+		}
+		psrc = p + slen;
+		count--;
+		if (!count)
+			break;
+	}
+	/* Copy the last part, after doing a sanity check */
+	assert(pres + strlen(psrc) + 1 == result + newsize);
+	strcpy(pres, psrc);
+	return result;
+}
+
 /* list_addafter_controlmem does *NOT* duplicate the data argument
  * use at your own risk, I am building a list out of malloc'd memory and
  * it is only going to get stored into this list, thus when I destroy it
diff --git a/libsemanage/src/utilities.h b/libsemanage/src/utilities.h
index 5fa15efd08d0..f2ff31f0f5b6 100644
--- a/libsemanage/src/utilities.h
+++ b/libsemanage/src/utilities.h
@@ -116,6 +116,16 @@ int semanage_str_count(char *data, char what);
 void semanage_rtrim(char *str, char trim_to);
 
 /**
+ * @param      value being searched for
+ * @param      replacement value that replaces found search values
+ * @param      string being searched and replaced on
+ * @param      maximum number of value occurences (zero for unlimited)
+ * @return     newly-allocated string with the replaced values
+ */
+char *semanage_str_replace(const char *search, const char *replace,
+			   const char *src, size_t lim);
+
+/**
  * @param data    some string
  * @return  modifies the string such that the first whitespace char becomes
  *	    '\0', ending the string.
diff --git a/libsemanage/tests/test_utilities.c b/libsemanage/tests/test_utilities.c
index b46f18db2a99..30ac7f5823e6 100644
--- a/libsemanage/tests/test_utilities.c
+++ b/libsemanage/tests/test_utilities.c
@@ -40,6 +40,7 @@ void test_semanage_split(void);
 void test_semanage_list(void);
 void test_semanage_str_count(void);
 void test_semanage_rtrim(void);
+void test_semanage_str_replace(void);
 void test_semanage_findval(void);
 void test_slurp_file_filter(void);
 
@@ -101,6 +102,10 @@ int semanage_utilities_add_tests(CU_pSuite suite)
 	if (NULL == CU_add_test(suite, "semanage_rtrim", test_semanage_rtrim)) {
 		goto err;
 	}
+	if (NULL == CU_add_test(suite, "semanage_str_replace",
+				test_semanage_str_replace)) {
+		goto err;
+	}
 	if (NULL == CU_add_test(suite, "semanage_findval",
 				test_semanage_findval)) {
 		goto err;
@@ -257,6 +262,35 @@ void test_semanage_rtrim(void)
 	free(str);
 }
 
+void test_semanage_str_replace(void)
+{
+	const char *test_str = "Hello, I am %{USERNAME} and my id is %{USERID}";
+	char *str1, *str2;
+
+	str1 = semanage_str_replace("%{USERNAME}", "root", test_str, 0);
+	CU_ASSERT_STRING_EQUAL(str1, "Hello, I am root and my id is %{USERID}");
+
+	str2 = semanage_str_replace("%{USERID}", "0", str1, 1);
+	CU_ASSERT_STRING_EQUAL(str2, "Hello, I am root and my id is 0");
+	free(str1);
+	free(str2);
+
+	str1 = semanage_str_replace(":(", ";)", "Test :( :) ! :(:(:))(:(", 0);
+	CU_ASSERT_STRING_EQUAL(str1, "Test ;) :) ! ;);):))(;)");
+	free(str1);
+
+	str1 = semanage_str_replace(":(", ";)", "Test :( :) ! :(:(:))(:(", 3);
+	CU_ASSERT_STRING_EQUAL(str1, "Test ;) :) ! ;);):))(:(");
+	free(str1);
+
+	str1 = semanage_str_replace("", "empty search string", "test", 0);
+	CU_ASSERT_EQUAL(str1, NULL);
+
+	str1 = semanage_str_replace("a", "", "abracadabra", 0);
+	CU_ASSERT_STRING_EQUAL(str1, "brcdbr");
+	free(str1);
+}
+
 void test_semanage_findval(void)
 {
 	char *tok;
-- 
2.11.0
