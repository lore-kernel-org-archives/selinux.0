Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1992BDC27;
	Fri,  5 Sep 2025 10:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757066712; cv=none; b=XZTPSCk0Uxtj3m+JmghU8J0wbLA/ZGnS6UnfF0QJnlpFo+WwHvNiAbUCWdTe6ZYHs7fwUEGMUGLMkBGyJCivuUqygwnx0LhgxEnl388tmbtM4WryH2gugN2FIc65LP6Ibbuk3s694MDcQwFUvWFdym23FMUrIXdOTJwUM+Cce2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757066712; c=relaxed/simple;
	bh=oPvbbbOjryt/WcGRBP+qXOUYcls7O9i3llpIoPoD7YA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jXehNDkb893rseiCpcnUTIkfjxbFuQNR5UuzJA+tMbPJGEEhhM78pFPTEEpFo5uWpoEYLRju828SKGkpyS40S6MnlXccywadX0FUGmrXCIqQDTFCkrCtL3OPbnYUSSLqr6YFMAkODTzNJA13lROAxfTRaRCCB6jKMkquRaxhPSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WEwEpqoO; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WEwEpqoO"
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-76e6cbb991aso1608016b3a.1;
        Fri, 05 Sep 2025 03:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757066710; x=1757671510; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mbYjVo+CtEVYvl1MNoJADrvhyhPGSDK3aQxvYcMbJPM=;
        b=WEwEpqoO+XtbAHG43hcsYAR9uv2sU1aaXvhalpFk1kb7Wz2vobIy6FeO6Xr9CMpMuI
         b5pdG4lN32PzrRTIEYtUdpqebxIq652nhNcD3jc5ZBfk5l4qUerOFG2YBt6d/vawaPfO
         +m82M702qunc7jHaLHBdvvg5gYXCIw0B2vPx7y5O64f/HjQ30LGlgKCRz/DK9ccw0IAx
         hxsnO1UGD8eRQGtiEvNZ0i/6IATbnsP3Q+S9SHEqcB+eEblKxOy3jJDwb+a86+HrMEa8
         o6YZCmreydQIkTNRLRJDqJbGXsFHfigf55xliu7RjIqtsMXXQEIONU7SAhkdeQk0nC4o
         zALQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757066710; x=1757671510;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mbYjVo+CtEVYvl1MNoJADrvhyhPGSDK3aQxvYcMbJPM=;
        b=hiEPwSbrrrG7lBfQkwoRRan6g4uNaw9SJDpttkPRTUdcX7m/4apWgxuLOekF0I+Jnd
         J0RzVZOBQ5NJ/rZotbADzj/w0Kk4DM0HwCfvBqwOPA12D6vBCzuk7t7ijqv9Hu7nF+4m
         NUF6rH2IuiI30HU73qIqJXDWm7OpY5huNFSqBDQGErBPTvzNSkgN9ZtatkAOEEPD0uxv
         booAKlFJj/GLT6GfU+jI6ar9J87J89hgRdsIAN5zpdNSdLWUh3Ahm7bxwNyTedMMbiWc
         LRkp9dCp/cLKkdHrafP6a9lFjN4bawOu9b0hpgbC+LNWhtZ2laDUGqQC5YeqRKgs00J+
         4tQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPhfogmyefmeQ78EoWRTCG8DnpEoUQpF8HqJy5+TTXGKFfirpFuMO4NRhvpiG3azSuXik4KBsP@vger.kernel.org
X-Gm-Message-State: AOJu0YxcuiK46sEy/bGSCr1c77uPVPuWURkah/Xiidy4nnoyv2VxJ/Ye
	k+UmTr3beb+PcQqL3mXeQ20KRGO6Px34whJrTSoSOnVd5yX8hwwD7hh4
