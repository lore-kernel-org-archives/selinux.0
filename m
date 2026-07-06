Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C0D2BEC52
	for <selinux@vger.kernel.org>; Mon,  6 Jul 2026 14:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783348341; cv=none; b=amFCoJXP1Hs+zFXt584W9+y/iveNCU8Gs0qN28/tHW82B7uPIl+QDlRDgtCafEja3+HhB+kLm0KQ8fMhBmfdBT0AYd7Ksd7GRKixav5BWzf9kAQm12MuhCLKhZOD50WLrMHcLLrbv9B221QxpsAOsrrH2elJHZkPFdvliwH/5wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783348341; c=relaxed/simple;
	bh=fnNIOIytEQTUuIX0OpJFQ1NKW75Cy5H6MvsNK/98yco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nzNvi4i7MQfE8EdAxcSMujNb2fRnc4X940B/Nzi2TGFPpUB/ngT/g/hstiwAfzTem8MQwUWOGOpw0j7JjQbiRTl9gADUOqBR0rt5BXOS1UKl/zMXt9NyznUfPZgjkzbHYJFHDkcQnlx91GEVCiudvlURbhubID+3t4MZzt+JNG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oo0UyMGC; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oo0UyMGC"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-51c0a81d286so20641981cf.1
        for <selinux@vger.kernel.org>; Mon, 06 Jul 2026 07:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783348339; x=1783953139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7C3KTgVpXhfCvWTRNw1lSs9LhnnzGPamVVAEuzL755s=;
        b=oo0UyMGCcOIeAilBBSegW8Q1m5zR4HbJma3O9Us6X1gTvIqPIbxW5vwPVmoVdCHada
         Q+EWaD+HeZvtIzTnb4Vxk8ZTKhHd4vxSQrR3nbI27VBYfWl2b13wt7OAgfiPFw3f0WEa
         1Pf4N8C4Rw7lJRDMZ5+y4427a1tMHgR57WkgEcNOcKEhy/5uBkPLimtsmrrZ5bksfTVL
         ySfCLaonINbaDNa296HQDcBqBpbFjLbsN+yTpUJ9HwsM3RNAm4qiQu71dfrvK7rMOSOM
         qbHwkxWr/vxsivLFe9XAY4OmtA/hn2fSe+/lk8y3M0Zd5onK7XkpBDnzRiHlktDthjK3
         zchw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783348339; x=1783953139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7C3KTgVpXhfCvWTRNw1lSs9LhnnzGPamVVAEuzL755s=;
        b=hIUPdB9RRFwAhdtmrM3TdmdWqV49JzmxuG40TLsav9C+J9RO8rv44eUSuS+9Gnxb2W
         Tf1McfoDZHZ9YGW9D1ONA2VCK3SZo+9cbX60fjCfdgynWQ87+6UqEGHd152zWtBAMS7G
         alJJdgCrt9LlXIm6vcEr062eMZIkQ/rwaXGOjdVfQlUQMvhZmbAm55QP44EVzHDS2RAV
         8DH7JwK5J8qnn9t95q312/NEpOuGtU8cspZyeedwOE8yWPlMdBeq/A9Udzq+xK1HBiHh
         +ybj1tiQWkaBjbMaOHCLlAR7eB0EIsiyNittFqVCqRt5AMzdErSeZNLPkotbBCrMf61/
         qolw==
X-Gm-Message-State: AOJu0Yxqcud329GSz6n3nwYt2T0+TMiljJADbpF6BT2SlA24i1pa6zW7
	AmJPsRZNRGaKwBbqeEYJkvjDyKsGS11uQzANvv8Z3Ml04susQCVhcFRSfNZibA==
X-Gm-Gg: AfdE7cncaVOTh7+wD972JQ/uqvEFkcnmzbhjD/KsF9vUlo/yoVj4Y+DnuUqJU/f6Yim
	8KsKalE4jtTfOAZYgrdVRSHfUYo0YR+XMTljkHibdCfGDuEv+8rpkdzM9xCVVwEMcs1NcBzUs8/
	HvVLAmB/oPSI3lzKca2orhfmgt1Zu1LUe6LtaihazbyS+ZerWxJhGcd5BLWY9wWQbFnbYUuZe/h
	rnPPAfvLhEVQwZ3ydoeFR44FGfdAMq2YBA/ui7LGvF38oyMNmiCtWuFHQ2S9tUDJaNS7WJS3q+p
	dGuSlExF879HzoMsIN3DSZOr/Yhe5idnI9sKdwFr5C5R8bP4KKB/dgEgTXd+mbZrxZl/7YMGkQz
	AHVYNkrhdaejg1Xpias7ArxTQ9r95r351bLNFXvLlhDBpQhONI/tGnhE6EImcfXsonlUxx9NCjv
	C4vQ07LhzpaTGiG0BElPgAuUdeIyICsB/+moiXf7PtSPESHVsytUdE1/sErDrAIuFytVJTYtkwb
	/hChEqpJhQzO8WB
