Return-Path: <SRS0=oqVN=6N=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14BAAC83004
	for <selinux@archiver.kernel.org>; Wed, 29 Apr 2020 20:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD208206D9
	for <selinux@archiver.kernel.org>; Wed, 29 Apr 2020 20:29:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=concurrentrt.onmicrosoft.com header.i=@concurrentrt.onmicrosoft.com header.b="jE8U0wKB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbgD2U37 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 29 Apr 2020 16:29:59 -0400
Received: from mail-mw2nam10on2102.outbound.protection.outlook.com ([40.107.94.102]:36833
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726511AbgD2U37 (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 29 Apr 2020 16:29:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lbgt9K1bOQYGLIhZX+y3vpbtPjJWc9fVZZjRX8dcGwiCippUki7828ZmQOqk2HNSZM9PMEIOgmZ13fm+1NvBJe4DGwioFsGrDOHJP9TkiT3LjMj3fW5f1AJSl0id68yDe9ePgPdTStLjwGngIVooSVbc4qddP2c8EukE0cQUUb3avOrFnbHtMbefKUwjXSS8HhxJG4p+fqfldqaWvc/yXo8eM0jucOF2PRG5HmnRd2xg7G60MgC6Mz3MSSIwE48SBCssF9c6vH1kfxnkd+zNu9g38oPe+rp2ZrdwQVTraUtXzUNhc9BYxAiTinMhvyAz+PvaMs2r35M/XZ/M7t+OLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e0WUebY65ps3Rw2pi3S0P5fvBNw36hNQbdBkDNaORk0=;
 b=a8770U0UciB/tquojdsfXrTo0GYYIZVl06FlS9+ik0nqgOAgL4gaeXAifwITp08WQvaiQjG965JD5OQcZw5/4KXOBjejbVYtww7xOUire531ACo7XottWsSqYHXg3ghht1ps9h0i7hY30YUSlxVFjRElJdNmOu268EtEUzvX8CgS3q3ZtpIwd31dwbbX0V5UlhF0+TylZquGD0+nCuG/P2Y/RA990aKpnGMdoLMD73XHE+x1PmDKQN03XIHie3ki10tw5B0pHxfUWPfFOa2jkvLU3Iviorgf9eFLsNG8kZ9fiIjNdMZ8drRIkV7Bhb12vYk6xhLgg9f4vJcpM0PEkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=concurrent-rt.com; dmarc=pass action=none
 header.from=concurrent-rt.com; dkim=pass header.d=concurrent-rt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=concurrentrt.onmicrosoft.com; s=selector2-concurrentrt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e0WUebY65ps3Rw2pi3S0P5fvBNw36hNQbdBkDNaORk0=;
 b=jE8U0wKB5oIGjF8RwyC1U3io/w/yDvJDbmO1nsicouUptUehc7LaPUTLKqUoyIZPRkHwUY5AnqU24XC/6FbnblRFPGTp7TWmMyzgFpkaVWNOSZt5xv0n/U/VbfR+47U7DSJ9ybgfhycdeVNk1GolS3Z+7Qz8tB9o1CeuyIirR1E=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=concurrent-rt.com;
Received: from MN2PR11MB3885.namprd11.prod.outlook.com (2603:10b6:208:151::27)
 by MN2PR11MB4096.namprd11.prod.outlook.com (2603:10b6:208:138::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Wed, 29 Apr
 2020 20:29:53 +0000
Received: from MN2PR11MB3885.namprd11.prod.outlook.com
 ([fe80::984:ec50:d6de:dc0a]) by MN2PR11MB3885.namprd11.prod.outlook.com
 ([fe80::984:ec50:d6de:dc0a%4]) with mapi id 15.20.2937.028; Wed, 29 Apr 2020
 20:29:53 +0000
From:   siarhei.liakh@concurrent-rt.com
To:     selinux@vger.kernel.org
Cc:     colin.king@canonical.com, eparis@parisplace.org,
        gregkh@linuxfoundation.org, jeffv@google.com, omosnace@redhat.com,
        paul@paul-moore.com, stephen.smalley.work@gmail.com,
        tglx@linutronix.de
Subject: [PATCH 1/2] SELinux: Add median to debug output of hash table stats
Date:   Wed, 29 Apr 2020 16:29:40 -0400
Message-Id: <20200429202941.18320-2-siarhei.liakh@concurrent-rt.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200429202941.18320-1-siarhei.liakh@concurrent-rt.com>
References: <20200429202941.18320-1-siarhei.liakh@concurrent-rt.com>
Content-Type: text/plain
X-ClientProxiedBy: BN6PR06CA0008.namprd06.prod.outlook.com
 (2603:10b6:404:10b::18) To MN2PR11MB3885.namprd11.prod.outlook.com
 (2603:10b6:208:151::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sl-s76.concurrent-rt.com (65.190.80.89) by BN6PR06CA0008.namprd06.prod.outlook.com (2603:10b6:404:10b::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19 via Frontend Transport; Wed, 29 Apr 2020 20:29:52 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [65.190.80.89]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 737317a7-8fc0-43f7-4494-08d7ec7c1287
X-MS-TrafficTypeDiagnostic: MN2PR11MB4096:
X-Microsoft-Antispam-PRVS: <MN2PR11MB409606FBD40C0DC2ABACA181B1AD0@MN2PR11MB4096.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:510;
X-Forefront-PRVS: 03883BD916
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3885.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(376002)(39840400004)(366004)(396003)(136003)(8676002)(36756003)(5660300002)(30864003)(6916009)(316002)(1076003)(66556008)(2906002)(66946007)(52116002)(7696005)(966005)(66476007)(186003)(2616005)(508600001)(9686003)(6486002)(6666004)(86362001)(8936002)(956004)(26005)(4326008)(16526019);DIR:OUT;SFP:1102;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /oXCMdGvoJWWGu8W3LHjGXwUvRjMiPcyjemFvd3WrPJM6tnhF4rBF2MEd84QFut+BZfjVoubO7Bb0QmSINLYvGNdFuOqOBYm/QTZmJy/CspF2aCtPzDJ5/m5i4rcLFeYcVMiiJbVl1F7HtSowGGE0MStIn8iUUbePENwKfQxA3QgMyY7qwT3AQA8A17fuvoqizFop67YFwTAlDMNHrFC47STtTsMh8Tmp9lnuYu4SRdCh2Q1FVT9vGZFX3mtQX40DVM3cFaQPKkYV/x834QrK3W3NQaKCkVCE83DyE7AO8C3HM1kYWc7tKiOllcHpUVximJLqRTwiSQ24Ki1SaIWTyTiatQHIzDHfpzEosbtHqdTWGa1yvIBbSSlBg8uOarmexqEDaEYxMG0lKZz9VqZpsIowS9qWj3zKjEt+5hmxDOVyfEx2QyMoVd9fekbfBclm3XssOlcr3RcdNfvbpUvZa2h/Bmy1BROu2RkEs+9vKiZ22i0C2MMVYG/oM42ZArKoiHR0CiLAbi2qFgjh5c9EA==
X-MS-Exchange-AntiSpam-MessageData: eYYDv5BlUeQIEi89G/NmipryJjcEnpCqasoVWronSatqjVVw+rEjNSUzfK34qPdgE8OZ1oZHRQZJ84m2Vom/YSoK1VWKkKpcJqaxwheUCJv6m6NSGVHXD7Y8/JEPFP12A/avXgvSUqlBOb65UxztL2MIr4IJ4cXbxldyVklpHJSABCEy/p6/fzTNqsjHlgNm2S6dmMgZhxFskaTixux3yk/RD1lvH0mgS+YA2EUIowQhfVcNRV1vggjCkawwSxU1Cj60HluCP81KHxcwbHMMPSxzn7DwXoljJJlXTVwO6ahZSn9k4Im4RCQgWhENeaWbZ8DqaK8al8TvSvGjYC02DlrfTYAm9+tcBuLHygE4gaiDfjaWByajFQwZbtmAWrYsZsuDI0vus7KrInqzTb6FI+Q41ua/lR6ormJT0u8A9S2mbmHFXri37CN4BFCwUfHCl992svJo8Tb1FPE89JO5sO6Jw6TYfmLo9CXVkniTxuWY+nTg+E9L1Jj6WNZoyBlxQ85mMwLVmT5rk35ws0FoM8hdWqrc0fAv1hJAyqD3tG5RV3icUTTrNttplgvXZ3e/yQ/nC102mQL+vFgSuB8fIYB9bjO9fNxB/6syhf2+64XQUKdJm38CcctwOiyhLqCy7lpBjAik/+rwLiEHAsc9oL1uAyX+KYIw0mZIs9FqaprqzTb35/pXOg2JaAhMfPpaR/sf7GdLkQq8uP1DuK7WWkQ0ULOwyUe40QrdjTch4AuRwKsXAAiWBvDDn88OqPDFLBx1D8FfxbNSEkD2GKmBrXx/J9pod43EreplorSJ2dk=
X-OriginatorOrg: concurrent-rt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 737317a7-8fc0-43f7-4494-08d7ec7c1287
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2020 20:29:53.0367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38747689-e6b0-4933-86c0-1116ee3ef93e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w7bsp0L40P4a9MS5tYsnhIsKNJn/Utxvbz5h2CgbQkoKkg7RQD7Xe1wAQzg1/2BPw3A0TUouu+aOp9HLkNAMgSHMEtDQypkMF1e8faiKn9Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4096
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Siarhei Liakh <siarhei.liakh@concurrent-rt.com>

This change introduces a median() function which is then used to report
25th, 50th, and 75th percentile metrics within distributions of hash table
bucket chain lengths. This allows to better assess and compare relative
effectiveness of different hash functions. Specifically, it allows to
ensure new functions not only reduce the maximum, but also improve (or, at
least, have no negative impact) on the median.

Sample output before change:

avc:
entries: 508
buckets used: 213/512
longest chain: 10

policydb:
SELinux: roles:  14 entries and 6/16 buckets used, longest chain length 5

Sample output after the change:

avc:
entries: 508
buckets used: 217/512
longest chain: 9
non-zero chain Q1/Med/Q3: 1/2/3

policydb:
SELinux: roles:  14 entries and 6/16 buckets used, longest chain length 5
non-zero Q1/Med/Q3 1/2/4

Signed-off-by: Siarhei Liakh <siarhei.liakh@concurrent-rt.com>
---
Please CC me directly on all replies.

 security/selinux/Kconfig          | 10 +++++
 security/selinux/avc.c            | 42 ++++++++++++++++---
 security/selinux/include/median.h | 67 +++++++++++++++++++++++++++++++
 security/selinux/ss/avtab.c       | 37 ++++++++++++++---
 security/selinux/ss/hashtab.c     | 28 ++++++++++++-
 security/selinux/ss/hashtab.h     |  5 +++
 security/selinux/ss/policydb.c    | 14 ++++---
 7 files changed, 185 insertions(+), 18 deletions(-)
 create mode 100644 security/selinux/include/median.h

diff --git a/security/selinux/Kconfig b/security/selinux/Kconfig
index 9e921fc72538..57c427e019c9 100644
--- a/security/selinux/Kconfig
+++ b/security/selinux/Kconfig
@@ -115,3 +115,13 @@ config SECURITY_SELINUX_SID2STR_CACHE_SIZE
 	  conversion.  Setting this option to 0 disables the cache completely.
 
 	  If unsure, keep the default value.
+
+config SECURITY_SELINUX_DEBUG_HASHES
+	bool "Print additional information about hash tables"
+	depends on SECURITY_SELINUX
+	default n
+	help
+	  This option allows to gather and display additional information about
+	  some of the key hash tables within SELinux.
+
+	  If unsure, keep the default value.
diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index d18cb32a242a..c3bbdb083371 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -31,6 +31,10 @@
 #include "avc_ss.h"
 #include "classmap.h"
 
+#ifdef CONFIG_SECURITY_SELINUX_DEBUG_HASHES
+#include "median.h"
+#endif
+
 #define AVC_CACHE_SLOTS			512
 #define AVC_DEF_CACHE_THRESHOLD		512
 #define AVC_CACHE_RECLAIM		16
@@ -149,9 +153,13 @@ void __init avc_init(void)
 
 int avc_get_hash_stats(struct selinux_avc *avc, char *page)
 {
-	int i, chain_len, max_chain_len, slots_used;
+	int i, chain_len, max_chain_len, slots_used, ret;
 	struct avc_node *node;
 	struct hlist_head *head;
+#ifdef CONFIG_SECURITY_SELINUX_DEBUG_HASHES
+	u32 med_ct = 0;
+	u32 *counts = vmalloc(AVC_CACHE_SLOTS * sizeof(u32));
+#endif
 
 	rcu_read_lock();
 
@@ -164,6 +172,10 @@ int avc_get_hash_stats(struct selinux_avc *avc, char *page)
 			chain_len = 0;
 			hlist_for_each_entry_rcu(node, head, list)
 				chain_len++;
+#ifdef CONFIG_SECURITY_SELINUX_DEBUG_HASHES
+			if (counts && chain_len)
+				counts[med_ct++] = chain_len;
+#endif
 			if (chain_len > max_chain_len)
 				max_chain_len = chain_len;
 		}
@@ -171,10 +183,30 @@ int avc_get_hash_stats(struct selinux_avc *avc, char *page)
 
 	rcu_read_unlock();
 
-	return scnprintf(page, PAGE_SIZE, "entries: %d\nbuckets used: %d/%d\n"
-			 "longest chain: %d\n",
-			 atomic_read(&avc->avc_cache.active_nodes),
-			 slots_used, AVC_CACHE_SLOTS, max_chain_len);
+#ifdef CONFIG_SECURITY_SELINUX_DEBUG_HASHES
+	if (counts) {
+		u32 q1 = 0;
+		u32 q3 = 0;
+		u32 med = median(counts, med_ct, &q1, &q3);
+
+		vfree(counts);
+		ret = scnprintf(page, PAGE_SIZE,
+				"entries: %d\nbuckets used: %d/%d\n"
+				 "longest chain: %d\n"
+				 "non-zero chain Q1/Med/Q3: %u/%u/%u\n",
+				atomic_read(&avc->avc_cache.active_nodes),
+				slots_used, AVC_CACHE_SLOTS, max_chain_len,
+				q1, med, q3);
+	} else /* Falling through! */
+#endif
+	{
+		ret = scnprintf(page, PAGE_SIZE,
+				"entries: %d\nbuckets used: %d/%d\n"
+				 "longest chain: %d\n",
+				atomic_read(&avc->avc_cache.active_nodes),
+				slots_used, AVC_CACHE_SLOTS, max_chain_len);
+	}
+	return ret;
 }
 
 /*
diff --git a/security/selinux/include/median.h b/security/selinux/include/median.h
new file mode 100644
index 000000000000..e90565b9d7f6
--- /dev/null
+++ b/security/selinux/include/median.h
@@ -0,0 +1,67 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* (C) Siarhei Liakh <Siarhei.Liakh@concurrent-rt.com>, 2020, GPL 2.0+ */
+
+#ifndef _LINUX_MEDIAN_H
+#define _LINUX_MEDIAN_H
+#include <linux/types.h>
+#include <linux/sort.h>
+
+/*
+ * Helper function to compare two u32s
+ */
+static int __cmp_u32(const void *a, const void *b)
+{
+	u32 x = *(const u32 *)(a);
+	u32 y = *(const u32 *)(b);
+
+	if (x < y)
+		return -1;
+
+	if (x > y)
+		return 1;
+
+	return 0;
+}
+
+/*
+ * median(): Find a median of an array containing "count" of u32s,
+ * optionally return 25th (q1) and 75th (q3) percentile.
+ */
+static inline u32 median(u32 val[], size_t count, u32 *q1, u32 *q3)
+{
+	u32 _q1 = 0;
+	u32 _q2 = 0;
+	u32 _q3 = 0;
+
+	if (count > 0) {
+		/*
+		 * Using existing sort() functionality as the easiest way
+		 * to get median with least amount of new code.
+		 *
+		 * This is not the most efficient way to find a median,
+		 * so feel free to implement a better one if performance is
+		 * of a primary concern. "Selection algorithm" Wikipedia
+		 * article is a good start:
+		 * https://en.m.wikipedia.org/wiki/Selection_algorithm
+		 */
+		sort(val, count, sizeof(u32), &__cmp_u32, NULL);
+
+		/*
+		 * Should really do some math if count is even,
+		 * but this is close enough for our purposes.
+		 */
+
+		_q1 = val[count / 4];
+		_q2 = val[count / 2];
+		_q3 = val[(count * 3) / 4];
+	}
+
+	if (q1)
+		*q1 = _q1;
+
+	if (q3)
+		*q3 = _q3;
+
+	return _q2;
+}
+#endif /* #ifndef _LINUX_MEAN_H */
diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
index 01b300a4a882..8baaddb01a95 100644
--- a/security/selinux/ss/avtab.c
+++ b/security/selinux/ss/avtab.c
@@ -23,6 +23,10 @@
 #include "avtab.h"
 #include "policydb.h"
 
+#ifdef CONFIG_SECURITY_SELINUX_DEBUG_HASHES
+#include "median.h"
+#endif
+
 static struct kmem_cache *avtab_node_cachep;
 static struct kmem_cache *avtab_xperms_cachep;
 
@@ -345,6 +349,10 @@ void avtab_hash_eval(struct avtab *h, char *tag)
 	int i, chain_len, slots_used, max_chain_len;
 	unsigned long long chain2_len_sum;
 	struct avtab_node *cur;
+#ifdef CONFIG_SECURITY_SELINUX_DEBUG_HASHES
+	u32 med_ct = 0;
+	u32 *counts = vmalloc(h->nslot * sizeof(u32));
+#endif
 
 	slots_used = 0;
 	max_chain_len = 0;
@@ -358,17 +366,36 @@ void avtab_hash_eval(struct avtab *h, char *tag)
 				chain_len++;
 				cur = cur->next;
 			}
-
+#ifdef CONFIG_SECURITY_SELINUX_DEBUG_HASHES
+			if (counts && chain_len)
+				counts[med_ct++] = chain_len;
+#endif
 			if (chain_len > max_chain_len)
 				max_chain_len = chain_len;
 			chain2_len_sum += chain_len * chain_len;
 		}
 	}
 
-	pr_debug("SELinux: %s:  %d entries and %d/%d buckets used, "
-	       "longest chain length %d sum of chain length^2 %llu\n",
-	       tag, h->nel, slots_used, h->nslot, max_chain_len,
-	       chain2_len_sum);
+#ifdef CONFIG_SECURITY_SELINUX_DEBUG_HASHES
+	if (counts) {
+		u32 q1 = 0;
+		u32 q3 = 0;
+		u32 med = median(counts, med_ct, &q1, &q3);
+
+		vfree(counts);
+		pr_debug("SELinux: %s:  %d entries and %d/%d buckets used, "
+			 "longest chain length %d non-zero Q1/Med/Q3 %u/%u/%u "
+			 "sum of chain length^2 %llu\n",
+			 tag, h->nel, slots_used, h->nslot, max_chain_len,
+			 q1, med, q3, chain2_len_sum);
+	} else /* Falling through! */
+#endif
+	{
+		pr_debug("SELinux: %s:  %d entries and %d/%d buckets used, "
+			 "longest chain length %d sum of chain length^2 %llu\n",
+			 tag, h->nel, slots_used, h->nslot, max_chain_len,
+			 chain2_len_sum);
+	}
 }
 
 static uint16_t spec_order[] = {
diff --git a/security/selinux/ss/hashtab.c b/security/selinux/ss/hashtab.c
index 883f19d32c28..e42d814067ba 100644
--- a/security/selinux/ss/hashtab.c
+++ b/security/selinux/ss/hashtab.c
@@ -8,8 +8,13 @@
 #include <linux/slab.h>
 #include <linux/errno.h>
 #include <linux/sched.h>
+#include <linux/vmalloc.h>
 #include "hashtab.h"
 
+#ifdef CONFIG_SECURITY_SELINUX_DEBUG_HASHES
+#include "median.h"
+#endif
+
 static struct kmem_cache *hashtab_node_cachep;
 
 /*
@@ -168,7 +173,10 @@ void hashtab_stat(struct hashtab *h, struct hashtab_info *info)
 {
 	u32 i, chain_len, slots_used, max_chain_len;
 	struct hashtab_node *cur;
-
+#ifdef CONFIG_SECURITY_SELINUX_DEBUG_HASHES
+	u32 med_ct = 0;
+	u32 *counts = vmalloc(h->size * sizeof(u32));
+#endif
 	slots_used = 0;
 	max_chain_len = 0;
 	for (i = 0; i < h->size; i++) {
@@ -180,7 +188,10 @@ void hashtab_stat(struct hashtab *h, struct hashtab_info *info)
 				chain_len++;
 				cur = cur->next;
 			}
-
+#ifdef CONFIG_SECURITY_SELINUX_DEBUG_HASHES
+			if (counts && chain_len)
+				counts[med_ct++] = chain_len;
+#endif
 			if (chain_len > max_chain_len)
 				max_chain_len = chain_len;
 		}
@@ -188,6 +199,19 @@ void hashtab_stat(struct hashtab *h, struct hashtab_info *info)
 
 	info->slots_used = slots_used;
 	info->max_chain_len = max_chain_len;
+#ifdef CONFIG_SECURITY_SELINUX_DEBUG_HASHES
+	if (counts) {
+		info->med_chain_len = median(counts, med_ct,
+					     &(info->q1_chain_len),
+					     &(info->q3_chain_len));
+
+		vfree(counts);
+	} else {
+		info->q1_chain_len = 0;
+		info->med_chain_len = 0;
+		info->q3_chain_len = 0;
+	}
+#endif
 }
 
 void __init hashtab_cache_init(void)
diff --git a/security/selinux/ss/hashtab.h b/security/selinux/ss/hashtab.h
index dde54d9ff01c..b660c0078dae 100644
--- a/security/selinux/ss/hashtab.h
+++ b/security/selinux/ss/hashtab.h
@@ -32,6 +32,11 @@ struct hashtab {
 struct hashtab_info {
 	u32 slots_used;
 	u32 max_chain_len;
+#ifdef CONFIG_SECURITY_SELINUX_DEBUG_HASHES
+	u32 q1_chain_len;
+	u32 med_chain_len;
+	u32 q3_chain_len;
+#endif
 };
 
 /*
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index c21b922e5ebe..420e347ac77c 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -41,9 +41,9 @@
 #include "mls.h"
 #include "services.h"
 
-#define _DEBUG_HASHES
+#ifdef CONFIG_SECURITY_SELINUX_DEBUG_HASHES
+#include "median.h"
 
-#ifdef DEBUG_HASHES
 static const char *symtab_name[SYM_NUM] = {
 	"common prefixes",
 	"classes",
@@ -623,15 +623,17 @@ static int (*index_f[SYM_NUM]) (void *key, void *datum, void *datap) =
 	cat_index,
 };
 
-#ifdef DEBUG_HASHES
+#ifdef CONFIG_SECURITY_SELINUX_DEBUG_HASHES
 static void hash_eval(struct hashtab *h, const char *hash_name)
 {
 	struct hashtab_info info;
 
 	hashtab_stat(h, &info);
-	pr_debug("SELinux: %s:  %d entries and %d/%d buckets used, longest chain length %d\n",
+	pr_debug("SELinux: %s:  %d entries and %d/%d buckets used, "
+		 "longest chain length %d non-zero Q1/Med/Q3 %u/%u/%u\n",
 		 hash_name, h->nel, info.slots_used, h->size,
-		 info.max_chain_len);
+		 info.max_chain_len, info.q1_chain_len,
+		 info.med_chain_len, info.q3_chain_len);
 }
 
 static void symtab_hash_eval(struct symtab *s)
@@ -670,7 +672,7 @@ static int policydb_index(struct policydb *p)
 	pr_debug("SELinux:  %d classes, %d rules\n",
 		 p->p_classes.nprim, p->te_avtab.nel);
 
-#ifdef DEBUG_HASHES
+#ifdef CONFIG_SECURITY_SELINUX_DEBUG_HASHES
 	avtab_hash_eval(&p->te_avtab, "rules");
 	symtab_hash_eval(p->symtab);
 #endif
-- 
2.17.1