X-Gm-Gg: ASbGnct5TqRPsziQyjPtei5WeSSCsuuz058AW9RR9H0iiRIs6ZDWqYzHVdY5XKoFZ+8
	4cfLcUZqyN0VNd7n0RYhvGsRleAWc4eL+UIQgU7caG0pDr6kb8HaAqLa6lTaM6mzVaUEIWd6GqA
	yQmgEbgzWUt7eKjC4d+5IlMxHWhE3DNOvuQtRpBB7J0ZMHFJf9waeOfo+3fgDyUmxQhJ2NBJM+x
	0lcGIVL74mM9V0uEJMfI60KP/Ez0FMpcyhLAZSigaCiRwrIWd8A/VxTzhLcp9/F+WeisH1B0zBt
	AcN4zsqm2WdNAf1pj8BtMi1hC0r/GXToaJHUt7JAkYFRSz0AIC98UZgfgs2AneVX9ONia9S48Jz
	6WJb86tT3nz0p2a34iJCd4q5X+BWOukwu9joPyP8HU04sntYgswNC9+w=
X-Google-Smtp-Source: AGHT+IHlaJDfiFBXDuvwpe5OnyRAPL5iAnxHlzgN0cRxqyls8/g4t1h3YvlkOpYazv5PhgUDqZzHKg==
X-Received: by 2002:aa7:8882:0:b0:772:4b09:ba3b with SMTP id d2e1a72fcca58-7724b09c30bmr24061800b3a.1.1757066710403;
        Fri, 05 Sep 2025 03:05:10 -0700 (PDT)
Received: from zhr-ThinkStation-K.mioffice.cn ([43.224.245.231])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-772447058dbsm17611904b3a.38.2025.09.05.03.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 03:05:10 -0700 (PDT)
From: Hongru Zhang <zhanghongru06@gmail.com>
X-Google-Original-From: Hongru Zhang <zhanghongru@xiaomi.com>
To: paul@paul-moore.com,
	stephen.smalley.work@gmail.com,
	omosnace@redhat.com
Cc: linux-kernel@vger.kernel.org,
	selinux@vger.kernel.org,
	Hongru Zhang <zhanghongru@xiaomi.com>
Subject: [PATCH] selinux: Make avc cache slot size configurable during boot
Date: Fri,  5 Sep 2025 18:04:54 +0800
Message-ID: <20250905100454.685866-1-zhanghongru@xiaomi.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Hongru Zhang <zhanghongru@xiaomi.com>

On mobile device high-load situations, permission check can happen
more than 90,000/s (8 core system). With default 512 cache nodes
configuration, avc cache miss happens more often and occasionally
leads to long time (>2ms) irqs off on both big and little cores,
which decreases system real-time capability.

An actual call stack is as follows:
 => avc_compute_av
 => avc_perm_nonode
 => avc_has_perm_noaudit
 => selinux_capable
 => security_capable
 => capable
 => __sched_setscheduler
 => do_sched_setscheduler
 => __arm64_sys_sched_setscheduler
 => invoke_syscall
 => el0_svc_common
 => do_el0_svc
 => el0_svc
 => el0t_64_sync_handler
 => el0t_64_sync

Although we can expand avc nodes through /sys/fs/selinux/cache_threshold
to mitigate long time irqs off, hash conflicts make the bucket average
length longer because of the fixed size of cache slots, leading to
avc_search_node latency increase.

Make avc cache slot size also configurable, and with fine tuning, we can
mitigate long time irqs off with slightly avc_search_node performance
regression.

Theoretically‌, the main overhead is memory consumption.

avc_search_node avg latency test results (about 100,000,000 times) on
Qcom SM8750, 6.6.30-android15-8:

Case 1:
+---------+---------------------+------------------------+
|         | no-patch (512/512)  | with-patch (512/512)   |
+---------+---------------------+------------------------+
| latency |        85 ns        |         87 ns          |
+---------+---------------------+------------------------+

Case 2:
+---------+---------------------+------------------------+
|         | no-patch (8192/512) | with-patch (8192/8192) |
+---------+---------------------+------------------------+
| latency |        277 ns       |         106 ns         |
+---------+---------------------+------------------------+

Case 1 shows 512 nodes configuration has ~2% performance regression
with patch.
Case 2 shows 8192 nodes configuration has ~61% latency benifit with
patch.

