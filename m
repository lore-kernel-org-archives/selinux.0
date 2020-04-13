Return-Path: <SRS0=t5D9=55=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B6ACC2BA2B
	for <selinux@archiver.kernel.org>; Mon, 13 Apr 2020 20:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62168206DA
	for <selinux@archiver.kernel.org>; Mon, 13 Apr 2020 20:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=concurrentrt.onmicrosoft.com header.i=@concurrentrt.onmicrosoft.com header.b="hhxJpS4W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388551AbgDMUnq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 13 Apr 2020 16:43:46 -0400
Received: from mail-eopbgr690097.outbound.protection.outlook.com ([40.107.69.97]:51840
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388526AbgDMUnn (ORCPT <rfc822;selinux@vger.kernel.org>);
        Mon, 13 Apr 2020 16:43:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k/c1wkbAwdrwcP9otd/n/ixxYxBQGZqkVV7hZSBT+dlx7OXqSr3+mGRFNyIMRF8pIs8oVWA/+e/7PUXTVeCE2yR8Os5dXfjz3x8OxIZ9euin1RTVAR1/skUmMEHxMW3XZC11mRGoTU77S92VzwP7Nwk4dnD1A/MYROxQQeSReJ2kP8zr8Ya/FZ05NnzMVCiRvDksSgi+yGhYm1LtCGxsayiuSFGZwjCB+buz9Qeb2Fm5n8zA0zi4L9hsDlIfNNGurrc0T4Sfj0V6p2eP3nDOjRTvEVFQRcOg2DMvKWFHG5y3SuwWDG9Ky3ExHsIzdOtqLnebedK7mn4UsYpcSIzrEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ScT1GpYeWfo/2megdpb+FQ4Q34ZNoacF43kksa8WyEE=;
 b=UaCxXioxNh1j41DfuT9LJ3q1whseDp0dVkM+CRS9rlhqbhxQN2L26R6zy/VNJsTdWzKFdhgVS+UBosbCZUinuXhmx9uBVfJBUva7QLYoppz26TQ9Pclkp2a7MJ1U40SxlPiSvE+tKRjwdKb24a4O/hSkh5LTwht22tGvA6/nlM438/erV/ys0zolAYb2qF1tt6wSG0UqBFAIbY/n2n9WMqimflAc8JtEL55ZF2cRCezgvPrCFng/MkUhLjuqLDNsAnCwgbLhjhMEEgR46Zbn3JdNtzQv6UNc3nrIflLagIvHZ/XdwGOZzATE1jrhO/5P58fNEu2W7Kv0s2n8kdzNxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=concurrent-rt.com; dmarc=pass action=none
 header.from=concurrent-rt.com; dkim=pass header.d=concurrent-rt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=concurrentrt.onmicrosoft.com; s=selector2-concurrentrt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ScT1GpYeWfo/2megdpb+FQ4Q34ZNoacF43kksa8WyEE=;
 b=hhxJpS4WVrBTHdkYsSjGE4cqALcTPt0/Q+4HRurF3i2jXbktT4G5HhZ673XkR6qmkzuWzYtCda7pwW9trfLqUwZggYD3cc4I/hDNG5QI0wa5eUfOhKQSqLb3gNRrxnF7C6kg/5AxMVjt8QXEVt/Wp9PVKK7B/iqO7QcA4r/bDyE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Siarhei.Liakh@concurrent-rt.com; 
Received: from MN2PR11MB3885.namprd11.prod.outlook.com (2603:10b6:208:151::27)
 by MN2PR11MB4757.namprd11.prod.outlook.com (2603:10b6:208:26b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Mon, 13 Apr
 2020 20:43:39 +0000
Received: from MN2PR11MB3885.namprd11.prod.outlook.com
 ([fe80::984:ec50:d6de:dc0a]) by MN2PR11MB3885.namprd11.prod.outlook.com
 ([fe80::984:ec50:d6de:dc0a%4]) with mapi id 15.20.2900.026; Mon, 13 Apr 2020
 20:43:39 +0000
Date:   Mon, 13 Apr 2020 16:43:35 -0400
From:   Siarhei Liakh <siarhei.liakh@concurrent-rt.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org, colin.king@canonical.com,
        Eric Paris <eparis@parisplace.org>, gregkh@linuxfoundation.org,
        jeffv@google.com, omosnace@redhat.com,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        tglx@linutronix.de
Subject: Re: [PATCH 0/9] SELinux: Improve hash functions and sizing of hash
 tables
Message-ID: <20200413204334.GA10584@concurrent-rt.com>
References: <20200408182416.30995-1-siarhei.liakh@concurrent-rt.com>
 <CAHC9VhRJ=b-dTVwgTE1TKezqY8KWoGFoHSU1XdfMNjP6uoHQFg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHC9VhRJ=b-dTVwgTE1TKezqY8KWoGFoHSU1XdfMNjP6uoHQFg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: BN6PR1401CA0008.namprd14.prod.outlook.com
 (2603:10b6:405:4b::18) To MN2PR11MB3885.namprd11.prod.outlook.com
 (2603:10b6:208:151::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from concurrent-rt.com (65.190.80.89) by BN6PR1401CA0008.namprd14.prod.outlook.com (2603:10b6:405:4b::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.17 via Frontend Transport; Mon, 13 Apr 2020 20:43:38 +0000
X-Originating-IP: [65.190.80.89]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ad4825cd-f6a4-4a30-a8bf-08d7dfeb5831
X-MS-TrafficTypeDiagnostic: MN2PR11MB4757:
X-Microsoft-Antispam-PRVS: <MN2PR11MB475706D4B725382FDE6053ADB1DD0@MN2PR11MB4757.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 037291602B
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3885.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(39840400004)(136003)(366004)(346002)(396003)(376002)(55016002)(81156014)(8676002)(66946007)(4326008)(2906002)(316002)(8936002)(7696005)(1076003)(8886007)(54906003)(26005)(44832011)(956004)(186003)(53546011)(2616005)(16526019)(6666004)(86362001)(52116002)(36756003)(6916009)(966005)(66476007)(66556008)(5660300002)(508600001)(33656002);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: concurrent-rt.com does not
 designate permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wAR1aGNyHUstZNc9iDVG7K+/Bk3e5DK66WGv5nfkTaBS6ZXxIz2bZ8uKRxyORrqvsXKIwwqe95TJ0nYLGkAJcbgOX+W2D+ql+0ascalre4dp7jY8g8ZcFLAk/9T+g8+0/sp601kYzjioRIZj5tWLQUcYa0P0y1Blnu86JKQZtF6E3iFoZKlrjmIsIhFfa4HzAa6kiyYnBpENzx0yApjsF5TXqWSf3VIN4dSkEZyIaxycgSExLPGLdBJNN44skLrFHSNA/gCKyGg7i8KM53v1GFZ1oFvwvZeOULf5+uq2KEm6uBgAodRHeFqlxH3ko6ibrQQJw1nxUjci1wtaqAjo7PqHw6TTp2exY9DHRu/v4GZB1nbfAL1k97xOwnKXSgqJdukp5Vph6qtPlMwh9fqAyVSW8+abbmQTWb2m2ga/J/N0qyKczdsltK77UC6GIhKuhefxxdOrpO4OoQrCElr7iGGbOhKcXopKP20OfmVZXEB/a6861KKciomTX8pqOT265eDX8eNGTKjrQDrVdNfuVA==
X-MS-Exchange-AntiSpam-MessageData: M5Hg5YvWXc+whyLnTaaOMYD45YJxMPO2UF8FC6TmcYReqhbbIpO87IFaksFU9WdRtBgLs0+YULO5Xz3/99Kowh4tgOasYehhwQRL7vldPAW/k9M6G5NKH3hkNxigFbkWOipn1bLCd60dbm3wu9Jm5A==
X-OriginatorOrg: concurrent-rt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad4825cd-f6a4-4a30-a8bf-08d7dfeb5831
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2020 20:43:38.8391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38747689-e6b0-4933-86c0-1116ee3ef93e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IyvqiqATGzAiJmqfBqh05HrU4n1og5LRMeRPh0LGzh9WQo5iJ0TFIRODcRiMig8o99rNAVQJI1++UhGX77FcBSH3pAhxpqRPo+OA2NsqHOw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4757
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The 04/09/2020 09:41, Paul Moore wrote:
> On Wed, Apr 8, 2020 at 2:24 PM <siarhei.liakh@concurrent-rt.com> wrote:
> > From: Siarhei Liakh <siarhei.liakh@concurrent-rt.com>
> >
> > This patch set is the result of an actual customer support case where a client
> > of ours observed unacceptable variability of timings while sending UDP packets
> > via sendto() with SELinux enabled. The initial investigation centered around
> > kernel 3.10.108 in CentOS 6.5 environment. Combination of these patches with
> > some substantial tuning of newly added Kconfig options was able to reduce
> > *maximum* sendto() latency to about 160us, down from well over 2ms. Worst
> > latency was typically observed when a new SSH login was initiated concurrently
> > with the test program running a sendto() loop, thus causing an AVC miss with a
> > subsequent call to security_compute_av(), which would spend most of its time
> > iterating through policydb within context_struct_compute_av().
> >
> > The original patch set was developed for linux kernel 3.10.108 and later ported
> > to newer versions. The patch set presented here is based off Linus' tree as of
> > April 7, 2020 and contains only a subset of the changes which are still relevant
> > to 5.6+ as many of the issues had already been addressed in different ways.
> >
> > The patch set consists of 9 patches total and is meant to achieve two goals:
> > 1. Replace most local copies of custom hash functions with generic hash
> >    functions already available in inlude/linux/*.h.
> >
> > 2. Replace hard-coded hash table sizing parameters with Kconfig tunables.
> >
> > "Advanced Hashing" Kconfig option is the only dependency between the patches,
> > but other than that and any combination of them can be used.
> 
> I haven't yet looked at these patches in detail, but a few quick thoughts:

Looks like I sent you a snapshot with a couple of minor porting errors before I
fixed them. You can still look at the patches since the errors do not change
the logic, just hold off on compiling. Apologies for the mix-up, I'll send out
another version soon.

Just wanted to provide some additional background so we can better understand
each other. I focus primarily on real-time aspects of the system, so pretty
much everything I write here has to be viewed in that context. For example,
while I would like to get average performance numbers improved, I am much more
concerned with extreme outliers. Such frame of thinking, to some degree, could
be considered similar to the primary reason why Linux prefers heapsort over
quicksort: while quicksort is faster on average, it also suffers from a
pathological worst-case scenario of O(n^2).

I understand that real-time Linux is a small niche. However, I do believe that
at least some of the changes I suggest would be useful to general public also.
Although I would be really happy if my patches were to get accepted, I think
of them more as conversation starters rather than actual finished product.

> * I would be very curious to see what the performance improvement is
> on a current kernel build from either selinux/next or Linus' tree.

I've got a Fedora 32 beta box installed, so I will get some benchmark numbers
for Linus' tree with default F32 policies soon.

> Performance numbers from an extremely old commercial distribution
> aren't of much interest to mainline development.

I get that. My point is that some of the inefficiencies (at least from my
standpoint) had been in the kernel for a long time and are still there today.
As much as I'd love to get our clients off ancient release, they have their
own reasons to use it, thus fixing my point of reference to something old.
 
> * In general I'm a fan of reducing the number of Kconfig options
> whenever possible in favor of the system auto-tuning based on usage
> (e.g. the loaded policy).  Obviously this isn't possible in some
> cases, but I worry that there is always a risk that if we expose a
> build knob there is a risk it will be mis-configured.  My initial
> reaction is that this patch set exposes way too many things as Kconfig
> knobs.  As an aside, I also worry about runtime tunables, but to a
> much lesser extent (the risk is less, the benefits greater, etc.).

Sure. My point is that hardcoded sizing is inconvenient so it would be nice
to fix it in some way. Moving stuff into Kconfig was the easiest way to do
it in my case, but I am open to better suggestions.

> * The AVC hash table improvement doesn't exactly look like a
> sea-change, 

Correct. However, old hash reliably produces about 40% collision rate while
a new one has distribution which is demonstrably better and it gets even more
so with liarger number of buckets (which, admittedly, is not necessarily what
a typical end-user would use).

> have you tried it on multiple policies and work loads?  I
> wonder if the small improvement you saw changes on different workloads
> and/or policies.

I am not an expert on SELinux (be that kernel or usersace side of business),
so I make do whith what is readily available to me: whatever comes with
the distribuition by default (meaning Targeted policy from CentOS), or
whatever a client is willing to provide us (if anything at all). Further,
as our client had discovered issues under particular workload, that is the
one I am using to benchmark my fixes. That said, I am willing to run a
better test suite if you have one ready.

> * In general I agree with your statement about using common code, e.g.
> hash functions, to improve code quality, maintenance, etc. but the
> hashing functions you are replacing are rather trivial and easily
> maintained.  Not to mention their performance in the SELinux code is a
> well known quantity at this point.

Here is my take on it: proper hash functions are just as hard to come up
with as locking and encryption schemes. Please consider following three points:

1. In 2006 Thomas Gleixner discovered that standard known-good hash_64()
is actually not that good. A very interesting discussion followed:
https://lwn.net/Articles/687494/
https://lore.kernel.org/lkml/20160428163525.495514517@linutronix.de/
https://lore.kernel.org/lkml/20160430205235.24232.qmail@ns.horizon.com/

2. A simple custom hash had already been deemed inadequate and replaced in
avtab.c with (unfortunately) a custom version of known good generic hash:
commit 33ebc1932a07efd8728975750409741940334489
Author: John Brooks <john.brooks@jolla.com>
Date:   Tue Mar 24 16:54:17 2015 -0400

3. We already have at least three ways to do essentially the same thing:

/* _OLD_ AVTab hash - see point #2 above */
static inline int avtab_hash(struct avtab_key *keyp, u32 mask)
{
       return ((keyp->target_class + (keyp->target_type << 2) +
                (keyp->source_type << 9)) & mask);
}

static u32 rangetr_hash(struct hashtab *h, const void *k)
{
        const struct range_trans *key = k;

        return (key->source_type + (key->target_type << 3) +
                (key->target_class << 5)) & (h->size - 1);
}

static inline int avc_hash(u32 ssid, u32 tsid, u16 tclass)
{
        return (ssid ^ (tsid<<2) ^ (tclass<<4)) & (AVC_CACHE_SLOTS - 1);
}

Yet another local copy of a simple custom hash is already being suggested for
future use in SELinux:

+static u32 role_trans_hash(struct hashtab *h, const void *k)
+{
+	const struct role_trans_key *key = k;
+
+	return (key->role + (key->type << 3) + (key->tclass << 5)) &
+		(h->size - 1);
+}

https://lore.kernel.org/selinux/20200407182858.1149087-1-omosnace@redhat.com/

So, as a kernel developer looking at SELinux for the first time in attempt to
resolve a real issue for a real custoer, I have the following questions:
- Why do we need so many ways to hash 3x 32-bit values?
- Why avtab hash was deemed to be bad, but not the other ones? Was it due to
unfortunate chice of shift constants?
- Why avc hash is using XOR while rangetr is using addition? Why shift (2, 4)
vs (3, 5)?
- Why not just use known-good jhash_3words() everywhere and be done with it?

> I'll take a closer look at these patches, likely next week after the
> merge window closes, but in the meantime if you could provide some
> more current performance numbers with a better explanation of the
> workloads I think it would be helpful.

Thank you for making time for this. I'll get you some numbers.
I really hope a better Linux for everyone will come out of this.

Thank you!
-- 
Siarhei Liakh
Concurrent Real-Time
