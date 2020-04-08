Return-Path: <SRS0=RcjK=5Y=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F8FC2BA2B
	for <selinux@archiver.kernel.org>; Wed,  8 Apr 2020 18:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F0A7208E4
	for <selinux@archiver.kernel.org>; Wed,  8 Apr 2020 18:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=concurrentrt.onmicrosoft.com header.i=@concurrentrt.onmicrosoft.com header.b="x840W/4n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730869AbgDHSYk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 8 Apr 2020 14:24:40 -0400
Received: from mail-eopbgr770102.outbound.protection.outlook.com ([40.107.77.102]:22754
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730862AbgDHSYi (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 8 Apr 2020 14:24:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EYQKr4QZc2FEcBr2SqsM4wIQ1kR5HONhnxAUyWAyxjArKTRgJshVircop6lC89XCGHTR7OAUkWplKNVM7rGUOXEuq6+IEoQJTNk3LUd5E3xLzW07KGCqt+Le82hL0fnAviQU2fFUebwq4sV1r7FPG4G8FrIbuG99EBQkpdt1X7wej1C6HT6jvE0a73JRg662UHa0mQ4DlZC50pl1bh12FbFONhBmJPtbDeSmF9p1pNIRYpfEfKUPSIJK8ymwABPFPHvk1q7lkxANGKu1poJZptN2cWfcodAN/uqijWgU4p7B1rwj8BmlvvGan6hCk1blDWMBczFqXmQha6aEfV+0Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9FKQGmX6WEAM1zYgX/RtKbzmuySB2oZSfTgMUI0lQ7c=;
 b=nlQwa4aAuRp0QWuAdpoXVrEfv6bbLVVacD801pHEnyGRftdXM3RubZ3w3Tqzk9m7b+kTEBdB1SWSc2vcDMU0LCjDnaR/o1IwJu1rWnexJI5ZkpqBj7v4lRmOCVCLngIWT2UCqDy3ubne3Hc6nTKmhYrulLd8jtZg62PBr+/lAS/ly7ATQJeMrhRftdP+mbaXW6DRXa6UJlsNJfLeAnU64/rOuKm1VvbpPryLC2xqwQ1Mhyz0aWXFEf2meTP4sh/kt3+2fM7G7uKTelSrn3facqysC0gDexODNLoNjkCCKxsjVc80GOEMt9sBmCQfEouWcnImlio/xlbK+HVv8wQKlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=concurrent-rt.com; dmarc=pass action=none
 header.from=concurrent-rt.com; dkim=pass header.d=concurrent-rt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=concurrentrt.onmicrosoft.com; s=selector2-concurrentrt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9FKQGmX6WEAM1zYgX/RtKbzmuySB2oZSfTgMUI0lQ7c=;
 b=x840W/4n2noe1VYc8Vj1kezQqMiceMVyOUJdTV+zRjMHRtRRkj9czcnkJiYpj9M/Bs3G5hh3LaFsG4WCtNtBxnX0ASX8iaz0X4cSlgGjwKBT84L7guroUJwc14NaLMoRASIVZHkyHeMhws1cc6bI5EzItGtvFle6S/Hjye9KOQw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Siarhei.Liakh@concurrent-rt.com; 
Received: from MN2PR11MB3885.namprd11.prod.outlook.com (2603:10b6:208:151::27)
 by MN2PR11MB4677.namprd11.prod.outlook.com (2603:10b6:208:24e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Wed, 8 Apr
 2020 18:24:32 +0000
Received: from MN2PR11MB3885.namprd11.prod.outlook.com
 ([fe80::984:ec50:d6de:dc0a]) by MN2PR11MB3885.namprd11.prod.outlook.com
 ([fe80::984:ec50:d6de:dc0a%4]) with mapi id 15.20.2878.018; Wed, 8 Apr 2020
 18:24:32 +0000
From:   siarhei.liakh@concurrent-rt.com
To:     selinux@vger.kernel.org
Cc:     colin.king@canonical.com, eparis@parisplace.org,
        gregkh@linuxfoundation.org, jeffv@google.com, omosnace@redhat.com,
        paul@paul-moore.com, stephen.smalley.work@gmail.com,
        tglx@linutronix.de
Subject: [PATCH 5/9] SELinux: Expose AVTab sizing tunables via Kconfig
Date:   Wed,  8 Apr 2020 14:24:12 -0400
Message-Id: <20200408182416.30995-6-siarhei.liakh@concurrent-rt.com>
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
X-MS-Office365-Filtering-Correlation-Id: 361a6504-b7ee-49e7-1d46-08d7dbea153c
X-MS-TrafficTypeDiagnostic: MN2PR11MB4677:
X-Microsoft-Antispam-PRVS: <MN2PR11MB4677E8EF1AEBDDD17F31E8AAB1C00@MN2PR11MB4677.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0367A50BB1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3885.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(366004)(346002)(396003)(376002)(39830400003)(136003)(9686003)(6666004)(508600001)(316002)(6486002)(6916009)(8676002)(52116002)(7696005)(81156014)(8936002)(1076003)(66476007)(186003)(4326008)(86362001)(2906002)(81166007)(16526019)(2616005)(26005)(956004)(66946007)(66556008)(36756003)(5660300002);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: concurrent-rt.com does not
 designate permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9YE0FwxTmIhjrjGCnHAlUj6ndHWY/aXZ/KKhwrXh09Fy+87efc/9ouGp2YjPrHfxnPMd3Akc8yYKs5JxoXfu2ffI4B7TbLO/v3ly6+6mC6DxDsIZNnXIsU35LvfpJJq7hnuiAg7o0flNPJN+nyj5lqDxsc9tVC7bZJ51Au1sR9fcuNCCcsz4P0uXT2fhr3ioDTyI9yzghi75XTn1snib70lPTtNj/uS7UgR2PrwxYyv6WBtQxyxUttdrGX3OsnFCxC5c4YCpf2VyUbSW5w0ktGA81OW+YTQgbigZnJR1jZrUZTIgHquqh2szA4bsiM18tBseumj+FsM6pcQxQijeV6itKpavBt3yobb55kxkLFmuKZiBDk/kSM9bA7tFpwIZ09klzQbOZO2E75z9zfyvv8/5vB6lqW+bF2WOaE71santPFNbLOdWxu6AnCJgN6RF
X-MS-Exchange-AntiSpam-MessageData: 0i2tNqKULxFfkh/xMi8XiJlDEiw2amXfkgw92eI0dqwElaH6lZKMUI6KL3KiuxoKqeMnCOCZPsn/+oZq31/q3Y2smhoHPTB8k35BHBzSHP2oVNQvPZRwP+IgqBwFiaqZ5v2rXRe/7SVI3KmPXJV53A==
X-OriginatorOrg: concurrent-rt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 361a6504-b7ee-49e7-1d46-08d7dbea153c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2020 18:24:32.2845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38747689-e6b0-4933-86c0-1116ee3ef93e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j/yzfPGhUZuQjoeLfhX3l/TBmfZ+wCpA+vXy2CJ6DYEQlzWh3+dfNgig3CCH9ct14TGPmfJPzSGI2b2dsmiu3j+lo/GaYQnHXVsRKsKtR9E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4677
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Siarhei Liakh <siarhei.liakh@concurrent-rt.com>

This change exposes previously hardcoded AVTab sizing tunables via Kconfig,
which provides a more convenient tuning mechanism for downstream distributions.
Default sizing is not affected.

Signed-off-by: Siarhei Liakh <siarhei.liakh@concurrent-rt.com>
---
Please CC me directly in all replies.

 security/selinux/Kconfig    | 12 ++++++++++++
 security/selinux/ss/avtab.h |  2 +-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/security/selinux/Kconfig b/security/selinux/Kconfig
index 3a736a1c6806..b7ced53ffd76 100644
--- a/security/selinux/Kconfig
+++ b/security/selinux/Kconfig
@@ -111,6 +111,18 @@ config SECURITY_SELINUX_AVC_RECLAIM_COUNT
 	  cycles to bring AVC size under the threshold. Large values may
 	  cause excessive latency of reclamation events.
 
+config SECURITY_SELINUX_AVTAB_HASH_BITS
+	int "Number of slots (buckets) for AVTab hash table, expressed as number of bits (i.e. 2^n)"
+	depends on SECURITY_SELINUX
+	range 1 32
+	default "16"
+	help
+	  This is a power of 2 representing the number of slots (buckets)
+	  used for AVTab hash table. AVTab is the core SELinux database
+	  holding all of the applicable rules. Smaller value reduces memory
+	  footprint at price of hash table lookup efficiency. One bucket
+	  per 10 to 100 rules is reasonable.
+
 config SECURITY_SELINUX_CHECKREQPROT_VALUE
 	int "NSA SELinux checkreqprot default value"
 	depends on SECURITY_SELINUX
diff --git a/security/selinux/ss/avtab.h b/security/selinux/ss/avtab.h
index 5fdcb6696bcc..52b3f82ddacd 100644
--- a/security/selinux/ss/avtab.h
+++ b/security/selinux/ss/avtab.h
@@ -110,7 +110,7 @@ struct avtab_node *avtab_search_node(struct avtab *h, struct avtab_key *key);
 
 struct avtab_node *avtab_search_node_next(struct avtab_node *node, int specified);
 
-#define MAX_AVTAB_HASH_BITS 16
+#define MAX_AVTAB_HASH_BITS CONFIG_SECURITY_SELINUX_AVTAB_HASH_BITS
 #define MAX_AVTAB_HASH_BUCKETS (1 << MAX_AVTAB_HASH_BITS)
 
 #endif	/* _SS_AVTAB_H_ */
-- 
2.17.1

