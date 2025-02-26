Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3D0153BE8
	for <selinux@vger.kernel.org>; Wed, 26 Feb 2025 09:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740563057; cv=none; b=QwkYZxsnPBsYEd5El+RLMDBLoWSlbJfvgR3bibvj5EE/Y2VqVeA+WbC/RLPsyCK/BfHRqeYboT9sgrcgLFDI2Knym4lSLFJCINj4gOuPpYjQaqfZ2AMoNQ/MNJ1W0nXjZwgUEExK8gRnRixQi8YmB56c4o2xQrRGmlsEty9CBf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740563057; c=relaxed/simple;
	bh=mW1NeOA0nI5HTseG2jX88wULriP8zNeHmPDTONVX+p4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sq3GkXcPmUwIcLz5+tfxdyhguCJdy92kpExuwsZqyJAmD4MaKL1r6wbJG0pJkvzI21WMGQ+MQWckySl+JzjpA4eDemnpw233yJ3OtvTOTxdx/BUaOgabzNT5+LGbm7iuMogf0iv4rnIv0i6JRYV9P7Zw1+2cFieyEpOgrpwKTTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=rVeUxNb5; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="rVeUxNb5"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1740563053;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iPTXm/0frYKCelOpzJwRrPZAY8IQOQ4WxqvSL1U4fpM=;
	b=rVeUxNb57s67J/V1ssRqefJzz19zQqUpYehgUjYZDR5k3lasnbA3xUjwbrM7KcsxVxjrGp
	tHl63+BW6KjVHa43+NDQ8TvNq0lphxiFBwJvxrh3x8/uJKKtc+GZmywonl8ALOA+PEJSAs
	+StvAOEyLiRHOD9eDgQp/hKs+NYjyqUROXnEG+YRhuF/R+z+6M5XnvgvzB+31ICTyRpraD
	wSyuEI5uW8oMTm/RjYHvEKZ8tx6jVoAdp4/kLyarDQaYnDFFU12WRaM56/YQx6SCgdZvAw
	vWWWDKxL+SnDGe3+WRagxboX48qF44J8KMxBokeVa7axapix3DXdh7aXytgQSA==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 1/2] libselinux: introduce context_to_str(3)
Date: Wed, 26 Feb 2025 10:44:08 +0100
Message-ID: <20250226094409.41452-2-cgoettsche@seltendoof.de>
In-Reply-To: <20250226094409.41452-1-cgoettsche@seltendoof.de>
References: <20250226094409.41452-1-cgoettsche@seltendoof.de>
Reply-To: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

Currently context_t offers the function context_str(3) to get the
formatted security context of the internal representation. The return
value is a pointer to an internally, on call allocated, stored cache.
This can lead to invalidation issues and if the caller wants to store
the result duplicate allocations.

Introduce context_to_str(3) not using any internal cache and moving
ownership of the string to the client.

Use in appropriate places.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/include/selinux/context.h |  8 ++++++++
 libselinux/src/context.c             | 30 ++++++++++++++++++++++++++++
 libselinux/src/get_context_list.c    | 15 +++++++-------
 libselinux/src/libselinux.map        |  5 +++++
 libselinux/src/selinux_restorecon.c  |  2 +-
 libselinux/src/setexecfilecon.c      |  2 +-
 6 files changed, 52 insertions(+), 10 deletions(-)

diff --git a/libselinux/include/selinux/context.h b/libselinux/include/selinux/context.h
index 59d9bb69..1b62fc72 100644
--- a/libselinux/include/selinux/context.h
+++ b/libselinux/include/selinux/context.h
@@ -27,6 +27,14 @@ extern "C" {
 
 	extern const char *context_str(context_t con);
 
+/*
+ * Return the string value of the context_t.
+ * Similar to context_str(3), but the client owns the string
+ * and needs to free it via free(3).
+ */
+
+	extern char *context_to_str(context_t con);
+
 /* Free the storage used by a context */
 	extern void context_free(context_t con);
 
diff --git a/libselinux/src/context.c b/libselinux/src/context.c
index 33c48ef3..2891e5a0 100644
--- a/libselinux/src/context.c
+++ b/libselinux/src/context.c
@@ -141,6 +141,36 @@ const char *context_str(context_t context)
 }
 
 
