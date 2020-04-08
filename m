Return-Path: <SRS0=RcjK=5Y=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C986C2BB54
	for <selinux@archiver.kernel.org>; Wed,  8 Apr 2020 18:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04D6920784
	for <selinux@archiver.kernel.org>; Wed,  8 Apr 2020 18:24:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=concurrentrt.onmicrosoft.com header.i=@concurrentrt.onmicrosoft.com header.b="yP9IZxas"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730841AbgDHSYd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 8 Apr 2020 14:24:33 -0400
Received: from mail-eopbgr770139.outbound.protection.outlook.com ([40.107.77.139]:43525
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729346AbgDHSYc (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 8 Apr 2020 14:24:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YDGFUWVg+N2MOKa+f/feLxE+QIUw3IMNYGMFHSLIhoc8OAM41ehWJFO4UXtES6ShWtdgc4Qjlxiu7ST4MoMDKJE1ghK1te4vurmWQedHtLQ/IcZY+wSk0d1N04QFKDoCZtXGl9SMgkcAm7Eualn9sF8/yFddjWTwU6yOEgmMtGSxzS9XT/iDtH+/sNrAaDQwxvwpTywoAvj8NVMC+5Ethbl54xfHSUJ7lo52ZScSbX2jI1o0i4K3EJwQNO/bZA6My1CCpJNU7asWp6h1dsHKJrOWMI53SVR28RNIXZQJd7BgnT4WkOY5LTE1E87tiHTRue5z4P8nUNmeaPBPJAcK+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KqDYMIHglrkQpu5Cp7eq1H3MjNmJXMo3IELbuMMGKCc=;
 b=NL7Y5+kFH2WyjEmUEOy0J8AYpUvlcfEuWfQ4SShLGaPjwYdKu5W+Rv0D4GLUzNS5L0r2z4THSq4glaG7gfyGhpo2/1x1kP96P2fzh/p4eWaele7PVe9Ox1UQcaIShJepfPABEwMUkUjYGPv6zFkbLKf0AIWYaZ7Gt23m1fudJu+SsYp7+6oHrualNTf1aOZCr9l5QX2LzfV7RugzzZEwZm7zy0tYN5gml1nSdrczONXasGAmbCT8fAjTyg7Q8/gvdf3HXh+Sc1rM4/mw1pRCtW6LhxBYHKExA1rTPatwDmW/yMNuT+SYzA7ke3ySOBsl6nSyvAUkoJ9W1/4bBOxLxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=concurrent-rt.com; dmarc=pass action=none
 header.from=concurrent-rt.com; dkim=pass header.d=concurrent-rt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=concurrentrt.onmicrosoft.com; s=selector2-concurrentrt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KqDYMIHglrkQpu5Cp7eq1H3MjNmJXMo3IELbuMMGKCc=;
 b=yP9IZxastkaVc0p96jmZK2w/9ieLZ383lrg/tQDtnf4YdEtKlFOGxXO06ltyeInoOxFA0KU1ZiiQ+HBAzI6llvZroWpzIEHy5KiC8gg7JFOK77l60ObeO0Hz7JjzJ2Oalc9V3OObcCNmKq4E/S4Hb8IRDaUP48Ey3V17I5sO2fI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Siarhei.Liakh@concurrent-rt.com; 
Received: from MN2PR11MB3885.namprd11.prod.outlook.com (2603:10b6:208:151::27)
 by MN2PR11MB4677.namprd11.prod.outlook.com (2603:10b6:208:24e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Wed, 8 Apr
 2020 18:24:29 +0000
Received: from MN2PR11MB3885.namprd11.prod.outlook.com
 ([fe80::984:ec50:d6de:dc0a]) by MN2PR11MB3885.namprd11.prod.outlook.com
 ([fe80::984:ec50:d6de:dc0a%4]) with mapi id 15.20.2878.018; Wed, 8 Apr 2020
 18:24:29 +0000
From:   siarhei.liakh@concurrent-rt.com
To:     selinux@vger.kernel.org
Cc:     colin.king@canonical.com, eparis@parisplace.org,
        gregkh@linuxfoundation.org, jeffv@google.com, omosnace@redhat.com,
        paul@paul-moore.com, stephen.smalley.work@gmail.com,
        tglx@linutronix.de
Subject: [PATCH 1/9] SELinux: Introduce "Advanced Hashing" Kconfig option
Date:   Wed,  8 Apr 2020 14:24:08 -0400
Message-Id: <20200408182416.30995-2-siarhei.liakh@concurrent-rt.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200408182416.30995-1-siarhei.liakh@concurrent-rt.com>
References: <20200408182416.30995-1-siarhei.liakh@concurrent-rt.com>
Content-Type: text/plain
X-ClientProxiedBy: BN6PR19CA0058.namprd19.prod.outlook.com
 (2603:10b6:404:e3::20) To MN2PR11MB3885.namprd11.prod.outlook.com
 (2603:10b6:208:151::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sl-s76.concurrent-rt.com (65.190.80.89) by BN6PR19CA0058.namprd19.prod.outlook.com (2603:10b6:404:e3::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16 via Frontend Transport; Wed, 8 Apr 2020 18:24:28 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [65.190.80.89]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b8a24d56-7365-4584-f753-08d7dbea1365
X-MS-TrafficTypeDiagnostic: MN2PR11MB4677:
X-Microsoft-Antispam-PRVS: <MN2PR11MB467706CA095C95C5668E820CB1C00@MN2PR11MB4677.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0367A50BB1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3885.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(366004)(346002)(396003)(376002)(39830400003)(136003)(9686003)(6666004)(508600001)(316002)(6486002)(6916009)(8676002)(52116002)(7696005)(81156014)(8936002)(1076003)(66476007)(186003)(4326008)(86362001)(2906002)(81166007)(16526019)(2616005)(26005)(956004)(66946007)(66556008)(36756003)(5660300002);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: concurrent-rt.com does not
 designate permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9nYKkZ7RBFczDiexdYSIQ/6Rt0SWC0ihbpLV2SqOiabGFXMqWZP00PDjvAyvqmeevtmobRyEFRkYIiS5nisamVomkDIReqFMdvZtDmxZYVWbd54RdTEWe+yjMmnjzNeLsw09akRnrUoy2uTbbXLa1V1tWp81rtgYEsdJZwzHyOoE7qxcWSLhdOI2GX8gXU5WJLT+FsEmMX89M51lzpmUn72eGw2nmOrFDhay1fuTsoSw2W2kjxYzth4f8A1vJ/NANITDRYNDsrRA2vuvcCu3WHpE82TgGRtfMn8bga7rETmdDBhKQno1vPb48yRffHakVj/pLDXQCv6FIW16UwAnG2INbswAZ6B6jURqK+YNZSdCc4jsCiGxfiNgVyAdg/wYhVMaQnqnItrHjnRFwkeCFT2FlUou8Q5T9l9QG0bu2p43STe9ky3IXfTcafYGJ5jp
X-MS-Exchange-AntiSpam-MessageData: sa1hPqyKE/K23wto2d4Ux6EfFEFMMc2X6SL1s7jqxY7xXW/HN8ZSPHsBJZ4jeeGCNgxvv8SmKGD/5MhgNzqdHKF7lH0On6zx5G+hnIdOGB0tjG2RwwKfNu3DSSjkYn1GOlOy83cnVMo8ucH9qWTTiA==
X-OriginatorOrg: concurrent-rt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8a24d56-7365-4584-f753-08d7dbea1365
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2020 18:24:29.2533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38747689-e6b0-4933-86c0-1116ee3ef93e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aTHEfY1HEpC4J2fws6IOre3QdRm24e2m+0GNk17b5FquX6O1j+CriSSI2qFofH8MMvCoPeEwe1jYqPbJ8IWNhI8kPNQUXZmqK0FsErRu1fA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4677
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Siarhei Liakh <siarhei.liakh@concurrent-rt.com>

This patch introduces "Advanced Hashing" Kconfig option for SELinux,
which is used by subsequent patches to switch between faster, simpler
local hash functions and a bit slower, but much better ones from standard
Linux library. The patch only adds an option; hash function changes are
provided as separate patches, one per function changed.

Signed-off-by: Siarhei Liakh <siarhei.liakh@concurrent-rt.com>
---
Please CC me directly in all replies.

 security/selinux/Kconfig | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/security/selinux/Kconfig b/security/selinux/Kconfig
index 9e921fc72538..4b5c9fa510a1 100644
--- a/security/selinux/Kconfig
+++ b/security/selinux/Kconfig
@@ -61,6 +61,15 @@ config SECURITY_SELINUX_DEVELOP
 	  permissive mode (if permitted by the policy) via
 	  /sys/fs/selinux/enforce.
 
+config SECURITY_SELINUX_ADVANCED_HASHING
+	bool "Advanced hashing for primary hash tables"
+	depends on SECURITY_SELINUX
+	default n
+	help
+	  This enables better, but a little slower hashing functions in hash
+	  tables. New hashing function greatly reduces hash collisions, thus
+	  improving performance of large/complex SELinux configurations.
+
 config SECURITY_SELINUX_AVC_STATS
 	bool "NSA SELinux AVC Statistics"
 	depends on SECURITY_SELINUX
-- 
2.17.1

