Return-Path: <SRS0=NJTS=56=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 396CFC2BA19
	for <selinux@archiver.kernel.org>; Tue, 14 Apr 2020 13:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B92920578
	for <selinux@archiver.kernel.org>; Tue, 14 Apr 2020 13:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=concurrentrt.onmicrosoft.com header.i=@concurrentrt.onmicrosoft.com header.b="5WGFlL/+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388126AbgDNNot (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 14 Apr 2020 09:44:49 -0400
Received: from mail-dm6nam12on2118.outbound.protection.outlook.com ([40.107.243.118]:48064
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388081AbgDNNom (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 14 Apr 2020 09:44:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hJB05pnU7JUnp/JXZpw1VAX7he84mwYTJKggDg8TjKX1DnfokQo/l8kGdJRUTr3w3miH1Z2Vylep6ELV+DrztSym+4zKOrwM7JGu2juOHSD5BlFJxpSbpw5di73l80d3rkwsKqTYwuo4+yA6r+aUHq6/iy3CIxMK3SpS1W+4sGZLFn+UvijLlzlnJ+KEgsq5LeOIqykUcJqUVa/wOYMWPhSFQe8extxX4hvYIXrCEgj2tPTP0YUwNEgmZ84KUgXlO/rkc9bTPks22jOkDFN+UBZHGm1Co1pJg+5wcr1gZRuqShDG4qKMTHu0A2rcwMZ/YYmVqFoKAvqkf+qVBqRVQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=db7UyCNwtMybSfw/40qCXds9GW/tMXyPuDmhE6cYiyU=;
 b=Cq0WRdD7I4dFf2fHhr/C6RWZrJuSQJVs5jHOPXDC0JQRYRtV3vLkKT3t/x6kV0X9EwKStPuG0HVc5uX+Pss3Ib+lWnuTxv/ne48bjNKI+4FiRIJjAbhefWrF2PkAQUFjXbV6NE9yVAjsnJd+kHB47HIqnnRrmlnlLbKEQHlt+nPUCLdcFv7Jb9TtqL+63CfNXby32q6AFhRL8kl7ztsaPL6w2DR48QfF/H3PYJK2P9jVdfc86rkyVt/ExQ8lwWPINlY0W1waBH6Ea0QN3XqUp3JwG38ks5wa5dTm7OWNYZw55aWDdxXVGl0X+seoNcKyFPHb24qV3c4zjFCM7wXrKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=concurrent-rt.com; dmarc=pass action=none
 header.from=concurrent-rt.com; dkim=pass header.d=concurrent-rt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=concurrentrt.onmicrosoft.com; s=selector2-concurrentrt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=db7UyCNwtMybSfw/40qCXds9GW/tMXyPuDmhE6cYiyU=;
 b=5WGFlL/+2u8Str0vrV2F92VU+v2A4bv9Gno1jjvqnksnVOo47d6IllXyi9gUUogTBlEtwHiSmNofrtjxETYRVSnzrFICrAJ99QQqYjD8u9I86Z5+i0Il15V3XEnfjm669t17GvnCZNeZR2jFkQl9Nc9EJGT6cRwak0dHZK1WlZA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Siarhei.Liakh@concurrent-rt.com; 
Received: from MN2PR11MB3885.namprd11.prod.outlook.com (2603:10b6:208:151::27)
 by MN2PR11MB4661.namprd11.prod.outlook.com (2603:10b6:208:26b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Tue, 14 Apr
 2020 13:44:38 +0000
Received: from MN2PR11MB3885.namprd11.prod.outlook.com
 ([fe80::984:ec50:d6de:dc0a]) by MN2PR11MB3885.namprd11.prod.outlook.com
 ([fe80::984:ec50:d6de:dc0a%4]) with mapi id 15.20.2900.026; Tue, 14 Apr 2020
 13:44:38 +0000
Date:   Tue, 14 Apr 2020 09:44:34 -0400
From:   Siarhei Liakh <siarhei.liakh@concurrent-rt.com>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>, colin.king@canonical.com,
        Eric Paris <eparis@parisplace.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeff Vander Stoep <jeffv@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 4/9] SELinux: Replace custom hash in avtab with generic
 lookup3 from the library
Message-ID: <20200414134434.GC10584@concurrent-rt.com>
References: <20200408182416.30995-1-siarhei.liakh@concurrent-rt.com>
 <20200408182416.30995-5-siarhei.liakh@concurrent-rt.com>
 <CAFqZXNt9nAzzEFps8PafP8zC7sE7Q4YuST67xiSezPzz3ofApQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFqZXNt9nAzzEFps8PafP8zC7sE7Q4YuST67xiSezPzz3ofApQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: BN6PR12CA0034.namprd12.prod.outlook.com
 (2603:10b6:405:70::20) To MN2PR11MB3885.namprd11.prod.outlook.com
 (2603:10b6:208:151::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from concurrent-rt.com (65.190.80.89) by BN6PR12CA0034.namprd12.prod.outlook.com (2603:10b6:405:70::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15 via Frontend Transport; Tue, 14 Apr 2020 13:44:37 +0000
X-Originating-IP: [65.190.80.89]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e11408e1-30b2-479b-ee43-08d7e079f9c0
X-MS-TrafficTypeDiagnostic: MN2PR11MB4661:
X-Microsoft-Antispam-PRVS: <MN2PR11MB4661EAE60017259E86F6423AB1DA0@MN2PR11MB4661.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0373D94D15
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3885.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(39840400004)(346002)(396003)(136003)(366004)(376002)(52116002)(7696005)(55016002)(6666004)(66946007)(6916009)(86362001)(1076003)(956004)(2616005)(2906002)(54906003)(316002)(66556008)(186003)(44832011)(26005)(53546011)(16526019)(508600001)(36756003)(81156014)(33656002)(8936002)(4326008)(8886007)(66476007)(5660300002)(8676002)(41533002);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: concurrent-rt.com does not
 designate permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d3VsJPGi5PxuklRIMjh1UfK6R4XBhXljzYeqYRh96+JfI1dHNZGEg1X3JoVGhQI3JVFzj7o17rlg7SBmAatF7+03n7eCDNBRNR5496UETwvPzH3NCU0bmeyCrptzWCYdSyBZ9yEDPQi3ebe4GiJuUYLZ3SwclkkuBeSvMXIt0aQf1Y/rv3UE5PEfg15+jy9MZ01CCHi4i/ouPFovF+N3GmOPsguleSwI+nfkwBYKaUP90EFLF4Ae5BgjkvmW2S9YAlHzOy/Ba/p8KHbqDIItc8xPzXXMb0gZB6QcxL4EfTqBXtCXyvC5nYaQ6wq5Jw5wHBd4fuj5oKbCijNQc415T79x0/AUWwCiZbHvWeCHbKI8sA5si2Ce/iACu5vq1RxItZVvBXM30rId6JMz7tml8KJi3xrpvin5+zc47BZImykaQ9KumCRaV+4+eFqAvaB8hMxFJ70YNBpIj26y324LX+vvc7eKSpE0Ms1IUDpRDKjOoKJ8g0cp84tmjxIfhGIv
X-MS-Exchange-AntiSpam-MessageData: h4GGMTeR9UJmaDxrir+3PLPDT7huiwNzVC694Mwn9ikaygHh9yanPRPANnkG04Y7tgXhiXeGJkQ0i/0IOCUnLkUxRcAVZ9jNbYEKytirN5EkF63s7zU62UH8vy1fE69j3tfCzFdYlWn1gFB4k9LLFQ==
X-OriginatorOrg: concurrent-rt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e11408e1-30b2-479b-ee43-08d7e079f9c0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2020 13:44:38.4118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38747689-e6b0-4933-86c0-1116ee3ef93e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LpbWXvMlAbNQ8fG9127oCAb6S4xb1llHpZzjtVnWRckblKsVy9PW/PpBjBcdHobr4pIUor1WsLrmhUCwmP1uCqQiaKFzIoTiX5DoSt+FYUo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4661
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The 04/14/2020 12:58, Ondrej Mosnacek wrote:
> Hi,
> 
> On Wed, Apr 8, 2020 at 8:24 PM <siarhei.liakh@concurrent-rt.com> wrote:
> >
> > From: Siarhei Liakh <siarhei.liakh@concurrent-rt.com>
> >
> > This patch replaces local copy of custom implementation of MurmurHash3 in
> > avtab.c with existing generic implementation of lookup3 from the standard
> > Linux library. The library version of hash used to mix 3 x u32 values is
> > comparable to the custom implementation in run time complexity and bit
> > avalanche. This change allows to reduce the amount of custom code with has
> > to be maintained, while preserving overall performance of the hash table
> > in question.
> >
> > Before (MurmurHash3):
> > rules:  282731 entries and 64534/65536 buckets used, longest chain length 17
> > sum of chain length^2 1522043
> >
> > After (lookup3):
> > rules:  282731 entries and 64572/65536 buckets used, longest chain length 16
> > sum of chain length^2 1517651
> >
> > Please note that either hash can show a slight [dis]advantage over the other
> > depending purely on actual rule sets loaded and number of buckets configured.
> 
> FWIW, I did a quick check comparing the duration of
> context_struct_compute_av() (triggered by forcing AVC misses) with and
> without this patch (i.e. its fixed version - see below) and there
> seems to be no measurable difference. I didn't compare the bucket
> occupancy stats, but I expect them to be equivalent or slightly
> better, as data from your commit message also shows. So considering
> that it removes a chunk of ugly code while not regressing in
> performance, I'm in favor of this patch (assuming issues below are
> fixed).

Good to hear that :-)
 
> >
> > Signed-off-by: Siarhei Liakh <siarhei.liakh@concurrent-rt.com>
> > ---
> > Please CC me directly in all replies.
> >
> >  security/selinux/ss/avtab.c | 39 +++++--------------------------------
> >  1 file changed, 5 insertions(+), 34 deletions(-)
> >
> > diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
> > index 01b300a4a882..58f0de17e463 100644
> > --- a/security/selinux/ss/avtab.c
> > +++ b/security/selinux/ss/avtab.c
> > @@ -20,49 +20,20 @@
> >  #include <linux/kernel.h>
> >  #include <linux/slab.h>
> >  #include <linux/errno.h>
> > +#include <linux/jhash.h>
> >  #include "avtab.h"
> >  #include "policydb.h"
> >
> >  static struct kmem_cache *avtab_node_cachep;
> >  static struct kmem_cache *avtab_xperms_cachep;
> >
> > -/* Based on MurmurHash3, written by Austin Appleby and placed in the
> > - * public domain.
> > +/*
> 
> Your patch has a trailing space after the '*' in the above line.
> Please remove it.

Will do.

> > + * Use existing Bob Jenkins' lookup3 hash from the library
> >   */
> >  static inline int avtab_hash(struct avtab_key *keyp, u32 mask)
> >  {
> > -       static const u32 c1 = 0xcc9e2d51;
> > -       static const u32 c2 = 0x1b873593;
> > -       static const u32 r1 = 15;
> > -       static const u32 r2 = 13;
> > -       static const u32 m  = 5;
> > -       static const u32 n  = 0xe6546b64;
> > -
> > -       u32 hash = 0;
> > -
> > -#define mix(input) { \
> > -       u32 v = input; \
> > -       v *= c1; \
> > -       v = (v << r1) | (v >> (32 - r1)); \
> > -       v *= c2; \
> > -       hash ^= v; \
> > -       hash = (hash << r2) | (hash >> (32 - r2)); \
> > -       hash = hash * m + n; \
> > -}
> > -
> > -       mix(keyp->target_class);
> > -       mix(keyp->target_type);
> > -       mix(keyp->source_type);
> > -
> > -#undef mix
> > -
> > -       hash ^= hash >> 16;
> > -       hash *= 0x85ebca6b;
> > -       hash ^= hash >> 13;
> > -       hash *= 0xc2b2ae35;
> > -       hash ^= hash >> 16;
> > -
> > -       return hash & mask;
> > +       return jhash_3words(keyp->target_class, keyp->target_type,
> > +                               keyp->source_type) & mask;
> 
> This function takes 4 arguments, not 3. (I can see you mentioned in
> your reply to Paul that you accidentally sent an older version of the
> patches, so I hope you have this already fixed in the final version.)

Yes, that was fixed before the patches were sent out, as it would not compile
otherwise.

> Also, please align the second line properly (start of
> "keyp->source_type" should be aligned with the end of "jhash_3words("
> on the previous line). Please also check for similar whitespace issues
> in the rest of the patches, since I didn't have a closer look at those
> yet.

Will do.
Thank you for your feedback!

-- 
Siarhei Liakh
Concurrent Real-Time
