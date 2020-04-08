Return-Path: <SRS0=RcjK=5Y=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E873C2BA2B
	for <selinux@archiver.kernel.org>; Wed,  8 Apr 2020 18:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 057002082F
	for <selinux@archiver.kernel.org>; Wed,  8 Apr 2020 18:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=concurrentrt.onmicrosoft.com header.i=@concurrentrt.onmicrosoft.com header.b="u4Aty2UN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730849AbgDHSYf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 8 Apr 2020 14:24:35 -0400
Received: from mail-eopbgr770139.outbound.protection.outlook.com ([40.107.77.139]:43525
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730840AbgDHSYd (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 8 Apr 2020 14:24:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yc77/qqaJR5rxFTlzCVLB8hH84p0m2Nc4RQQjOu0/IN8SVX137tD/jQNi5sQ6O/soH3EAxFgYTdvWThpnmw3mJQV+g6SIj5WlpmYrJvxzKWsQPBsyeLYyl4T4Dk+kvo/hK2nbDJryDOwHr3iEjs97oGSYMR1tWeL8vUJRYxvdYmH9T3MSzgIohPV2sSG/MMGAIWHITpUG3lDPC8jiWqxgUoBSdheTzf6gqpk2KTjWBDV26FCVrNRw3eHaiB+juBKXlZBC+Vbj1IixRFlQqrxPkcVD554d3bxCgHUf25Nnywe8ctfVRH3+NJyw64sAQ/8+Dvp1Ks+2RLNhe8LYc6vyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5fCtA/3gry63EpZfrgNQAhSo8DUqkWBhLBhXzjxSDc=;
 b=GAFVzzVZK/EJ9bFrWbvlfAkRkqHdpEJPdzQYUH8UoY6pw90dgZn4fLgcwhJ0QIj/czqmg5yxQvU8YBoGOsMYMAncMM7Q7SOzsBfaz761pGh9EkWtPZIGW/jJuI3UXr3nx9kPAGriOtqp0z/bj8ynpZnefV7OutMvGksiERM4wBxNjqb2pqXGE6twmm2KahxJkfPkxrEGuSw/ZU4WnWztHCd4LlNidIa8bd6wsTLlPJZy4AkY9d5csBNgJIDSWwZHn5bqoTzDhnPg1czBlgajsN3YrtBOp5X8Xo6QdDD7FqGtY2QxtsVTQBGBsisbeU1pH3CBq+LalIPD4vKzOyGU5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=concurrent-rt.com; dmarc=pass action=none
 header.from=concurrent-rt.com; dkim=pass header.d=concurrent-rt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=concurrentrt.onmicrosoft.com; s=selector2-concurrentrt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5fCtA/3gry63EpZfrgNQAhSo8DUqkWBhLBhXzjxSDc=;
 b=u4Aty2UNvhLjeMvg2n6DBOgLD0ccV4+Yk78pTMQSlEnrsYuGTHk2zdBhtGxEaaXdqkeZ/PrsOmFpJM+Z3XltTAjuEfVLC5ooA4+viHv4BnxSeZvUnMm2cTLlPvwk7jhObTyWtAtWUibon0y9BnVWYQak+/zRa1cowCAnO72n5vc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Siarhei.Liakh@concurrent-rt.com; 
Received: from MN2PR11MB3885.namprd11.prod.outlook.com (2603:10b6:208:151::27)
 by MN2PR11MB4677.namprd11.prod.outlook.com (2603:10b6:208:24e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Wed, 8 Apr
 2020 18:24:28 +0000
Received: from MN2PR11MB3885.namprd11.prod.outlook.com
 ([fe80::984:ec50:d6de:dc0a]) by MN2PR11MB3885.namprd11.prod.outlook.com
 ([fe80::984:ec50:d6de:dc0a%4]) with mapi id 15.20.2878.018; Wed, 8 Apr 2020
 18:24:28 +0000
From:   siarhei.liakh@concurrent-rt.com
To:     selinux@vger.kernel.org
Cc:     colin.king@canonical.com, eparis@parisplace.org,
        gregkh@linuxfoundation.org, jeffv@google.com, omosnace@redhat.com,
        paul@paul-moore.com, stephen.smalley.work@gmail.com,
        tglx@linutronix.de
Subject: [PATCH 0/9] SELinux: Improve hash functions and sizing of hash tables
Date:   Wed,  8 Apr 2020 14:24:07 -0400
Message-Id: <20200408182416.30995-1-siarhei.liakh@concurrent-rt.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: BN6PR19CA0058.namprd19.prod.outlook.com
 (2603:10b6:404:e3::20) To MN2PR11MB3885.namprd11.prod.outlook.com
 (2603:10b6:208:151::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sl-s76.concurrent-rt.com (65.190.80.89) by BN6PR19CA0058.namprd19.prod.outlook.com (2603:10b6:404:e3::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16 via Frontend Transport; Wed, 8 Apr 2020 18:24:27 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [65.190.80.89]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7039949a-f213-4d85-2dcf-08d7dbea12d4
X-MS-TrafficTypeDiagnostic: MN2PR11MB4677:
X-Microsoft-Antispam-PRVS: <MN2PR11MB46772CA319FCD38AD9C3A8A8B1C00@MN2PR11MB4677.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0367A50BB1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3885.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(366004)(346002)(396003)(376002)(39830400003)(136003)(9686003)(6666004)(508600001)(316002)(6486002)(6916009)(8676002)(52116002)(7696005)(81156014)(8936002)(1076003)(66476007)(186003)(4326008)(86362001)(2906002)(81166007)(16526019)(2616005)(26005)(956004)(66946007)(66556008)(36756003)(5660300002);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: concurrent-rt.com does not
 designate permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JLpCFMBwU6zG9lkhwJcLNBePyvR6G9aJbIpmA68gNcJIs87SGSLR0NbgztTMUt6jnmIX2Iwcn0RYifpvLZ4DVXMeRxYQxxJmkrkZE0J5DBNYmxQqDAalnUPc4eiuNJnJxg6sPPu+18/kVXdi9hEB/JhkUKqx0sP+eghpR8UYpXtv3Qf2BcPivjOm0pAIBTUPYPVt7WGb+zU4TwH4rK1WwJVys4iLAfd2PLH/G/or25kkxAzAluhSvpHYc5AJKMgQEmjmEFgTDM5RbIh4ubyyZHqQktite+crmoZRKmTmVofbXUUjzrqM1RLb806r+7n/LDkRYYf7PQ8et5d/ulnQmDbRxWfFnMSJ3TEL2m0oQuuF8DaifmlXkekwTzQQ2Dj6D/3N1dZJlbeqrbjjvmUjPrp055oAUx9463/BaKqIk+DejqfcOEwXpcY9H3nALlLH
X-MS-Exchange-AntiSpam-MessageData: 6BetluI7tfSemCh/g4ivYepiS1+K+AwZygrHUBvtDXXL4sFproK7D2DSy5HJkYAklzkyoXdxS4MeNYJFCiIBJqLjvv9S16kuNESzNwqgUbTDvv0At9uLs6EUVcB4OzlFWrENC91xlEJDSq8T+8/SvQ==
X-OriginatorOrg: concurrent-rt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7039949a-f213-4d85-2dcf-08d7dbea12d4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2020 18:24:28.2878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38747689-e6b0-4933-86c0-1116ee3ef93e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xlgff7LMMB1vj95FJDkSTeQu0jOlPPFOVD74vHMeaKYf/TanuC/p3QBEcZdQ/HMa/V9ybsf/P5SP5gdFuCym+CQDHzyFcIEw509A47yS22M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4677
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Siarhei Liakh <siarhei.liakh@concurrent-rt.com>

This patch set is the result of an actual customer support case where a client
of ours observed unacceptable variability of timings while sending UDP packets
via sendto() with SELinux enabled. The initial investigation centered around
kernel 3.10.108 in CentOS 6.5 environment. Combination of these patches with
some substantial tuning of newly added Kconfig options was able to reduce
*maximum* sendto() latency to about 160us, down from well over 2ms. Worst
latency was typically observed when a new SSH login was initiated concurrently
with the test program running a sendto() loop, thus causing an AVC miss with a
subsequent call to security_compute_av(), which would spend most of its time
iterating through policydb within context_struct_compute_av(). 

The original patch set was developed for linux kernel 3.10.108 and later ported
to newer versions. The patch set presented here is based off Linus' tree as of
April 7, 2020 and contains only a subset of the changes which are still relevant
to 5.6+ as many of the issues had already been addressed in different ways.

The patch set consists of 9 patches total and is meant to achieve two goals:
1. Replace most local copies of custom hash functions with generic hash
   functions already available in inlude/linux/*.h.
   
2. Replace hard-coded hash table sizing parameters with Kconfig tunables.

"Advanced Hashing" Kconfig option is the only dependency between the patches,
but other than that and any combination of them can be used.

Please CC me directly in all replies.

Siarhei Liakh (9):
  SELinux: Introduce "Advanced Hashing" Kconfig option
  SELinux: Use Bob Jenkins' lookup3 hash in AVC
  SELinux: Expose AVC sizing tunables via Kconfig
  SELinux: Replace custom hash in avtab with generic lookup3 from the
    library
  SELinux: Expose AVTab sizing tunables via Kconfig
  SELinux: Replace custom hash with generic lookup3 in policydb
  SELinux: Expose filename_tr hash table sizing via Kconfig
  SELinux: Replace custom hash with generic lookup3 in symtab
  SELinux: Expose netport hash table sizing via Kconfig

 security/selinux/Kconfig       | 83 ++++++++++++++++++++++++++++++++++
 security/selinux/avc.c         | 23 ++++++++--
 security/selinux/netport.c     |  4 +-
 security/selinux/ss/avtab.c    | 39 ++--------------
 security/selinux/ss/avtab.h    |  2 +-
 security/selinux/ss/policydb.c | 46 +++++++++++++++----
 security/selinux/ss/symtab.c   | 12 +++++
 7 files changed, 159 insertions(+), 50 deletions(-)

-- 
2.17.1

