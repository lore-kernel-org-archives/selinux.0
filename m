Return-Path: <SRS0=wTGR=6U=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B58FC28CBC
	for <selinux@archiver.kernel.org>; Wed,  6 May 2020 21:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6A832070B
	for <selinux@archiver.kernel.org>; Wed,  6 May 2020 21:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=concurrentrt.onmicrosoft.com header.i=@concurrentrt.onmicrosoft.com header.b="iOWtEqZs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729398AbgEFVmV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 May 2020 17:42:21 -0400
Received: from mail-bn8nam12on2109.outbound.protection.outlook.com ([40.107.237.109]:64288
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729268AbgEFVmU (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 6 May 2020 17:42:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GshN708dkgNpfUNmzGiZLZsM6WPoQgCrhc0/zwXa452bu1tUYohCXyBcMOmC54cr0zoV9+PSNeUHXVn80r9rgx+0n1IMngsonbPWtTWocLM2GerZ3ofDJyDlUOSCIYvTqfmfDf/JPyOQAAgT3des0IyDVFuJvb/+PEQlh+tpy26Bk7ELSbxmzuv1qvtKgtjfuUvGUcOtTlIpAWFhK79q3S8RibwA02XXZn0BOgew9ifZ4zIJdtyIXPm0dVdAQUNBp+tmvLxB1X/1gRQ1BEOuXg7pZZ97CHR0OSdhfe5Xb4+o32jNDv9ymC9CIhd9t4tyo+JYhKQOjsAQboqrfySULw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zc9H4DRjeX8Qw79z8sazBQZ9N2iKnJ5bL7fab5rg+Bs=;
 b=dzE8HlthRSQQnY2BGi8WRNAkTeSkGV/6hx9SU3WpcDeXs5om+e10gsNR7Ssko/r/stw0Xi1ex/ZW2vqwXld6LSA7O/z3l0Ujx467Lxaw3cMQ6gU/WcOZaTBRJ3gd3SXYFTRllGOklwURKPaVZwRoYtrucYHjX4a3qvAGHRI8qLjgdWoXwhloW22DUceE56ADC6sW2kBZXpcUCalg4BWNt+T+t+PRuPJrBqkna5nPEl5/qExwZec3qQ0xvKYHWP7SXn1vNcI0e4D+gyop7RPQVx4tPFRSC2TEAGt8jmdSwqxLa15V6Fo7SNrrn5C5fJsIl+1U2fjswLxB90IH7sL2qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=concurrent-rt.com; dmarc=pass action=none
 header.from=concurrent-rt.com; dkim=pass header.d=concurrent-rt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=concurrentrt.onmicrosoft.com; s=selector2-concurrentrt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zc9H4DRjeX8Qw79z8sazBQZ9N2iKnJ5bL7fab5rg+Bs=;
 b=iOWtEqZsnHCMaeqF/JRQ3UaXv8WkwtcnbRcUkMSw1NoI5eLXRgKh9IdKH+dN8f38iQvUew6FW8C9ucmy12c8Pz+hMvVrPV4nindyV9EgE2el3AJ60VayNgZlk4OzZLqOx3a/8P20/RTnstlruHzFJQJ9aeI+7FKOkW7kZhP4z/8=
Authentication-Results: paul-moore.com; dkim=none (message not signed)
 header.d=none;paul-moore.com; dmarc=none action=none
 header.from=concurrent-rt.com;
Received: from MN2PR11MB3885.namprd11.prod.outlook.com (2603:10b6:208:151::27)
 by MN2PR11MB4678.namprd11.prod.outlook.com (2603:10b6:208:264::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.25; Wed, 6 May
 2020 21:42:16 +0000
Received: from MN2PR11MB3885.namprd11.prod.outlook.com
 ([fe80::62:c976:4484:7958]) by MN2PR11MB3885.namprd11.prod.outlook.com
 ([fe80::62:c976:4484:7958%6]) with mapi id 15.20.2979.028; Wed, 6 May 2020
 21:42:16 +0000
Date:   Wed, 6 May 2020 17:42:13 -0400
From:   Siarhei Liakh <siarhei.liakh@concurrent-rt.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org, colin.king@canonical.com,
        Eric Paris <eparis@parisplace.org>, gregkh@linuxfoundation.org,
        jeffv@google.com, omosnace@redhat.com,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        tglx@linutronix.de
Subject: Re: [PATCH 2/2] SELinux: Introduce hash3() as alternative to
 shift-xor
Message-ID: <20200506214208.GA3947@concurrent-rt.com>
References: <20200429202941.18320-1-siarhei.liakh@concurrent-rt.com>
 <20200429202941.18320-3-siarhei.liakh@concurrent-rt.com>
 <CAHC9VhRKpWzaPrF3SGwC1J_DGGuSE0Z0tiYrVV_Rdkam0JosGw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHC9VhRKpWzaPrF3SGwC1J_DGGuSE0Z0tiYrVV_Rdkam0JosGw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: BN6PR11CA0040.namprd11.prod.outlook.com
 (2603:10b6:404:4b::26) To MN2PR11MB3885.namprd11.prod.outlook.com
 (2603:10b6:208:151::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from concurrent-rt.com (65.190.80.89) by BN6PR11CA0040.namprd11.prod.outlook.com (2603:10b6:404:4b::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28 via Frontend Transport; Wed, 6 May 2020 21:42:15 +0000
X-Originating-IP: [65.190.80.89]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf1e1ecf-f1f5-4f7a-7dad-08d7f2065810
X-MS-TrafficTypeDiagnostic: MN2PR11MB4678:
X-Microsoft-Antispam-PRVS: <MN2PR11MB4678734476523F7FE740B30FB1A40@MN2PR11MB4678.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 03950F25EC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SPjVsER5v1OrfIWywoIFaxYBD+ss4c42mf9XNGR2Zess+B/UuwNJXTL09ZN2lyt8Ao4HaL4vnFYCFkCnB/cpnLDMcS0vKSMLzHXsX7tAVzB3lc6zjc4AFRO6tNtmO2A4G4L74jnmJlcRcd9VmbFkl6hCeN5nsIkE2ZcCTajni0WNaUczFht971GM262Ayv9uuE0XrVh1bULJgv5N0UTcbgQDc7qSZg2LGPTEYOhCQY/cMIx20ZzNlZBb7KHMhDqMEohMPdyFpphnzRj56q4CzLd1LeZCJTzr/V+vg5uvfla3paCaHJRCCVJZzZCxzgCEUeWjmMEGKhYTZxrA2cNyUOMfefxRclveI3WtMUM4UHR3e1T+PxopZWK1tz5O8exS7GZPbLZ9M641hDGQoCtliLPlC5/au52u8o4KxzPTsMz+6sSnFNFWt0gmwkWjyclqZPVC0yJTuksLnffxqBTsBCtOyILD8NQQUM72di5B0on+VVPAhYRowL9geyHmfBiEPK3xxxj98Ka+PAvIajUsi5ca/xX4UJ1pEIaI5HNJMUHONHQFEspthRNf88hkt+JszXBsDoAIUTVPiI7MvLcqEiReaRxvMMBypUcCsBMdRTo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3885.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(39840400004)(376002)(346002)(136003)(366004)(33430700001)(66556008)(66476007)(26005)(66946007)(6916009)(16526019)(186003)(30864003)(8886007)(8676002)(55016002)(2906002)(33656002)(8936002)(1076003)(54906003)(44832011)(86362001)(7696005)(33440700001)(956004)(53546011)(2616005)(316002)(36756003)(508600001)(4326008)(966005)(5660300002)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: TBoGos4abgkOpfoi9hpCb+k3b/zX7t9wvjLFaJV2mgIKt87zgTJAU8aWxi3XufWgOWvOQOd0Dr4QYtgLHe6lUwC6+FzYsS5ma3Ufy21IC0Xml701mh/5ideCMpaQyaNzdIzukYsVExK0jRIEmnf7KMBtFyUhfgAZXSPLrJMHJfq+HEbQkqzugOoObuyEVxTngNoagVUHoV6Lh5zccYznLGygK2ll+IgsYIsl1KbJvHsYphJdycRw5ChK5UsHJqwsk67L0XZk+r+GSKWSqJf3u4P4EHTnuJFVfRrUjNeBi0/y+fsXS+K7Z2CGKourb6j5ydd3g9lxuTT3WakpD2j7fh6lTSWnDb48/4P1klRCDz1bxPaiAtPIz1TsVoZ1FDKvO+uYiDLFlMP369jzla2QVUGcTBBFwWsWY2loG5oQKqc7TA10sPBOUPas/GxHDHoKoS14la3/vGCT3wgGRXbTozsyq9PX7cUm3YgwPfY03EKT710jM7xBbGHrrCZw3hXlFUvIknvtRGLEUQVs8PrCGU0Y1AZXc1U4s1P4j2UktcxHOY0T1w2u50bFokXFSl1BDe4QO8rvMu2wKXIihRJ8JMnzlKl4LxgtRlu6cKYuCwmZZmEhELKH4dER7o/8EP6ztVvqMQUFFmoxYsI1nPe4/UYLHBWN8L0EELxfDc+aJhzv1XFhjBFAyKgxV+00TlgMqPGcRg5DujgtkFKTTNpOSa1WBkNQl4k5p1PCIp1DfCXPps/yl99ckeoJ1uRyvc1ut+snH4+07iACzBWGbvuYmHY+63Iu9M1XmbcWBFtoCZc=
X-OriginatorOrg: concurrent-rt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf1e1ecf-f1f5-4f7a-7dad-08d7f2065810
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2020 21:42:16.1433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38747689-e6b0-4933-86c0-1116ee3ef93e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bfM0yBXBfdLpma6lkjLIUQd88f5pQwW0d1i7i1Gd9MLwKBaJXoNjd6OPpSsizWCnjDsz3ddtQniZTwltCzDNG2oJDc10KqN9mgQizJF/QTs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4678
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The 05/05/2020 17:18, Paul Moore wrote:
> On Wed, Apr 29, 2020 at 4:29 PM <siarhei.liakh@concurrent-rt.com> wrote:
> > From: Siarhei Liakh <siarhei.liakh@concurrent-rt.com>
> >
> > This change improves performance of hashing functions used in AVC and
> > AVTab to hash 3x 32-bit values. As compared to original shift-xor function
> > used in AVC, substantial improvement in quality of hashing is gained by:
> > 1. replacing shifts with rolls, thus preserving all of the incoming
> >    entropy
> > 2. adjusting shift/roll constants to reduce overlap between the input
> >    values
> > 3. use of arithmetic addition instead of XOR, as a way to spread out
> >    collisions
> > 4. use of hash_32() to level out the distribution of hash output values
> >    throughout the range
> >
> > Within the scope of particular application, these changes bring hash
> > quality to that of much more complex MurmurHash3 (which is currently used
> > in AVTab), while maintaining trivial simplicity of the original code.
>
> [ . . . ] 
>
> > /sys/fs/selinux/avc/hash_stats:
> >             Old     New
> > Samples:   100      100
> > Entries:   504.43   503.67
> > Buckets:   219.73   304.61
> > 1st Qu.:     1.00     1.00
> > Median :     1.39     1.00
> > 3rd Qu.:     3.00     2.00
> > Maximum:     9.32     5.37
> >
> > Next, performance of avc_lookup() is analyzed by timing it with ftrace on
> > a system with same configuration as above:
> >
> > acv_lookup(), latency in us:
> >             Old     New
> >  Samples: 261534    244168
> >  Min.   : 0.1320    0.1310
> >  1st Qu.: 0.2410    0.2360
> >  Median : 0.4220    0.4240
> >  3rd Qu.: 0.5580    0.5600
> >  Max.   : 9.9300    9.9890
> >
> > Considering small size of AVC in default configuration, the change does
> > not show any latency improvements. In fact, median and 75th percentile
> > timings appear to be in line with addition of extra 4 clock cycles for MUL
> > (roughly 2ns on a 2.2Ghz CPU), or 0.47%. This appears to be a small price
> > to pay for substantially better distribution of hash values, reducing a
> > probability and/or severity of potential pathological behavior on some
> > larger configurations.
> >
> > Note that absolute max latency is likely not indicative, as it is
> > susceptible to one-off events such as interrupts, cache misses, etc.
> 
> Thanks for providing more performance information, this is helpful.
> Right now as I look at the results, I'm trying to decide if I care at
> all about the chain length information as ultimately the latency is
> really what we care about, yes?

Correct, but there are different ways to look at it. One way is to only look
at average / median we get right now in current default configuration. Another
way is to think in terms of potential variability and possible pathological
cases down the road which would be difficult to diagnose and/or fix for an
end-user. In my mind, this is the same type of a decision as with choice of a
default sort algorithm: quicksort is faster on average, however Linux Kernel
relies on heap sort as it does not have a O(n^2) worst-case behavior (as
explained in lib/sort.c). I understand that sort has a guaranteed
bound on worst-case performance, while hash is probabalistic in nature and
the worst-case scenario can still happen even with a good hash. However,
hash3() does demonstrate a much better distribution as compared to the current
hash function, thus reducing probability and/or severity of any potential
pathological case. Think of this as proactive preventative maintenance, rather
than a reactive bug fix.

> I'm also trying to reconcile the
> chain length information with the latency information; based on the
> difference in chain lengths I would have expected more of a difference
> in the latency numbers.  As you mention the latency numbers are
> basically the same (give or take two clock cycles) between the two
> hash implementations, assuming we exclude the worst case.  If we
> include the worst case the old implementation is better, at least in
> the data you've provided.
> 
> Is the added complexity of the hash3 implementation, as compared to
> the current avc hash, stealing from the performance improvement
> brought by the improved hash table utilization?  If true, I would
> expect the penalty to be constant regardless of the chain length, but
> it seems like the latency difference between old and new gets worse
> (from a "new" perspective) as the chain length grows.  Can you explain
> that?  Or are we simply playing in the noise of the measurement since
> we are only talking about a clock cycle or two?

TL;DR:
L1/L2/L3 cache latency is 4-6/14/50-70 cycles on Intel Skylake [1].
So, I think it is just noise.

[1] https://software.intel.com/sites/default/files/managed/9e/bc/64-ia-32-architectures-optimization-manual.pdf
Section 2.2.1.3, Table 2-6 on page 2-11.

Long version:

I suspect that what we see is the result of whole ACV being able to fit within
CPU cache without much cache line eviction in between the consecutive inserts/
lookups, combined with really good branch predicion, speculation & etc.

Here is a fun experiment: I just tested a simple scan of a flat 512-element
array of packed 64-bit values {a:24; b:24; c:16} and it comes up as roughly
500 cycles (~127ns) per *full* scan on Intel Core i7-7820HK CPU @ 3.90GHz. That
would translate to about 225ns on the 2.2Ghz system benchmarked above, which is
just about what we get for 25th percentile lowest latency of hash table! Thus,
a straight scan would be the best if abolute max latency of isolated 512-enry
AVC is all we care about and cache pressure is not a factor. Sounds pretty
crazy, right? 

However, such approach not only does not scale well, but also churns through
up to 4KB (64 cache lines) of memory on each full pass. In contrast, a hash
table with bucket depth of 5 would only issue 6 cache line fetches worst case.
Thus, even if flat scan is *faster* in this particular configuration, it does
not necessarily mean that it is *better* for system as a whole.

What we have is a confuence of the following factors:
1. AVC is a central point of the SELinux which is used all the time by pretty
much everything running on every core
2. L3 shared mode hit is abouot 50% more expensive than a hit in a non-shared
mode [2]
3. Remote DRAM access is about 1.5x - 2x more expensive than local [2]
4. Single-socket NUMA systems becoming ubiquitous (ex: AMD ZEN / EPYC)

Just think about this: on a single-socket AMD EPYC system we can have at most
of AVC memory access as either shared or remote. To me it only makes sense to
reduce any unnecessary cache/DRAM references proactively, even if there is no
obvious immediate payoff right this moment (given, of course, that it does not
make things worse for a "regular" use case today).

[2] https://software.intel.com/sites/products/collateral/hpc/vtune/performance_analysis_guide.pdf
Table 2, page 22. (yes, this info is about 10 years old)

> > AVTab:
> [ . . . ]
> > Old:
> > rules:  81014 entries and 29600/32768 buckets used, longest chain length
> > 11 non-zero Q1/Med/Q3 2/2/4 sum of chain length^2 290030
> >
> > New:
> > rules:  81014 entries and 29645/32768 buckets used, longest chain length
> > 11 non-zero Q1/Med/Q3 2/2/4 sum of chain length^2 288810
> 
> Oh, one nit against the first patch - you might as well use all
> lower-case letters in the stats (e.g. "q1" not "Q1" and "med" instead
> of "Med") to be consistent with the existing output.

Will do.
 
> > Performance, though, is a different matter: a clear savings of 8ns to
> > 10ns (75th and 50th percentiles respectively) had been measured with
> > ftrace for the most frequent AVTab lookup method:
> >
> > avtab_search_node(), latency in us:
> >           Old       New
> >  Samples: 5953243   5458099
> >  Min.   : 0.136     0.129
> >  1st Qu.: 0.199     0.189
> >  Median : 0.219     0.209
> >  3rd Qu.: 0.294     0.286
> >  Max.   :10.000     9.990
> >
> > The results are not as clear for much less frequently (that is 1500x call
> > frequency difference) used avtab_search(), though they appear to lean
> > towards a positive side:
> >
> > avtab_search(), latency in us:
> >             Old     New
> >  Samples: 3863      3638
> >  Min.   : 0.165     0.157
> >  1st Qu.: 0.297     0.293
> >  Median : 0.510     0.517
> >  3rd Qu.: 0.803     0.774
> >  Max.   : 9.343     7.701
> 
> So with the avtab we see similar chain length numbers between the two
> hash implementations but we manage to save a couple of clock cycles
> across the board from best to worst.  I'm guessing this is almost
> surely due to the simpler hash3 implementation over the current avtab
> implementation, yes?

Yes. MurmurHash3() version translates into roughly 6x more instructions
as compared to hash3(), so the fixed offset is really measurable. Note
that Max for avtab_search_node() is pretty much the same in both cases,
which falls in line with my earlier assertion that it is likely not
indicative of real performance differences as it is a function of other
more random and more expensive processes (such as interrupts, cache
misses, and etc.).

> 
> (more comments inline)
> 
> [ . . . ]
> > +/*
> > + * hash3(): Mix and hash 3 x u32's with minimal overhead,
> > + * truncate result to requested number of bits.
> > + *
> > + * This hash function produces very good results for inputs where most of
> > + * input entropy is contained within the lower 11 bits of each of the words.
> > + *
> > + * For example, AVC hash table (in avc.c) is indexed by a 3-tuple (u32 ssid,
> > + * u32 tsid, u16 tclass), where (on Fedora 32 Beta, as of March 2020) ssid and
> > + * tsid appear to be sequential indexes between 0x0 and 0xA00, while tclass
> > + * appears to be confined to the lower 8 bits, resulting in almost perfect
> > + * packing of the indexes into a single 32-bit value.
> > + *
> > + * The function still produces reasonable hash values even when input value
> > + * ranges span beyond 11 bits, as long as the placement of entropy within the
> > + * input values is roughly the same for each of the componets (a, b, c), and
> > + * the address space (a, b, c) is sparsely populated. Such behaviour is the
> > + * result of two conscious choices: (1) use of rol32() to preserve all of the
> > + * incoming entropy (as opposed to simple shifts which discard some input bits)
> > + * and (2) use of arithmetic addition which carries over colliding bits (as
> > + * opposed to binary XOR, which does not carry).
> > + *
> > + * The function will produce horrible collisions if input entropy is distrubuted
> > + * within (a, b, c) such that it ends up within the same bit ranges after
> > + * rotations, and the address space is densly populated. If that is the case,
> > + * then two options are available:
> > + * 1. Try switching around some of the inputs. EX: (a, b, c) => (b, c, a)
> > + * 2. Use a real hash, such as jhash_3words() from linux/jhash.h
> > + */
> 
> I'm not one to throw stones as my spelling is terrible, but I wouldn't
> be doing my job if I didn't ask you to run spellcheck on the comment
> above.

Will do.
 
> > +static inline u32 hash3(u32 a, u32 b, u32 c, int bits)
> > +{
> > +       return hash_32(a + rol32(b, 11) + rol32(c, 22), bits);
> > +}
> > +
> > +#endif /* #ifndef _SELINUX_HASH3_H */
> 
> ...
> 
> > diff --git a/security/selinux/ss/avtab.h b/security/selinux/ss/avtab.h
> > index 5fdcb6696bcc..bf24d8094019 100644
> > --- a/security/selinux/ss/avtab.h
> > +++ b/security/selinux/ss/avtab.h
> > @@ -85,6 +85,7 @@ struct avtab {
> >         u32 nel;        /* number of elements */
> >         u32 nslot;      /* number of hash slots */
> >         u32 mask;       /* mask to compute hash func */
> > +       u32 bits;       /* number of bits in mask */
> >  };
> 
> We can get rid of the "mask" field, right?

Yes, I think we can.

-- 
Siarhei Liakh
Concurrent Real-Time
