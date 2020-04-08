Return-Path: <SRS0=RcjK=5Y=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD8CC2BA1A
	for <selinux@archiver.kernel.org>; Wed,  8 Apr 2020 18:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1656208E4
	for <selinux@archiver.kernel.org>; Wed,  8 Apr 2020 18:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=concurrentrt.onmicrosoft.com header.i=@concurrentrt.onmicrosoft.com header.b="LsJOrGFR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730870AbgDHSYn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 8 Apr 2020 14:24:43 -0400
Received: from mail-eopbgr770139.outbound.protection.outlook.com ([40.107.77.139]:43525
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730867AbgDHSYk (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 8 Apr 2020 14:24:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FJQaih2I9j+6PTm0b75WPEdvaCQjXwKOL/CgeBP/lld/W987mdGRwBxfijlaplBRzOIYhhAohwFeW3JjZRv8fzSQ5VqXBeVDiUwP+TD3hdBCkOJzuM1hMIseq2f8r7auqbhACSTZnRyZmeExEiY7TYD2QSy8Iy8s9VD1x03h6jKlHfoTsLnwBUpwftIHciqGZmpN3Br7Rkogsym/LNcNyBMbSm60cWAn06Jln117XC/2FkiGMd7Sf+dG5oTk0ql4WwTHAsGKcRqRWllrEKFSTbOlaYGzwbWeSZ5kAyedldrEEBFHregtFoA1SOoM+3zQsqQBiF6Seh9KgwTDSDIgAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NZMiYpVueZyIHbLVbGFzvxDBQU9pghZxULZSdPSRZFI=;
 b=QSLn1RTyDPIoCFoShUsDTTLzhz+Idoj/XZr96KL2RVHxfk3oVyNNBxg6S9wU8scoMi3ciKHA5BROUy6+1KCtGYkV/9ZtCDFjZwyDi4ThIVf2ZrbhHhG+MDajbs1avaqC3EySPYHysqG3CQWPZkSVkDHr0qY4MufELGOULG9RwYOpBacG9KICBilFaGD6VB/rNxkpjCENm9SFkuf4fFRqp605YByuIKtZ9Zho6gbh6cl9egeVQG5vgdvHW+QpCaQWA0hGfh/JDmbvv4TtgBqcE1bJSe4gpTVxlhqDBy+YDOvOrwaQzNuiZsbxV7y3s5L+60OwkwKWitZff/FMCvAkSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=concurrent-rt.com; dmarc=pass action=none
 header.from=concurrent-rt.com; dkim=pass header.d=concurrent-rt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=concurrentrt.onmicrosoft.com; s=selector2-concurrentrt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NZMiYpVueZyIHbLVbGFzvxDBQU9pghZxULZSdPSRZFI=;
 b=LsJOrGFRqDWDkUVey9RIgdXVuFeU5zO13dmRowTXunOEDtMdvtAltWLlVGpwnoVhk4Ud5QhWzGHmbrZvVLmMbkJkNoC9JtKao4uwspQdp4/vNxYPCFdGw2DR1qOAYQGCMLMvrNoYM48humKQecBnVTOBMSHFrRBWWHHavIspkPo=
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
Subject: [PATCH 8/9] SELinux: Replace custom hash with generic lookup3 in symtab
Date:   Wed,  8 Apr 2020 14:24:15 -0400
Message-Id: <20200408182416.30995-9-siarhei.liakh@concurrent-rt.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200408182416.30995-1-siarhei.liakh@concurrent-rt.com>
References: <20200408182416.30995-1-siarhei.liakh@concurrent-rt.com>
Content-Type: text/plain
X-ClientProxiedBy: BN6PR19CA0058.namprd19.prod.outlook.com
 (2603:10b6:404:e3::20) To MN2PR11MB3885.namprd11.prod.outlook.com
 (2603:10b6:208:151::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sl-s76.concurrent-rt.com (65.190.80.89) by BN6PR19CA0058.namprd19.prod.outlook.com (2603:10b6:404:e3::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16 via Frontend Transport; Wed, 8 Apr 2020 18:24:34 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [65.190.80.89]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 96ff04e1-1772-4f35-ee94-08d7dbea16bd
X-MS-TrafficTypeDiagnostic: MN2PR11MB4677:
X-Microsoft-Antispam-PRVS: <MN2PR11MB46778C3B8E8E3D8426DBA8F3B1C00@MN2PR11MB4677.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-Forefront-PRVS: 0367A50BB1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3885.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(366004)(346002)(396003)(376002)(39830400003)(136003)(9686003)(6666004)(508600001)(316002)(6486002)(6916009)(8676002)(52116002)(7696005)(81156014)(8936002)(1076003)(66476007)(186003)(4326008)(86362001)(2906002)(81166007)(16526019)(2616005)(26005)(956004)(66946007)(66556008)(36756003)(5660300002)(41533002);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: concurrent-rt.com does not
 designate permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dE49iIFuTLqaXDm7Oggu1yv1AqcNrndexBLDmAihCBXnnVBUyK7CesnTBSScRuJZxTFtT8M6Un/gGURh8zhlCtKo5E4/NT1k4X0eLC4ECEwn161igbnqcqPshLEbTwRQTIVb/y+azmGIftUWApytfmcXjiDk5BtFLCpnqqQvcMsTYtcKqGgkE1Emes1z7VezrJWutyF30GMRc3cWTp2zCo7V+4iEwkASvlPxk5ONcoXv2PWU6etlgVwhXEqnzVo6/TO7DMghqEwE0ofZqHLeUZfaEgrg/Fm+TGxXK9Kh8AAa2M6iLKzJyKJfT6rcTjETA0QoBXy7VP7uvp7ZO9BHFEN3TNw84PVeAoU8A8X2clxNNplexBzPWxmQOIB8GVnrM5mRotFdvaDW62enHHFO3mDsRzZOmhbdxskFGZ/ZaTQnsAk2l2lKavQwjXBXNAtP0mt5YeY0FXjJw3MjlShbZ5QRDtO0M9jMsFIJRm+8M/Y=
X-MS-Exchange-AntiSpam-MessageData: 8qdqvt1FC0A3O93mr+qLaPvrWBlXWYPLEp3E+kBPJV12geaEtC1DFY9Eo3S7T4iFOUYGdMxiRIFujMFEV9yd6Oeb+PfVfN3gYASD0jQt2fj9G0iBhK14i2m9pNVjuLHemnZL4aY6cDty0KDBwz/j/A==
X-OriginatorOrg: concurrent-rt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96ff04e1-1772-4f35-ee94-08d7dbea16bd
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2020 18:24:34.7980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38747689-e6b0-4933-86c0-1116ee3ef93e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9y7IO8kXMPizNRUT7ITyXvLBocn8BkfusiPjP9A7X6U21d8lOkaF1miNJZH8ojUo7XDKZ1Vt7O+QtRVInSK4cq4I53p/ViocmgdVGzSPOZE=
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

 security/selinux/ss/symtab.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/security/selinux/ss/symtab.c b/security/selinux/ss/symtab.c
index dc2ce94165d3..8d189d7683d1 100644
--- a/security/selinux/ss/symtab.c
+++ b/security/selinux/ss/symtab.c
@@ -9,6 +9,16 @@
 #include <linux/errno.h>
 #include "symtab.h"
 
+#ifdef CONFIG_SECURITY_SELINUX_ADVANCED_HASHING
+#include <linux/jhash.h>
+
+static unsigned int symhash(struct hashtab *h, const void *key)
+{
+	return jhash(key, strlen((const char *) key), 0) & (h->size - 1);
+}
+
+#else /* #ifdef CONFIG_SECURITY_SELINUX_ADVANCED_HASHING */
+
 static unsigned int symhash(struct hashtab *h, const void *key)
 {
 	const char *p, *keyp;
@@ -23,6 +33,8 @@ static unsigned int symhash(struct hashtab *h, const void *key)
 	return val & (h->size - 1);
 }
 
+#endif /* #else #ifdef CONFIG_SECURITY_SELINUX_ADVANCED_HASHING */
+
 static int symcmp(struct hashtab *h, const void *key1, const void *key2)
 {
 	const char *keyp1, *keyp2;
-- 
2.17.1

