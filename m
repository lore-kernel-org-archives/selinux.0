Return-Path: <SRS0=oqVN=6N=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A58F4C83000
	for <selinux@archiver.kernel.org>; Wed, 29 Apr 2020 20:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70DD9206D9
	for <selinux@archiver.kernel.org>; Wed, 29 Apr 2020 20:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=concurrentrt.onmicrosoft.com header.i=@concurrentrt.onmicrosoft.com header.b="aDBRJJHA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgD2U34 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 29 Apr 2020 16:29:56 -0400
Received: from mail-mw2nam10on2102.outbound.protection.outlook.com ([40.107.94.102]:36833
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726456AbgD2U3z (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 29 Apr 2020 16:29:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G1syjksf7WzPZakSfk6WXPwjEcPjSz372FJSzSJ6yLyBJ6NZW9Eh3O+kg3KNT/Bt7YNl7LppS6XibFVbAY78eixOzq+DoZ8LnKeJD/1xweNAN7D+Chb6I4v+EsXsLdelFvMbIDL6Xf8TYqEVQxktFQBT+GQRH2KdMCRYwmCkVsDM+j4HbRMFrIGpTDexFTMfDCNPSCffWlkcQdiHfW5d46DdUaTABfNshHlK4DfVtPx4DaIkicbhZS8CdBUCkbuUvO6onSKhXSf8iY4z4Ccq4eQBQdQABdYf+Ov7QCyzmrQcRJoy8RE625+JMBMX8cCnxdXJPqGBc7mjYTmCecJ8qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dnaM9OlYG8FnIppPdG1cBdesbEImF01jIdhwIWfrb4c=;
 b=AFGUcd/VpwETEbXA0D+6xxdfIhDMXaw9dWIivSuSR0AgVawJvyoPWvvBgxI+d2ykR+tiin2TbNovt489yT+vEftqoi0tIZvjYhkDXMrYhxIXZ9/IRkYqGwaMmDTHB0Na0rvjBetGPncEFFOi4pX9vkXUcgIaZVKIiZpaEyLi7caDzb2+dNA3GK24xafo7ZAmnWiUoKtpk5ElQ3hhaUiUIO4ZOQO1zCLxFnkW2rkplRpvlqjAvh8OzEIiECAhR13/RfbNJkH2vAH/PIVzz12pkWlOZFOgCAvOpVTWr7kLnW0UbeYTijpdhUCX55Rd6ubkFRzCNfoS0Ckt1nydA0ST6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=concurrent-rt.com; dmarc=pass action=none
 header.from=concurrent-rt.com; dkim=pass header.d=concurrent-rt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=concurrentrt.onmicrosoft.com; s=selector2-concurrentrt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dnaM9OlYG8FnIppPdG1cBdesbEImF01jIdhwIWfrb4c=;
 b=aDBRJJHAh4n/uwvfcyjqaa/JkGJHIACUIY6AOOBvlP1QCh5juAcMUNtLhcHLK2Q4jlPk49jgMV7oOXzEvgubLGPfj9eo803ez1tWgOSoA4gMEdGcJR61+ASlJWy2VqxibhC4Tv+w8da5iGH+6+ymTF+GHgQ6pxX1xq5LefavnHE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=concurrent-rt.com;
Received: from MN2PR11MB3885.namprd11.prod.outlook.com (2603:10b6:208:151::27)
 by MN2PR11MB4096.namprd11.prod.outlook.com (2603:10b6:208:138::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Wed, 29 Apr
 2020 20:29:52 +0000
Received: from MN2PR11MB3885.namprd11.prod.outlook.com
 ([fe80::984:ec50:d6de:dc0a]) by MN2PR11MB3885.namprd11.prod.outlook.com
 ([fe80::984:ec50:d6de:dc0a%4]) with mapi id 15.20.2937.028; Wed, 29 Apr 2020
 20:29:52 +0000
From:   siarhei.liakh@concurrent-rt.com
To:     selinux@vger.kernel.org
Cc:     colin.king@canonical.com, eparis@parisplace.org,
        gregkh@linuxfoundation.org, jeffv@google.com, omosnace@redhat.com,
        paul@paul-moore.com, stephen.smalley.work@gmail.com,
        tglx@linutronix.de
Subject: [PATCH 0/2] SELinux: Improve hashing
Date:   Wed, 29 Apr 2020 16:29:39 -0400
Message-Id: <20200429202941.18320-1-siarhei.liakh@concurrent-rt.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: BN6PR06CA0008.namprd06.prod.outlook.com
 (2603:10b6:404:10b::18) To MN2PR11MB3885.namprd11.prod.outlook.com
 (2603:10b6:208:151::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from sl-s76.concurrent-rt.com (65.190.80.89) by BN6PR06CA0008.namprd06.prod.outlook.com (2603:10b6:404:10b::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19 via Frontend Transport; Wed, 29 Apr 2020 20:29:51 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [65.190.80.89]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3c4f59d-cf47-49ca-039b-08d7ec7c11ca
X-MS-TrafficTypeDiagnostic: MN2PR11MB4096:
X-Microsoft-Antispam-PRVS: <MN2PR11MB4096663DD3AD4B09CE1F4E4BB1AD0@MN2PR11MB4096.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 03883BD916
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3885.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(376002)(39840400004)(366004)(396003)(136003)(8676002)(36756003)(5660300002)(6916009)(316002)(1076003)(66556008)(2906002)(66946007)(52116002)(7696005)(966005)(66476007)(186003)(2616005)(508600001)(9686003)(6486002)(6666004)(86362001)(8936002)(956004)(26005)(4326008)(16526019);DIR:OUT;SFP:1102;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D9ZhGpYBAFCqzNSfUtQ1cov3QGq4Cmiy7XcKgr340EtP8fpBGmqZtXCX74dOcOVHxONUNn5QwB79cSdA6tiILkUhkMAsj7322fLN/bXAPqFi6yqczLG9EbtKJlJoPvTf2Us3po/90mZEzQv88/cfLqkxruxhcNGWVSVjTrVtfs1bFQilclvYH48n/LUi0qLHGOba12dHOyQmGG3xskqI2mhJfUTSg+h+TC9y+zuP47yue+OWBkqneQRnLWrRlAGzJxojLS9QX8J5F85PxYlS69+qRjqcDw+azCxUFfrqmidLkqyWnmijvbfR1JMEZQuBR78re+c206efcAjGhQ5gjdAIShpKyU5eQ9eq/Q43IPfYxC/ktsUknogD4Xl4JPJR1vMj1Osqc0eXY877kSuAK3KCQOwRpxEZ6p7RE11x/fgbDu/rZomTaTDt4eZO1XEg5kX5ddrSf7Y4kuSw9s6jUP4+jkUthO7JV0R9kB6qeoI193G/qviG+t2jcz3GOR7CPI+WZbDW2Oiw6efT+rD/og==
X-MS-Exchange-AntiSpam-MessageData: uOB6Z1NAzen0u5GOLzC5KahneeTIGfYUzME+g9JqUqxCpjtcnDIy4yIsbncKaU4Q3YaW39gyA9EuQ8KPxSvT9iewkVw43j8SNvPfnZ5uT6XNunjtf70kE1A7pTfLwKdQwsRa60whK9jwdSShO9NzQRxy2UM1YeRlOBDIL+CufcHNm8XymE+e/xViQchNMQcXR4RwlbE7MwmhqS6/68LsafqFPE7QMk7XFvH99cKX8NSEGFyUZoJ26O05FTKjt5X3VUjTbBok5IB1RYyz3s/BIzQvyT9tuyCjad5XzyOS1tGpJ0RCGJB6l4reZHTDkyfZeTZI2lCVcVfpfNT8EyuYaJI188pZHDWPaf7Xjv99cjJ/iRFC34QArXSefHcJNu4hitzebhhbo6U2nJvP+xkE22aSCCUViVbmyjhq2Qwo+pDOjnHbPRGLEgsGd1kavcUFBXZ/BkEJForKj/uOnSIxzFd+I891+Fb5/pdevi/ZpyiR9Qj1gtQvg6PZz29ub75MjmPprfK+uL64l0XvSkGWZ5yg+8wPGbCPAWFEbs0ut+QDdz+9zKG2DxqMfVTWhtENYDuhEXBtDpHi6Uvxq9/IePJx4UfcCXFGBL8+VOMwi0xUuFhZC/Kuu+kSLufAKIXH6MNC+VZK7hDc3riM0PrMsKxRQM3xaiLQliwQRa8MDLynOJiORUDYS4+7yVdSqkxHM4sbZ736TB6bBg5DdZOhN9fW5r/j4h9E7T8nZDFf9cG1Hg9/rm970KlpLnHu8xAVNBNESVXRFiNjA6vQ6pX91TPQ07ruzjyuZ/SDXzndWtM=
X-OriginatorOrg: concurrent-rt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3c4f59d-cf47-49ca-039b-08d7ec7c11ca
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2020 20:29:51.9333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38747689-e6b0-4933-86c0-1116ee3ef93e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t0S4cSl5ypPqEvQzDrnNx1eSYYSNKCsLwaqnvYLnHe4DNuTMEZKJ00uADsriHREqe6KW8/N/1BYUQ4kkb2tZ+bKLyTJZJQlALpYu1Or+C3U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4096
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Siarhei Liakh <siarhei.liakh@concurrent-rt.com>

This is a follow-up to the original discussion of hashing within SELinux [1].
Based on the initial feedback received from Paul Moore and Ondrej Mosnacek,
I've re-focused and reduced the patch set down to the following two patches:

1. SELinux: Add median to debug output of hash table stats
2. SELinux: Introduce hash3() as alternative to shift-xor

The first one simply adds some extra stats in debug output generated by
the hash tables. I found it to be useful during the investigation, however
the patch not required for the actual hash improvement to work or be visible.

The second patch contains the actual proposed hash function alternative,
which improves bucket distribution in AVC, and latency in AVTab. After some
substantial research and testing, this new function (hash3()) ended up being
just as good at hashing 3x u32s as (or even *very* slightly better than)
jhash_3words() from jhash.h, avtab_hash() (which is a version of MurmurHash3),
and even a version of xxhash unrolled for just 3x 32-bit values. Please note
that all of the above is written strictly in context of SELinux and the way
it addresses its Access Vectors by 3-tuple of values (Source ID, Target ID,
Class ID). I suspect that significant part of surprising performance of
hash3() (or, depending on a view point, rather poor performance of other
"good" hashes) can be attributed to a sequential nature of these IDs within
a limited range.

Please keep in mind that the goal of this patch is not to replace any
particular hash function with something clearly more superior in one way
or another, but rather to find an acceptable standard which could be used
throughout SELinux as a way to eliminate multiple, substantially similar,
yet slightly different local implementations of hash functions within each
of SELinux components.

See second patch for the actual discussion of the new hash function and its
performance.

Please CC me directly on all replies.

Thank you!

References:

[1] https://lore.kernel.org/selinux/20200408182416.30995-1-siarhei.liakh@concurrent-rt.com/

Signed-off-by: Siarhei Liakh <siarhei.liakh@concurrent-rt.com>

Siarhei Liakh (2):
  SELinux: Add median to debug output of hash table stats
  SELinux: Introduce hash3() as alternative to shift-xor

 security/selinux/Kconfig          | 10 ++++
 security/selinux/avc.c            | 50 +++++++++++++---
 security/selinux/include/hash3.h  | 44 +++++++++++++++
 security/selinux/include/median.h | 67 ++++++++++++++++++++++
 security/selinux/ss/avtab.c       | 94 ++++++++++++++++---------------
 security/selinux/ss/avtab.h       |  1 +
 security/selinux/ss/hashtab.c     | 28 ++++++++-
 security/selinux/ss/hashtab.h     |  5 ++
 security/selinux/ss/policydb.c    | 14 +++--
 9 files changed, 252 insertions(+), 61 deletions(-)
 create mode 100644 security/selinux/include/hash3.h
 create mode 100644 security/selinux/include/median.h

-- 
2.17.1

