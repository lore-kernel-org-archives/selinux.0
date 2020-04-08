Return-Path: <SRS0=RcjK=5Y=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A03AFC2D0F4
	for <selinux@archiver.kernel.org>; Wed,  8 Apr 2020 18:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E89A20784
	for <selinux@archiver.kernel.org>; Wed,  8 Apr 2020 18:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=concurrentrt.onmicrosoft.com header.i=@concurrentrt.onmicrosoft.com header.b="AJ4hOE7W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729873AbgDHSYp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 8 Apr 2020 14:24:45 -0400
Received: from mail-eopbgr770102.outbound.protection.outlook.com ([40.107.77.102]:22754
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729789AbgDHSYo (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 8 Apr 2020 14:24:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DNoiGhbSathkbCfHigIQs8Zvi4TfkfHHIGd5YjZwGLFio/Wyi+XlVWlvU2Zj/LFa9WiDWGJuGaXpiInYn06Bhy9s5PF5OhyzOTpp4KyW3h8+NMTs0QtdTg+EaaXvqiAAwUO7STRNUUDhbebxBGL0KyRdcWSUkHM3ObYkfPsxPEKdwJnhJDF+nKSSGX/Bx1kxobXnRMu6X1VsSD/5BcyS/qN7jWolH5N3JKteBVXiF11k8g+UWbJXffuvk6H/xBV/Fy81h1BR2iLLifMR/xN0KTVgNTwVVDRu69O8Z64bDFLLnDgJ6E8b7VEMo+pUBW0wkKUJjfFsGhNp5xkx9g07SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JlJbsT0e97LL4eWW8se91Pu1a4i5Pffdsc4945eyeQs=;
 b=DBWniFEgN66i4V3sApJm62ORIk0+ttPhLAVEPFtU8QMHz71De0x3tZAwP3AzFr+/wSeuudExEZvvC/2cEmOTakmkS3AtgijEVYdm1+cK8ajWbv22Llg9hmcWNzp3bAvdb7q5KUs26YSvniVUqrXhE0nVBGDDDHKaubsmStFhyJzIGYN2n8E4Y5muLXBYAQhZwTHmxZxtQHqTOXJGUAU2AD/JcvAqCH9Q+9PA4oj2M+r2KcIIlhrMNJc5ykyfdvZi47Qvw5UntkPL30aXLNs7IZ8fMvgQSkKvE/19e+tU2ufziUbvwpQ52fxIXJCNGE0DH97r1xyK93kOtzOv1xAQ9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=concurrent-rt.com; dmarc=pass action=none
 header.from=concurrent-rt.com; dkim=pass header.d=concurrent-rt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=concurrentrt.onmicrosoft.com; s=selector2-concurrentrt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JlJbsT0e97LL4eWW8se91Pu1a4i5Pffdsc4945eyeQs=;
 b=AJ4hOE7WIBnu1rOGcq/G7M+UdJvceM/4nin7FYz4p/lEMdd7nQ1fmD/dm+7SUXK6q0sg1xGXej74wmUk/o7uEXxxL2wWVktHm9KMoTTcbi78Ypk0kyTAg7OVBEg/kyXWuLTLVyjRR4RbrBVSRPYg2rzhGAcA1TbeYbh7on8o69A=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Siarhei.Liakh@concurrent-rt.com; 
Received: from MN2PR11MB3885.namprd11.prod.outlook.com (2603:10b6:208:151::27)
 by MN2PR11MB4677.namprd11.prod.outlook.com (2603:10b6:208:24e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Wed, 8 Apr
 2020 18:24:35 +0000
Received: from MN2PR11MB3885.namprd11.prod.outlook.com
 ([fe80::984:ec50:d6de:dc0a]) by MN2PR11MB3885.namprd11.prod.outlook.com
 ([fe80::984:ec50:d6de:dc0a%4]) with mapi id 15.20.2878.018; Wed, 8 Apr 2020
 18:24:35 +0000
From:   siarhei.liakh@concurrent-rt.com
To:     selinux@vger.kernel.org
Cc:     colin.king@canonical.com, eparis@parisplace.org,
        gregkh@linuxfoundation.org, jeffv@google.com, omosnace@redhat.com,
        paul@paul-moore.com, stephen.smalley.work@gmail.com,
        tglx@linutronix.de
Subject: [PATCH 9/9] SELinux: Expose netport hash table sizing via Kconfig
Date:   Wed,  8 Apr 2020 14:24:16 -0400
Message-Id: <20200408182416.30995-10-siarhei.liakh@concurrent-rt.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200408182416.30995-1-siarhei.liakh@concurrent-rt.com>
References: <20200408182416.30995-1-siarhei.liakh@concurrent-rt.com>
Content-Type: text/plain
X-ClientProxiedBy: BN6PR19CA0058.namprd19.prod.outlook.com
 (2603:10b6:404:e3::20) To MN2PR11MB3885.namprd11.prod.outlook.com
 (2603:10b6:208:151::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sl-s76.concurrent-rt.com (65.190.80.89) by BN6PR19CA0058.namprd19.prod.outlook.com (2603:10b6:404:e3::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16 via Frontend Transport; Wed, 8 Apr 2020 18:24:35 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [65.190.80.89]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8a6b8a1-a02c-4079-8ad0-08d7dbea172f
X-MS-TrafficTypeDiagnostic: MN2PR11MB4677:
X-Microsoft-Antispam-PRVS: <MN2PR11MB467715EAFD4915FFB50EADFAB1C00@MN2PR11MB4677.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 0367A50BB1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3885.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(366004)(346002)(396003)(376002)(39830400003)(136003)(9686003)(6666004)(508600001)(316002)(6486002)(6916009)(8676002)(52116002)(7696005)(81156014)(8936002)(1076003)(66476007)(186003)(4326008)(86362001)(2906002)(81166007)(16526019)(2616005)(26005)(956004)(66946007)(66556008)(36756003)(5660300002);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: concurrent-rt.com does not
 designate permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eKNZoll1cUx52mdXCyu9a4/1DoyIlGjjjZzQYSs1+e9tgsrkVTHlzlTuf77uG4cQ1w45clR2cgz44PyVaXMd6wqznRXvpaFOve21+0+OxedPAZuGebOpnEMWWDeRc/89exBXPcih/Hb7zKr24mD+Ja533OqLUofCmkCfVPmteQgPZ1sHh6HpSLbZhrnkdjdCkZt2TsQT8Fo7nw32JPwCP8acm07m029GLRQxN8ZC20F3Wrpjh0HrcONdVZmLFRbB8MdaoK8yXkA1xKoV/fb5DPyJ7NCmkK6cUZmzpEoghSAVRi5s4992sNWHi8yuOL3K6kOpJ9rgXiNH6XVXeICJpX8q+PBOw2LEo8XCjp4abkBJrG+RVW+lLhI8oHI91FnI3Zq7Cyh6iFg93ScAMGTlN8BoskxdJnWXmqc6S11he1/bxP30FTETsxt83dxwzgcP
X-MS-Exchange-AntiSpam-MessageData: rO4XQvV0NFKe/mHEk4qWgSYI7AQhlnjMHHeS7iPQdIGRK5tVuM0y+VAnqt/isopp5+XbueyXW3k/p9zNc55cBWTjoab/jdliX0QFmJb6sh5xctqbytXfmNV+PZrhATl+93Y7xMMMoqqk/kBA6pEFyQ==
X-OriginatorOrg: concurrent-rt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8a6b8a1-a02c-4079-8ad0-08d7dbea172f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2020 18:24:35.5865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38747689-e6b0-4933-86c0-1116ee3ef93e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FBhgG1QGdQsieZ0CPIq+IeGSUuX7R5/8lHWUReyZP9aUJitm39wcwcKixV8Z7e65m2mCqjIROnHhS/coe1D3F2cN99biN86+gidWz8mS8Uo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4677
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Siarhei Liakh <siarhei.liakh@concurrent-rt.com>

This change exposes previously hardcoded netport sizing tunables via Kconfig,
which provides a more convenient tuning mechanism for downstream distributions.
Default sizing is not affected.

Signed-off-by: Siarhei Liakh <siarhei.liakh@concurrent-rt.com>
---
Please CC me directly in all replies.

 security/selinux/Kconfig   | 20 ++++++++++++++++++++
 security/selinux/netport.c |  4 ++--
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/security/selinux/Kconfig b/security/selinux/Kconfig
index 23ec741b1ce6..d65626142bcf 100644
--- a/security/selinux/Kconfig
+++ b/security/selinux/Kconfig
@@ -133,6 +133,26 @@ config SECURITY_SELINUX_PDB_FILE_TR_HASH_BITS
 	  used for File Transitions hash table. Smaller value reduces memory
 	  footprint at price of hash table lookup efficiency.
 
+config SECURITY_SELINUX_NETPORT_HASH_BITS
+	int "Number of slots (buckets) for Netport hash table, expressed as number of bits (i.e. 2^n)"
+	depends on SECURITY_SELINUX
+	range 1 16
+	default "8"
+	help
+	  This is a power of 2 representing the number of slots (buckets)
+	  used for Netport hash table. Smaller value reduces memory
+	  footprint at price of hash table lookup efficiency.
+
+config SECURITY_SELINUX_NETPORT_HASH_BLIMIT
+	int "Bucket size limit for Netport hash table."
+	depends on SECURITY_SELINUX
+	range 1 131072
+	default "16"
+	help
+	  This is a an upper limit on number of entries a bucket can hold
+	  within Netport hash. Lower values conserve memory at price of
+	  more expensive lookups when a Netport cache miss occurs.
+
 config SECURITY_SELINUX_CHECKREQPROT_VALUE
 	int "NSA SELinux checkreqprot default value"
 	depends on SECURITY_SELINUX
diff --git a/security/selinux/netport.c b/security/selinux/netport.c
index de727f7489b7..ef8e9abcadf7 100644
--- a/security/selinux/netport.c
+++ b/security/selinux/netport.c
@@ -32,8 +32,8 @@
 #include "netport.h"
 #include "objsec.h"
 
-#define SEL_NETPORT_HASH_SIZE       256
-#define SEL_NETPORT_HASH_BKT_LIMIT   16
+#define SEL_NETPORT_HASH_SIZE (1 << CONFIG_SECURITY_SELINUX_NETPORT_HASH_BITS)
+#define SEL_NETPORT_HASH_BKT_LIMIT CONFIG_SECURITY_SELINUX_NETPORT_HASH_BLIMIT
 
 struct sel_netport_bkt {
 	int size;
-- 
2.17.1

