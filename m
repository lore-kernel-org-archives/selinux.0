Return-Path: <SRS0=RcjK=5Y=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF8BC2BA1A
	for <selinux@archiver.kernel.org>; Wed,  8 Apr 2020 18:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A6A420753
	for <selinux@archiver.kernel.org>; Wed,  8 Apr 2020 18:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=concurrentrt.onmicrosoft.com header.i=@concurrentrt.onmicrosoft.com header.b="nZtrAA2O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730862AbgDHSYk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 8 Apr 2020 14:24:40 -0400
Received: from mail-eopbgr770139.outbound.protection.outlook.com ([40.107.77.139]:43525
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730860AbgDHSYj (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 8 Apr 2020 14:24:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dQSL2shHUrXNhPWSePR9f99w1jD1QTImDPQc7gwJFVnVa91bGe+gteEadic85WL4Uxsm84HonI5fWbFBd57YtBKVKLmPslq9gdaq/hNtDzxT41b0wY3BTc2sAqeAUQUXcpExM34Rt3UsQiHQFfcBp/7k1JYAcJa4vhThiu1TJ3jrXwPsPqnMtKaV+FbwySgJzYR/mRRG7XYTpexK2AWKUtCQm91j4fHr0YSgdyiq0L/ndz/z71yjXyBH8AqdHD30Q3Q2LWqRwezXG9xuCEghnqN8wrqRXxq3m4kFvmFL9iUzn1AfeJ8MHcGBWfyY1b43ICH6my00cdSIgOukKVRTtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VpinJPN8AAeZsBa5+Vo4HlZG01e5K/FwbcyJLVe5+GQ=;
 b=B/QVAd1w4iK5wcqkkVVyWWQ6rLdh5HK3FfcEQIGG99ZnD2O/XPVK0Jn2xmV9g2AliNkBs4bll/5EuqL7FEVvbIdzatUGFjUxHlPD/5brfzNhQJEL+smUESefcaP0maYlCNF721ZT1wcXmuQyer4rJ3xFNPL+xQSQP7ACZ0fD7884ixEhTcy7D9yKrOLdlblU/aQoPLcxXDB+46IUv3jZEiRyFwjk5Okn2WcLHObnT+VHR3K2wbqeZLCIKTto/5oy6zM6ve16/YeUBD5FNCAiW0jDO7QM4gysXD5BOUWc0svfCi7BFa+xpLpP2BYRPt0jUp0zl811O34c/MeJhCRX9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=concurrent-rt.com; dmarc=pass action=none
 header.from=concurrent-rt.com; dkim=pass header.d=concurrent-rt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=concurrentrt.onmicrosoft.com; s=selector2-concurrentrt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VpinJPN8AAeZsBa5+Vo4HlZG01e5K/FwbcyJLVe5+GQ=;
 b=nZtrAA2OtrWWdJ6j/MAIOtzvqtPxGUNVhZZT1ezFVNSdA61TWyJiEDNa3XvMGGGI815tAsq8cPFZsYX754kqjWIr4GR9K6LdaOqkQyVKGa/MIYsFLqzJCrcYi0OF1lnmNdbsXLF2RQcMImiIdsXQkjDwf2iQcgCZu6TvhfjtTAc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Siarhei.Liakh@concurrent-rt.com; 
Received: from MN2PR11MB3885.namprd11.prod.outlook.com (2603:10b6:208:151::27)
 by MN2PR11MB4677.namprd11.prod.outlook.com (2603:10b6:208:24e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Wed, 8 Apr
 2020 18:24:33 +0000
Received: from MN2PR11MB3885.namprd11.prod.outlook.com
 ([fe80::984:ec50:d6de:dc0a]) by MN2PR11MB3885.namprd11.prod.outlook.com
 ([fe80::984:ec50:d6de:dc0a%4]) with mapi id 15.20.2878.018; Wed, 8 Apr 2020
 18:24:33 +0000
From:   siarhei.liakh@concurrent-rt.com
To:     selinux@vger.kernel.org
Cc:     colin.king@canonical.com, eparis@parisplace.org,
        gregkh@linuxfoundation.org, jeffv@google.com, omosnace@redhat.com,
        paul@paul-moore.com, stephen.smalley.work@gmail.com,
        tglx@linutronix.de
Subject: [PATCH 6/9] SELinux: Replace custom hash with generic lookup3 in policydb
Date:   Wed,  8 Apr 2020 14:24:13 -0400
Message-Id: <20200408182416.30995-7-siarhei.liakh@concurrent-rt.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200408182416.30995-1-siarhei.liakh@concurrent-rt.com>
References: <20200408182416.30995-1-siarhei.liakh@concurrent-rt.com>
Content-Type: text/plain
X-ClientProxiedBy: BN6PR19CA0058.namprd19.prod.outlook.com
 (2603:10b6:404:e3::20) To MN2PR11MB3885.namprd11.prod.outlook.com
 (2603:10b6:208:151::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sl-s76.concurrent-rt.com (65.190.80.89) by BN6PR19CA0058.namprd19.prod.outlook.com (2603:10b6:404:e3::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16 via Frontend Transport; Wed, 8 Apr 2020 18:24:32 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [65.190.80.89]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 483250b1-b542-4df8-4b51-08d7dbea15c4
X-MS-TrafficTypeDiagnostic: MN2PR11MB4677:
X-Microsoft-Antispam-PRVS: <MN2PR11MB467727DD4CBE21C8F07BBD52B1C00@MN2PR11MB4677.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 0367A50BB1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3885.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(366004)(346002)(396003)(376002)(39830400003)(136003)(9686003)(6666004)(508600001)(316002)(6486002)(6916009)(8676002)(52116002)(7696005)(81156014)(8936002)(1076003)(66476007)(186003)(4326008)(86362001)(2906002)(81166007)(16526019)(2616005)(26005)(956004)(66946007)(66556008)(36756003)(5660300002)(41533002);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: concurrent-rt.com does not
 designate permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ydI/ZxL+ejldEWOlFF+OnPwPiz+IKt5GAyqFNzU2NgdEVkaFwBrRJkMb7Y+HDWKdbsxBfNo5apCjvWtUsJGP5uAkOdk3ACOknwCvqkqasZjHq/ng1wXIWN10jxbcaeUPDbw6fiGOerUX0urflZEsHtRMsI6/1wkG+53ay5hyUTmEh3lDYNFV1GtwKX8z1atiP8LweiWQCtBiITsbDMvtqrkWHJqevMkexOBrIgjU8GNDrHSUNJY+LOo2ddvT9fmLRdoO5OtyYr2+/JJkCgUTnKAis9bdUs5VlIzxQry00DoR55FAqMB+GVLVNU+M/FwUSpfy4v0eIJ0HPI02msVQIKPbHV02ahwRqbkc/zIZUGgz+aJ2kEY5TWbg0SU/0LkLljm9Rndd5LZrLQh2obIzPM2kd4qgpB+sDznVeBCM82hXryYW9v4CVn7qpHVUVY3me6LJyhJPX+2EVU+dMN9GOel5xoIAmtUSFw2NA9DH+BpnLtHuTR81YjXIxttECpZG
X-MS-Exchange-AntiSpam-MessageData: pyEGUAgnrh2oxUMF4lgco9PCPvpoJdHkhVHdapJHfcdJnqxvr+jOPS9YIX1QWxbDkUJ0tlDqfXoy1w+P0ILs4e6+ZfHZW2HN+B0U5oFPl6j5BonoTof/GNwANGbgrOJ1QCHjHVf5bovTD8ElHmFesA==
X-OriginatorOrg: concurrent-rt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 483250b1-b542-4df8-4b51-08d7dbea15c4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2020 18:24:33.2139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38747689-e6b0-4933-86c0-1116ee3ef93e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 14Gdvg8a3MezWxkktXdnXLc/eO6JIh9ks1wtVg0k1xyPXq8tnrsOTi+Goap4+u1qlFXqGZ7TXKzasF05H+zhmdXNf5KXs4iCgg6WPIl9RfU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4677
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Siarhei Liakh <siarhei.liakh@concurrent-rt.com>

This patch replaces local copy of custom hash function with existing
implementation of lookup3 from the standard Linux library. This change
allows to reduce the amount of custom code with has to be maintained, while
potentially improving overall performance of the hash table in question.

Signed-off-by: Siarhei Liakh <siarhei.liakh@concurrent-rt.com>
---
Please CC me directly in all replies.

 security/selinux/ss/policydb.c | 43 +++++++++++++++++++++++++++-------
 1 file changed, 35 insertions(+), 8 deletions(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 70ecdc78efbd..0d03036ca20d 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -41,6 +41,10 @@
 #include "mls.h"
 #include "services.h"
 
+#ifdef CONFIG_SECURITY_SELINUX_ADVANCED_HASHING
+#include <linux/jhash.h>
+#endif /* #ifdef CONFIG_SECURITY_SELINUX_ADVANCED_HASHING */
+
 #define _DEBUG_HASHES
 
 #ifdef DEBUG_HASHES
@@ -399,6 +403,27 @@ static int roles_init(struct policydb *p)
 	return rc;
 }
 
+#ifdef CONFIG_SECURITY_SELINUX_ADVANCED_HASHING
+
+static u32 filenametr_hash(struct hashtab *h, const void *k)
+{
+	const struct filename_trans_key *ft = k;
+	unsigned long hash;
+
+	hash = jhash_2words(ft->ttype, ft->tclass, 0);
+	hash = jhash(ft->name, strlen(ft->name), hash);
+	return hash & (h->size - 1);
+}
+
+static u32 rangetr_hash(struct hashtab *h, const void *k)
+{
+	const struct range_trans_key *key = k;
+	return jhash_3words(key->source_type, key->target_type,
+			key->target_class, 0) & (h->size - 1);
+}
+
+#else /* #ifdef CONFIG_SECURITY_SELINUX_ADVANCED_HASHING */
+
 static u32 filenametr_hash(struct hashtab *h, const void *k)
 {
 	const struct filename_trans_key *ft = k;
@@ -414,6 +439,16 @@ static u32 filenametr_hash(struct hashtab *h, const void *k)
 	return hash & (h->size - 1);
 }
 
+static u32 rangetr_hash(struct hashtab *h, const void *k)
+{
+	const struct range_trans *key = k;
+
+	return (key->source_type + (key->target_type << 3) +
+		(key->target_class << 5)) & (h->size - 1);
+}
+
+#endif /* #else #ifdef CONFIG_SECURITY_SELINUX_ADVANCED_HASHING */
+
 static int filenametr_cmp(struct hashtab *h, const void *k1, const void *k2)
 {
 	const struct filename_trans_key *ft1 = k1;
@@ -432,14 +467,6 @@ static int filenametr_cmp(struct hashtab *h, const void *k1, const void *k2)
 
 }
 
-static u32 rangetr_hash(struct hashtab *h, const void *k)
-{
-	const struct range_trans *key = k;
-
-	return (key->source_type + (key->target_type << 3) +
-		(key->target_class << 5)) & (h->size - 1);
-}
-
 static int rangetr_cmp(struct hashtab *h, const void *k1, const void *k2)
 {
 	const struct range_trans *key1 = k1, *key2 = k2;
-- 
2.17.1

