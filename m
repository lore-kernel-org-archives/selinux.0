Return-Path: <SRS0=RcjK=5Y=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3AE3C2D0F4
	for <selinux@archiver.kernel.org>; Wed,  8 Apr 2020 18:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 924F820784
	for <selinux@archiver.kernel.org>; Wed,  8 Apr 2020 18:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=concurrentrt.onmicrosoft.com header.i=@concurrentrt.onmicrosoft.com header.b="nNxwDawY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729827AbgDHSYn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 8 Apr 2020 14:24:43 -0400
Received: from mail-eopbgr770102.outbound.protection.outlook.com ([40.107.77.102]:22754
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730840AbgDHSYk (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 8 Apr 2020 14:24:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fJGl7uOU4vr8FXc4xcxPoeU6gzT7KpPKiP6EFxHsWoOXQB1bIaqooE7trl/CpL+p/Xk2chn1H0v+ZRSARWMMfQsHaNb8Z7xVwqiNQAQWvo5eF9w39ybsfizjYsFsMpYZEUcAXRJTE99H9LEUKDHheJ9UFkvX8bPmHNtlDV9QHT59TkFwT3jga7k7LzUXIfGYfe757p7oPrcoIKSyVXredAshKvyIYYZwU3GN7paEdmSUF83qN279PLa/s2frwr5o3y4pJ3SMj3aGCspZzcaOVhukD9pV0DiH2vZzPWZc8cj0RlGHZEYXPZ2CHOjmNOamF2MAngv12jw7DDJU/JTfFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4V/IO9wmy8YvnrX406MJhRSSMBEC0CXnKXQb9YPqQgo=;
 b=Nji+lSmu+eaWWrvZaqOsfWjb5ly4tXHoXPnxpdg/TouMnWazmVEhdV3he0INUZmWF7HuCprUA4Zp6vOSxJdpNVifnr66VK/E58C1FpTxO1eMmkLDEFValMZVy+A3Ea6ifNJDsInqCahiub6AA9GzTiPTLvHVgm1HlwxMKi/WdVYDR0ZsvGeyhJPeSeJdEYPW/mX3JHXFkqtugOccTHROJyhZ7qb1LEXz7yHA9Rolcyk9AAuYWm1F1a/pi//MoxH+pd8M75SCQy9mxR8IsBYac0kt8gy37BQ4bOf0j4rKG1zQbuGpOrS6eXPapZiDrMnBOKzktn2w8DWm5dAgPyz5Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=concurrent-rt.com; dmarc=pass action=none
 header.from=concurrent-rt.com; dkim=pass header.d=concurrent-rt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=concurrentrt.onmicrosoft.com; s=selector2-concurrentrt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4V/IO9wmy8YvnrX406MJhRSSMBEC0CXnKXQb9YPqQgo=;
 b=nNxwDawYz0+rcdvzN1EQqW+eOBHhAaKNOHyvxOfUrN9TsGhjuFOogOrSU4/tQMY+tj5ya5D4Q9I0cWhDA9KKXYCvOxTyxbyTCVKMZkx9KsqobMvaJaRHjdgH2N+plz8zUKsouBTdEBcijI39yoYNBFV/8dzroqISOttHuOzBTTA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Siarhei.Liakh@concurrent-rt.com; 
Received: from MN2PR11MB3885.namprd11.prod.outlook.com (2603:10b6:208:151::27)
 by MN2PR11MB4677.namprd11.prod.outlook.com (2603:10b6:208:24e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Wed, 8 Apr
 2020 18:24:34 +0000
Received: from MN2PR11MB3885.namprd11.prod.outlook.com
 ([fe80::984:ec50:d6de:dc0a]) by MN2PR11MB3885.namprd11.prod.outlook.com
 ([fe80::984:ec50:d6de:dc0a%4]) with mapi id 15.20.2878.018; Wed, 8 Apr 2020
 18:24:34 +0000
From:   siarhei.liakh@concurrent-rt.com
To:     selinux@vger.kernel.org
Cc:     colin.king@canonical.com, eparis@parisplace.org,
        gregkh@linuxfoundation.org, jeffv@google.com, omosnace@redhat.com,
        paul@paul-moore.com, stephen.smalley.work@gmail.com,
        tglx@linutronix.de
Subject: [PATCH 7/9] SELinux: Expose filename_tr hash table sizing via Kconfig
Date:   Wed,  8 Apr 2020 14:24:14 -0400
Message-Id: <20200408182416.30995-8-siarhei.liakh@concurrent-rt.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200408182416.30995-1-siarhei.liakh@concurrent-rt.com>
References: <20200408182416.30995-1-siarhei.liakh@concurrent-rt.com>
Content-Type: text/plain
X-ClientProxiedBy: BN6PR19CA0058.namprd19.prod.outlook.com
 (2603:10b6:404:e3::20) To MN2PR11MB3885.namprd11.prod.outlook.com
 (2603:10b6:208:151::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sl-s76.concurrent-rt.com (65.190.80.89) by BN6PR19CA0058.namprd19.prod.outlook.com (2603:10b6:404:e3::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16 via Frontend Transport; Wed, 8 Apr 2020 18:24:33 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [65.190.80.89]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9d8a6ea-8669-43b4-8b53-08d7dbea1644
X-MS-TrafficTypeDiagnostic: MN2PR11MB4677:
X-Microsoft-Antispam-PRVS: <MN2PR11MB467777AC014AC382E0FA8F7EB1C00@MN2PR11MB4677.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0367A50BB1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3885.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(366004)(346002)(396003)(376002)(39830400003)(136003)(9686003)(6666004)(508600001)(316002)(6486002)(6916009)(8676002)(52116002)(7696005)(81156014)(8936002)(1076003)(66476007)(186003)(4326008)(86362001)(2906002)(81166007)(16526019)(2616005)(26005)(956004)(66946007)(66556008)(36756003)(5660300002);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: concurrent-rt.com does not
 designate permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dzkaR0R6WPaYZ9vCDJ1mvxDHq/ScU6ZmOgn6TAtWvflo9OtYteWW51waf6KnmGvLJ8Txilk0euZkVwo99dzkgcWwIFS7kPxUA7Z94iT6wdnQWvDqymGTJndmZg0Q/3uQ1zlQyDNlm6H5ytULCPVihEMfonN6phmww22H6ofGcB++Cpy0oJut7QFcM8YrrVPRYFkUC9EYAn41HQ6jOOin31CZ0L54Sf0789vOhZW70p0rNVUZHb56eOFVfxCWKzFNudTgo7KLr0MUs9IZQS2pJ2ZxMwrUImRO3N90HdZ7f7jPSQYo4vmLDY2jnLxowpiEWNFW8edxTDhOCPcUSNHlmoXngMIVXm3UkQ7HEP6S/Yk7SLyp1x4piytlxBYajTqFPP8EsGPlplxrmXJTeyQxj+/YRnyWW/PbnQZqlH/gmWhJI0eqZa+cSQ8YtF98/iLH
X-MS-Exchange-AntiSpam-MessageData: 5tuYLXk3A1e8izxWGakSNhx0Xj76lWZgmC8FzwOoy1qTeweiWjgB71RAUWLAwOypfn/SiorwB/lFb3l1eh9FqvtVMrFys+dk+LY2LG/cuqzWf8vr813twhhNW9zJR3vZ809drkDLzkwjaiMnmD4lmg==
X-OriginatorOrg: concurrent-rt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9d8a6ea-8669-43b4-8b53-08d7dbea1644
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2020 18:24:34.0864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38747689-e6b0-4933-86c0-1116ee3ef93e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BrNS54VyLm2tBANz9zyfodE514DUC3qLWXX6U1M1iPxMVHsA8kmGploCmjJ0BZcnhXGJrSBvxE3o+yau8E3UVAQK7XRg9487wJ0zj6ph860=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4677
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Siarhei Liakh <siarhei.liakh@concurrent-rt.com>

This change exposes previously hardcoded filename_tr sizing via Kconfig,
which provides a more convenient tuning mechanism for downstream distributions.
Default sizing is not affected.

Signed-off-by: Siarhei Liakh <siarhei.liakh@concurrent-rt.com>
---
Please CC me directly in all replies.

 security/selinux/Kconfig       | 10 ++++++++++
 security/selinux/ss/policydb.c |  3 ++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/security/selinux/Kconfig b/security/selinux/Kconfig
index b7ced53ffd76..23ec741b1ce6 100644
--- a/security/selinux/Kconfig
+++ b/security/selinux/Kconfig
@@ -123,6 +123,16 @@ config SECURITY_SELINUX_AVTAB_HASH_BITS
 	  footprint at price of hash table lookup efficiency. One bucket
 	  per 10 to 100 rules is reasonable.
 
+config SECURITY_SELINUX_PDB_FILE_TR_HASH_BITS
+	int "Number of slots (buckets) for File Transitions hash table, expressed as number of bits (i.e. 2^n)"
+	depends on SECURITY_SELINUX
+	range 1 32
+	default "11"
+	help
+	  This is a power of 2 representing the number of slots (buckets)
+	  used for File Transitions hash table. Smaller value reduces memory
+	  footprint at price of hash table lookup efficiency.
+
 config SECURITY_SELINUX_CHECKREQPROT_VALUE
 	int "NSA SELinux checkreqprot default value"
 	depends on SECURITY_SELINUX
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 0d03036ca20d..f2d809dffb25 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -496,7 +496,8 @@ static int policydb_init(struct policydb *p)
 	cond_policydb_init(p);
 
 	p->filename_trans = hashtab_create(filenametr_hash, filenametr_cmp,
-					   (1 << 11));
+			   (1 << CONFIG_SECURITY_SELINUX_PDB_FILE_TR_HASH_BITS));
+
 	if (!p->filename_trans)
 		return -ENOMEM;
 
-- 
2.17.1

