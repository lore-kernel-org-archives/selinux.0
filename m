Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76402EAD19;
	Tue, 17 Jun 2025 14:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750169192; cv=none; b=RKBC57sPAwAOE8LHEKMEJFcf1mG8VBawkZA3dDEWQBiFcNkuPLY8Jw2Olg9+Cfuqh5whJ8W22MCTnwllxuy4zhj8dfwwYa7iv3hWHU99ylPjv7ynm41zbO0N37+Ht+0NiM4mxk5NQdapL5pzfa6EbFgBnlAo08cmoxx/q910Oac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750169192; c=relaxed/simple;
	bh=Y1S59WdSZDJiJmGnDA4YeVXddt/+PzBJwc09g4u4mWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hMB929vPi8h3AJo+9heFogyeRYCkdkwPxXNLM0mGJY9LfNUGVgSUhQ6GdA/U98fTTie99zacFkRbyVSrWS5ZFe+OrHl88uCjHn99OQ8kszhMLGdn/5zsgek3yF5FocGP7sX3EI3hsss3wIzOkcMq6AV1ZixgJA9bPoTOu9e+r3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dKCg738z; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dKCg738z"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7d20f799fe9so676034785a.2;
        Tue, 17 Jun 2025 07:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750169189; x=1750773989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qrjXV73tcxArxBfaP25fwEocN2/8rpZFNQIoY18pg10=;
        b=dKCg738z5ftAEp0dEPADM9V2o7OqdP3k1xvDfcQU0OJ26AXZuFO+H5zuyg8yKO8V+X
         L9gHPjfe3Egu3z/pjl9iz9NTP66EMrHC1SfkY4Gi60uOE/Mv4KA2BuRP5VEJ8+CISJAN
         jeX4aZ3SNmPBNmbQXF3mdQxPSYxZm5SFcaxfvXTwVyM8YAYHXV6fNObU5ADnzxs5pIa8
         2A0Qxz4bOS5r0t9nc6X+QYHPIUjTNI38ucAdELlqT/jk5ItD7UAmOyPOrREgR8hw2iWx
         jUwpJjDMKj7rkmUni159T8fAZnVm5aFKLVACHKhWyS4/XTidRnbULweAcywP5By5e4Iz
         JyqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750169189; x=1750773989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qrjXV73tcxArxBfaP25fwEocN2/8rpZFNQIoY18pg10=;
        b=On4bgAio5As9BWcLSq9x+xbT1Y2rXu76GGF09T+iJV2B7vWTlDN6vszkjoFzODmoyv
         LMO0bZJOmtGHcAby4alDtVVZ2eie0k8YVrSCWU3+C2svVS01LhSwJUXeTIdtp82kMGMT
         JSCb2Q43xuWvVqq9l3rH5wVkTpLmqzRntxI7+3stOkCxAANcYqcdlZWoVF1YiVgZbz0C
         wt+nlfolzdzfKxqKV1NEP4grrmeIlg7WivadqDcbqe0Sy0nmCL2UXKjFZiw6gZS/HZK7
         z9oZ39q/G3e3fr8SJRgXSWZxVexV0nPmUtJHR0FJ7VXSJCwCS6AhJdveLABawZe3o4kG
         iE7A==
X-Forwarded-Encrypted: i=1; AJvYcCUdCJZr3LOWbgn3ANlUfBkWBTDUnVmEzANzRgG9R2qqQfIQ4kFI3qVIq0DqJj60v5btI8DInIo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrkD6bpIw7XghbIDB0o7Ww8NvyrkS3cFJW0vzUp+wLXblu2dPe
	qQYFkRh3Ewr6GejIZ9/hAXJAbWJh+tK4jpuC7AyZtIRdkEWjYClcuAPDsAUltQ==
X-Gm-Gg: ASbGnctTnVBGgNowDmsh902fRVQujU1HkyVWbgU12anDBfF9XfuqjBdWOrjAlk2CccL
	KYu3+narP/f0QIVHnpxfMW3/ddYJY3sE0PEdbbRtutEy9RpEBDa9iiIjc9bqJbQP0iTz1n95Yzg
	BW7YBypf8ufcinfz6N8hukbyHxwklZ8/p6XQ+4d3+vN6uRyI8IkkO20OlxfkpthPTpA/fsrjnfE
	7U1t/K5744bUVZ4OvaGs/g3AsSpbh9mSsHLYCgpryKcdYtdAFbLNtC/s5LXKOWu2Hcou+5N9iW/
	A8ApDKJ1ZI4ramIwT54P+WUkaDBExqNMjeEjkljyrgFnMU/mbbLU/Wth/8Pwr3JxjKT+MoUT2+D
	gzVrbdtfXbxNRF0lFEV/nDqASv+vgCyuVBwtgVuhDJGA2WWBkmw0+7v9sairsPEVEp1CWoMxIOI
	Nk
