Return-Path: <SRS0=NJTS=56=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E46C4C2BA19
	for <selinux@archiver.kernel.org>; Tue, 14 Apr 2020 14:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2C4B20578
	for <selinux@archiver.kernel.org>; Tue, 14 Apr 2020 14:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=concurrentrt.onmicrosoft.com header.i=@concurrentrt.onmicrosoft.com header.b="aGG+F8o2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388847AbgDNODg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 14 Apr 2020 10:03:36 -0400
Received: from mail-bn7nam10on2106.outbound.protection.outlook.com ([40.107.92.106]:59125
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388831AbgDNODd (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 14 Apr 2020 10:03:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZM37N1TItJB4kGoSYOt7sem5lKhOBqFfVesQtMKOzxOyrUy1JtgCBfhyQAMYmUrdfTn0BhfWUOobH+N7jHCD3q+fDvsvL0XSbPwKkObqe4tZTTiLBVTAf1N1NwGZSQj/g8VDclTumlBuQQdIWsCIN8fEqRAKlbBmlmuQsvWxs+GFvCtYFjlHeD6R3kkTz9Y5L9wcPhvVTYN3s6+iI0jCbSC27qySKSxsDDCr/J2a4IpuVD/RKK5fITdftoIqJV1gYTc1RWmhGDNwaQJVgr7yiinUah7FtI5p48YmrtXnXtMUag7XXs4uE3wMKLFHwz7P5v8cWS0SALL1DWSME7uT2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ONUXnBkqFqPUVytsNHyfTG/S1F6k3zxN0YD5ai7tz0=;
 b=g6cNhdJ6QVB7OoYNRb4DFYOmcm5BnNTQUUEHuv3+i2H32flWAN0OiQdvJXxzGr8B7bIhVOJLlaxDAexRkmnOFC5B8Pj979RQzzPOc/2BSAGT8Cyk/mylOFx61jSknA+oPivYC9MAV+WaTm0OcN1+W0zFUEU1RRlRJxmHeAcOZZ6KvamHA1EKkSudQ98YoXQhjERN2vZTcCP5I9RZWZmZIVSqtr/Rgae48WshrIwywOXC8B5pknV6EUDdX91PNS3wmaZJhfpEtJEWsomOgiYVTb7TZAcYLDQiyVy5T9k9T7GX9gdZdWfAUdfenPOnF4Y0dm3z+eIbO72gkQ/bXdG/UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=concurrent-rt.com; dmarc=pass action=none
 header.from=concurrent-rt.com; dkim=pass header.d=concurrent-rt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=concurrentrt.onmicrosoft.com; s=selector2-concurrentrt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ONUXnBkqFqPUVytsNHyfTG/S1F6k3zxN0YD5ai7tz0=;
 b=aGG+F8o2rBC/NV0VBFDtopj02xzUb8SMDqV3UcX8xElrc64Go0BrAI6FHoH21wXGfEXUghiySW/D/4gBJ2OklYfn/Qj90FglvduwTWv6PeB2jZGvMN9ybYMoKD8D7WsmixDCQzafDPXfYwzFHi+o0RuNmCJR8nTE/tAjJqVXHow=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Siarhei.Liakh@concurrent-rt.com; 
Received: from MN2PR11MB3885.namprd11.prod.outlook.com (2603:10b6:208:151::27)
 by MN2PR11MB4269.namprd11.prod.outlook.com (2603:10b6:208:190::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.25; Tue, 14 Apr
 2020 14:03:27 +0000
Received: from MN2PR11MB3885.namprd11.prod.outlook.com
 ([fe80::984:ec50:d6de:dc0a]) by MN2PR11MB3885.namprd11.prod.outlook.com
 ([fe80::984:ec50:d6de:dc0a%4]) with mapi id 15.20.2900.026; Tue, 14 Apr 2020
 14:03:26 +0000
Date:   Tue, 14 Apr 2020 10:03:24 -0400
From:   Siarhei Liakh <siarhei.liakh@concurrent-rt.com>
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>, colin.king@canonical.com,
        Eric Paris <eparis@parisplace.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeff Vander Stoep <jeffv@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 8/9] SELinux: Replace custom hash with generic lookup3 in
 symtab
Message-ID: <20200414140323.GD10584@concurrent-rt.com>
References: <20200408182416.30995-1-siarhei.liakh@concurrent-rt.com>
 <20200408182416.30995-9-siarhei.liakh@concurrent-rt.com>
 <CAFqZXNsqHCeq8u_ieLb5-fk82bF47ook8yT-jMyBHYmE7m8CcA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFqZXNsqHCeq8u_ieLb5-fk82bF47ook8yT-jMyBHYmE7m8CcA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: BN6PR02CA0025.namprd02.prod.outlook.com
 (2603:10b6:404:5f::11) To MN2PR11MB3885.namprd11.prod.outlook.com
 (2603:10b6:208:151::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from concurrent-rt.com (65.190.80.89) by BN6PR02CA0025.namprd02.prod.outlook.com (2603:10b6:404:5f::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15 via Frontend Transport; Tue, 14 Apr 2020 14:03:26 +0000
X-Originating-IP: [65.190.80.89]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 076c0c2a-a725-4b4f-04fb-08d7e07c9a60
X-MS-TrafficTypeDiagnostic: MN2PR11MB4269:
X-Microsoft-Antispam-PRVS: <MN2PR11MB4269A2245FCA5B46413E66B7B1DA0@MN2PR11MB4269.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0373D94D15
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3885.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(39840400004)(376002)(346002)(366004)(396003)(136003)(36756003)(66946007)(4326008)(33656002)(2906002)(508600001)(5660300002)(55016002)(1076003)(6916009)(16526019)(956004)(2616005)(186003)(316002)(8676002)(81156014)(86362001)(8936002)(26005)(53546011)(44832011)(54906003)(7696005)(52116002)(8886007)(66476007)(66556008)(41533002);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: concurrent-rt.com does not
 designate permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uCMmbiaGQfq7K+q02Wf2JhW82t4y3clTKZhX73aeTs5XRwuw05FsJpbAu++AwkVm4ZSMEgMKJEjQm/XkHvhu0NNJsMeAm8CWiDUvhYEO3QyX6ezlEvWyuCNvGsvaDJp/poK+cUhuBLsoEO3i9ETylxHilYd/YsAs+Ek1k4/zMVdvbzAmRIwjmruvS97rRPTtRpup4QTfqDJcAUHeyqCdpD6+280UFScDSOXhNsJ5UGRnzBDWK34YI3b/7gob3fdi3SaNJDJFF6EIIZqPEVuiRmoDOrYyjLeK7juA8GK/X516J0J5SNF0S37imRsqQqM44mGf0Z2JV4vViZ2AppF05otmFDQ5Q33XmlfxpffTmEMV/ww1tttlOPIh+xfbIURfEMrw2sJI8o3M1EDtZBCsBZ330H4OfBLm2M3UKaDheMeU4I9pvEKqNkIh2/qj3QC3HXXioFU+URy+RITxJCFVvKR/yIMzKoboTpuwNQ7Ng+2DrWMthdkvNBVINpk3F1ug
X-MS-Exchange-AntiSpam-MessageData: KGz/ff4oJP6XWbKC/ZZQsSi2PmC+sMCpra3poTYpCbT9WTt3Jn2dIukf2DrUY59hl5NPk9OW78Iu26diIR8UUAX1p83ZILHGoEFxu8SvHH0HKSNNkAKmY4TH68Vh/fITl2rQOFWZZpzMnMLEh0+C2w==
X-OriginatorOrg: concurrent-rt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 076c0c2a-a725-4b4f-04fb-08d7e07c9a60
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2020 14:03:26.8773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38747689-e6b0-4933-86c0-1116ee3ef93e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JQiJLYZeIXUNybHkeGw4aTYvq24bGY+hCfQ1tWnShXKltneGtJvCeHhym7saaGsA9J4OY+QM1k2XPgRCkukS8wAaqkzeV6eBRO1smTXtYjg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4269
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The 04/14/2020 13:06, Ondrej Mosnacek wrote:
> Hi,
> 
> On Wed, Apr 8, 2020 at 8:24 PM <siarhei.liakh@concurrent-rt.com> wrote:
> >
> > From: Siarhei Liakh <siarhei.liakh@concurrent-rt.com>
> >
> > This patch replaces local copy of custom hash function with existing
> > implementation of lookup3 from the standard Linux library. This change
> > allows to reduce the amount of custom code with has to be maintained, while
> > potentially improving overall performance of the hash table in question.
> >
> > Signed-off-by: Siarhei Liakh <siarhei.liakh@concurrent-rt.com>
> > ---
> > Please CC me directly in all replies.
> >
> >  security/selinux/ss/symtab.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/security/selinux/ss/symtab.c b/security/selinux/ss/symtab.c
> > index dc2ce94165d3..8d189d7683d1 100644
> > --- a/security/selinux/ss/symtab.c
> > +++ b/security/selinux/ss/symtab.c
> > @@ -9,6 +9,16 @@
> >  #include <linux/errno.h>
> >  #include "symtab.h"
> >
> > +#ifdef CONFIG_SECURITY_SELINUX_ADVANCED_HASHING
> > +#include <linux/jhash.h>
> > +
> > +static unsigned int symhash(struct hashtab *h, const void *key)
> > +{
> > +       return jhash(key, strlen((const char *) key), 0) & (h->size - 1);
> 
> Did you consider using full_name_hash() here instead? It is used in
> other places (mainly filesystem code) to hash strings. I wonder how it
> compares to jhash both in terms of speed and in terms of randomness of
> the resulting hash. It would be nice if you could do some benchmarks
> and provide some numbers to support the choice.

No, I have not considered other hashes, as my goal is to simply eliminate local
copies of custom hashes in favor of existing ones from the Linux library. So,
any other standard has will do, as far as I am concerned... However, this whole
conversation brings up an interesting point: looks like we need an official
hashing guide with benchmarks and references to official sources/research behind
each hash function available. Sounds like an excellent project for some student
somewhere! :-)

I'll see what I can quickly put together within the scope of this discussion,
though.
 
Thank you!

-- 
Siarhei Liakh
Concurrent Real-Time