X-Received: by 2002:a05:622a:cf:b0:516:ed2c:9c75 with SMTP id d75a77b69052e-51c3c05a9f4mr186629371cf.16.1783348338762;
        Mon, 06 Jul 2026 07:32:18 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c41ab77e7sm92790761cf.3.2026.07.06.07.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 07:32:18 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Seth Moore <sethmo@google.com>,
	Purushottam Choudhary <purushottamchoudhary29@gmail.com>
Subject: [PATCH v3 2/5] libselinux: stringrep: serialize access to the discover_class_cache
Date: Mon,  6 Jul 2026 10:31:52 -0400
Message-ID: <20260706143155.36629-3-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260706143155.36629-1-stephen.smalley.work@gmail.com>
References: <20260706143155.36629-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The discover_class_cache list is accessed without locking by the
string_to_*() and *_to_string() functions in libselinux for
translating between string names and class/perm values, and returns
pointers to strings within this list to callers.
selinux_flush_class_cache() frees the list upon a policy reload,
called by avc_process_policyload() from selinux_status_updated() and
avc_netlink_process().

Make this safe for multi-threaded users by introducing and taking a
mutex around the list accesses, and by moving flushed nodes to a
retired list rather than freeing them so that returned string pointers
remain valid. Given the infrequency of policy reloads, the relative
stability of the class/perm mapping even across policy reloads, and
the small amount of memory required, this seems a worthwhile tradeoff.
If it becomes an issue, there are several options:
1. Only load/refresh new/modified class/permission names and values
upon policy reload rather than flushing and reloading them all,
2. Provide a way to drain the retired list safely when the application
knows it is no longer using any returned strings.

Fixes: #287 #335 #336
Link: https://lore.kernel.org/selinux/CAJsHiNx1E7x1jaBkS0i4L1nBWXp8YXLHRWcCaDaH4LOn=zm+Zw@mail.gmail.com/
Link: https://lore.kernel.org/selinux/20220120073329.15234-1-purushottamchoudhary29@gmail.com/
Reported-by: Seth Moore <sethmo@google.com>
Reported-by: Purushottam Choudhary <purushottamchoudhary29@gmail.com>

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libselinux/src/stringrep.c | 120 +++++++++++++++++++++++++++----------
 1 file changed, 87 insertions(+), 33 deletions(-)

diff --git a/libselinux/src/stringrep.c b/libselinux/src/stringrep.c
index ec6fc637..cd9841ca 100644
--- a/libselinux/src/stringrep.c
+++ b/libselinux/src/stringrep.c
@@ -27,7 +27,9 @@ struct discover_class_node {
 	struct discover_class_node *next;
 };
 
+static pthread_mutex_t discover_class_lock = PTHREAD_MUTEX_INITIALIZER;
 static struct discover_class_node *discover_class_cache = NULL;
+static struct discover_class_node *discover_class_retired = NULL;
 
 static struct discover_class_node *get_class_cache_entry_name(const char *s)
 {
@@ -156,9 +158,6 @@ static struct discover_class_node *discover_class(const char *s)
 	}
 	closedir(dir);
 
-	node->next = discover_class_cache;
-	discover_class_cache = node;
-
 	return node;
 
 err4:
