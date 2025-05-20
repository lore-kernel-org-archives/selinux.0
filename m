Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C4B28313F;
	Tue, 20 May 2025 12:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747742486; cv=none; b=OtMevFW17lLQ1cKVKsQLzF829tGA3HoBlc1gOLpVnbmC78B1gPGELrHZL/ZDk38GjW7ZCjBhH4Qdk8RuH4ppe46GJqCc6fz/oqpdJOPO/dWOWKf1oADQMGxx/XDvEx1UdIHUPH863otKZ6eY3QmrFGTUQusFj53fJAnvHPoLewY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747742486; c=relaxed/simple;
	bh=MLxPkXZ1sLJDUuTGYcnSbsTYas+49YIA0LdbP3QlRTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qAA2TDKjoAjl3/Kc7ufhVJFJDV+4FhbKoG95AG4CPI2AlRy83dfxif1u7rccpInIRNTIiQO9U/pOfcItXB54ooJwyh7NWErU9EOwJBWTD5f++jPxCXhM8KIJtuNDVUo4MlFSEaNKEpN0uC4n6CxGwJdtn73NMURhSdtSi4ViSXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RFWhSMFe; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RFWhSMFe"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2da73155e91so1395917fac.0;
        Tue, 20 May 2025 05:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747742483; x=1748347283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xiXqwtwAhXu4+jyqmGFxITCrsHEiUq2mzrMBhXH9F6A=;
        b=RFWhSMFeYEfcBnxydiG9rp0DtCNZYiPo4PxCMukHzkuJxKV2FNHXGquaY34f9pvmZP
         tUJ1V5XXsDBO4ZWL4XEXZydzbwpeK3qsa2qnRJyDucQsVLubV+kX3D5UOFdOeQTgR8+2
         3kBhAJZeDLTI08RL5HLgNRzqjAoOaKe47Qm/alDU1H8qzbFAPwqLrJE0VSsSVOQTGvtK
         W0TyoAZgcGGFx8cZwNMsffgtYVE5V40RM2tUzM0TYQBCWP4SS/tpYup/QvJNLuC1n3Df
         Lr9Mx0kzpwTgSlwW9g4ZkIHmGx9Pat80vQ34XKk6N+CNhDQ4zUb4d+v8/PyuaQ6oILy2
         mxtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747742483; x=1748347283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xiXqwtwAhXu4+jyqmGFxITCrsHEiUq2mzrMBhXH9F6A=;
        b=ZEs3ZrGtqqVlMcIQ23oA7wIbK0PsQGIJr1Nzp2q2GM6+B89mbu+4iLca3PCSlGIefo
         cyjrhjUfwywA2sOcnx/rr8OrRQIaUEIBQakUDhVyG4ZoJbTFD52cCl3QYreJY9MSRBg1
         zIk8f/OSdee/7IWYASO1C7W7ezCOUUaXwpJhi3lXavaz7x2kBpxn8BqmUn2C09/5UfL6
         guPeDQRNt/FCrmVkg2/cczThMh4fR+1IgdKJm1g6BQnd3fCqIpfseCCFBg6sSWCdH8kI
         wCUspnJsAwTUqn1Ljrrj0wK7Kd8vJoJCUZaVKgKreOMtmZEKWj5r6ePqA1ErbJw2Ibeh
         I3LA==
X-Forwarded-Encrypted: i=1; AJvYcCUtwVfh6RRHNZukOyIyfxTIKrFtPn9ZdgCaAmrHZK6LaBTxI8BBsOmeCN5826/lA20p8spD1WQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfVboS5h4XuXaT918/+gjhYvJRDLctcxAVRWAVl3zpYsENrTHM
	UxWMkdId4YGqdQBVqvkUQvJYCAJSWxO6inL3D1WBU6gCx/BJbpLCx7O+mkA/Zw==
X-Gm-Gg: ASbGncsAafxuJmK9QArXCpz0COj3kZphUaBe5+3tnGpRfIWi7M8QPmYo5kpSVwoj/yU
	3Uys2fXKAeN3igqHQCteqIJn1L2RuM5lfbKktG09e733aZuKynDiJyULniEUVdpQ5sj6IS1Nxjy
	cstUftZrFgHPl1GzeZX63zjsRaRzR2dw4uDCylBFMCqw9TGq6UpiaJH3uUe2oLuDIh5l1e/Wr6a
	mUJHuV8bVL+z05KBbvlIG3eMaArxB4+qlnHof7kGle3sL2yKSCQFrmM24Dac82j+BSOpa/v26XL
	kFC/MYgrtwgAdCWJSAb8NgwvkgsHulf6oy1YtU3Ui1n8vTeLYxNBo5v1ZLdYpP6hVSNt7n/wUv1
	2l1hkyhOVjo8PZWRrvP/eE7wyyy3CQeT0IhL3FdRJlI27nZ4kJcZOHw==
X-Google-Smtp-Source: AGHT+IGjN69xpK58LWTUxNWiBa1zgjjwNLDBUkpa9MT5YNQWeZwHkuWoVVBqM6u80zLBIoP4ZNtwKg==
X-Received: by 2002:a05:6871:538e:b0:29e:766d:e969 with SMTP id 586e51a60fabf-2e3c81f9480mr9173862fac.10.1747742483445;
        Tue, 20 May 2025 05:01:23 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cd468b6e52sm728409985a.77.2025.05.20.05.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 05:01:22 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v3 19/42] selinux: maintain a small cache in the global SID table
Date: Tue, 20 May 2025 07:59:17 -0400
Message-ID: <20250520120000.25501-21-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520120000.25501-2-stephen.smalley.work@gmail.com>
References: <20250520120000.25501-2-stephen.smalley.work@gmail.com>
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
index f3e13b2d4fb5..b66f1e85bc7e 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -7878,6 +7878,7 @@ static void selinux_state_free(struct work_struct *work)
 
 	do {
 		parent = state->parent;
+		global_sidtab_invalidate_state(state);
 		if (state->status_page)
 			__free_page(state->status_page);
 		selinux_policy_free(state->policy);
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