Signed-off-by: Hongru Zhang <zhanghongru@xiaomi.com>
---
 .../admin-guide/kernel-parameters.txt         |  4 ++
 security/selinux/avc.c                        | 68 +++++++++++++------
 2 files changed, 50 insertions(+), 22 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 747a55abf494..70dc6d659117 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6620,6 +6620,10 @@
 			1 -- enable.
 			Default value is 1.
 
+	selinux_avc_cache_slots= [SELINUX] Set the avc cache slot size.
+			Format: <int> (must be >0, power of 2)
+			Default: 512
+
 	serialnumber	[BUGS=X86-32]
 
 	sev=option[,option...] [X86-64]
diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 430b0e23ee00..35f5436f5da0 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -34,7 +34,7 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/avc.h>
 
-#define AVC_CACHE_SLOTS			512
+int avc_cache_slots __ro_after_init = 512;
 #define AVC_DEF_CACHE_THRESHOLD		512
 #define AVC_CACHE_RECLAIM		16
 
@@ -68,9 +68,13 @@ struct avc_xperms_node {
 	struct list_head xpd_head; /* list head of extended_perms_decision */
 };
 
+struct avc_slot {
+	struct hlist_head	slot;		/* head for avc_node->list */
+	spinlock_t		slot_lock;	/* lock for writes */
+};
+
 struct avc_cache {
-	struct hlist_head	slots[AVC_CACHE_SLOTS]; /* head for avc_node->list */
-	spinlock_t		slots_lock[AVC_CACHE_SLOTS]; /* lock for writes */
+	struct avc_slot		*slots;
 	atomic_t		lru_hint;	/* LRU hint for reclaim scan */
 	atomic_t		active_nodes;
 	u32			latest_notif;	/* latest revocation notification */
@@ -93,14 +97,34 @@ struct selinux_avc {
 
 static struct selinux_avc selinux_avc;
 
+static int __init set_selinux_avc_cache_slots(char *str)
+{
+	int val;
+
+	if ((kstrtoint(str, 0, &val)) || !is_power_of_2(val)) {
+		pr_warn("Unable to set selinux_avc_cache_slots, use default value\n");
+		return 1;
+	}
+
+	avc_cache_slots = val;
+
+	return 1;
+}
+__setup("selinux_avc_cache_slots=", set_selinux_avc_cache_slots);
+
 void selinux_avc_init(void)
 {
 	int i;
 
+	selinux_avc.avc_cache.slots =
+		kmalloc_array(avc_cache_slots, sizeof(struct avc_slot), GFP_KERNEL);
+	if (!selinux_avc.avc_cache.slots)
+		panic("SELinux: No memory to alloc avc cache slots\n");
+
 	selinux_avc.avc_cache_threshold = AVC_DEF_CACHE_THRESHOLD;
-	for (i = 0; i < AVC_CACHE_SLOTS; i++) {
-		INIT_HLIST_HEAD(&selinux_avc.avc_cache.slots[i]);
-		spin_lock_init(&selinux_avc.avc_cache.slots_lock[i]);
+	for (i = 0; i < avc_cache_slots; i++) {
+		INIT_HLIST_HEAD(&selinux_avc.avc_cache.slots[i].slot);
+		spin_lock_init(&selinux_avc.avc_cache.slots[i].slot_lock);
 	}
 	atomic_set(&selinux_avc.avc_cache.active_nodes, 0);
 	atomic_set(&selinux_avc.avc_cache.lru_hint, 0);
@@ -124,7 +148,7 @@ static struct kmem_cache *avc_xperms_cachep __ro_after_init;
 
 static inline u32 avc_hash(u32 ssid, u32 tsid, u16 tclass)
 {
-	return (ssid ^ (tsid<<2) ^ (tclass<<4)) & (AVC_CACHE_SLOTS - 1);
+	return (ssid ^ (tsid<<2) ^ (tclass<<4)) & (avc_cache_slots - 1);
 }
 
 /**
@@ -150,8 +174,8 @@ int avc_get_hash_stats(char *page)
 
 	slots_used = 0;
 	max_chain_len = 0;
-	for (i = 0; i < AVC_CACHE_SLOTS; i++) {
-		head = &selinux_avc.avc_cache.slots[i];
+	for (i = 0; i < avc_cache_slots; i++) {
+		head = &selinux_avc.avc_cache.slots[i].slot;
 		if (!hlist_empty(head)) {
 			slots_used++;
 			chain_len = 0;
@@ -167,7 +191,7 @@ int avc_get_hash_stats(char *page)
 	return scnprintf(page, PAGE_SIZE, "entries: %d\nbuckets used: %d/%d\n"
 			 "longest chain: %d\n",
 			 atomic_read(&selinux_avc.avc_cache.active_nodes),
-			 slots_used, AVC_CACHE_SLOTS, max_chain_len);
+			 slots_used, avc_cache_slots, max_chain_len);
 }
 
 /*
@@ -463,11 +487,11 @@ static inline int avc_reclaim_node(void)
 	struct hlist_head *head;
 	spinlock_t *lock;
 
-	for (try = 0, ecx = 0; try < AVC_CACHE_SLOTS; try++) {
+	for (try = 0, ecx = 0; try < avc_cache_slots; try++) {
 		hvalue = atomic_inc_return(&selinux_avc.avc_cache.lru_hint) &
-			(AVC_CACHE_SLOTS - 1);
-		head = &selinux_avc.avc_cache.slots[hvalue];
-		lock = &selinux_avc.avc_cache.slots_lock[hvalue];
+			(avc_cache_slots - 1);
+		head = &selinux_avc.avc_cache.slots[hvalue].slot;
+		lock = &selinux_avc.avc_cache.slots[hvalue].slot_lock;
 
 		if (!spin_trylock_irqsave(lock, flags))
 			continue;
@@ -524,7 +548,7 @@ static inline struct avc_node *avc_search_node(u32 ssid, u32 tsid, u16 tclass)
 	struct hlist_head *head;
 
 	hvalue = avc_hash(ssid, tsid, tclass);
-	head = &selinux_avc.avc_cache.slots[hvalue];
+	head = &selinux_avc.avc_cache.slots[hvalue].slot;
 	hlist_for_each_entry_rcu(node, head, list) {
 		if (ssid == node->ae.ssid &&
 		    tclass == node->ae.tclass &&
@@ -625,8 +649,8 @@ static void avc_insert(u32 ssid, u32 tsid, u16 tclass,
 	}
 
 	hvalue = avc_hash(ssid, tsid, tclass);
-	head = &selinux_avc.avc_cache.slots[hvalue];
-	lock = &selinux_avc.avc_cache.slots_lock[hvalue];
+	head = &selinux_avc.avc_cache.slots[hvalue].slot;
+	lock = &selinux_avc.avc_cache.slots[hvalue].slot_lock;
 	spin_lock_irqsave(lock, flag);
 	hlist_for_each_entry(pos, head, list) {
 		if (pos->ae.ssid == ssid &&
@@ -846,8 +870,8 @@ static int avc_update_node(u32 event, u32 perms, u8 driver, u8 base_perm,
 	/* Lock the target slot */
 	hvalue = avc_hash(ssid, tsid, tclass);
 
-	head = &selinux_avc.avc_cache.slots[hvalue];
-	lock = &selinux_avc.avc_cache.slots_lock[hvalue];
+	head = &selinux_avc.avc_cache.slots[hvalue].slot;
+	lock = &selinux_avc.avc_cache.slots[hvalue].slot_lock;
 
 	spin_lock_irqsave(lock, flag);
 
@@ -929,9 +953,9 @@ static void avc_flush(void)
 	unsigned long flag;
 	int i;
 
-	for (i = 0; i < AVC_CACHE_SLOTS; i++) {
-		head = &selinux_avc.avc_cache.slots[i];
-		lock = &selinux_avc.avc_cache.slots_lock[i];
+	for (i = 0; i < avc_cache_slots; i++) {
+		head = &selinux_avc.avc_cache.slots[i].slot;
+		lock = &selinux_avc.avc_cache.slots[i].slot_lock;
 
 		spin_lock_irqsave(lock, flag);
 		/*
-- 
2.43.0