@@ -176,41 +175,84 @@ err1:
 
 void selinux_flush_class_cache(void)
 {
-	struct discover_class_node *cur = discover_class_cache, *prev = NULL;
-	size_t i;
-
-	while (cur != NULL) {
-		free(cur->name);
-
-		for (i = 0; i < MAXVECTORS; i++)
-			free(cur->perms[i]);
-
-		free(cur->perms);
+	struct discover_class_node *head, *tail;
 
-		prev = cur;
-		cur = cur->next;
+	__pthread_mutex_lock(&discover_class_lock);
+	head = discover_class_cache;
+	discover_class_cache = NULL;
 
-		free(prev);
+	/*
+	 * Move old list to the retired chain rather than
+	 * freeing it; other threads may hold pointers to
+	 * class/perm strings within it returned by
+	 * security_class_to_string() and
+	 * security_av_perm_to_string(). This incurs a small
+	 * memory cost but given the infrequency of policy
+	 * reloads, it should never be significant. If
+	 * required, a new interface could be introduced to
+	 * allow the application to safely drain the retired
+	 * list when it knows it is safe to do so.
+	 */
+	if (head) {
+		tail = head;
+		while (tail->next)
+			tail = tail->next;
+		tail->next = discover_class_retired;
+		discover_class_retired = head;
 	}
-
-	discover_class_cache = NULL;
+	__pthread_mutex_unlock(&discover_class_lock);
 }
 
 security_class_t string_to_security_class(const char *s)
 {
-	struct discover_class_node *node;
+	struct discover_class_node *node, *retry;
+	security_class_t value;
+	size_t i;
 
+	__pthread_mutex_lock(&discover_class_lock);
 	node = get_class_cache_entry_name(s);
-	if (node == NULL) {
-		node = discover_class(s);
+	if (node) {
+		value = node->value;
+		__pthread_mutex_unlock(&discover_class_lock);
+		return map_class(value);
+	}
+	__pthread_mutex_unlock(&discover_class_lock);
 
-		if (node == NULL) {
-			errno = EINVAL;
-			return 0;
-		}
+	/* Discover outside of lock; reads selinuxfs */
+	node = discover_class(s);
+	if (node == NULL) {
+		errno = EINVAL;
+		return 0;
 	}
+	value = node->value;
+
+	/*
+	 * Retry cache lookup with lock held in case
+	 * another thread raced with us. If we don't
+	 * find it, add the new one; else use
+	 * the old one and free the new one.
+	 */
+	__pthread_mutex_lock(&discover_class_lock);
+	retry = get_class_cache_entry_name(s);
+	if (!retry) {
+		node->next = discover_class_cache;
+		discover_class_cache = node;
+	} else {
+		value = retry->value;
+		/*
+		 * We can only safely free node here
+		 * because it wasn't yet added to the cache.
+		 */
+		free(node->name);
+		for (i = 0; i < MAXVECTORS; i++)
+			free(node->perms[i]);
+		free(node->perms);
+		free(node);
+		node = NULL;
+	}
+	__pthread_mutex_unlock(&discover_class_lock);
 
-	return map_class(node->value);
+	return map_class(value);
 }
 
 security_class_t mode_to_security_class(mode_t m)
@@ -239,13 +281,17 @@ access_vector_t string_to_av_perm(security_class_t tclass, const char *s)
 	struct discover_class_node *node;
 	security_class_t kclass = unmap_class(tclass);
 
+	__pthread_mutex_lock(&discover_class_lock);
 	node = get_class_cache_entry_value(kclass);
 	if (node != NULL) {
 		size_t i;
 		for (i = 0; i < MAXVECTORS && node->perms[i] != NULL; i++)
-			if (strcmp(node->perms[i], s) == 0)
+			if (strcmp(node->perms[i], s) == 0) {
+				__pthread_mutex_unlock(&discover_class_lock);
 				return map_perm(tclass, UINT32_C(1) << i);
+			}
 	}
+	__pthread_mutex_unlock(&discover_class_lock);
 
 	errno = EINVAL;
 	return 0;
@@ -254,14 +300,16 @@ access_vector_t string_to_av_perm(security_class_t tclass, const char *s)
 const char *security_class_to_string(security_class_t tclass)
 {
 	struct discover_class_node *node;
+	const char *name;
 
 	tclass = unmap_class(tclass);
 
+	__pthread_mutex_lock(&discover_class_lock);
 	node = get_class_cache_entry_value(tclass);
-	if (node == NULL)
-		return NULL;
-	else
-		return node->name;
+	name = node ? node->name : NULL;
+	__pthread_mutex_unlock(&discover_class_lock);
+
+	return name;
 }
 
 const char *security_av_perm_to_string(security_class_t tclass,
@@ -269,16 +317,22 @@ const char *security_av_perm_to_string(security_class_t tclass,
 {
 	struct discover_class_node *node;
 	size_t i;
+	const char *name;
 
 	av = unmap_perm(tclass, av);
 	tclass = unmap_class(tclass);
 
+	__pthread_mutex_lock(&discover_class_lock);
 	node = get_class_cache_entry_value(tclass);
 	if (av && node)
 		for (i = 0; i < MAXVECTORS; i++)
-			if ((UINT32_C(1) << i) & av)
-				return node->perms[i];
+			if ((UINT32_C(1) << i) & av) {
+				name = node->perms[i];
+				__pthread_mutex_unlock(&discover_class_lock);
+				return name;
+			}
 
+	__pthread_mutex_unlock(&discover_class_lock);
 	return NULL;
 }
 
-- 
2.54.0

