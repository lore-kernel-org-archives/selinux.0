Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uBLIMCXj021001
 for <selinux@tycho.nsa.gov>; Wed, 21 Dec 2016 13:22:18 -0500
Received: from localhost.localdomain (32.206.133.77.rev.sfr.net
 [77.133.206.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 663FB5647EF
 for <selinux@tycho.nsa.gov>; Wed, 21 Dec 2016 19:22:12 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH v2 4/7] libsemanage: simplify string utilities functions
Date: Wed, 21 Dec 2016 19:21:01 +0100
Message-Id: <20161221182104.16967-5-nicolas.iooss@m4x.org>
In-Reply-To: <20161221182104.16967-1-nicolas.iooss@m4x.org>
References: <20161221182104.16967-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Use string functions from C standard library instead of ustr. This makes
the code simpler and make utilities.c no longer depend on ustr library.

This changes how semanage_split() behaves when delim is not empty (NULL
or "") and the input string contains several successive delimiters:
semanage_split("foo::::bar", ":") returned "bar" and now returns ":bar".
This would not have any impact in the current code as semanage_split()
is only called with delim="=" (through semanage_findval(), in
libsemanage/src/genhomedircon.c), in order to split a "key=value"
statement.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsemanage/src/utilities.c | 59 ++++++++++-----------------------------------
 1 file changed, 13 insertions(+), 46 deletions(-)

diff --git a/libsemanage/src/utilities.c b/libsemanage/src/utilities.c
index f48ffa489d14..fa86cc77dc56 100644
--- a/libsemanage/src/utilities.c
+++ b/libsemanage/src/utilities.c
@@ -26,7 +26,6 @@
 #include <string.h>
 #include <sys/types.h>
 #include <assert.h>
-#include <ustr.h>
 
 #define TRUE 1
 #define FALSE 0
@@ -74,64 +73,32 @@ char *semanage_split_on_space(const char *str)
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
+	return strdup(retval + strlen(delim));
 }
 
 int semanage_list_push(semanage_list_t ** list, const char *data)
-- 
2.11.0
