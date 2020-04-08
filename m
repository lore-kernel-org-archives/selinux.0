Return-Path: <SRS0=RcjK=5Y=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1EE1C2BA1A
	for <selinux@archiver.kernel.org>; Wed,  8 Apr 2020 18:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8104A2082F
	for <selinux@archiver.kernel.org>; Wed,  8 Apr 2020 18:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=concurrentrt.onmicrosoft.com header.i=@concurrentrt.onmicrosoft.com header.b="SiuWhozZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730856AbgDHSYh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 8 Apr 2020 14:24:37 -0400
Received: from mail-eopbgr770139.outbound.protection.outlook.com ([40.107.77.139]:43525
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730851AbgDHSYf (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 8 Apr 2020 14:24:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GE+JLptok7hBKa1pK4LhIql8k73enfMT7FpO3fDH2mAdR1L+GM9aCRy9/FYckrCkp3BCy6IWQ2Equp/NUeCMqPjZ6DkbllQtNnRSiftMtKBjcHjcWBDN+TJLfNOpPT+ewhPmzvnwHVCtGk5h3JzvzTsmP8dtexAH3d1HiSPJ06a6teP/z+5KfgE6xhCWfmB9SCnHhnu+/IEGNOrw9HyjU15f0cKhy1UwtCRELCXKQIY/W4Y+BzLmhitgKYvK+ocN0Ul0DpHEGbLD4NYEthQSY/ZsUDSAjS349LBkLvrQyIaireQpvrezfC88GW8P9hLXOdx+SHcH84RiIdHUmAxtRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EiUPASNy1md0M0PAgCMU9ISa22x/WZCIZX/txj/Xdbw=;
 b=R4RNfusHX8Rn+qLdA/ZZ3qC+7dJiOjFzE0pgnI7JfirjYDCD4Ilz436EBy8ZGl7CYfuUkeWNMQo5ZAFzW9aVJt2gEzXRjaoe1uoiHP2U01fzC1qknKBC2jRPYNwKJ9sbYb04C6DohVutix81hyZMPPVi1uL3A+H0/dui7hYv4sj7kWZHy9HWGISg98B+8NbBYFUW3Yia7Dnf1MjuH8U2G95sZCUcGGIHkEsL3MAa1hBG6Zpt6jVdEGxxH/OyXHbgahq0t59D6z9tCHMlJ8XUwfzN33XLvT5U/cJjYj4PiOazz7INApqOoUEr17fA8zS5EunTw6GjTzvSMZRQXNpr+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=concurrent-rt.com; dmarc=pass action=none
 header.from=concurrent-rt.com; dkim=pass header.d=concurrent-rt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=concurrentrt.onmicrosoft.com; s=selector2-concurrentrt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EiUPASNy1md0M0PAgCMU9ISa22x/WZCIZX/txj/Xdbw=;
 b=SiuWhozZaLZwutR+oGygfiIYc9LzFx+FvV0j1UtqZfBv4wQZkAmVad47Acl9M5Da/RNHamcx8Cko30Y//iWInco/moo0VvZYewGdb6EQcy1TMzEo0/igmwKTZIVqTdTOQ2zTYacV8MnshxqdPcbjJQdjS4eOgLZAd2wiOUP38UE=
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
 18:24:30 +0000
From:   siarhei.liakh@concurrent-rt.com
To:     selinux@vger.kernel.org
Cc:     colin.king@canonical.com, eparis@parisplace.org,
        gregkh@linuxfoundation.org, jeffv@google.com, omosnace@redhat.com,
        paul@paul-moore.com, stephen.smalley.work@gmail.com,
        tglx@linutronix.de
Subject: [PATCH 3/9] SELinux: Expose AVC sizing tunables via Kconfig
Date:   Wed,  8 Apr 2020 14:24:10 -0400
Message-Id: <20200408182416.30995-4-siarhei.liakh@concurrent-rt.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200408182416.30995-1-siarhei.liakh@concurrent-rt.com>
References: <20200408182416.30995-1-siarhei.liakh@concurrent-rt.com>
Content-Type: text/plain
X-ClientProxiedBy: BN6PR19CA0058.namprd19.prod.outlook.com
 (2603:10b6:404:e3::20) To MN2PR11MB3885.namprd11.prod.outlook.com
 (2603:10b6:208:151::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sl-s76.concurrent-rt.com (65.190.80.89) by BN6PR19CA0058.namprd19.prod.outlook.com (2603:10b6:404:e3::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16 via Frontend Transport; Wed, 8 Apr 2020 18:24:30 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [65.190.80.89]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ac3f2af-a5bd-4b72-32eb-08d7dbea1459
X-MS-TrafficTypeDiagnostic: MN2PR11MB4677:
X-Microsoft-Antispam-PRVS: <MN2PR11MB46779B1C9B045F9947BC5EA5B1C00@MN2PR11MB4677.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0367A50BB1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3885.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(366004)(346002)(396003)(376002)(39830400003)(136003)(9686003)(6666004)(508600001)(316002)(6486002)(6916009)(8676002)(52116002)(7696005)(81156014)(8936002)(1076003)(66476007)(186003)(4326008)(86362001)(2906002)(81166007)(16526019)(2616005)(26005)(956004)(66946007)(66556008)(36756003)(5660300002);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: concurrent-rt.com does not
 designate permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YrkmVaYLXOLi69bYJQ/G3Xj+avEWE9F3U7ydGywdwvQWSG/IwX/6df8b1HzoUA+g+LCbhMunC0mXrYaEKV/VeS81l9PV2Amb/LeDXgw54GB9mSy8PwJBoMDDAnYsfe33muA+OW+1zp32Pytc9P/00S9COpxeQ3jVzCtvYKC/UYFuzkwcIoWsow7XuAljXRhunzBCPdOuU0FnITYSY+h4VR8hWhIUj0Xp3LJCwDlO7lWcHyheaLJa7F1GUJgInXD/fXnzdIfJvClCVZCC7KmZPlx57v+qTMk4Rg+DRqBDxHNGXMu9QD8ZPb4aMA6JVS/eHUeTeHSDE0qjyXAIK98GWPWCET/qhas/7FYf4V/SNR60cjH6s7J7GP7+mxn0eSzhAsWnKQF1Ur/jm40/UtWBZ5ylIhKhjkeI7d9QCRKLCpM+OJJxCdfRlK0nALYS3zbP
X-MS-Exchange-AntiSpam-MessageData: WI+K1Zo91cbbogtXD37M/JFkCCg9Zw+vkVcY9HZpgy68KIRdrNBv7Lk5GbAxQQp/Pz8PuEFnluWKOsHMQJVBSf1WSTwjAAV0QOoL2tCOSAaVU1uKvySM5SJcsHuNqLcSAYFId0bG5V+6xxijFZNRog==
X-OriginatorOrg: concurrent-rt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ac3f2af-a5bd-4b72-32eb-08d7dbea1459
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2020 18:24:30.8153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38747689-e6b0-4933-86c0-1116ee3ef93e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3q4twZoVy1IqPX6cNVEHXxUQCS00p9TFuBEx2RlYxQdOKarMGQzGLkRVrJmBtibhRa4pGjjiS9sEC8/gIvQdsC6M4445sBXyt59vb7+kG1o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4677
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Siarhei Liakh <siarhei.liakh@concurrent-rt.com>

This change exposes previously hardcoded AVC sizing tunables via Kconfig,
which provides a more convenient tuning mechanism for downstream distributions.
Default sizing is not affected.

Signed-off-by: Siarhei Liakh <siarhei.liakh@concurrent-rt.com>
---
Please CC me directly in all replies.

 security/selinux/Kconfig | 32 ++++++++++++++++++++++++++++++++
 security/selinux/avc.c   |  6 +++---
 2 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/security/selinux/Kconfig b/security/selinux/Kconfig
index 4b5c9fa510a1..3a736a1c6806 100644
--- a/security/selinux/Kconfig
+++ b/security/selinux/Kconfig
@@ -79,6 +79,38 @@ config SECURITY_SELINUX_AVC_STATS
 	  /sys/fs/selinux/avc/cache_stats, which may be monitored via
 	  tools such as avcstat.
 
+config SECURITY_SELINUX_AVC_DEF_THRESHOLD
+	int "Default value for AVC reclamation threshold"
+	depends on SECURITY_SELINUX
+	range 64 1048576
+	default "512"
+	help
+	  Reclamation threshold effectively sets a limit on AVC size.
+	  Increasing this number could improve performance of busy
+	  systems with lots of complex policies. Threshold value can
+	  also be changed at run-time via selinuxfs.
+
+config SECURITY_SELINUX_AVC_HASH_BITS
+	int "Number of slots (buckets) for AVC hash table, expressed as number of bits (i.e. 2^n)"
+	depends on SECURITY_SELINUX
+	range 1 32
+	default "9"
+	help
+	  This is a power of 2 representing the number of slots (buckets)
+	  used for AVC hash table. Smaller value reduces memory footprint
+	  at price of hash table lookup efficiency.
+
+config SECURITY_SELINUX_AVC_RECLAIM_COUNT
+	int "Number of AVC entries to reclaim in a single cycle"
+	depends on SECURITY_SELINUX
+	range 1 SECURITY_SELINUX_AVC_DEF_THRESHOLD
+	default "16"
+	help
+	  A single reclamation cycle will evict this many AVC entries
+	  from the cache. Small values may require multiple reclamation
+	  cycles to bring AVC size under the threshold. Large values may
+	  cause excessive latency of reclamation events.
+
 config SECURITY_SELINUX_CHECKREQPROT_VALUE
 	int "NSA SELinux checkreqprot default value"
 	depends on SECURITY_SELINUX
diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index b5893621290b..80af3d1f31fd 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -31,9 +31,9 @@
 #include "avc_ss.h"
 #include "classmap.h"
 
-#define AVC_CACHE_SLOTS			512
-#define AVC_DEF_CACHE_THRESHOLD		512
-#define AVC_CACHE_RECLAIM		16
+#define AVC_CACHE_SLOTS			(1 << CONFIG_SECURITY_SELINUX_AVC_HASH_BITS)
+#define AVC_DEF_CACHE_THRESHOLD		CONFIG_SECURITY_SELINUX_AVC_DEF_THRESHOLD
+#define AVC_CACHE_RECLAIM		CONFIG_SECURITY_SELINUX_AVC_RECLAIM_COUNT
 
 #ifdef CONFIG_SECURITY_SELINUX_AVC_STATS
 #define avc_cache_stats_incr(field)	this_cpu_inc(avc_cache_stats.field)
-- 
2.17.1

