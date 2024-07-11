Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C6812C549
	for <selinux@vger.kernel.org>; Thu, 11 Jul 2024 14:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720709601; cv=none; b=sUSLMlinznf3XR4+m6gkm1cjjV/4o6TMyjGcr2pR+ELLFnHM0I9OqNVW6yo4dkfALWhTq6jQZ6gQHxT8LIPaHgV+od152Veuu6KzHlxPp7pAkAnENW1sIrOWwK+VyXShlX83CnnnG+XcvsgDaKlC0c1Z/xbbXTHqE4OyPzGmo9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720709601; c=relaxed/simple;
	bh=YsAp92bkPYjED7S9V3Zjfl/WXmJamJ574CGJOEGrdRg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yw2tSqf4vK73FSG44WdQGEjXKt941DUwPuIkVmAHttn2EBcHTgTp6WrWTUFYHrPmU2z0SyFyHWKsPTcEpntYxE9g3uR5nRsUvZ8AXai63GOQaRvKAyHeS+tm36buO/eU863elJF7xaPrJDRdvcKqKlHLnt0KGakghKUOE+8o7mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XjmcjiZD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XjmcjiZD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720709599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kq2growGao5DyZ5qkeVvqQEEAODDmXIfPKytuw/zc5I=;
	b=XjmcjiZDNXtlhZdOTGYGlVLN/CRi+1qXjEvaIra4iZ48AkIi43wuM06c56m++oL7JXCSKy
	AqkRBB2QKglrVRPD2ohyuX9/Audaz51NlMw6qxsc1HzddnaFo9ZyMpy58zya0z4s6hIYn4
	9aV8W9+TxvaQsOkoaRcTbLr2rbfG8Lc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-599-jxtuUIDyO8Sg-GJupkYDIw-1; Thu,
 11 Jul 2024 10:53:16 -0400
X-MC-Unique: jxtuUIDyO8Sg-GJupkYDIw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 36C941954B0A
	for <selinux@vger.kernel.org>; Thu, 11 Jul 2024 14:53:16 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.244])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 806FE1955E89
	for <selinux@vger.kernel.org>; Thu, 11 Jul 2024 14:53:15 +0000 (UTC)
From: Vit Mojzis <vmojzis@redhat.com>
To: selinux@vger.kernel.org
Subject: [RFC PATCH] libsemanage: Do not change file context when copying files
Date: Thu, 11 Jul 2024 16:15:04 +0200
Message-ID: <20240711145257.392771-2-vmojzis@redhat.com>
In-Reply-To: <20240711145257.392771-1-vmojzis@redhat.com>
References: <20240711145257.392771-1-vmojzis@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Issue:
  # semodule -B
  # ls -lZ  /etc/selinux/targeted/contexts/files

-rw-r--r--. 1 root root unconfined_u:object_r:file_context_t:s0 421397 Jul 11 09:57 file_contexts
-rw-r--r--. 1 root root unconfined_u:object_r:file_context_t:s0 593470 Jul 11 09:57 file_contexts.bin
-rw-r--r--. 1 root root unconfined_u:object_r:file_context_t:s0  14704 Jul 11 09:57 file_contexts.homedirs
-rw-r--r--. 1 root root unconfined_u:object_r:file_context_t:s0  20289 Jul 11 09:57 file_contexts.homedirs.bin

  SELinux user changed from system_u to the user used to execute semodule

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
 libsemanage/src/semanage_store.c | 24 +++++++++++++++++++++++-
 libsemanage/src/semanage_store.h |  1 +
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index 27c5d349..694c1519 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -731,7 +731,9 @@ int semanage_copy_file(const char *src, const char *dst, mode_t mode,
 
 	if (!mode)
 		mode = S_IRUSR | S_IWUSR;
-	
+
+	semanage_setfscreatecon(src);
+
 	mask = umask(0);
 	if ((out = open(tmp, O_WRONLY | O_CREAT | O_TRUNC, mode)) == -1) {
 		umask(mask);
@@ -812,6 +814,7 @@ static int semanage_copy_dir_flags(const char *src, const char *dst, int flag)
 	}
 
 	if (stat(dst, &sb) != 0) {
+		semanage_setfscreatecon(src);
 		mask = umask(0077);
 		if (mkdir(dst, S_IRWXU) != 0) {
 			umask(mask);
@@ -831,6 +834,7 @@ static int semanage_copy_dir_flags(const char *src, const char *dst, int flag)
 		snprintf(path2, sizeof(path2), "%s/%s", dst, names[i]->d_name);
 		if (S_ISDIR(sb.st_mode)) {
 			mask = umask(0077);
+			semanage_setfscreatecon(path);
 			if (mkdir(path2, 0700) == -1 ||
 			    semanage_copy_dir_flags(path, path2, flag) == -1) {
 				umask(mask);
@@ -952,6 +956,24 @@ cleanup:
 	return status;
 }
 
+/* Get file context of "path" and use it for the next file to be created.
+ * To be used for creating a sandbox labeled the same as the original SELinux store */
+int semanage_setfscreatecon(const char *path)
+{
+	int status = 0;
+	char *fcontext_raw = NULL;
+
+	if (getfilecon(path, &fcontext_raw) < 0){
+		fcontext_raw = NULL;
+	}
+
+	status = setfscreatecon_raw(fcontext_raw);
+
+	freecon(fcontext_raw);
+
+	return status;
+}
+
 /********************* sandbox management routines *********************/
 
 /* Creates a sandbox for a single client. Returns 0 if a
diff --git a/libsemanage/src/semanage_store.h b/libsemanage/src/semanage_store.h
index 1fc77da8..135e6ac6 100644
--- a/libsemanage/src/semanage_store.h
+++ b/libsemanage/src/semanage_store.h
@@ -124,6 +124,7 @@ int semanage_get_cil_paths(semanage_handle_t * sh, semanage_module_info_t *modin
 int semanage_get_active_modules(semanage_handle_t *sh,
 			       semanage_module_info_t **modinfo, int *num_modules);
 
+int semanage_setfscreatecon(const char *path);
 
 /* lock file routines */
 int semanage_get_trans_lock(semanage_handle_t * sh);
-- 
2.43.0

