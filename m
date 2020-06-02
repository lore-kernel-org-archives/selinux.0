Return-Path: <SRS0=4SPy=7P=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0135C433DF
	for <selinux@archiver.kernel.org>; Tue,  2 Jun 2020 20:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79C6A207D5
	for <selinux@archiver.kernel.org>; Tue,  2 Jun 2020 20:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=concurrentrt.onmicrosoft.com header.i=@concurrentrt.onmicrosoft.com header.b="5+15cDH5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbgFBUmY (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 2 Jun 2020 16:42:24 -0400
Received: from mail-bn8nam11on2124.outbound.protection.outlook.com ([40.107.236.124]:60384
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727860AbgFBUmX (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 2 Jun 2020 16:42:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IrWRDhrDZkp0siepdcuUIsEOs4+OLfyoz1WbgQZifs0p6ZyCzl08RLpL5SfhbGJY+m3BfKmAyTAIKwCZKd+vXZ0iO3JuEOxgjaKiRY+iqWAN0Wxw6XasTph09ZS5BgxMZriJnhICbUaMSOo7HB+kKpg36nQSjq7FudFKatSIvrCKXzv6IBAcBiY+2ustWFNKFBIILzWkH+BBfLbUHKH83xbl4XM5q6+lTIyuOwUVoNkJIGXSmUBdN9x8jp+7IiGEIOX/fGaBEa//9Xk02mqVpn8LmVT0AqVtvmqm43iVMZEuqEjYssPddtqX7OrZnAwnsyq0vM397BKiE5OrusKheg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dgtk2743la04k/nPjF88gltz8Qvjd6l1ZwbfzQsGX+g=;
 b=X6yIdGsShOmEQg8YtVGeB3CLpMV8mJmfB+ceVrUyq2acfaXbJWruOY6WlZ0XBQS6Tt4vgLOwnFJmS3WKMhAbLIaiEuWDpoox4Ck446BmUMgIWuwxBO27MDXjzwNVnXgBPoUI9q+A+0KwkSo1zbWY1QSyqZg0E3Z0xgsKiVd3IUr8HHKWA7JIr/lfnmD13jQ2vZ5Rjmgqvhg42zPQ01acOXFqntDFCWhZfErf8esQrZ0CbQJZVuHSvSi+fM/EyXX3aN/bDnJ1WlI5sS0ZB43jfrd+Udxk43UB0jLudVdUJTSeDq+cgTv14G0l4bAvz0rPwf99TBN0Nku0w8r81xgiZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=concurrent-rt.com; dmarc=pass action=none
 header.from=concurrent-rt.com; dkim=pass header.d=concurrent-rt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=concurrentrt.onmicrosoft.com; s=selector2-concurrentrt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dgtk2743la04k/nPjF88gltz8Qvjd6l1ZwbfzQsGX+g=;
 b=5+15cDH5bJ5Hm5dtg/r4ykFrTXSwG7r6J8ImhbV+GPk5kXHmgyi7q4a7n2oO6SwRnAHDnHixvNZWdp4rhiEbtk7D4E1U8o7qXCNoXXX79O7606sP2rPOl9KFDjYemVCN4Rsjuy9n2B4pgjelLiP6IOt++jbDLUGy69UBd4beqec=
Authentication-Results: paul-moore.com; dkim=none (message not signed)
 header.d=none;paul-moore.com; dmarc=none action=none
 header.from=concurrent-rt.com;
Received: from MN2PR11MB3885.namprd11.prod.outlook.com (2603:10b6:208:151::27)
 by MN2PR11MB4272.namprd11.prod.outlook.com (2603:10b6:208:196::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Tue, 2 Jun
 2020 20:42:18 +0000
Received: from MN2PR11MB3885.namprd11.prod.outlook.com
 ([fe80::62:c976:4484:7958]) by MN2PR11MB3885.namprd11.prod.outlook.com
 ([fe80::62:c976:4484:7958%6]) with mapi id 15.20.3045.022; Tue, 2 Jun 2020
 20:42:18 +0000
Date:   Tue, 2 Jun 2020 16:42:15 -0400
From:   Siarhei Liakh <siarhei.liakh@concurrent-rt.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org, colin.king@canonical.com,
        Eric Paris <eparis@parisplace.org>, gregkh@linuxfoundation.org,
        jeffv@google.com, omosnace@redhat.com,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        tglx@linutronix.de
Subject: Re: [PATCH 1/2] SELinux: Add median to debug output of hash table
 stats
Message-ID: <20200602204214.GA29793@concurrent-rt.com>
References: <20200429202941.18320-1-siarhei.liakh@concurrent-rt.com>
 <20200429202941.18320-2-siarhei.liakh@concurrent-rt.com>
 <CAHC9VhRuYa2nA18tnQCwfAUW+whce1a84W802GKk135ztoN8Cw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHC9VhRuYa2nA18tnQCwfAUW+whce1a84W802GKk135ztoN8Cw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: BN8PR15CA0029.namprd15.prod.outlook.com
 (2603:10b6:408:c0::42) To MN2PR11MB3885.namprd11.prod.outlook.com
 (2603:10b6:208:151::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from concurrent-rt.com (65.190.80.89) by BN8PR15CA0029.namprd15.prod.outlook.com (2603:10b6:408:c0::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19 via Frontend Transport; Tue, 2 Jun 2020 20:42:17 +0000
X-Originating-IP: [65.190.80.89]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fed17b5e-b146-48ea-aec9-08d8073570a6
X-MS-TrafficTypeDiagnostic: MN2PR11MB4272:
X-Microsoft-Antispam-PRVS: <MN2PR11MB427270473E9F4D3EC63E43D9B18B0@MN2PR11MB4272.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0422860ED4
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yojFQgTXRrzy+e3XlmEa+UYhDw8p040kzVRhi7n3wOBbXzawXrZPL2yt5w/5CPZ+/IvoXWeeIA/7EkBwifapLv8Hvt3ZlW3N9NEjM9dWK1kmCwQnXLjlepCn4HhHhdgkfyZbDvaRY3nuq4CsHejlUgW5NDBYiMbH3nmJufVfM03gOlXWmlRpT7Ia2SemmpiLCHmM6SP1LnG/2SR9T6vGwoRfgiCo7zY2OHsHk1nRVQx7bC3INIAO+x5DPactLo4jatqYbWx+p7zzLbuXLdRjWbk4TFQ5zqGpLBq7cUduJk8aXnkOM3rubX0br18W9zEjq7R9fVthfV3Q8M8KXurHSA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3885.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39840400004)(366004)(376002)(396003)(346002)(136003)(86362001)(2906002)(44832011)(36756003)(2616005)(83380400001)(5660300002)(956004)(8886007)(33656002)(8676002)(66476007)(53546011)(4326008)(54906003)(316002)(66946007)(66556008)(6916009)(7696005)(8936002)(55016002)(508600001)(186003)(52116002)(16526019)(1076003)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: De0UKCELlrIWWLYuTMvxANFzqIToN0ib3tlZTHA/KGh9biQ2HfTQ/qXOgPrv7T8BY2w1TG+w/CDSMtBqUir9pw6OB+uGpidYdRVW3k0N0BzdlH6f5WRon6R3z3gvnPuMWU9HWBP9uWw/DtTglS+nUjwGTjmDfQ44asxT88jPK+aho7HwVd64HEYyv331UTeJoZQp1Bdc9A6WUxKbg124iSEJTshyZyZL6k+k2pN5Sk/X2psHzF6bYJLUUGZyKh4A8w6tsmFhCFYURv6/O29szjg+7io2V4w2FNjZyE+JwaCazN0VWdq1zL7jtDVyiflsIX2A+cvhiFG56zcQRSSNI+1Jwge0ChS+OBq8mySp6V8KDYx1Zuq5BH+agKcbbweFqJbpRxBw4ov0bn0nM43VpmLiI3OYakfx7DtcJDT0La0+4RDgMqUysR6ULHDGq17zR6KaTeD/5EFybNi6JItcdI8tb6u5QXGI7zvW0be5XSI=
X-OriginatorOrg: concurrent-rt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fed17b5e-b146-48ea-aec9-08d8073570a6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2020 20:42:17.9846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38747689-e6b0-4933-86c0-1116ee3ef93e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sJ6nZy8FJyo4ih/eYTPoN6zpVZq4T11qQGTBoMbX0S1vo+FWDVq5ZnPiib01oxGp2qGwBqSVeSkPVRVu+rg3oowQdbzx9zq+g+ztl28C4/8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4272
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The 05/13/2020 17:55, Paul Moore wrote:
> On Wed, Apr 29, 2020 at 4:29 PM <siarhei.liakh@concurrent-rt.com> wrote:
> >
> > From: Siarhei Liakh <siarhei.liakh@concurrent-rt.com>
> >
> > This change introduces a median() function which is then used to report
> > 25th, 50th, and 75th percentile metrics within distributions of hash table
> > bucket chain lengths. This allows to better assess and compare relative
> > effectiveness of different hash functions. Specifically, it allows to
> > ensure new functions not only reduce the maximum, but also improve (or, at
> > least, have no negative impact) on the median.
[ . . . ]
> > diff --git a/security/selinux/Kconfig b/security/selinux/Kconfig
> > index 9e921fc72538..57c427e019c9 100644
> > --- a/security/selinux/Kconfig
> > +++ b/security/selinux/Kconfig
> > @@ -115,3 +115,13 @@ config SECURITY_SELINUX_SID2STR_CACHE_SIZE
> >           conversion.  Setting this option to 0 disables the cache completely.
> >
> >           If unsure, keep the default value.
> > +
> > +config SECURITY_SELINUX_DEBUG_HASHES
> > +       bool "Print additional information about hash tables"
> > +       depends on SECURITY_SELINUX
> > +       default n
> > +       help
> > +         This option allows to gather and display additional information about
> > +         some of the key hash tables within SELinux.
> > +
> > +         If unsure, keep the default value.
> 
> I forgot to mention this earlier, but I think this is another case
> where we don't need to add another Kconfig option.

Right. What is your preferred way to control conditional inclusion of
code spread out across several files?

My issue is that there already are two different symbols which require
coordination to activate this functionality: DEBUG_HASHES defined and used
locally within policydb.c and simple DEBUG which is needed for pr_debug()
statements throughout the code.

Personally, I prefer something global and controlled from a single well-known
place, hence the Kconfig. However, I also see your point about reducing
Kconfig... But if not Kconfig, then what? Should I just create an additional
.h file with all SELinux-specific debug symbols and have it included
everywhere in SELinux?

How would you approach this?

Thank you.
-- 
Siarhei Liakh
Concurrent Real-Time
