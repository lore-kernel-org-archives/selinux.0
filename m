Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA83D403AEF
	for <selinux@vger.kernel.org>; Fri, 12 Jun 2026 17:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781284160; cv=none; b=Sz5pTixbGuaszGmvPveutM0EVtkAf2ZSr/9c6AQHHVFeq89Sy28uXdWDaNLuIaYK++1oZjYSI3fdqxEK3IitPz/MyT6Q+xUatKWbYiZzvJMKehT4+e9IT/CFKw6pKuZfiNjL/p60gvqM1Nt5h5lEXW7fBAj7E8Si0vdqQqzCodI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781284160; c=relaxed/simple;
	bh=ElP0s8kzvBY/fMANya9nc3iIOeDthNHM1hd2Xktx/LQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o42chaaCBxIVtHvqiwWw974F2VNoWg09kWLPJLZBPU6vVR5+zA7NoGV3CrCM1DjslHRqUFKZqV7+9RGCMZlWW8uFxUR636WLz7OTHjI4Bhkew3Q2b3zL9NPL1PqV8WIl5SVJhf6uu2xDLrtB2sQQuRoc4XwTGE9k9vyU6Y0MzX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qk1F59TH; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qk1F59TH"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-91591f19716so134701285a.3
        for <selinux@vger.kernel.org>; Fri, 12 Jun 2026 10:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781284158; x=1781888958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vw7pJbZpicbTJomGfqn1YX7H6bBn8b5YA1gyZ8HJ9vU=;
        b=Qk1F59THRSeamg3cVTb9q2j/EVT1bKGUyZF34WvMySW5ncOcZ2SrPU6QUClt8UPhXI
         xZG3kmWdPsm0ozkNahqDQ5l/7oO/xOfBygHU4muz7Q8sDqdTeP6RGIxZmlv54dtshIRh
         DJg7OTO0uzGf7YnxvvzKnsWpJ7t07TVNwNpnL5lDjzI9MvlfsmVU+RNZb+cE4+v0Ts17
         f2rQKYmGSO3QGd1CVSPAAngvh6In8eVrN5Ofr+pHmqmsQ541r6VeqLFtkfpYl4VNwics
         UcnFgeDIQDz0kpYrfKzHfHXFHI2MkkYzVwp9lQ+ypbPcKCQRnyoHZ29nVmN+pwjQJWFI
         fSGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781284158; x=1781888958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vw7pJbZpicbTJomGfqn1YX7H6bBn8b5YA1gyZ8HJ9vU=;
        b=puCN7k8WUCjH98wdf3MmaQlsQ38cMif75jDrGbcjHO2BGRk9pHArfjqg7+0bAv2Kxs
         1sN63J5QxIORD+1NeyU7j8JiiLc5M5y2J0HMuUTUm85VBVRjKrsM6TbGSFqDtKVgWOSS
         YgaHV4ibatRQDWGj9IMEd2NVDDrkQtiiVwhHObJrIGUcGPyqlwjoYZ4PyMgmY+0g5gCO
         PphrIqjlg02sETfUVHqaY4ak6zupAu7Ma+qcKU1T9jDy++PKRR1RiVYqQgPcz7OFge7l
         34+P18dus2Y9D6sX/tEI5FvyJx41BxfarZWCYQC1MehN3+L0G3C62Wty5Qox941iyFx3
         oJHA==
X-Gm-Message-State: AOJu0YynFoCfSRU4AggIbWxqMT8s3GoZK2EZ2eSqso7KLuVZsbKCAbZm
	27nWNcjETXOZ29MoHHQtZ8QqWxlC9apABVPlSovCmmHEpqMXTCerss49el/ogQ==
X-Gm-Gg: Acq92OHuWRuuYh7JF97qog9zwOw55US7R51G10G9rNsRT6SRvPsaimhK1u4HYd8dfkD
	BWgWazlkkdGGWGFQZdfNSTT3D7a2dDPWF7oAMK1BXefmrjJkY118AD6XDE1KRc8FU8okV6c/xjy
	diy9ghdZ1T1hD8klD7mskrAGfxtJs0GB9NfKPP2086/9bzRSs/xp2bkYo3suJ8MZ2w2IcSTdsQg
	UTAzgRha7T0lX3AFtCtHY3cMdnU5X0wWAgmhQKwu6o/DzEljvSwhCBvLoX7TXJUGDgr5ACbkUkU
	8j8dq7fWIISCY+TGsxXGiS1YaMdR+hMjxd+GFrmcc497Bl/b0LrjDtczE9Vn7vFht2KQ//G0kYH
	mZbm4EFO4Wp/k5URtS35W484IXfjeUtDOAPD96014fFcdks9YHdNFwqGja3bOpY4isTJ0sc+OQd
	FUl1gO/45298UJBSluStLhAK4m1Gi0c6rLqIWMjQFZwm3Nw2Pyuz1iFvb3f+DAXeHawEx+Vrwwv
	jT7lvJ7/fPV61iNXgSWxm1n7GIbspf/8S5Wgg==
X-Received: by 2002:a05:620a:1722:b0:915:db15:4e39 with SMTP id af79cd13be357-9161bccabffmr551143985a.28.1781284157459;
        Fri, 12 Jun 2026 10:09:17 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91619ed8aa6sm265590085a.2.2026.06.12.10.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 10:09:17 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Seth Moore <sethmo@google.com>,
	Purushottam Choudhary <purushottamchoudhary29@gmail.com>
Subject: [RFC PATCH 2/3] libselinux: stringrep: serialize access to the discover_class_cache
Date: Fri, 12 Jun 2026 13:08:55 -0400
Message-ID: <20260612170856.17904-3-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612170856.17904-1-stephen.smalley.work@gmail.com>
References: <20260612170856.17904-1-stephen.smalley.work@gmail.com>
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
 libselinux/src/stringrep.c | 97 +++++++++++++++++++++++++-------------
 1 file changed, 65 insertions(+), 32 deletions(-)

diff --git a/libselinux/src/stringrep.c b/libselinux/src/stringrep.c
index ec6fc637..d009c856 100644
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
@@ -176,41 +175,63 @@ err1:
 
 void selinux_flush_class_cache(void)
 {
-	struct discover_class_node *cur = discover_class_cache, *prev = NULL;
-	size_t i;
-
-	while (cur != NULL) {
-		free(cur->name);
+	struct discover_class_node *head, *tail;
 
-		for (i = 0; i < MAXVECTORS; i++)
-			free(cur->perms[i]);
-
-		free(cur->perms);
-
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
 	struct discover_class_node *node;
+	security_class_t value;
 
+	__pthread_mutex_lock(&discover_class_lock);
 	node = get_class_cache_entry_name(s);
-	if (node == NULL) {
-		node = discover_class(s);
+	if (node) {
+		value = node->value;
+		__pthread_mutex_unlock(&discover_class_lock);
+		return map_class(node->value);
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
 
-	return map_class(node->value);
+	__pthread_mutex_lock(&discover_class_lock);
+	/* duplicates are harmless so we don't bother to check */
+	node->next = discover_class_cache;
+	discover_class_cache = node;
+	__pthread_mutex_unlock(&discover_class_lock);
+
+	return map_class(value);
 }
 
 security_class_t mode_to_security_class(mode_t m)
@@ -239,13 +260,17 @@ access_vector_t string_to_av_perm(security_class_t tclass, const char *s)
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
@@ -254,14 +279,16 @@ access_vector_t string_to_av_perm(security_class_t tclass, const char *s)
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
@@ -269,16 +296,22 @@ const char *security_av_perm_to_string(security_class_t tclass,
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