X-Google-Smtp-Source: AGHT+IFtP8zkDNagaT4OfmJwSdQTK86tPR5NkIgnveEhIqFpzW/uIVnV1IlDU69RGG6GVQa9ZxOfcQ==
X-Received: by 2002:a05:620a:2990:b0:7d3:9109:4472 with SMTP id af79cd13be357-7d3c6cda074mr2332960385a.37.1750169189124;
        Tue, 17 Jun 2025 07:06:29 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3b8edbe29sm651079585a.91.2025.06.17.07.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 07:06:28 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v5 20/42] selinux: maintain a small cache in the global SID table
Date: Tue, 17 Jun 2025 10:05:07 -0400
Message-ID: <20250617140531.2036-21-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617140531.2036-1-stephen.smalley.work@gmail.com>
References: <20250617140531.2036-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Maintain a small cache in the global SID table to avoid needing
to map the context string each time we use a given SID in a different
namespace than the original one.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/Kconfig                 | 11 +++
 security/selinux/global_sidtab.c         | 58 ++++++++++++++++
 security/selinux/hooks.c                 |  1 +
 security/selinux/include/global_sidtab.h |  7 ++
 security/selinux/include/sidtab.h        | 29 +++++++-
 security/selinux/ss/sidtab.c             | 85 ++++++++++++++++++++++++
 6 files changed, 189 insertions(+), 2 deletions(-)

diff --git a/security/selinux/Kconfig b/security/selinux/Kconfig
index aa25da389c46..f7bd54aa136c 100644
--- a/security/selinux/Kconfig
+++ b/security/selinux/Kconfig
@@ -141,3 +141,14 @@ config SECURITY_SELINUX_MAXNSDEPTH
 	help
 	  This option sets the default maximum depth of SELinux namespaces.
 	  The value may be viewed or modified via /sys/fs/selinux/maxnsdepth.
