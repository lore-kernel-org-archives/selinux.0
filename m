Return-Path: <SRS0=RcjK=5Y=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1381C2BA1B
	for <selinux@archiver.kernel.org>; Wed,  8 Apr 2020 18:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8FAD20753
	for <selinux@archiver.kernel.org>; Wed,  8 Apr 2020 18:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=concurrentrt.onmicrosoft.com header.i=@concurrentrt.onmicrosoft.com header.b="N3y078Ot"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730863AbgDHSYi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 8 Apr 2020 14:24:38 -0400
Received: from mail-eopbgr770139.outbound.protection.outlook.com ([40.107.77.139]:43525
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729779AbgDHSYi (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 8 Apr 2020 14:24:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=msWQP8A9xuqu9Hv2XLOEr2XaZxpaGqacaN5Vu7428AzDeUDbCKNkwJyjZJqTaC0tCh8cEUltBeKUa6sZobg9XemAnpjP59ZGiN7hJEaT2KiF9iR4dkVKvxmAeBsKP6WZvk/JhGDt6na66fiuB3EBGXayJe2iLDs7qhbREAPdoTmfrkpISVdmnauukywmwNawAGl2nkR2Rgx7wAoL36Mk38eEF3BTW4HNkwkwlDoqpg2ti7obMhqpk3RVNoF0+8r7F0f5CNZ8lRYRdmB86fv6U6dzeFXvzdSfawjtV7BeQQLOySLQgXW9F1MuFM1WP83TZ3t7jocJkarovkW37rKGTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ORhfV8J2sru70F8aBPMjETga5ccf2dxxWPJ0rmuNP8=;
 b=UticO005QulXf2VHYl+0B/OXMEGpF4KnkNzPp+R6o2Yvk01teNiJPqkcR4a9suF+zHLbKqr/HjgGDo+HhQVK3qOwX4RrHsO69lw35j+qrQ4YlKldLbyOanki/LMfj7jpMkQJBHXTzxwOVS99sXNyaOb6ofX4ggWuOVzP7RClj87jZEu/8BU8yPdH248UkVMc8KK/IKE3VVGz7080EqqZU+l0Di0aWmCrXtR14R7ETI6BJFOg7MEG/f2nunwePbMbs2Qaamq43FZsN9u66LVZ1+77sCrCiMhG5fMEcd+iX4Iky7mcH81qm+26QjAyp7hYhoMR3xHJFzFnEwTrrLaUtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=concurrent-rt.com; dmarc=pass action=none
 header.from=concurrent-rt.com; dkim=pass header.d=concurrent-rt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=concurrentrt.onmicrosoft.com; s=selector2-concurrentrt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ORhfV8J2sru70F8aBPMjETga5ccf2dxxWPJ0rmuNP8=;
 b=N3y078Otzh3i3wMpwScRrutaTg6R4yOsAYc7BBGhbnT7wzPsCiikxO+Aa+yle5hxoFv6ekGFfSpW0nvUrP3gNrlBqiJm01AIY72W1OAxxXWVL7jKVOjNjRmJjHz/tYVrJgVzuMAHaIQWPEpMQOHXKjH9c+C/dmj440qGD4uIhQI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Siarhei.Liakh@concurrent-rt.com; 
Received: from MN2PR11MB3885.namprd11.prod.outlook.com (2603:10b6:208:151::27)
 by MN2PR11MB4677.namprd11.prod.outlook.com (2603:10b6:208:24e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Wed, 8 Apr
 2020 18:24:31 +0000
Received: from MN2PR11MB3885.namprd11.prod.outlook.com
 ([fe80::984:ec50:d6de:dc0a]) by MN2PR11MB3885.namprd11.prod.outlook.com
 ([fe80::984:ec50:d6de:dc0a%4]) with mapi id 15.20.2878.018; Wed, 8 Apr 2020
 18:24:31 +0000
From:   siarhei.liakh@concurrent-rt.com
To:     selinux@vger.kernel.org
Cc:     colin.king@canonical.com, eparis@parisplace.org,
        gregkh@linuxfoundation.org, jeffv@google.com, omosnace@redhat.com,
        paul@paul-moore.com, stephen.smalley.work@gmail.com,
        tglx@linutronix.de
Subject: [PATCH 4/9] SELinux: Replace custom hash in avtab with generic lookup3 from the library
Date:   Wed,  8 Apr 2020 14:24:11 -0400
Message-Id: <20200408182416.30995-5-siarhei.liakh@concurrent-rt.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200408182416.30995-1-siarhei.liakh@concurrent-rt.com>
References: <20200408182416.30995-1-siarhei.liakh@concurrent-rt.com>
Content-Type: text/plain
X-ClientProxiedBy: BN6PR19CA0058.namprd19.prod.outlook.com
 (2603:10b6:404:e3::20) To MN2PR11MB3885.namprd11.prod.outlook.com
 (2603:10b6:208:151::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sl-s76.concurrent-rt.com (65.190.80.89) by BN6PR19CA0058.namprd19.prod.outlook.com (2603:10b6:404:e3::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16 via Frontend Transport; Wed, 8 Apr 2020 18:24:31 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [65.190.80.89]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb648525-ff96-4715-443d-08d7dbea14cb
X-MS-TrafficTypeDiagnostic: MN2PR11MB4677:
X-Microsoft-Antispam-PRVS: <MN2PR11MB4677F80BED63AA3B0CD18468B1C00@MN2PR11MB4677.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0367A50BB1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3885.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(366004)(346002)(396003)(376002)(39830400003)(136003)(9686003)(6666004)(508600001)(316002)(6486002)(6916009)(8676002)(52116002)(7696005)(81156014)(8936002)(1076003)(66476007)(186003)(4326008)(86362001)(2906002)(81166007)(16526019)(2616005)(26005)(956004)(66946007)(66556008)(36756003)(5660300002)(41533002);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: concurrent-rt.com does not
 designate permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lb8+5c7EmPYleQGtS7H1SgOTJfmIR6FiJGS5Fq4J7iqG8nMsYVcjp9wnWseJ8IpKQfR/JxgpUOrOWIsoS4sOc2ZE1jX3J7490JAenrSALQgROWQB7/y62KBLkhATWmXFtjelVGQqb7pXD8wTKwZ4VNWY4CE2Uq7lEG4R+hyF6s8+lyLwWVO/9IwnRZ7hrnnifRNAmJpVr5+PnrkCo/Umy4RExVGFYtOFqPfltOKrU4ZGkHx/xgKS8kZKMSwIw52VcwvoaZIFcSP5qI3aYCc44T/z3D0bsYg60s4yiYGtAkPOc4Ghkk8EiEZj/43plr/a6Mon983MzJfz6BE5fP/Wx7qT9ZANVkryFj+eW7YESIwwzH6wdZS8ajPoh04vNngPtHzThg9PpFQftzkWHNGuxUconfXXxybE8yRbpkkJIFQW3foy7e9HbUphRdq4gyNQ3wBMvGyIbR2CELOZXuJfNIgECpFkSxFa2XuDeaHhqicSXjd2wov4Y/4+e0KTKKd2
X-MS-Exchange-AntiSpam-MessageData: 4KSwl4yCct72ljWRgFKoQd1OXuRyNGWO5k10X2rOma0Woq5Eb4U3Z0Q5XbVrKLDkYsfLRhhcxe3BsrkZvaVbIV3CERztx3/pwwtP/aZ4jk4swepPgA68BFCxnJLWJYBV2R2uqGFopq105feZlxXcxA==
X-OriginatorOrg: concurrent-rt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb648525-ff96-4715-443d-08d7dbea14cb
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2020 18:24:31.5789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38747689-e6b0-4933-86c0-1116ee3ef93e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mP6sD9NQAlOTTdXERCauiXNHQH8ulKyfJ38xSX17eZ3XaR6XAeJSCBm/4k+KB6HKpC+Ulx0O4v357IY26YM1QJNjVq6/UBDn9AUlBEM3hwA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4677
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Siarhei Liakh <siarhei.liakh@concurrent-rt.com>

This patch replaces local copy of custom implementation of MurmurHash3 in
avtab.c with existing generic implementation of lookup3 from the standard
Linux library. The library version of hash used to mix 3 x u32 values is
comparable to the custom implementation in run time complexity and bit
avalanche. This change allows to reduce the amount of custom code with has
to be maintained, while preserving overall performance of the hash table
in question.

Before (MurmurHash3):
rules:  282731 entries and 64534/65536 buckets used, longest chain length 17
sum of chain length^2 1522043

After (lookup3):
rules:  282731 entries and 64572/65536 buckets used, longest chain length 16
sum of chain length^2 1517651

Please note that either hash can show a slight [dis]advantage over the other
depending purely on actual rule sets loaded and number of buckets configured.

Signed-off-by: Siarhei Liakh <siarhei.liakh@concurrent-rt.com>
---
Please CC me directly in all replies.

 security/selinux/ss/avtab.c | 39 +++++--------------------------------
 1 file changed, 5 insertions(+), 34 deletions(-)

diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
index 01b300a4a882..58f0de17e463 100644
--- a/security/selinux/ss/avtab.c
+++ b/security/selinux/ss/avtab.c
@@ -20,49 +20,20 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/errno.h>
+#include <linux/jhash.h>
 #include "avtab.h"
 #include "policydb.h"
 
 static struct kmem_cache *avtab_node_cachep;
 static struct kmem_cache *avtab_xperms_cachep;
 
-/* Based on MurmurHash3, written by Austin Appleby and placed in the
- * public domain.
+/* 
+ * Use existing Bob Jenkins' lookup3 hash from the library
  */
 static inline int avtab_hash(struct avtab_key *keyp, u32 mask)
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
+	return jhash_3words(keyp->target_class, keyp->target_type,
+				keyp->source_type) & mask;
 }
 
 static struct avtab_node*
-- 
2.17.1

