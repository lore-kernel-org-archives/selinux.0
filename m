Return-Path: <SRS0=qygk=4C=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F023C2BA83
	for <selinux@archiver.kernel.org>; Fri, 14 Feb 2020 13:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D41032187F
	for <selinux@archiver.kernel.org>; Fri, 14 Feb 2020 13:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="PNoyjdWg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgBNNSx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 14 Feb 2020 08:18:53 -0500
Received: from USFB19PA32.eemsg.mail.mil ([214.24.26.195]:64482 "EHLO
        USFB19PA32.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728452AbgBNNSx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 14 Feb 2020 08:18:53 -0500
X-EEMSG-check-017: 56494688|USFB19PA32_ESA_OUT02.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,440,1574121600"; 
   d="scan'208";a="56494688"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USFB19PA32.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 14 Feb 2020 13:18:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1581686332; x=1613222332;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=P3N9ytbWCHfZKo+6tcT0wJkmWcogZ8QoAj49wG7FU84=;
  b=PNoyjdWgVK30A/HxiC/w1BrUlR1RApEvyjjDfyreJz453LJ+b2hh9gsY
   3gSvyJf/75OvhY1/TKgES2I/GEAlGNQJOmz2z3H/nvw2RePyc5Wghus7r
   xYefaS6UJLhXJB/o6Rx8jMdCTvZoz3/YUR7J6wQ3k7kld5kyruYLLYE94
   vAN3jOJPnYoa5ARm8JrwZNsFlg5gCM/AauyQz3e1UEjzhDkwlahSnnD1Y
   auJMgBV8C09Y18Rxvcu8TjUGZBv+aa573o3QpAaBdjVbp15b393ClxMEE
   7dyAta27hsp/CMFIelnC0GM+ym3opDFZJu6d96daIUl7HpYujUS+I2g19
   g==;
X-IronPort-AV: E=Sophos;i="5.70,440,1574121600"; 
   d="scan'208";a="39126248"
IronPort-PHdr: =?us-ascii?q?9a23=3AGvqC0R3KwbzYdGnCsmDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZseMVL/ad9pjvdHbS+e9qxAeQG9mCt7Qb06GK4ujJYi8p39WoiDg6aptCVh?=
 =?us-ascii?q?sI2409vjcLJ4q7M3D9N+PgdCcgHc5PBxdP9nC/NlVJSo6lPwWB6nK94iQPFR?=
 =?us-ascii?q?rhKAF7Ovr6GpLIj8Swyuu+54Dfbx9HiTagbr5+Nhe7oRneusQZhYZpN7o8xA?=
 =?us-ascii?q?bOrnZUdOtawn9lK0iOlBjm/Mew+5Bj8yVUu/0/8sNLTLv3caclQ7FGFToqK2?=
 =?us-ascii?q?866tHluhnFVguP+2ATUn4KnRpSAgjK9w/1U5HsuSbnrOV92S2aPcrrTbAoXD?=
 =?us-ascii?q?mp8qlmRAP0hCoBKjU063/chNBug61HoRKhvx1/zJDSYIGJL/p1Y6fRccoHSW?=
 =?us-ascii?q?ZdQspdUipMDY2mb4sLEuEPI+BWoYfgrFcKtBezBQ2hCObpxzRVhHH5wLc63v?=
 =?us-ascii?q?w8Hw/Y0gwuH9EAvnrao9r6NqgdTe+7wbLUzTjBdf5axSvx5YbKfx0nvPqCXa?=
 =?us-ascii?q?hwcc3UyUQ3Cg3FkkufqZTlPzyL0OQGrnWV7+96WuKrj24otQFwqSWoy8c3l4?=
 =?us-ascii?q?bJnZkYykzE9CplwIY1Ise0SEhgYdG+CpdQuCaaN5VvT84kXmpmuz46x6UbtZ?=
 =?us-ascii?q?O0cyUG0pQqywPFZ/CZfIWE/AjvWPuXLDxlnnxqYqi/iAy38UW4z+38UdS730?=
 =?us-ascii?q?hSoypel9nMqmgN1xvO6sibUvd9/lmu2TKI1w3L9uFLO1o0lavGK5462LIwl5?=
 =?us-ascii?q?wTsUrEHi/thkr5kLWadlkk++e06+TnZa/qppmAOI9vlg7yKKEums27AeggMw?=
 =?us-ascii?q?gOWXaU+fik2bH+8kD0T69Gg/0rnqXDrpzXKtoXqrSkDwNN14Ys8Re/DzOo0N?=
 =?us-ascii?q?QCmnkHKUpIeAmagIjyIFzOPPD5Auu/g1SrijtrwevGMaf7DpXCKXjDjq/tfa?=
 =?us-ascii?q?xh5E5E1Aoz0ddf6opMCr4bPfLzXlT8tMTCAR8kNwy42uPnCNJ61oMER22DGL?=
 =?us-ascii?q?OWMKTXsVWQ/OIgP/GMZJMJuDb6M/Ul/ODhjXs4mV8bYKmo0oAaaG63Hvt4OU?=
 =?us-ascii?q?WVe3nsjckbEWcMoAU+SPbmiFqYUT5cf3yyRb4z5iknCIK6CofOXoetgLmG3C?=
 =?us-ascii?q?egGJ1ZfHxJBU6XHHfyaYqLRvcMZziOIsN7jjMEUr2hGMcd0kSWvRL+g59gKf?=
 =?us-ascii?q?DZsnkAvI/n/MB8+umWkBY17zEyBMOYhTKjVWZxy1gUSic20aY3mkl0zlOOwO?=
 =?us-ascii?q?AsmPBDPcBC7PNOFAEhPNjTyPIsWIO6YR7IYtrcEAXued6hGzxkC4tsktI=3D?=
X-IPAS-Result: =?us-ascii?q?A2ByAgD2nEZe/wHyM5BmHAEBAQEBBwEBEQEEBAEBgXuBf?=
 =?us-ascii?q?YFtIBKEPokDhloBAQQGgTeJcI9jgWcJAQEBAQEBAQEBNwQBAYRAAoIlOBMCE?=
 =?us-ascii?q?AEBAQUBAQEBAQUDAQFshUOCOykBgwEBAQEBAgEjFUEFCwsYAgImAgJXBg0IA?=
 =?us-ascii?q?QGCYz+CVwUgrQR1gTKFSoNNgT6BDiqMPnmBB4ERJw+BX34+hBYBEgGDMYJeB?=
 =?us-ascii?q?JdHRpdtgkSCT5N8BhybGKwnImdxKwgCGAghD4MoTxgNnQEjA45WgjIBAQ?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 14 Feb 2020 13:18:50 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 01EDHsFN081349;
        Fri, 14 Feb 2020 08:17:54 -0500
Subject: Re: [PATCH v2] selinux: remove unused initial SIDs and improve
 handling
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org, omosnace@redhat.com
References: <20200129164256.3190-1-sds@tycho.nsa.gov>
 <966793d8-4bd2-5d3e-d674-d900c0728f98@tycho.nsa.gov>
 <CAHC9VhSQ4K-rVe=Y2wwk=7oY-6r67_M8DMo1VvyYUsXD-FOiUg@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <eddd809f-a388-249e-35d2-244ff1870629@tycho.nsa.gov>
Date:   Fri, 14 Feb 2020 08:19:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAHC9VhSQ4K-rVe=Y2wwk=7oY-6r67_M8DMo1VvyYUsXD-FOiUg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/13/20 5:34 PM, Paul Moore wrote:
> First let me climb up on my current favorite soapbox ... This is a
> perfect example of an email where you could have trimmed the bulk of
> it in your reply to the original patch posting. ;)

Ah, sorry about that.  On the positive side, I have definitely increased 
how often and how much I am trimming.  I just don't always remember still.

> Yes, I've been somewhat avoiding this patch simply because I'm not yet
> sure what I think of all this yet, and since it affects the
> kernel-userspace API it needs some careful thought.  In other words,
> yes, I see this patch and the associated GH issue, but no I don't have
> any real comments yet.
> 
> Sorry.

FWIW, this patch alone doesn't truly change the userspace API (aside 
from making it possible to add new initial SIDs in the future without 
errors, which in fact is just restoring to the behavior we had 
originally).  It just removes things that are never used and lays the 
groundwork for future evolution.