+
+config SECURITY_SELINUX_SS_SID_CACHE_SIZE
+	int "Global SID to security server SID translation cache size"
+	depends on SECURITY_SELINUX_NS
+	default 4
+	help
+	  This option defines the size of the global SID -> security server
+	  SID cache, which improves the performance of mapping global SIDs.
+	  Setting this option to 0 disables the cache completely.
+
+	  If unsure, keep the default value.
diff --git a/security/selinux/global_sidtab.c b/security/selinux/global_sidtab.c
index 48934b429c8c..e1acf6607788 100644
--- a/security/selinux/global_sidtab.c
+++ b/security/selinux/global_sidtab.c
@@ -119,6 +119,11 @@ static int map_global_sid_to_ss(struct selinux_state *state, u32 sid,
 	int rc;
 	char *scontext;
 	u32 scontext_len;
+#if CONFIG_SECURITY_SELINUX_SS_SID_CACHE_SIZE > 0
+	struct sidtab_ss_sid_cache *cache;
+	unsigned long flags;
+	int i, first, last;
+#endif
 
 	if (sid <= SECINITSID_NUM) {
 		*ss_sid = sid;
@@ -136,6 +141,16 @@ static int map_global_sid_to_ss(struct selinux_state *state, u32 sid,
 		rcu_read_unlock();
 		return 0;
 	}
+#if CONFIG_SECURITY_SELINUX_SS_SID_CACHE_SIZE > 0
+	cache = &entry->ss_sid_cache;
+	for (i = cache->first; i >= 0 && i <= cache->last; i++) {
+		if (cache->state[i] == state && cache->ss_sid[i]) {
+			*ss_sid = cache->ss_sid[i];
+			rcu_read_unlock();
+			return 0;
+		}
+	}
+#endif
 	rcu_read_unlock();
 
 	rc = global_sid_to_context(sid, &scontext, &scontext_len);
@@ -144,10 +159,53 @@ static int map_global_sid_to_ss(struct selinux_state *state, u32 sid,
 
 	rc = selinux_ss_context_to_sid_force(state, scontext,
 					     scontext_len, ss_sid, gfp);
+#if CONFIG_SECURITY_SELINUX_SS_SID_CACHE_SIZE > 0
+	if (rc == 0) {
+		spin_lock_irqsave(&global_sidtab.lock, flags);
+		entry = sidtab_search_entry_force(&global_sidtab, sid);
+		if (!entry) {
+			spin_unlock_irqrestore(&global_sidtab.lock, flags);
+			return -EINVAL;
+		}
+		cache = &entry->ss_sid_cache;
+		first = cache->first;
+		last = cache->last;
+		for (i = 0; i < ARRAY_SIZE(cache->ss_sid) && cache->ss_sid[i];
+		     i++)
+			;
+		if (i < ARRAY_SIZE(cache->ss_sid)) {
+			WRITE_ONCE(cache->ss_sid[i], *ss_sid);
+			/* ensure that the SID is written before the state */
+			smp_wmb();
+			WRITE_ONCE(cache->state[i], state);
+		} else {
+			if (first == -1)
+				i = 0;
+			else
+				i = first;
+			WRITE_ONCE(cache->ss_sid[i], *ss_sid);
+			/* ensure that the SID is written before the state */
+			smp_wmb();
+			WRITE_ONCE(cache->state[i], state);
+		}
+		/* ensure that state is updated before indices */
+		smp_wmb();
+		if (first == -1 || i < first)
+			WRITE_ONCE(cache->first, i);
+		if (last == -1 || i > last)
+			WRITE_ONCE(cache->last, i);
+		spin_unlock_irqrestore(&global_sidtab.lock, flags);
+	}
+#endif
 	kfree(scontext);
 	return rc;
 }
 
+void global_sidtab_invalidate_state(struct selinux_state *state)
+{
+	sidtab_invalidate_state(&global_sidtab, state);
+}
+
 static int map_ss_sid_to_global(struct selinux_state *state, u32 ss_sid,
 				u32 *out_sid, gfp_t gfp)
 {
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index ff8f89c9a324..fda182be4334 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7848,6 +7848,7 @@ static void selinux_state_free(struct work_struct *work)
 
 	do {
 		parent = state->parent;
+		global_sidtab_invalidate_state(state);
 		if (state->status_page)
 			__free_page(state->status_page);
 		selinux_policy_free_rcu(state->policy);
diff --git a/security/selinux/include/global_sidtab.h b/security/selinux/include/global_sidtab.h
index 2e06bb865326..bf450d775b66 100644
--- a/security/selinux/include/global_sidtab.h
+++ b/security/selinux/include/global_sidtab.h
@@ -9,11 +9,18 @@
 
 #ifdef CONFIG_SECURITY_SELINUX_NS
 extern int global_sidtab_init(void);
+
+struct selinux_state;
+void global_sidtab_invalidate_state(struct selinux_state *state);
 #else
 static inline int global_sidtab_init(void)
 {
 	return 0;
 }
+
+static inline void global_sidtab_invalidate_state(struct selinux_state *state)
+{
+}
 #endif /* CONFIG_SECURITY_SELINUX_NS */
 
 #endif /* _GLOBAL_SIDTAB_H_ */
diff --git a/security/selinux/include/sidtab.h b/security/selinux/include/sidtab.h
index 61389c588775..2df3ac0df935 100644
--- a/security/selinux/include/sidtab.h
+++ b/security/selinux/include/sidtab.h
@@ -18,6 +18,16 @@
 
 #include "context.h"
 
+#ifdef CONFIG_SECURITY_SELINUX_NS
+#if CONFIG_SECURITY_SELINUX_SS_SID_CACHE_SIZE > 0
+struct sidtab_ss_sid_cache {
+	u32 ss_sid[CONFIG_SECURITY_SELINUX_SS_SID_CACHE_SIZE];
+	struct selinux_state *state[CONFIG_SECURITY_SELINUX_SS_SID_CACHE_SIZE];
+	int first, last;
+};
+#endif
+#endif
+
 struct sidtab_entry {
 	u32 sid;
 	u32 hash;
@@ -27,8 +37,11 @@ struct sidtab_entry {
 #endif
 	struct hlist_node list;
 #ifdef CONFIG_SECURITY_SELINUX_NS
-	u32 ss_sid; // global SID table only
-	struct selinux_state *state; // global SID table only
+	u32 ss_sid;
+	struct selinux_state *state;
+#if CONFIG_SECURITY_SELINUX_SS_SID_CACHE_SIZE > 0
+	struct sidtab_ss_sid_cache ss_sid_cache;
+#endif
 #endif
 };
 
@@ -166,4 +179,16 @@ static inline int sidtab_sid2str_get(struct sidtab *s,
 }
 #endif /* CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE > 0 */
 
+#ifdef CONFIG_SECURITY_SELINUX_NS
+#if CONFIG_SECURITY_SELINUX_SS_SID_CACHE_SIZE > 0
+extern void sidtab_invalidate_state(struct sidtab *s,
+				    struct selinux_state *state);
+#else
+static inline void sidtab_invalidate_state(struct sidtab *s,
+					   struct selinux_state *state)
+{
+}
+#endif /* CONFIG_SECURITY_SELINUX_SS_SID_CACHE_SIZE > 0 */
+#endif /* CONFIG_SECURITY_SELINUX_NS */
+
 #endif /* _SS_SIDTAB_H_ */
diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
index 19991f01cd20..eea37f78bec9 100644
--- a/security/selinux/ss/sidtab.c
+++ b/security/selinux/ss/sidtab.c
@@ -648,3 +648,88 @@ int sidtab_sid2str_get(struct sidtab *s, struct sidtab_entry *entry, char **out,
 }
 
 #endif /* CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE > 0 */
+
+#ifdef CONFIG_SECURITY_SELINUX_NS
+#if CONFIG_SECURITY_SELINUX_SS_SID_CACHE_SIZE > 0
+static void sidtab_invalidate_state_entry(struct sidtab_entry *entry,
+					  struct selinux_state *state)
+{
+	struct sidtab_ss_sid_cache *cache;
+	int i, first, last;
+
+	cache = &entry->ss_sid_cache;
+	first = cache->first;
+	last = cache->last;
+	for (i = first; i >= 0 && i <= last; i++) {
+		if (cache->state[i] == state) {
+			WRITE_ONCE(cache->ss_sid[i], 0);
+			WRITE_ONCE(cache->state[i], NULL);
+			if (first == i) {
+				for (first = i + 1; first <= last &&
+					     !cache->ss_sid[first]; first++)
+					;
+				if (first == (i+1))
+					first = -1;
+				WRITE_ONCE(cache->first, first);
+			}
+			if (last == i) {
+				for (last = i - 1; last >= first &&
+					     last >= 0 &&
+					     !cache->ss_sid[last]; last--)
+					;
+				if (last == (i-1))
+					last = -1;
+				WRITE_ONCE(cache->last, last);
+			}
+			return;
+		}
+	}
+}
+
+static void sidtab_invalidate_state_tree(union sidtab_entry_inner entry,
+					 u32 level,
+					 struct selinux_state *state)
+{
+	u32 i;
+
+	if (level != 0) {
+		struct sidtab_node_inner *node = entry.ptr_inner;
+
+		if (!node)
+			return;
+
+		for (i = 0; i < SIDTAB_INNER_ENTRIES; i++)
+			sidtab_invalidate_state_tree(node->entries[i],
+						     level - 1, state);
+	} else {
+		struct sidtab_node_leaf *node = entry.ptr_leaf;
+
+		if (!node)
+			return;
+
+		for (i = 0; i < SIDTAB_LEAF_ENTRIES; i++)
+			sidtab_invalidate_state_entry(&node->entries[i], state);
+	}
+}
+
+void sidtab_invalidate_state(struct sidtab *s, struct selinux_state *state)
+{
+	u32 i, level;
+	unsigned long flags;
+
+	spin_lock_irqsave(&s->lock, flags);
+
+	for (i = 0; i < SECINITSID_NUM; i++)
+		if (s->isids[i].set)
+			sidtab_invalidate_state_entry(&s->isids[i].entry, state);
+
+	level = SIDTAB_MAX_LEVEL;
+	while (level && !s->roots[level].ptr_inner)
+		--level;
+
+	sidtab_invalidate_state_tree(s->roots[level], level, state);
+
+	spin_unlock_irqrestore(&s->lock, flags);
+}
+#endif /* CONFIG_SECURITY_SELINUX_SS_SID_CACHE_SIZE > 0 */
+#endif /* CONFIG_SECURITY_SELINUX_NS */
-- 
2.49.0

