Return-Path: <SRS0=oqVN=6N=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66FF3C83000
	for <selinux@archiver.kernel.org>; Wed, 29 Apr 2020 20:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37CB720B1F
	for <selinux@archiver.kernel.org>; Wed, 29 Apr 2020 20:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=concurrentrt.onmicrosoft.com header.i=@concurrentrt.onmicrosoft.com header.b="AOnHP9Fr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbgD2Udh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 29 Apr 2020 16:33:37 -0400
Received: from mail-mw2nam10on2102.outbound.protection.outlook.com ([40.107.94.102]:36833
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726456AbgD2Udg (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 29 Apr 2020 16:33:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ecLix04NaJ1p7hmJoSZVaUQCHU8td40mL2oY7xUenhmvHdbhLIZuhEDp0IqghdLkfy8r03c3d7DKBgMMcPmiuFEWfW0f7Qk4XU4frVaoeD1p0yFfeIYkcbngObFREUfNEX8c7HbDNP9Y8oQVLoHCaDNAZbZsiYGcZP0ySeedODRlXG8cINsFS355RMO8vvyD7XFgRGDU4hXNPUgveZ7/dKQV6fTM+vysTYaSkgYiI5yfSwIhACcR7jadWw2h8y5V2w0mD3K3ATVCFqTqpoUcjqDaI20S5GzwARH2+VXcrkbVIWL/b9CBBfDbnMbkOtFlYfRI93yMGmNcrMTkUGtf8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BN+yUXvVxznXfIdVvfBXNnnoADfhy451FQvPLmcq4b8=;
 b=b/M5Qu7gOAYeQVlE85pTOYwSA0Teymf0YKcMFUFYnNcLkN+rfvoLuogDje0sqpw5DkPiWlQfArP41Rx29vS2T8mQmGOyrcGIBkFPCDFEIvCuNq8D/D4FQtCPhZwBtp3Z86wAy7Ih9QaxzBAU0NIKIqLlfSkM/czsRAmYeziDpwGE9TWDSKfmHZqt4b3gjZ8rLskXJpUQw3Uh0vB0nHvZmKK2M0ZyjMeKVAWc+1/FKNPfOMKypL+wLYF+kw0nw2D8HZMTloho3QfwwcaKyck+2Zkd7sPerGWnZXA70lvVtre4XzjoWhT94FK004mU1Bh7rXaK1JGZpBn7ajZ+AgkEbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=concurrent-rt.com; dmarc=pass action=none
 header.from=concurrent-rt.com; dkim=pass header.d=concurrent-rt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=concurrentrt.onmicrosoft.com; s=selector2-concurrentrt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BN+yUXvVxznXfIdVvfBXNnnoADfhy451FQvPLmcq4b8=;
 b=AOnHP9Fr9LoHwslAlc4M7ghV5dQDoEoPDn1jG9vC2dmyUPD0IKAhWTs7Ae5IE0OQlq5m+Yo6FpFhJpRKHjyiUyXQYRJeyrkT5LpR4H/xHpQGJL/WzXnTncavn7Zfx5qWLtNQM/NKvxZ6+KuW4B7MbP06mIKq8FeTBUyuyw/7+Bw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=concurrent-rt.com;
Received: from MN2PR11MB3885.namprd11.prod.outlook.com (2603:10b6:208:151::27)
 by MN2PR11MB4096.namprd11.prod.outlook.com (2603:10b6:208:138::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Wed, 29 Apr
 2020 20:29:54 +0000
Received: from MN2PR11MB3885.namprd11.prod.outlook.com
 ([fe80::984:ec50:d6de:dc0a]) by MN2PR11MB3885.namprd11.prod.outlook.com
 ([fe80::984:ec50:d6de:dc0a%4]) with mapi id 15.20.2937.028; Wed, 29 Apr 2020
 20:29:54 +0000
From:   siarhei.liakh@concurrent-rt.com
To:     selinux@vger.kernel.org
Cc:     colin.king@canonical.com, eparis@parisplace.org,
        gregkh@linuxfoundation.org, jeffv@google.com, omosnace@redhat.com,
        paul@paul-moore.com, stephen.smalley.work@gmail.com,
        tglx@linutronix.de
Subject: [PATCH 2/2] SELinux: Introduce hash3() as alternative to shift-xor
Date:   Wed, 29 Apr 2020 16:29:41 -0400
Message-Id: <20200429202941.18320-3-siarhei.liakh@concurrent-rt.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200429202941.18320-1-siarhei.liakh@concurrent-rt.com>
References: <20200429202941.18320-1-siarhei.liakh@concurrent-rt.com>
Content-Type: text/plain
X-ClientProxiedBy: BN6PR06CA0008.namprd06.prod.outlook.com
 (2603:10b6:404:10b::18) To MN2PR11MB3885.namprd11.prod.outlook.com
 (2603:10b6:208:151::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sl-s76.concurrent-rt.com (65.190.80.89) by BN6PR06CA0008.namprd06.prod.outlook.com (2603:10b6:404:10b::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19 via Frontend Transport; Wed, 29 Apr 2020 20:29:53 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [65.190.80.89]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a664e6b-9f44-44c6-42f5-08d7ec7c131c
X-MS-TrafficTypeDiagnostic: MN2PR11MB4096:
X-Microsoft-Antispam-PRVS: <MN2PR11MB40968B66A1E78C9B0F4D4441B1AD0@MN2PR11MB4096.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 03883BD916
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3885.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(376002)(39840400004)(366004)(396003)(136003)(8676002)(36756003)(5660300002)(30864003)(6916009)(316002)(1076003)(66556008)(2906002)(66946007)(52116002)(7696005)(66476007)(186003)(2616005)(508600001)(9686003)(6486002)(6666004)(86362001)(8936002)(956004)(26005)(4326008)(16526019);DIR:OUT;SFP:1102;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a4rEWvNTYlkT/J02PvQJF5YMYcfGWM34nMWVmahHyME4xl+nKERybT0/Lxu4n8yta/uks6K+RCtZfcCjK76MhRLV4W5dWKfP3FDwwLDM7ZVmWsAlLogP3QAnq2MuCuVVorcpI+fIg9pq+3HOuXc1pUUMjtszh2Co2aZ/RkCDsnOkQmjYOyILdUEshwexsSiyGnFsBDjvaP/pfsrx8Siel+s66Y3FomCLT+tUAvd6RX71RDFy5q38aeoXXCOOptYdvmZur8H0MJtSCzHCUFgzOoypoKCZq5vcnmRYTDOclN+xD15tEz7o1JaPbFe9BBF+oD5r7WOtLQTez9vF2GLPRyNCwaoy9UiYYyd7ub5PFZPk7WuvbvEH1JqGi0denran5mroSHuuWFvdBCbtz7EuH4vKKfifORrnOY5xt5OAbHXFHnw1YNNABkQozrR52IJL
X-MS-Exchange-AntiSpam-MessageData: f31XhHCCmGimIdaUf9YAVU4H4EZ9RVsotFnO/VloPofeggwx4EGeWRmwJNXuRR8tlfXn0VFvohwOAhO5WxG+EKl0l8P26HmcKA9ztHw1LArJRgg6SnvTGUyYj25dq7TMQdiVUycxBj6ZCUbdyFkKTTySBTlGugJqYzw21Ld0VzLeLk3wVokpdMhQ5UQZW/oX03U5JXshWcjhyQzNc3140aatY+MjbTWBT/FEB4j4DR1BtkL3yg2BB2DplPd9yUxPDqSoe/BZAhfIFkgqxIYPLC5xb9rTpiqW1qFbaNTzWaAsE3zS/5To1ekbZ2WJJOzrwe4gtey3V0IKGiqw01RIO1IK0bDzNlACcWT/95K/xlN3jZ6PGmZJgyice183ylM4O69zgiPNZwnnHYJkbyCp4TbrIyvQ4AFYpTVMvh8kFSX4o8quZcDodMTF2qKL67dhePGNSj3siBQf2DqyjGJkieFizqvWse/6tKaoiSQyPRc6QqiUdOFJNKmIDj28LKAV+mVZ1wphx9QQvSuCEe36AZJPTkMK5b14xTU6eSsCgg4ldRbV7u8A12iy8oNA3iJOixDKpZ5X0WDEGcyA4Es2UcFFhe/WeNj9fcwGoZZHQ92bkNmMJq8P7RUoqude1HZ6qSO6HA8pln/rkRvjbRZ3wZbMW9LnXbgJI3PXmVUk8fY3CtaWviL8xixLirY6Nb/xwod+EoiqyNqC2TnJyFCt2ibmmc1XES2InuOkiwgklp56cw6XCZy+ZRpbG1VNEfViu3btFeIFBNyXYEZHJ66dsH4ERt2fnIhshI5F7f4UJ1s=
X-OriginatorOrg: concurrent-rt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a664e6b-9f44-44c6-42f5-08d7ec7c131c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2020 20:29:53.9692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38747689-e6b0-4933-86c0-1116ee3ef93e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: thjMl+yruHlW+UFY038dKDOghraFSF3JMNvwSowhoN6NlFMpwhEmHdBoQUUB0YOiAVM4Tr1FpPJI0PLYvmyRJ+60i0nbo69gB7abpAm77wc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4096
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Siarhei Liakh <siarhei.liakh@concurrent-rt.com>

This change improves performance of hashing functions used in AVC and
AVTab to hash 3x 32-bit values. As compared to original shift-xor function
used in AVC, substantial improvement in quality of hashing is gained by:
1. replacing shifts with rolls, thus preserving all of the incoming
   entropy
2. adjusting shift/roll constants to reduce overlap between the input
   values
3. use of arithmetic addition instead of XOR, as a way to spread out
   collisions
4. use of hash_32() to level out the distribution of hash output values
   throughout the range

Within the scope of particular application, these changes bring hash
quality to that of much more complex MurmurHash3 (which is currently used
in AVTab), while maintaining trivial simplicity of the original code.

The only price paid for the improvements is introduction of a single
32-bit multiplication instruction upon which hash_32() is built, which is
not a problem on almost any modern platform where fast multiplication is
available. For example, 32-bit MULs have had latency of 4 on pretty much
all Intel x86 CPUs for at least a decade or so (while ADD/XOR/SHL/ROL have
latency of 1). Platforms without fast multiplication provide their own
alternative mechanism for hash_32().

New hash function hash3() had been applied to two key parts of SELinux:
Access Vector Cache (AVC) and Access Vector Table (AVTab) with results
that follow.

AVC:

Below is the content of hash_stats, as observed on Fedora 32 in its
default configuration with targeted policy, averaged over 100 samples. The
stats show that new hash function not only cuts the longest chain almost
in half, but also provides a much better distribution throughout the table:
about 39% more buckets are being used, with at least half of all non-zero
buckets consistently staying at length 1, with 75% at 2 or below.

/sys/fs/selinux/avc/hash_stats:
            Old     New
Samples:   100      100
Entries:   504.43   503.67
Buckets:   219.73   304.61
1st Qu.:     1.00     1.00
Median :     1.39     1.00
3rd Qu.:     3.00     2.00
Maximum:     9.32     5.37

Next, performance of avc_lookup() is analyzed by timing it with ftrace on
a system with same configuration as above:

acv_lookup(), latency in us:
            Old     New
 Samples: 261534    244168
 Min.   : 0.1320    0.1310
 1st Qu.: 0.2410    0.2360
 Median : 0.4220    0.4240
 3rd Qu.: 0.5580    0.5600
 Max.   : 9.9300    9.9890

Considering small size of AVC in default configuration, the change does
not show any latency improvements. In fact, median and 75th percentile
timings appear to be in line with addition of extra 4 clock cycles for MUL
(roughly 2ns on a 2.2Ghz CPU), or 0.47%. This appears to be a small price
to pay for substantially better distribution of hash values, reducing a
probability and/or severity of potential pathological behavior on some
larger configurations.

Note that absolute max latency is likely not indicative, as it is
susceptible to one-off events such as interrupts, cache misses, etc.

AVTab:

Unlike AVC, AVTab hash table is much larger and much more densely
populated. In the past, need for better hashing in AVTab was demonstrated,
resulting in transition to a local copy of custom implementation of much
more complicated (and better) MurmurHash3, adapted for hashing of 3x u32s.
This change replaces MurmurHash3 with a much simpler, faster, yet just as
effective (at least, in this particular use case) hash3() function
described above.

As evidenced by debug output produced during the boot process, despite
being much simpler, hash3() yields quite similar (if not just a tiny bit
better) hash distribution quality within AVTab:

Old:
rules:  81014 entries and 29600/32768 buckets used, longest chain length
11 non-zero Q1/Med/Q3 2/2/4 sum of chain length^2 290030

New:
rules:  81014 entries and 29645/32768 buckets used, longest chain length
11 non-zero Q1/Med/Q3 2/2/4 sum of chain length^2 288810

Performance, though, is a different matter: a clear savings of 8ns to
10ns (75th and 50th percentiles respectively) had been measured with
ftrace for the most frequent AVTab lookup method:

avtab_search_node(), latency in us:
          Old       New
 Samples: 5953243   5458099
 Min.   : 0.136     0.129
 1st Qu.: 0.199     0.189
 Median : 0.219     0.209
 3rd Qu.: 0.294     0.286
 Max.   :10.000     9.990

The results are not as clear for much less frequently (that is 1500x call
frequency difference) used avtab_search(), though they appear to lean
towards a positive side:

avtab_search(), latency in us:
            Old     New
 Samples: 3863      3638
 Min.   : 0.165     0.157
 1st Qu.: 0.297     0.293
 Median : 0.510     0.517
 3rd Qu.: 0.803     0.774
 Max.   : 9.343     7.701

Signed-off-by: Siarhei Liakh <siarhei.liakh@concurrent-rt.com>
---
Please CC me directly on all replies.

 security/selinux/avc.c           |  8 +++--
 security/selinux/include/hash3.h | 44 ++++++++++++++++++++++++
 security/selinux/ss/avtab.c      | 57 ++++++++++----------------------
 security/selinux/ss/avtab.h      |  1 +
 4 files changed, 67 insertions(+), 43 deletions(-)
 create mode 100644 security/selinux/include/hash3.h

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index c3bbdb083371..ed092324bef1 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -30,12 +30,14 @@
 #include "avc.h"
 #include "avc_ss.h"
 #include "classmap.h"
+#include "hash3.h"
 
 #ifdef CONFIG_SECURITY_SELINUX_DEBUG_HASHES
 #include "median.h"
 #endif
 
-#define AVC_CACHE_SLOTS			512
+#define AVC_CACHE_BITS			(9)
+#define AVC_CACHE_SLOTS			(1 << AVC_CACHE_BITS)
 #define AVC_DEF_CACHE_THRESHOLD		512
 #define AVC_CACHE_RECLAIM		16
 
@@ -125,9 +127,9 @@ static struct kmem_cache *avc_xperms_data_cachep;
 static struct kmem_cache *avc_xperms_decision_cachep;
 static struct kmem_cache *avc_xperms_cachep;
 
-static inline int avc_hash(u32 ssid, u32 tsid, u16 tclass)
+static inline u32 avc_hash(u32 ssid, u32 tsid, u16 tclass)
 {
-	return (ssid ^ (tsid<<2) ^ (tclass<<4)) & (AVC_CACHE_SLOTS - 1);
+	return hash3(ssid, tsid, tclass, AVC_CACHE_BITS);
 }
 
 /**
diff --git a/security/selinux/include/hash3.h b/security/selinux/include/hash3.h
new file mode 100644
index 000000000000..21e2408f5227
--- /dev/null
+++ b/security/selinux/include/hash3.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* (C) Siarhei Liakh <Siarhei.Liakh@concurrent-rt.com>, 2020, GPL 2.0+ */
+
+#ifndef _SELINUX_HASH3_H
+#define _SELINUX_HASH3_H
+
+#include <linux/hash.h>
+#include <linux/bitops.h>
+
+/*
+ * hash3(): Mix and hash 3 x u32's with minimal overhead,
+ * truncate result to requested number of bits.
+ *
+ * This hash function produces very good results for inputs where most of
+ * input entropy is contained within the lower 11 bits of each of the words.
+ *
+ * For example, AVC hash table (in avc.c) is indexed by a 3-tuple (u32 ssid,
+ * u32 tsid, u16 tclass), where (on Fedora 32 Beta, as of March 2020) ssid and
+ * tsid appear to be sequential indexes between 0x0 and 0xA00, while tclass
+ * appears to be confined to the lower 8 bits, resulting in almost perfect
+ * packing of the indexes into a single 32-bit value.
+ *
+ * The function still produces reasonable hash values even when input value
+ * ranges span beyond 11 bits, as long as the placement of entropy within the
+ * input values is roughly the same for each of the componets (a, b, c), and
+ * the address space (a, b, c) is sparsely populated. Such behaviour is the
+ * result of two conscious choices: (1) use of rol32() to preserve all of the
+ * incoming entropy (as opposed to simple shifts which discard some input bits)
+ * and (2) use of arithmetic addition which carries over colliding bits (as
+ * opposed to binary XOR, which does not carry).
+ *
+ * The function will produce horrible collisions if input entropy is distrubuted
+ * within (a, b, c) such that it ends up within the same bit ranges after
+ * rotations, and the address space is densly populated. If that is the case,
+ * then two options are available:
+ * 1. Try switching around some of the inputs. EX: (a, b, c) => (b, c, a)
+ * 2. Use a real hash, such as jhash_3words() from linux/jhash.h
+ */
+static inline u32 hash3(u32 a, u32 b, u32 c, int bits)
+{
+	return hash_32(a + rol32(b, 11) + rol32(c, 22), bits);
+}
+
+#endif /* #ifndef _SELINUX_HASH3_H */
diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
index 8baaddb01a95..d24f18ab9e4d 100644
--- a/security/selinux/ss/avtab.c
+++ b/security/selinux/ss/avtab.c
@@ -22,6 +22,7 @@
 #include <linux/errno.h>
 #include "avtab.h"
 #include "policydb.h"
+#include "hash3.h"
 
 #ifdef CONFIG_SECURITY_SELINUX_DEBUG_HASHES
 #include "median.h"
@@ -30,43 +31,10 @@
 static struct kmem_cache *avtab_node_cachep;
 static struct kmem_cache *avtab_xperms_cachep;
 
-/* Based on MurmurHash3, written by Austin Appleby and placed in the
- * public domain.
- */
-static inline int avtab_hash(struct avtab_key *keyp, u32 mask)
+static inline u32 avtab_hash(struct avtab_key *keyp, u32 bits)
 {
-	static const u32 c1 = 0xcc9e2d51;
-	static const u32 c2 = 0x1b873593;
-	static const u32 r1 = 15;
-	static const u32 r2 = 13;
-	static const u32 m  = 5;
-	static const u32 n  = 0xe6546b64;
-
-	u32 hash = 0;
-
-#define mix(input) { \
-	u32 v = input; \
-	v *= c1; \
-	v = (v << r1) | (v >> (32 - r1)); \
-	v *= c2; \
-	hash ^= v; \
-	hash = (hash << r2) | (hash >> (32 - r2)); \
-	hash = hash * m + n; \
-}
-
-	mix(keyp->target_class);
-	mix(keyp->target_type);
-	mix(keyp->source_type);
-
-#undef mix
-
-	hash ^= hash >> 16;
-	hash *= 0x85ebca6b;
-	hash ^= hash >> 13;
-	hash *= 0xc2b2ae35;
-	hash ^= hash >> 16;
-
-	return hash & mask;
+	return hash3(keyp->target_class, keyp->target_type,
+		     keyp->source_type, bits);
 }
 
 static struct avtab_node*
@@ -116,7 +84,7 @@ static int avtab_insert(struct avtab *h, struct avtab_key *key, struct avtab_dat
 	if (!h)
 		return -EINVAL;
 
-	hvalue = avtab_hash(key, h->mask);
+	hvalue = avtab_hash(key, h->bits);
 	for (prev = NULL, cur = h->htable[hvalue];
 	     cur;
 	     prev = cur, cur = cur->next) {
@@ -160,7 +128,7 @@ avtab_insert_nonunique(struct avtab *h, struct avtab_key *key, struct avtab_datu
 
 	if (!h)
 		return NULL;
-	hvalue = avtab_hash(key, h->mask);
+	hvalue = avtab_hash(key, h->bits);
 	for (prev = NULL, cur = h->htable[hvalue];
 	     cur;
 	     prev = cur, cur = cur->next) {
@@ -191,7 +159,7 @@ struct avtab_datum *avtab_search(struct avtab *h, struct avtab_key *key)
 	if (!h)
 		return NULL;
 
-	hvalue = avtab_hash(key, h->mask);
+	hvalue = avtab_hash(key, h->bits);
 	for (cur = h->htable[hvalue]; cur;
 	     cur = cur->next) {
 		if (key->source_type == cur->key.source_type &&
@@ -227,7 +195,7 @@ avtab_search_node(struct avtab *h, struct avtab_key *key)
 	if (!h)
 		return NULL;
 
-	hvalue = avtab_hash(key, h->mask);
+	hvalue = avtab_hash(key, h->bits);
 	for (cur = h->htable[hvalue]; cur;
 	     cur = cur->next) {
 		if (key->source_type == cur->key.source_type &&
@@ -301,6 +269,7 @@ void avtab_destroy(struct avtab *h)
 	h->htable = NULL;
 	h->nslot = 0;
 	h->mask = 0;
+	h->bits = 0;
 }
 
 void avtab_init(struct avtab *h)
@@ -313,6 +282,7 @@ void avtab_init(struct avtab *h)
 int avtab_alloc(struct avtab *h, u32 nrules)
 {
 	u32 mask = 0;
+	u32 bits = 0;
 	u32 shift = 0;
 	u32 work = nrules;
 	u32 nslot = 0;
@@ -339,6 +309,13 @@ int avtab_alloc(struct avtab *h, u32 nrules)
 	h->nel = 0;
 	h->nslot = nslot;
 	h->mask = mask;
+
+	while (mask) {
+		mask  = mask >> 1;
+		bits++;
+	}
+
+	h->bits = bits;
 	pr_debug("SELinux: %d avtab hash slots, %d rules.\n",
 	       h->nslot, nrules);
 	return 0;
diff --git a/security/selinux/ss/avtab.h b/security/selinux/ss/avtab.h
index 5fdcb6696bcc..bf24d8094019 100644
--- a/security/selinux/ss/avtab.h
+++ b/security/selinux/ss/avtab.h
@@ -85,6 +85,7 @@ struct avtab {
 	u32 nel;	/* number of elements */
 	u32 nslot;      /* number of hash slots */
 	u32 mask;       /* mask to compute hash func */
+	u32 bits;       /* number of bits in mask */
 };
 
 void avtab_init(struct avtab *h);
-- 
2.17.1

