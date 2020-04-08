Return-Path: <SRS0=RcjK=5Y=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07ABCC2D0F4
	for <selinux@archiver.kernel.org>; Wed,  8 Apr 2020 18:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBC7320784
	for <selinux@archiver.kernel.org>; Wed,  8 Apr 2020 18:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=concurrentrt.onmicrosoft.com header.i=@concurrentrt.onmicrosoft.com header.b="qkskwy8D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730854AbgDHSYf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 8 Apr 2020 14:24:35 -0400
Received: from mail-eopbgr770139.outbound.protection.outlook.com ([40.107.77.139]:43525
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730849AbgDHSYe (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 8 Apr 2020 14:24:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dvnSwJMYrbBPupPQEZuSfkUtJaNu1YdoPBeqpHcL+dE3f/ehhnLyrIactISbCNVg1rmfHHnaB8c1tEDqLdX92HqGGl+/LWFbHf79iYEsc8kYoXN2PJqx2JCY/KQbuiym+flP+JMXU/o/6otDKPTkpDTFXsM4RmQITOktUo79WCOpeT5BWhIyphtYCAvCvtwQI7MoapFVA4a3tnz0asElBywZCBIZ1sx4AeyF/UNGxnrZ8Od4txQsdJJje5JiyRzFxtPIGAfc9rEm0NdsAFVyjixXjBMwMmydLsCNCzKxG/FlilLGK/usw1rkGH3nMqlemApR/MjfAWRX2S19Qm8TMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ud22KMce5TwmIGLZlKSMjtT0eA8RL2O+PqxGBtf3B7Y=;
 b=C7+SgydUiyyeGzX51x0dIU/azPFiui2pOK4PtVxK6T5VuxdO+gvuHV4JZ5i8JfAERemqvXRPBFrOFpbCj5lvleai1N12LvL2CtSjRfc5Z0oNEs5XVXHekC+9v4YaxRtH3hHUQ6IncpShHEWiI/fhDIon3GC8IPIggXVQgKVsgA8IrfnxOwQAQZNGL/3a15hheyYoUoyqswaja6YHozkcZ0hEDsR+/g1ghB10Vs3jtXtSwnQBO2Z42oUG1vnzUi3b4bsyELhPtUYsPzRo4GfGqp2iV6Dd0ObQirjXtindGdq5iT7BDBsW54yxA8ltTM/wkPmpEAeSN3TdzoosaMTrzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=concurrent-rt.com; dmarc=pass action=none
 header.from=concurrent-rt.com; dkim=pass header.d=concurrent-rt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=concurrentrt.onmicrosoft.com; s=selector2-concurrentrt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ud22KMce5TwmIGLZlKSMjtT0eA8RL2O+PqxGBtf3B7Y=;
 b=qkskwy8DPxJSkRMCLhMkrRlyHdn1O1fDhCRgMA3EtWffOl+zgZCDsNSUrTar/fxEL+hlZf1Sq2JVgRVB4gPpDEkBx8rupaWgC4yoB78C+3VdMsrX3+lUDDpW3vAaFBiHhugDybNbvlRzCtDwGQx6vKKgtlsldPp9cl2d+VOaQMI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Siarhei.Liakh@concurrent-rt.com; 
Received: from MN2PR11MB3885.namprd11.prod.outlook.com (2603:10b6:208:151::27)
 by MN2PR11MB4677.namprd11.prod.outlook.com (2603:10b6:208:24e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Wed, 8 Apr
 2020 18:24:30 +0000
Received: from MN2PR11MB3885.namprd11.prod.outlook.com
 ([fe80::984:ec50:d6de:dc0a]) by MN2PR11MB3885.namprd11.prod.outlook.com
 ([fe80::984:ec50:d6de:dc0a%4]) with mapi id 15.20.2878.018; Wed, 8 Apr 2020
 18:24:30 +0000
From:   siarhei.liakh@concurrent-rt.com
To:     selinux@vger.kernel.org
Cc:     colin.king@canonical.com, eparis@parisplace.org,
        gregkh@linuxfoundation.org, jeffv@google.com, omosnace@redhat.com,
        paul@paul-moore.com, stephen.smalley.work@gmail.com,
        tglx@linutronix.de
Subject: [PATCH 2/9] SELinux: Use Bob Jenkins' lookup3 hash in AVC
Date:   Wed,  8 Apr 2020 14:24:09 -0400
Message-Id: <20200408182416.30995-3-siarhei.liakh@concurrent-rt.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200408182416.30995-1-siarhei.liakh@concurrent-rt.com>
References: <20200408182416.30995-1-siarhei.liakh@concurrent-rt.com>
Content-Type: text/plain
X-ClientProxiedBy: BN6PR19CA0058.namprd19.prod.outlook.com
 (2603:10b6:404:e3::20) To MN2PR11MB3885.namprd11.prod.outlook.com
 (2603:10b6:208:151::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sl-s76.concurrent-rt.com (65.190.80.89) by BN6PR19CA0058.namprd19.prod.outlook.com (2603:10b6:404:e3::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16 via Frontend Transport; Wed, 8 Apr 2020 18:24:29 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [65.190.80.89]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 624ea0cf-7b64-4849-bd0b-08d7dbea13f0
X-MS-TrafficTypeDiagnostic: MN2PR11MB4677:
X-Microsoft-Antispam-PRVS: <MN2PR11MB4677DA5CF1AD7DD6A03C22DCB1C00@MN2PR11MB4677.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-Forefront-PRVS: 0367A50BB1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3885.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(366004)(346002)(396003)(376002)(39830400003)(136003)(9686003)(6666004)(508600001)(316002)(6486002)(6916009)(8676002)(52116002)(7696005)(81156014)(8936002)(1076003)(66476007)(186003)(4326008)(86362001)(2906002)(81166007)(16526019)(2616005)(26005)(956004)(66946007)(66556008)(36756003)(5660300002);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: concurrent-rt.com does not
 designate permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vlf9Wyy9Djyy6hOKHIlo64Gz07i3JBs1yWYmcUrssxMS8huRfyqdqeADHtMaaZ4/cjNXC8o2so6jnmlCATVSA81/5QwXpj1lnAdFRouCQ+JQdr1r12zLkSUfkuTQgyw15bXxrK1hrLYYP/QFZEydtc5ihamBPFfaGMiC3lv9bncmVS+TT4UAF8k4D0c47HVpn9b285zs/XK6NHcY26N/Dr9gQQyeW/OXyBA4GLXql8Ixy1PiyWUDZ75KiD8BgfbxoTYC1GsezN1FiQjOPpXpZSoXsn5eFT5brbHyqQRCS0zsCW739EGKSYOb18Zr+LlL958AG811gyQag92rYpBqUhbGHZUnNmTyT9jzekg4W/2f8RAsR7dbkgdvELoT6g9XARgLeDvNKcFMZGjr8aLxJieXYOm4XcjoNL/mxNaE4i2g9b4qq3Q/U6mPDqNEr9DA
X-MS-Exchange-AntiSpam-MessageData: aNMYt21wO60LxFYr7d0rdf1QHXmkiQ8J7AgZMbhdC0ILK9o+MmQ14A4YHEfk5HPQC2BfmBdVkqQLmHjCgUAHprqwJAeMayZusm05RBr1a43HjfGYDSF0Ao5ChMqc1CtLfvMzt4fhQiC1LZ+XWQAHWA==
X-OriginatorOrg: concurrent-rt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 624ea0cf-7b64-4849-bd0b-08d7dbea13f0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2020 18:24:30.1157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38747689-e6b0-4933-86c0-1116ee3ef93e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZWNXNJH4sX37H23ESw1gFeUBX6B0lBso5cOJYExRvmXN8Lct0WqHttudrhr4bq/aLSvH6DVN3cmEcSjPNJQUwnQc0aZKH2g7Axc8h+V6cHU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4677
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Siarhei Liakh <siarhei.liakh@concurrent-rt.com>

This patch allows use of lookup3 as a hash function within AVC with
following benefits:
1. lookup3 has much better bit avalanche properties as compared to local
version of custom hash function, thus reducing hash table collisions.
2. lookup3 is part of standard Linux library, thus provides a much better
long-term maintenance path

Here is an example of how lookup3 improves distribution of entries within AVC:
BJ's lookup3:
entries: 4962
buckets used: 2839/4096
longest chain: 7

Standard hash function:
entries: 4974
buckets used: 2582/4096
longest chain: 12

Signed-off-by: Siarhei Liakh <siarhei.liakh@concurrent-rt.com>
---
Please CC me directly in all replies.

 security/selinux/avc.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index d18cb32a242a..b5893621290b 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -121,9 +121,24 @@ static struct kmem_cache *avc_xperms_data_cachep;
 static struct kmem_cache *avc_xperms_decision_cachep;
 static struct kmem_cache *avc_xperms_cachep;
 
+#ifdef CONFIG_SECURITY_SELINUX_ADVANCED_HASHING
+
+#include <linux/jhash.h>
+#define _avc_hash3(a, b, c) jhash_3words(a, b, c, 0)
+
+#else /* #ifdef CONFIG_SECURITY_SELINUX_ADVANCED_HASHING */
+/*
+ * Original hashing function
+ */
+static inline u32 _avc_hash3(u32 a, u32 b, u32 c)
+{
+	return (a ^ (b << 2) ^ (c << 4));
+}
+#endif /* #else #ifdef CONFIG_SECURITY_SELINUX_ADVANCED_HASHING */
+
 static inline int avc_hash(u32 ssid, u32 tsid, u16 tclass)
 {
-	return (ssid ^ (tsid<<2) ^ (tclass<<4)) & (AVC_CACHE_SLOTS - 1);
+	return _avc_hash3(ssid, tsid, tclass) & (AVC_CACHE_SLOTS - 1);
 }
 
 /**
-- 
2.17.1

