Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E902EE272;
	Fri, 20 Jun 2025 17:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750441539; cv=none; b=MV7UWn0awMOGQWDHpbeq0nF34NO0Mh/nNh42z/ZmDCfMTYOUtwcviK+MTGaDpjbxs32t/ItjYpTf20MljWLdCdBq6rkQ3p44Nv/7G3hawk+yE4jhiOkv7qEKyvsBCou3tz4fcTOb5hsib8PHZKHQEcPxtsdNAYxULzaVfKWREek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750441539; c=relaxed/simple;
	bh=s1VE7NI9sBLPm+vUhRxYxRvreGYUIDS6HHeq575CDEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WIp6dPEEZ/klwZBdfaZyvX0bHflBwQind52Li2B/4Wgieto0YOlM+OjvKWMjp6k0M6fSFNLbxH+oB6cAN7BJS0JDDt+y2NVJQMZgmt5TRg1pxvM2r9V4QV4tRAACNcpDv1STh3MkF21b4kkn0k/3n6BJkEXQkKYlaZM2weS2UL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gzvGxLl2; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gzvGxLl2"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6fafb6899c2so22693096d6.0;
        Fri, 20 Jun 2025 10:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750441536; x=1751046336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bkWuAWsZtRSkUraNp17Mr8ZlrMlvQ8rOvU3rQgxet0E=;
        b=gzvGxLl26lu0ZbPTAUII2t7ubk3UbMR4Lsi6rkt4IbREVnTKWFex/fTIAOXguSBJPH
         u05hg570MLLKQyyzS5ufTgQIdgmt+82f4qE5aDKeiSTxFN9PhzwHiwUCB2S2v/yQwQN9
         J66zwfMpqg42mjIgkkKh129FALJDfNrKeWy8uVB+XbAQ5MC5RTiJA703ZkogVrKhB9Dw
         kOxBsWfIgqPGpFCsdYIfrMwPtD0ufd4YXMDhaPhFzfkeCjRWyJvk5OLuCIcefA39BhIs
         Q/OCKLNX1Nsw8sLocr/WF2Jlk2pZDENHuo7GndNy50B7pKN8JLqE23uXNN0nXpMuTv1I
         zQEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750441536; x=1751046336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bkWuAWsZtRSkUraNp17Mr8ZlrMlvQ8rOvU3rQgxet0E=;
        b=YB6TlXQ1iksAoLGvUwf2pjvj6RmAJ/OPGTUgktU7U1or1/cmdrBhGpJVIExRw+3YBt
         R5WexJpxQJhF3NDdZUUyyS50LtGsQT1q445yR+P+aD24IsO28onENKEW2fzPFSzpsd+3
         aGa2aydGhbCu0eTv1Bm5vW483Va8oBYw8ukfAmqqgPWKOET8rNY5getL2Za6JNcgwwhi
         hPse5jILzfT5WuX6XUTDBFELCVkzAHA9PHsyVnbrvYhVwgNz69WnHP1IJRWx/nFKd7Wt
         rmPgD16ofDMfn5zY1YuMFCPPSQuUQ2GUNbo1a176HRPKPHZZS1Knjf3MFn+hWyStJndh
         BgIw==
X-Forwarded-Encrypted: i=1; AJvYcCWz7qbUhpOk/M8UAi/AdWJZsdTRjfp61Yr2ZN9mFci3KHfaolBs5oWPzcof7EbLwc8n6pZOHzg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4WccI53AIugI/1osdlpW2Sy/f9Xw7rWEQL29GJSgjRiwiegQk
	luXy0/kgvV8MSYMWDhPO7bRXbTwg64HGN0e9Vr8TX/l7YYZZQmCEo6IB7q+bjw==
X-Gm-Gg: ASbGnctbw+X5nR5vgdNipwK5IuHsWhiJsrsus0m9Rivh99emuYdr8RgNjF5GBu6VnaU
	ncl3aXlNB4GjY4Yf26g8UzLpfkijrczLni7ieoHsMD9nszfYLSuJ01SIp64lEFOfCkdSy+akk3q
	WWliYTLCV4FoRPeLRip5Kd2LqEGfXhyOJNNYNNmKxSarZCDni5ukYxpd1cwiaDKnGLo8vAVNxw7
	i5gLJWtyP2eNICcFREN5pQTPNtBRRQ76kTm7k7gc40wbpdeXf7TF5FtrQsgG+umUXwh5qPFc8s5
	emNZ4ZkRkowGJXi9gbvH2GBaMSTHWMyBek8dznaOKgZyyHmSUVdSnCGR4XAEDQQcle3q9Z4jdqb
	XD72FuAsE8FhnkzWwjkJFx9vakbFYU/sYzyUmZvCQyCpbzQth/5R1ypojwqz7QtFLLg==
X-Google-Smtp-Source: AGHT+IH+zFZUZpAaDMVQU6UsiAmVxsRrf8rOr/HAB6ZdWQS8nGwQaq1KKEbZNoN0XywYMth+lOsXWw==
X-Received: by 2002:a05:6214:490a:b0:6fa:b8d9:e6df with SMTP id 6a1803df08f44-6fd0c94e54emr45554746d6.10.1750441535877;
        Fri, 20 Jun 2025 10:45:35 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd093decf0sm14580976d6.16.2025.06.20.10.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 10:45:35 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v6 20/42] selinux: maintain a small cache in the global SID table
Date: Fri, 20 Jun 2025 13:44:32 -0400
Message-ID: <20250620174502.1838-21-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620174502.1838-1-stephen.smalley.work@gmail.com>
References: <20250620174502.1838-1-stephen.smalley.work@gmail.com>
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
index c807c560f04c..b75b9b16bbf7 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7860,6 +7860,7 @@ static void selinux_state_free(struct work_struct *work)
 
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

