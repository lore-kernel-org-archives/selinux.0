Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6D119F113
	for <selinux@vger.kernel.org>; Mon, 11 Nov 2024 14:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731334642; cv=none; b=ScuYuINu8Wso9nrjVzeOzbmY0aNOw22j50hD3smY+gm2ot3+GBhTse3H8cgSh0l5jIE9m4ed2IJ8290DsR9APtBC//Fiv2Jnch8VH12lTy8R/5FSlcrlR8+mQbO/17WVkFjFUdlJ4q/v7GSiW62XNdS16g6gXBbdzA4QVckecAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731334642; c=relaxed/simple;
	bh=8yQf4NvJsNA1/tp0933mk3NUBWO+E+lbBgxlNsXCkfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nbIi62v3Mco9O9JH3jlLRMSzWuP3QaNtH8QdhQg8zse5+DzVqoghZT+T8TF7MxdBGqmzpnMDOxMRbhSEab9SXNHZZ5AS6hIV74EnmT21Zlqnb1KkSfzJ1spU1HPPewZwRRFMt7HIp7GIMfGn9BaPcQkI8WKJRKJvFfAp0dgCcIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=W9dRqXsH; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="W9dRqXsH"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1731334636;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nDmtPL9C7TYTDpODA7ICoFwr1NgCb6ae14GVdS3YSvM=;
	b=W9dRqXsH+9xaPfexb+BIas7Guk5HYU44B7G7WwoZF02dRz+7f4jJzI/quETVvt7yv29MP3
	Os0lw9p8g4f3B7t+o7wdmNCbYYkGrVfBzH7mX13hmXoMri7e/jyLR5m9lQQRHeAZwWnOuf
	nI0QQwteQf2Qm2DfbN+q42jWPlk/Uh2hyCMUWtlNZYy7UvOyDWrNkDiZmGkGnM2o4iEcl6
	M42bjFaxYaHPJ4sDckeSlem7v+ViXaLmhYrMkF6LIw2wV0GdvJ4tSEu2O3CVoWf/G0ca5T
	FyP3PMIOV7US7+yFDjrk5UfANBnA+0Iiq3kGfGjdau5f2pHQ6M9r2lf2Q1qTnQ==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 17/47] libsemanage: drop casts to same type
Date: Mon, 11 Nov 2024 15:16:36 +0100
Message-ID: <20241111141706.38039-17-cgoettsche@seltendoof.de>
In-Reply-To: <20241111141706.38039-1-cgoettsche@seltendoof.de>
References: <20241111141706.38039-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsemanage/src/genhomedircon.c  | 10 +++++-----
 libsemanage/src/semanage_store.c |  8 ++++----
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
index 31c9a5bf..29ff4259 100644
--- a/libsemanage/src/genhomedircon.c
+++ b/libsemanage/src/genhomedircon.c
@@ -472,10 +472,10 @@ static int HOME_DIR_PRED(const char *string)
 /* new names */
 static int USERNAME_CONTEXT_PRED(const char *string)
 {
-	return (int)(
-		(strstr(string, TEMPLATE_USERNAME) != NULL) ||
-		(strstr(string, TEMPLATE_USERID) != NULL)
-	);
+	return
+		strstr(string, TEMPLATE_USERNAME) != NULL ||
+		strstr(string, TEMPLATE_USERID) != NULL
+	;
 }
 
 /* This will never match USER if USERNAME or USERID are found. */
@@ -484,7 +484,7 @@ static int USER_CONTEXT_PRED(const char *string)
 	if (USERNAME_CONTEXT_PRED(string))
 		return 0;
 
-	return (int)(strstr(string, TEMPLATE_USER) != NULL);
+	return strstr(string, TEMPLATE_USER) != NULL;
 }
 
 static int STR_COMPARATOR(const void *a, const void *b)
diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index f5c19e00..fb3f3cc9 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -2656,7 +2656,7 @@ int semanage_fc_sort(semanage_handle_t * sh, const char *buf, size_t buf_len,
 			continue;
 		}
 
-		temp->path = (char *)strndup(&line_buf[start], regex_len);
+		temp->path = strndup(&line_buf[start], regex_len);
 		if (!temp->path) {
 			ERR(sh, "Failure allocating memory.");
 			semanage_fc_node_destroy(temp);
@@ -2691,7 +2691,7 @@ int semanage_fc_sort(semanage_handle_t * sh, const char *buf, size_t buf_len,
 
 			/* Record the inode type. */
 			temp->file_type =
-			    (char *)strndup(&line_buf[i], type_len);
+			    strndup(&line_buf[i], type_len);
 			if (!temp->file_type) {
 				ERR(sh, "Failure allocating memory.");
 				semanage_fc_node_destroy(temp);
@@ -2724,7 +2724,7 @@ int semanage_fc_sort(semanage_handle_t * sh, const char *buf, size_t buf_len,
 		finish = i;
 		context_len = finish - start;
 
-		temp->context = (char *)strndup(&line_buf[start], context_len);
+		temp->context = strndup(&line_buf[start], context_len);
 		if (!temp->context) {
 			ERR(sh, "Failure allocating memory.");
 			semanage_fc_node_destroy(temp);
@@ -2963,7 +2963,7 @@ int semanage_nc_sort(semanage_handle_t * sh, const char *buf, size_t buf_len,
 		}
 
 		node->rule =
-		    (char *)strndup(line_buf + offset, line_len - offset);
+		    strndup(line_buf + offset, line_len - offset);
 		node->rule_len = line_len - offset;
 		node->next = NULL;
 
-- 
2.45.2

