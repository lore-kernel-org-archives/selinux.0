Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uBJD4msr020578
 for <selinux@tycho.nsa.gov>; Mon, 19 Dec 2016 08:04:48 -0500
Received: from localhost.localdomain (32.206.133.77.rev.sfr.net
 [77.133.206.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 24481564788
 for <selinux@tycho.nsa.gov>; Mon, 19 Dec 2016 14:04:43 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 4/7] libsemanage: simplify string utilities functions
Date: Mon, 19 Dec 2016 14:04:01 +0100
Message-Id: <20161219130404.11496-5-nicolas.iooss@m4x.org>
In-Reply-To: <20161219130404.11496-1-nicolas.iooss@m4x.org>
References: <20161219130404.11496-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Use string functions from C standard library instead of ustr. This makes
the code simpler and make utilities.c no longer depend on ustr library.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsemanage/src/utilities.c | 64 +++++++++++++--------------------------------
 1 file changed, 18 insertions(+), 46 deletions(-)

diff --git a/libsemanage/src/utilities.c b/libsemanage/src/utilities.c
index f48ffa489d14..b5b92b085310 100644
--- a/libsemanage/src/utilities.c
+++ b/libsemanage/src/utilities.c
@@ -26,7 +26,6 @@
 #include <string.h>
 #include <sys/types.h>
 #include <assert.h>
-#include <ustr.h>
 
 #define TRUE 1
 #define FALSE 0
@@ -74,64 +73,37 @@ char *semanage_split_on_space(const char *str)
 {
 	/* as per the man page, these are the isspace() chars */
 	const char *seps = "\f\n\r\t\v ";
-	size_t slen = strlen(seps);
-	size_t off = 0, rside_len = 0;
-	char *retval = NULL;
-	Ustr *ustr = USTR_NULL, *temp = USTR_NULL;
+	size_t off = 0;
 
 	if (!str)
-		goto done;
-	if (!(ustr = ustr_dup_cstr(str)))
-		goto done;
-	temp =
-	    ustr_split_spn_chrs(ustr, &off, seps, slen, USTR_NULL,
-				USTR_FLAG_SPLIT_DEF);
-	if (!temp)
-		goto done;
-	/* throw away the left hand side */
-	ustr_sc_free(&temp);
-
-	rside_len = ustr_len(ustr) - off;
-	temp = ustr_dup_subustr(ustr, off + 1, rside_len);
-	if (!temp)
-		goto done;
-	retval = strdup(ustr_cstr(temp));
-	ustr_sc_free(&temp);
+		return NULL;
 
-      done:
-	ustr_sc_free(&ustr);
-	return retval;
+	/* skip one token and the spaces before and after it */
+	off = strspn(str, seps);
+	off += strcspn(str + off, seps);
+	off += strspn(str + off, seps);
+	return strdup(str + off);
 }
 
 char *semanage_split(const char *str, const char *delim)
 {
-	Ustr *ustr = USTR_NULL, *temp = USTR_NULL;
-	size_t off = 0, rside_len = 0;
-	char *retval = NULL;
+	char *retval;
+	size_t delim_len;
 
 	if (!str)
-		goto done;
+		return NULL;
 	if (!delim || !(*delim))
 		return semanage_split_on_space(str);
-	ustr = ustr_dup_cstr(str);
-	temp =
-	    ustr_split_cstr(ustr, &off, delim, USTR_NULL, USTR_FLAG_SPLIT_DEF);
-	if (!temp)
-		goto done;
-	/* throw away the left hand side */
-	ustr_sc_free(&temp);
-
-	rside_len = ustr_len(ustr) - off;
 
-	temp = ustr_dup_subustr(ustr, off + 1, rside_len);
-	if (!temp)
-		goto done;
-	retval = strdup(ustr_cstr(temp));
-	ustr_sc_free(&temp);
+	retval = strstr(str, delim);
+	if (retval == NULL)
+		return NULL;
 
-      done:
-	ustr_sc_free(&ustr);
-	return retval;
+	delim_len = strlen(delim);
+	do {
+		retval += delim_len;
+	} while (!strncmp(retval, delim, delim_len));
+	return strdup(retval);
 }
 
 int semanage_list_push(semanage_list_t ** list, const char *data)
-- 
2.11.0
