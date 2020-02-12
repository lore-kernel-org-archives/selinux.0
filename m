Return-Path: <SRS0=d/HA=4A=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB23C352A4
	for <selinux@archiver.kernel.org>; Wed, 12 Feb 2020 19:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F93C21739
	for <selinux@archiver.kernel.org>; Wed, 12 Feb 2020 19:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="Fz1djrb4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbgBLT5r (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 Feb 2020 14:57:47 -0500
Received: from USFB19PA33.eemsg.mail.mil ([214.24.26.196]:12492 "EHLO
        USFB19PA33.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727361AbgBLT5q (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 12 Feb 2020 14:57:46 -0500
X-EEMSG-check-017: 55424289|USFB19PA33_ESA_OUT03.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,433,1574121600"; 
   d="scan'208";a="55424289"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USFB19PA33.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 12 Feb 2020 19:57:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1581537465; x=1613073465;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=0LU24A6kYTHbM8VuhZTogGkmGbMiR6tU5PeVyd5B8hI=;
  b=Fz1djrb4JCWOeelDhAoPlPavZONZZEb7lRmWNSK34bD8dJ4tmIvY9PtF
   MNZbfnMCBZ2S0X3OkHptBV6qXyuLBu/8D+CaCZppO4BotZqdLH1hoXihI
   fHkqGOWx+ffpExyKeiuOPaMA08gvmD+Jc3yuCn04ymtQbW0XsBo6S1ky1
   apyQQkhsbxzNk6sVRi++Yr6iFXV3E0kAO4iompQ05/ae4aRrIPoPS4uDa
   sjQssmNdLoR23sz1PWm8Q6/4ZE6C/ziR5tj0FPoknW3VfrLd65MHbh0TD
   L50ImhAZ82O34aMdb14v1TphkU0En5BY6XWhlkF18c/9nrkmvmZIMKSJr
   w==;
X-IronPort-AV: E=Sophos;i="5.70,433,1574121600"; 
   d="scan'208";a="39036873"
IronPort-PHdr: =?us-ascii?q?9a23=3ATQVqIRWByySN22pYPp2DcVk0fADV8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYZRSDvadThVPEFb/W9+hDw7KP9fy5BSpevN3Y6ypKWacPfi?=
 =?us-ascii?q?FGoP1epxYnDs+BBB+zB9/RRAt+Iv5/UkR49WqwK0lfFZW2TVTTpnqv8WxaQU?=
 =?us-ascii?q?2nZkJ6KevvB4Hdkdm82fys9J3PeQVIgye2ba9vIBmsogjdq8YbjZFjJ6sxxR?=
 =?us-ascii?q?fFv3VFd/pLzm50OFyfmArx6ci38JN/6Spbpugv99RHUaX0fqQ4SaJXATE7OG?=
 =?us-ascii?q?0r58PlqAfOQxKX6nQTTmsZnBxIAxPY7B7hRZf+rjH6tutm1yaEO8D9UK05Vi?=
 =?us-ascii?q?6j76dvTx/olTsHOjsk+2zZlsB8kKRWqw+6qhdh34Dbfp2aNPtmfqPcY9waQ3?=
 =?us-ascii?q?ZBXt1MXCBFG4+wcpcDA/YEMeteoYb9vV8OpgagCweqCu3k1ztEimbo0aA+1u?=
 =?us-ascii?q?gsFxzN0g49ENIUqHnascv7NKkSX+62wqfHwzrMYPFK1jny84XIbhIsrOuQUb?=
 =?us-ascii?q?5sf8fcy08iHB7FgFWKrozlOiuY2PkRs2eF9+pgVfygi2g6oA9spzig3MMsio?=
 =?us-ascii?q?3XiYMV11vJ8j55z5suJdCjVE56YcKrEJtXty2AMYt2WdktT3tnuCY91L0LoJ?=
 =?us-ascii?q?i2dzUExpQgwh7Qcf2Hc46Q7xLgSumROzF4i2xheL6lgBay60egx+vhXce3yF?=
 =?us-ascii?q?ZHtjdJn9bDu3wX1xHf99KLRuVy80u/wzqDygbe4fxeL08uj6rUMZshz6Y1lp?=
 =?us-ascii?q?oUrEvMADf7mF7zjK+KbkUk/fWo6/j/brXmuJCcM4h0hxniMqs0gMy/APk4Mh?=
 =?us-ascii?q?MUU2ia/+S82rrj/VbnT7pWlPE2jqnYv4zaJcQcvKK5BRNa0p0/5BqlCjem0d?=
 =?us-ascii?q?AYkWEGLFJDZh2Hk5DkN0zBLf33F/uyg0mgnC11y/3JILHtGIjBImDGkLj7fL?=
 =?us-ascii?q?Z970BcyBA0zdBa/59UEawOIOnoV0/ttN3XEh85Mwuuz+bhE9VyzJkSWW2IAq?=
 =?us-ascii?q?+HKK/Sq0OH5vozI+mQY48YoDH9K/0i5/71i382g0MScrey0JsNdn+3A/RmLF?=
 =?us-ascii?q?+FYXb2ntgBFmIKtBIkTOP2kF2CTSJTZ3GqUqIn+D47DIOmDYHeRoGim7GBwi?=
 =?us-ascii?q?i7EYNMZmxcCVCDD23od4OaVPcIci6SJdVhkjMcX7i7V4AhzQ2utBP9y7d/Nu?=
 =?us-ascii?q?rb4DAYtZb42dht/eLTiBUy+SVxD8Sa1GGNVX97knkUSD8x2aAs6XB6n3CF3b?=
 =?us-ascii?q?J1gbR9EsdV7vhEUU9uMpvb1OpzAN3aQA/Nft6VDl2hR4PiSSo8StM33s8mfU?=
 =?us-ascii?q?lwAZOhgwrF0i7sBKUa0/SzDYEwuofb2GL8b5JlwmvC/LEokl1jR8xIL2Dgja?=
 =?us-ascii?q?l6oVv9HYnMxn6Fmr6qeKJU5yvE8GOO3CLap01DeBJhWqXCG3YEbw3ZqsqvtR?=
 =?us-ascii?q?CKdKOnFblyalgJ8sWFMKYfL4Sz3Fg=3D?=
X-IPAS-Result: =?us-ascii?q?A2CIAgCSV0Re/wHyM5BmHAEBAQEBBwEBEQEEBAEBgXuBf?=
 =?us-ascii?q?YEYVSASKoQUiQOGZQEBAQEBAQaBN4lwkUoJAQEBAQEBAQEBLQoEAQGEQAKCb?=
 =?us-ascii?q?TgTAhABAQEFAQEBAQEFAwEBbIU3DII7KQGDAgEFIxVRCw4KAgImAgJXBgEMB?=
 =?us-ascii?q?gIBAYJjPwGCViUPrRmBMoQ1AYEUg0GBOAaBDiqMPnmBB4E4D4IoNT6ENYMmg?=
 =?us-ascii?q?jwiBI1iiWNGl2uCRIJPhH6OfgYcmxWOaIhulFAigVgrCAIYCCEPO4I4ATMTP?=
 =?us-ascii?q?RgNjigYiGSFXSMDMAIBjxyCQgEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 12 Feb 2020 19:57:43 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 01CJuk1G204055;
        Wed, 12 Feb 2020 14:56:47 -0500
Subject: Re: [PATCH v2 2/2] selinux: optimize storage of filename transitions
To:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>
References: <20200212112255.105678-1-omosnace@redhat.com>
 <20200212112255.105678-3-omosnace@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <1e3f5f2e-6af4-2f1c-af4f-2d057ebedbea@tycho.nsa.gov>
Date:   Wed, 12 Feb 2020 14:58:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200212112255.105678-3-omosnace@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/12/20 6:22 AM, Ondrej Mosnacek wrote:
> In these rules, each rule with the same (target type, target class,
> filename) values is (in practice) always mapped to the same result type.
> Therefore, it is much more efficient to group the rules by (ttype,
> tclass, filename).
> 
> Thus, this patch drops the stype field from the key and changes the
> datum to be a linked list of one or more structures that contain a
> result type and an ebitmap of source types that map the given target to
> the given result type under the given filename. The size of the hash
> table is also incremented to 2048 to be more optimal for Fedora policy
> (which currently has ~2500 unique (ttype, tclass, filename) tuples,
> regardless of whether the 'unconfined' module is enabled).
> 
> Not only does this dramtically reduce memory usage when the policy
> contains a lot of unconfined domains (ergo a lot of filename based
> transitions), but it also slightly reduces memory usage of strongly
> confined policies (modeled on Fedora policy with 'unconfined' module
> disabled) and significantly reduces lookup times of these rules on
> Fedora (roughly matches the performance of the rhashtable conversion
> patch [1] posted recently to selinux@vger.kernel.org).
> 
> An obvious next step is to change binary policy format to match this
> layout, so that disk space is also saved. However, since that requires
> more work (including matching userspace changes) and this patch is
> already beneficial on its own, I'm posting it separately.
> 
> Performance/memory usage comparison:
> 
> Kernel           | Policy load | Policy load   | Mem usage | Mem usage     | openbench
>                   |             | (-unconfined) |           | (-unconfined) | (createfiles)
> -----------------|-------------|---------------|-----------|---------------|--------------
> reference        |       1,30s |         0,91s |      90MB |          77MB | 55 us/file
> rhashtable patch |       0.98s |         0,85s |      85MB |          75MB | 38 us/file
> this patch       |       0,95s |         0,87s |      75MB |          75MB | 40 us/file
> 
> (Memory usage is measured after boot. With SELinux disabled the memory
> usage was ~60MB on the same system.)
> 
> [1] https://lore.kernel.org/selinux/20200116213937.77795-1-dev@lynxeye.de/T/
> 
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

[...]
