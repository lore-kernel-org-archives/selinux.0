Return-Path: <SRS0=NJTS=56=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E809C2BA19
	for <selinux@archiver.kernel.org>; Tue, 14 Apr 2020 13:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5576E20644
	for <selinux@archiver.kernel.org>; Tue, 14 Apr 2020 13:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=concurrentrt.onmicrosoft.com header.i=@concurrentrt.onmicrosoft.com header.b="50ArqkCT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387846AbgDNNjt (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 14 Apr 2020 09:39:49 -0400
Received: from mail-bn8nam12on2090.outbound.protection.outlook.com ([40.107.237.90]:11137
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387836AbgDNNjl (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 14 Apr 2020 09:39:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a0SuHN6vj8Pn6jK3AvE9wPm1vtgHWWKDSthF1EaqcPjkgqTO0+vteTB69gA+q5ynl4WsiiHBDFTf/soG8EcHLNV7A34cklEEV116OJ6fxJYUrqMh43mjiiw1OXpfRmDwGYUckn2yL4zU7LGD8w2tO/vYqnkJZD0gg53i07fjb3u4MsDYF9HoSkfxQ0cOpTsH8hYUnwM7183LOVwTQ7dwp9hEB76ovBMNHNe5GKGLHntEMsSvkaroiueq570l++kXnKN/4j8u9//6h90U+N0Nk+AaN6PcPdKZ8X8HmiD7JjbuYqWCUj6cDrsE8GO/93qVn54gCiP7liBhmDv+rx/m1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/j3SwtfSUo+sEHeEsSJTTcNqq81x0lnU94G9boWyjrY=;
 b=WRiw2HG07bbVvP2v47wS4uJJxfGVOTRJXKZS3NGhLYoy31Km7uTCWCegilGlfS/JMYRoHPZBBGIj778y0gOGXO+cMu15EyjTxELROille9JQu4Ld4VHEvm7RhelYy7Tv85flELXvdtsVlWABcoMmFgilOSaAIPlYYvuMjcrhxS4d30JdHNRx44VZtDmT8MSwZ7GaB8ccdUwsfShlqFBHueOVZyYy903HtZ2sqxmFMOeIt2VzEaIJnZ2lOsL8kcl5wIyn2pyLWdLMNmeufAJR4aJrXeGALKBCicteS2jOG64XGgw9e3DKrdZwFmQvuic3lpYw/IxE04yfflymSwitHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=concurrent-rt.com; dmarc=pass action=none
 header.from=concurrent-rt.com; dkim=pass header.d=concurrent-rt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=concurrentrt.onmicrosoft.com; s=selector2-concurrentrt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/j3SwtfSUo+sEHeEsSJTTcNqq81x0lnU94G9boWyjrY=;
 b=50ArqkCTY9PPkcIYICYHEv1Vq1JY5qSZMY0cbCmS/gaefZ2AQVs9ZeTuPdz6EmrSsfzVTi4v9GzDqZ/cgPH4tLEK4vEG0v/lmj6IDqX5z7qHPg/Q2KYQb5Kb2GB9N9FeGRRgw2seqsu+uFF+nCPKYdz5j5OrYN+XzDz7cDFUFX4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Siarhei.Liakh@concurrent-rt.com; 
Received: from MN2PR11MB3885.namprd11.prod.outlook.com (2603:10b6:208:151::27)
 by MN2PR11MB4237.namprd11.prod.outlook.com (2603:10b6:208:195::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.19; Tue, 14 Apr
 2020 13:39:37 +0000
Received: from MN2PR11MB3885.namprd11.prod.outlook.com
 ([fe80::984:ec50:d6de:dc0a]) by MN2PR11MB3885.namprd11.prod.outlook.com
 ([fe80::984:ec50:d6de:dc0a%4]) with mapi id 15.20.2900.026; Tue, 14 Apr 2020
 13:39:37 +0000
Date:   Tue, 14 Apr 2020 09:39:34 -0400
From:   Siarhei Liakh <siarhei.liakh@concurrent-rt.com>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>, colin.king@canonical.com,
        Eric Paris <eparis@parisplace.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeff Vander Stoep <jeffv@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 7/9] SELinux: Expose filename_tr hash table sizing via
 Kconfig
Message-ID: <20200414133931.GB10584@concurrent-rt.com>
References: <20200408182416.30995-1-siarhei.liakh@concurrent-rt.com>
 <20200408182416.30995-8-siarhei.liakh@concurrent-rt.com>
 <CAFqZXNt4+O6Ys-5Xb8mrXyvSsVt6NanuHxkq0oN7BPok-ecvOQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFqZXNt4+O6Ys-5Xb8mrXyvSsVt6NanuHxkq0oN7BPok-ecvOQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: BN4PR11CA0002.namprd11.prod.outlook.com
 (2603:10b6:403:1::12) To MN2PR11MB3885.namprd11.prod.outlook.com
 (2603:10b6:208:151::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from concurrent-rt.com (65.190.80.89) by BN4PR11CA0002.namprd11.prod.outlook.com (2603:10b6:403:1::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15 via Frontend Transport; Tue, 14 Apr 2020 13:39:36 +0000
X-Originating-IP: [65.190.80.89]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 98b07f41-8dff-4df6-dff2-08d7e0794612
X-MS-TrafficTypeDiagnostic: MN2PR11MB4237:
X-Microsoft-Antispam-PRVS: <MN2PR11MB4237355C787B7A23959D219CB1DA0@MN2PR11MB4237.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0373D94D15
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3885.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(136003)(396003)(39840400004)(376002)(346002)(366004)(7696005)(6916009)(1076003)(54906003)(8886007)(5660300002)(2906002)(53546011)(508600001)(36756003)(8676002)(956004)(16526019)(8936002)(81156014)(186003)(52116002)(26005)(2616005)(55016002)(66556008)(4326008)(86362001)(66946007)(66476007)(33656002)(966005)(44832011)(316002);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: concurrent-rt.com does not
 designate permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0fyP3MistE7Fy6Tvxnm58wQxzcn4VvnGn7PdfIHL/xbis6p7jj/3iekb6HFB1FFzhhr3bUG4CpN7DdEj3z/AAteBSf1noFslpLcW7sCSn+YSKNSmq0RcQCMFGezpOeUxRUGXyh14jcfyGTtcXjOn06VvLKpp4VlM5DYX6w0gsjT58QO9jxsvk5yRxQLxlnKVmZeas8lIXJ2ymvXlzxI/r9720A5tTq8Oy2XAjbrE+zkIflnlFO0hGuQgNqn5yUPaICjITs41+ZcRgjmSRuVxMkkqSe3U6XLbCwKw2Mz7K9JuQCZG3GBQnBvFXVqhdUUuDpOp3ZG1oSxwrz+dxAEB0palt5yu1Apeu8iMyXoj5fSReifYHulytkCX1BhhUD+1xOcfGqiysCgH7pj1UsG9bFAPQDWQC0kzcnWOSm3MAwvWSa51pDgSJcAUuR2huLD/kL49E7jBlvcFkJmvMW1KGrB/E2EfP7DBqXRwawgQR5RJDLFUAZoPTEEG3vOIg5iPQBiW//CBllQUSUL6VGUKyA==
X-MS-Exchange-AntiSpam-MessageData: jypOW6xlWxSxD4ZgqR8sSQmB83qd1S8XB6ULCjqocB9p59k7W2yxH/QGoJ4Mj9Z9rEKl/YAWFmpyo+zr7LB2VEZ2ctnV0voETqEFxP/UBNPT9GBGnpwZvL3Y8iwNLa4BIe+Afn4fAIkADZmdsYz9mQ==
X-OriginatorOrg: concurrent-rt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98b07f41-8dff-4df6-dff2-08d7e0794612
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2020 13:39:37.1149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38747689-e6b0-4933-86c0-1116ee3ef93e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zAs/l6FZDTTUbaY4Lx3m+3gtt83kOIFEBeo2s1nUnf1xKqVuI0i8mRgvPtbJExCghxa9fBYGCUmLftosZIpQywYwcjZ+3Dnx+0SWMMjq/yI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4237
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The 04/14/2020 12:54, Ondrej Mosnacek wrote:
> Hi Siarhei,
> 
> On Wed, Apr 8, 2020 at 8:24 PM <siarhei.liakh@concurrent-rt.com> wrote:
> >
> > From: Siarhei Liakh <siarhei.liakh@concurrent-rt.com>
> >
> > This change exposes previously hardcoded filename_tr sizing via Kconfig,
> > which provides a more convenient tuning mechanism for downstream distributions.
> > Default sizing is not affected.
> >
> > Signed-off-by: Siarhei Liakh <siarhei.liakh@concurrent-rt.com>
> > ---
> > Please CC me directly in all replies.
> >
> >  security/selinux/Kconfig       | 10 ++++++++++
> >  security/selinux/ss/policydb.c |  3 ++-
> >  2 files changed, 12 insertions(+), 1 deletion(-)
> >
> > diff --git a/security/selinux/Kconfig b/security/selinux/Kconfig
> > index b7ced53ffd76..23ec741b1ce6 100644
> > --- a/security/selinux/Kconfig
> > +++ b/security/selinux/Kconfig
> > @@ -123,6 +123,16 @@ config SECURITY_SELINUX_AVTAB_HASH_BITS
> >           footprint at price of hash table lookup efficiency. One bucket
> >           per 10 to 100 rules is reasonable.
> >
> > +config SECURITY_SELINUX_PDB_FILE_TR_HASH_BITS
> > +       int "Number of slots (buckets) for File Transitions hash table, expressed as number of bits (i.e. 2^n)"
> > +       depends on SECURITY_SELINUX
> > +       range 1 32
> > +       default "11"
> > +       help
> > +         This is a power of 2 representing the number of slots (buckets)
> > +         used for File Transitions hash table. Smaller value reduces memory
> > +         footprint at price of hash table lookup efficiency.
> > +
> >  config SECURITY_SELINUX_CHECKREQPROT_VALUE
> >         int "NSA SELinux checkreqprot default value"
> >         depends on SECURITY_SELINUX
> > diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
> > index 0d03036ca20d..f2d809dffb25 100644
> > --- a/security/selinux/ss/policydb.c
> > +++ b/security/selinux/ss/policydb.c
> > @@ -496,7 +496,8 @@ static int policydb_init(struct policydb *p)
> >         cond_policydb_init(p);
> >
> >         p->filename_trans = hashtab_create(filenametr_hash, filenametr_cmp,
> > -                                          (1 << 11));
> > +                          (1 << CONFIG_SECURITY_SELINUX_PDB_FILE_TR_HASH_BITS));
> > +
> >         if (!p->filename_trans)
> >                 return -ENOMEM;
> >
> > --
> > 2.17.1
> 
> Note that this patch in particular won't be needed after (if) [1] gets
> merged. Then for all policies built by new userspace the number of
> elements will be known before the hashtab creation and it will be
> passed to hashtab_create() directly (as is already done for the other
> hashtabs). The hard-coded size will only be used in the
> backwards-compat code path (when a policy built by an older userspace
> is loaded) and thus won't be worth tuning any more.
> 
> [1] https://patchwork.kernel.org/patch/11462503/

This is excellent news!
Unfortunately, my clients tend to have really long product life cycles, meaning
that even with new kernels they will still have old userspace tools. I guess
I'll just keep these patches in our local tree...

Thank you!

-- 
Siarhei Liakh
Concurrent Real-Time
