Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426D4305E07;
	Thu, 14 Aug 2025 13:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755178047; cv=none; b=FOWdDSoQQxcnZd7ZijM569BXmaDU0Xsb41gD1YSMsH/Hb7hQBi/XZmiIMUjUhJxjKoEhu/DsnL2LYav7NzHnVYtkEts/p/OHn4seXFoyEv8r6ZkBcCadcy5oAQUyTLz35p3eXfXc3VM4XxS7l68Ux0hb/xLnisfTjJ5rzu4aZX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755178047; c=relaxed/simple;
	bh=Sa3GTIzS0lw/zFSYa4uqTKmp/p9AUKxeR+lSxKo1Dz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HHJz5Lif9BddduQGOKN5xTYUmv8vLbDXD+uWs3/ReXsGX36v4ob7r2gzO/kJFva9QtQiQYS2YmWrjm88+DVamFZvVXdR26vBvzX3gC/ERhAN2Isjmh3PV8nphhJPZBhIVvUT8IrWZwkI8ZYQenT0hmhhMrXub/TJQAGCyZpHu4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l8eDRgw8; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l8eDRgw8"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4b109acc6c6so13251471cf.1;
        Thu, 14 Aug 2025 06:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755178044; x=1755782844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I6Kj1NmUbqqRwQi5TKXUFLaYVtVZgpPoPzFkesIlD1E=;
        b=l8eDRgw8ay/sLC12UboErD2Zrpw1tiUaqnFzcCv/2CMHBnD0BTFkUmxv8sVjH25Cy9
         P0RIJ/JXbHN6PCS8bV0kmrs38Qv0X4HhIUBM12KG9tAzW0AmrfGNy7VJVpLFbIkfWGqg
         wEaNOVEvt8HAb6AF0wuMqsqZHJAmn2Nhm01KVBYTTnOBpAkcDtxGc+BR8QC87T4mUHuV
         bvdSKGpZ1NBAFcGDRIZnkMxCZ10cPPhOFMWAcxTH7FN8/Q7EW1hNp5FcoCoIG6qlYaHy
         Tv8PchmE8kr/WQ+KrTg529nlskFjEvKtdwKrR71ZCb9a0afGa/k1NbMYOBznrgUQr1+N
         MfVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755178044; x=1755782844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I6Kj1NmUbqqRwQi5TKXUFLaYVtVZgpPoPzFkesIlD1E=;
        b=CFpUCflK68vNlB+RqQnx8RZkiCnehtKVj6Zq33XOmywfoiNQLYVwRQL4x+OLngrxKv
         gaIvPlN+HC6jE6Q0/0OTw/+u4u0Ub9xHabxyMa5yXcys3ZYXJvg7Cgm3xyJN0fNIpoHn
         T36S4I5S+tp3pPZSOxf0TnJz9qkLmbvKgwOJBkHPMqs3AWihjqON/JECkm9KcPFAI3lr
         NO8hw3tHyjFfdOMEQnRAasQ1i7OhVL2O0eXbM+Lpmn4TPHCIWKZsC7dFq9m7oSVUzj5F
         VjIgPwtbVj723G5nHYyiZkF4b21VTH//nelNHLNVC/LkCvGbujFCXTVh8qOO1VCvT6w0
         ErzA==
X-Forwarded-Encrypted: i=1; AJvYcCUScO3utNSSO9uwhxrcBi+qltcg3ikHGPey5q/pJZBmzXuA+T/0IwKahvUPXVUrMf+jaRvl8Qk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEFilktQMqkuHVy3QWFVUijwZwVbEpGcvC8UhYY+nqBDV7uqCj
	VFDqcVLSelbIxsli9h/QwFZJVqUeInBo7WXXfO6lkR7JIBMKVbn31+JPz8CP2g==
X-Gm-Gg: ASbGncv5A4czRxTsmQOaxhXO93OPWyQ6X7SJuXfCVMS0RuvlK/WqME+4nGOxbLbiuq2
	dHEdtrZTMYMGnspaaDHfGqkKiRMcF1FxoKmDCggjdbUCDkZG1r4IYAjipX7EB9dlNuqCo/GrgmR
	48X7YWI4Ajn8b7i9wxQaJCI24KfokybDJxw/YnfFti7y2ZpndXSoEM7VjegQVT4+XCTR9xmMzQy
	DFrrbSM6wsDyDUfLdHzQFo6GukHOUckLgPRAwsuwTYy4jIr8a8FFUNsUn1OizkRr5y3X/wh6xXV
	kGBhwMsUQKoIRcamujPkI8R1OSLnCB5+8Rzd/JA/Oe+0OrYUEhKMMR3CCntuAXqgBsDmv12Gncm
	NTE4BnPhXqCMfkCQ+Nu6VpjYH1sbKxC+E/mBhbZt776UYLuDkLWcipOBYWfofGKNxdSW9eSLBTt
	QdoM6C/INMpuZDwqN47Q0QpZYFDw==
X-Google-Smtp-Source: AGHT+IFNOU43iMaMUGQCeGMsb5qFmpNmXMNL6Fp4WrABfb+xEXCKBQE3qHC5DZNXkeJGiozTqxAP2w==
X-Received: by 2002:a05:622a:11c3:b0:4b0:ac74:1388 with SMTP id d75a77b69052e-4b10aad646amr43573801cf.47.1755178043725;
        Thu, 14 Aug 2025 06:27:23 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b0733088e1sm153587391cf.61.2025.08.14.06.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 06:27:23 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v7 20/42] selinux: maintain a small cache in the global SID table
Date: Thu, 14 Aug 2025 09:26:11 -0400
Message-ID: <20250814132637.1659-21-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250814132637.1659-1-stephen.smalley.work@gmail.com>
References: <20250814132637.1659-1-stephen.smalley.work@gmail.com>
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
index 98347ddae2e9..e8cfd18a1cb1 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7874,6 +7874,7 @@ static void selinux_state_free(struct work_struct *work)
 
 	do {
 		parent = state->parent;
+		global_sidtab_invalidate_state(state);
 		if (state->status_page)
 			__free_page(state->status_page);
 		selinux_state_policy_free(state);
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
2.50.1

