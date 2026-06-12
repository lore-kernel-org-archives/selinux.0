Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A8C3A7F55
	for <selinux@vger.kernel.org>; Fri, 12 Jun 2026 19:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781291529; cv=none; b=QineDYzhpywY2aSR81AxCOMKwgH2FpPlil/m1gstaEsNvAMc+1uDGuHI3z85+XQNqTUlpvxKQ+iM2DUXt+d0D+JNsmVbUVOabTkeYX0uaH7EZUH3zoB4huLUlIJOUvuKcGlXicRd6NBG7L+A69a+3Dpa904tVFCDLAVjFALEij0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781291529; c=relaxed/simple;
	bh=rUizprnRsKuQiFM5+VupoTybdNvot/eeKupLPe6Nz7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k84kNeIjKsRlfnObV5ze52gxZhCLRNUJfhYyyXyBKzuz7ZJB+iBMqbTet/V/ZfgoMfSTvcMJEw+Tkm0HOZTTOxgVO78zoWpnXCVx8okI1NWTTROsJbldJjvJcQ/SWtn6Gf/ZbsifL6iQj3GFCFDzE3h3Hdl+r6qyRm7Oq1Grre0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wj7RYli+; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wj7RYli+"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-91591f19716so148645085a.3
        for <selinux@vger.kernel.org>; Fri, 12 Jun 2026 12:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781291527; x=1781896327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LaAmrVONlLKC4fHwimdL4j0+nqSgD6xhsnTfgRlolmk=;
        b=Wj7RYli+3EWHydvuN9H7/Q7tr6k9+ZVfuvS+Hzj6zjF8G792Nl+TRFzxLw6JOK8xY6
         XJk4NCay3cOQGHunfw9Zll6yosdLbjG8nzmSe+RgJ8SkFPASbNy9/inWVXZcSK3jcplw
         8VPxlgJfjAWJdIFfUbA02ickt0xCxuSBYYbzRejzScY4qZ6ILT+iSSAUBYiSIx78rfMR
         omodm2q00PbBXvNMx+0in1OfuA/yNZaAJV1isYYy/m3J7VVeVc0oauS4t3btWRkDaLAu
         rLhz0TX1+Iu33G1s/tGzuEdKck4Qg4QeQNYqSD+Cj1ER4g3/q1ga+9a052YH2Jct7q1B
         /ejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781291527; x=1781896327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LaAmrVONlLKC4fHwimdL4j0+nqSgD6xhsnTfgRlolmk=;
        b=B41lUVIh/4VSbwmyXhK9kuuQqK3P4cSU/iDdoqApR9m2xTf37SuH3k8jlIxjkmoVYx
         kOQwMhRbSd522gF/Fcx4M9tkSMcORE8S6kJhabEGFKNJsUzQQPsphwcgE7akAgCE7++K
         ITY/tqiJQmnI1O/GKH7vzc/gtwWTug3KRRRLg8ctfArQWgUrPijFsbNK6/6efd65+oHm
         oBH+ah/2ZtK3dA0T/+so2NsIbQAny7X7Cf3WP3DVqusDcK3vXthdAqP7usQKTIp1v0mx
         66oCpzYy/u2iwl6Af4ypo8omkieYOcxN+CHAkvksu+T4kp8mwfl6mRkrmmzSiTOUc0AW
         Y7AQ==
X-Gm-Message-State: AOJu0YxnCKFLrqRTUjbQnxgYM+O6X5Sy3/JD1Lmzqv3+XK32YBwI8u9+
	jqhZNWhxqNGJCNPDmODRManTpvu9VfAuxg0pqfEQqq/iJOdNkAgck87xm4DJzw==
X-Gm-Gg: Acq92OEgNkJem69nXLomJDUIQcpkF0y6ugoMdL0rRW85LpdB/7a92IsEymc1hy/S5n3
	GfzQCQFSZ6rwSzCjwiZJXlr9aP/Z7dKVA+IOuuniWl5LH4le/MStbT49rXhTmO8NEAYfMRlVsp2
	uDs1tZDrVOTXgGeKr9vdOiStiVmEq/4y4qZKRGUEysacsTi6Ijz0JF27BiHE2xNGq39Z1vpj9Ng
	l6x1DBNrRYqo0lUo7wJmQvctcRpPtpB5yGm5HvNRCzAHgrkWktpCepDJpAKu1G6b1tkLgzVa9s8
	l1ownPL8OorD/kWv4yHROGufFBAZpJcsPTDv8wVIDMHNE6G9sijuMJNpMFW7aYIxwcNTZKGaWW4
	5TIVmk85wzI+iW9SxrMYSnO7Y+RjUrArQ8QoUF0E5JrWuPsBhW4chQXzxAcywezu0MTiwvkP1GN
	zhldfhcYUoyZV8f+zUE73JIvyIhGXhaC099STGNnliWIJJ/J9PHe+53/WKB9vzLvjsf+ogA7JLg
	86W3sEI+ZzhmUN56t8yKCl7WvKiQXP2hU+7zQ==
X-Received: by 2002:a05:620a:1a1e:b0:915:9047:940b with SMTP id af79cd13be357-9161baf40damr608981885a.1.1781291527014;
        Fri, 12 Jun 2026 12:12:07 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9161a04b472sm295086885a.37.2026.06.12.12.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 12:12:06 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Seth Moore <sethmo@google.com>,
	Purushottam Choudhary <purushottamchoudhary29@gmail.com>
Subject: [RFC PATCH v2 2/3] libselinux: stringrep: serialize access to the discover_class_cache
Date: Fri, 12 Jun 2026 15:11:45 -0400
Message-ID: <20260612191146.20122-3-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612191146.20122-1-stephen.smalley.work@gmail.com>
References: <20260612191146.20122-1-stephen.smalley.work@gmail.com>
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
v2 fixes string_to_security_class() to return the value saved prior to
unlocking, and to retry the cache lookup after taking the lock and
free the new node if a match is found rather than inserting a
duplicate.

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