+/*
+ * Return a new string value of the context.
+ */
+char *context_to_str(context_t context)
+{
+	const context_private_t *n = context->ptr;
+	char *buf;
+	size_t total = 0;
+
+	for (int i = 0; i < 4; i++) {
+		if (n->component[i]) {
+			total += strlen(n->component[i]) + 1;
+		}
+	}
+	buf = malloc(total);
+	if (buf != NULL) {
+		char *cp = buf;
+
+		cp = stpcpy(cp, n->component[0]);
+		for (int i = 1; i < 4; i++) {
+			if (n->component[i]) {
+				*cp++ = ':';
+				cp = stpcpy(cp, n->component[i]);
+			}
+		}
+	}
+	return buf;
+}
+
+
 /* Returns nonzero iff failed */
 static int set_comp(context_private_t * n, int idx, const char *str)
 {
diff --git a/libselinux/src/get_context_list.c b/libselinux/src/get_context_list.c
index 8d5ee6fb..0f3bdc5c 100644
--- a/libselinux/src/get_context_list.c
+++ b/libselinux/src/get_context_list.c
@@ -145,7 +145,7 @@ static int get_context_user(FILE * fp,
 	char *linerole, *linetype;
 	char **new_reachable = NULL;
 	char *usercon_str;
-	const char *usercon_str2;
+	char *usercon_str2;
 	context_t usercon;
 
 	int rc;
@@ -255,7 +255,7 @@ static int get_context_user(FILE * fp,
 			rc = -1;
 			goto out;
 		}
-		usercon_str2 = context_str(usercon);
+		usercon_str2 = context_to_str(usercon);
 		if (!usercon_str2) {
 			context_free(usercon);
 			rc = -1;
@@ -264,6 +264,7 @@ static int get_context_user(FILE * fp,
 
 		/* check whether usercon is already in reachable */
 		if (is_in_reachable(*reachable, usercon_str2)) {
+			free(usercon_str2);
 			context_free(usercon);
 			start = end;
 			continue;
@@ -271,20 +272,18 @@ static int get_context_user(FILE * fp,
 		if (security_check_context(usercon_str2) == 0) {
 			new_reachable = reallocarray(*reachable, *nreachable + 2, sizeof(char *));
 			if (!new_reachable) {
+				free(usercon_str2);
 				context_free(usercon);
 				rc = -1;
 				goto out;
 			}
 			*reachable = new_reachable;
-			new_reachable[*nreachable] = strdup(usercon_str2);
-			if (new_reachable[*nreachable] == NULL) {
-				context_free(usercon);
-				rc = -1;
-				goto out;
-			}
+			new_reachable[*nreachable] = usercon_str2;
+			usercon_str2 = NULL;
 			new_reachable[*nreachable + 1] = 0;
 			*nreachable += 1;
 		}
+		free(usercon_str2);
 		context_free(usercon);
 		start = end;
 	}
diff --git a/libselinux/src/libselinux.map b/libselinux/src/libselinux.map
index 02f5b761..ab002f01 100644
--- a/libselinux/src/libselinux.map
+++ b/libselinux/src/libselinux.map
@@ -257,3 +257,8 @@ LIBSELINUX_3.8 {
   global:
     matchpathcon_filespec_add64;
 } LIBSELINUX_3.5;
+
+LIBSELINUX_3.9 {
+  global:
+    context_to_str;
+} LIBSELINUX_3.8;
diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index ab1c5216..f5023492 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -611,7 +611,7 @@ static int compare_types(const char *curcon, const char *newcon, char **newtypec
 		rc |= context_role_set(conb, context_role_get(cona));
 		rc |= context_range_set(conb, context_range_get(cona));
 		if (!rc) {
-			*newtypecon = strdup(context_str(conb));
+			*newtypecon = context_to_str(conb);
 			if (!*newtypecon) {
 				rc = -1;
 				goto err;
diff --git a/libselinux/src/setexecfilecon.c b/libselinux/src/setexecfilecon.c
index 4b31e775..15346621 100644
--- a/libselinux/src/setexecfilecon.c
+++ b/libselinux/src/setexecfilecon.c
@@ -34,7 +34,7 @@ int setexecfilecon(const char *filename, const char *fallback_type)
 		if (context_type_set(con, fallback_type))
 			goto out;
 		freecon(newcon);
-		newcon = strdup(context_str(con));
+		newcon = context_to_str(con);
 		if (!newcon)
 			goto out;
 	}
-- 
2.47.2

