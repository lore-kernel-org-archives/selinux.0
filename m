Return-Path: <SRS0=fAir=37=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B274C352A3
	for <selinux@archiver.kernel.org>; Tue, 11 Feb 2020 15:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2DE920675
	for <selinux@archiver.kernel.org>; Tue, 11 Feb 2020 15:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="FZTJ1jJF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbgBKPDh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Feb 2020 10:03:37 -0500
Received: from UPDC19PA24.eemsg.mail.mil ([214.24.27.199]:34845 "EHLO
        UPDC19PA24.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbgBKPDh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Feb 2020 10:03:37 -0500
X-EEMSG-check-017: 57751647|UPDC19PA24_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,428,1574121600"; 
   d="scan'208";a="57751647"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA24.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 11 Feb 2020 15:03:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1581433412; x=1612969412;
  h=subject:to:references:cc:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=3e2UX75hVK7e4IXfR2MQCMhra/YORn0osj8blcCS1xc=;
  b=FZTJ1jJFqfGauqFHOO0i5lBqkZtI7DZbydjfWHUOw3Wzr36rMfxJG1P1
   /psoUTFnT+xSvKw6E5Bh/uPz9LHls1jsgIkB41CKz0vPVzqtwMEs9wdYm
   sbCpqZzP16TOeKDYsATelGX++d8U6iAY2vF8GRxMBumjN/s4KDxpKG+2L
   w1Itz+iPCjS376eTpwXKefUYojxmmLKCmsrs9RWCR4SJ6qofgcTjkmrCU
   g1DpsAdFL8MhQFA7rkJlrchE+b40eVZssprxn3l532CDPdQn2mKEiEjIx
   NRFSDjSg4mWrWz1Zi/CS5mdyW3D8+Yd5Rt4OVyDXfTUhX+7WapeOQMSOe
   Q==;
X-IronPort-AV: E=Sophos;i="5.70,428,1574121600"; 
   d="scan'208";a="38948806"
IronPort-PHdr: =?us-ascii?q?9a23=3A8cTG8xVTtKStnXYc5k3TUQw9HDDV8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYZRSHv6dThVPEFb/W9+hDw7KP9fy5BSpeut3f4DgrS99laV?=
 =?us-ascii?q?wssY0uhQsuAcqIWwXQDcXBSGgEJvlET0Jv5HqhMEJYS47UblzWpWCuv3ZJQk?=
 =?us-ascii?q?2sfQV6Kf7oFYHMks+5y/69+4HJYwVPmTGxfa5+IA+5oAnMucQam4pvJ6g+xh?=
 =?us-ascii?q?bIoXZDZvhby35vKV+PkBnw4du98oR++CpKofIh8MBAUaT+f6smSLFTESorPW?=
 =?us-ascii?q?Mo6sD1rBfPVQSA6GcSXWUQiRpIHhPK7ArmUZfrsyv1rfRy1S+HNsDrV780WD?=
 =?us-ascii?q?Ci76B2SB/0jSoMKjA0/H3LhsF2kalWuwyqqQBhzIHIYYGVLPt+cb3bfdMGXm?=
 =?us-ascii?q?pKQ8JdWzVcDo+gc4cDCuwMMuhCr4n5ulAAsx2wCwexD+/r0zNFiHv70ag83u?=
 =?us-ascii?q?88Ew/JwRYgEsoTvnrKotX7NKQcX+67w6bHzzrMc/xY1Czh6IXKaB0tve2AUL?=
 =?us-ascii?q?xyfMfX1EIhFxnFjlKVqYH9Ij2VyvoCs3Cb7+V+U+KklnMpqwRrrTirwscjlI?=
 =?us-ascii?q?nIjZ8Sx1Df6Cp52504JcG4SUFnYd6kF4FctyeBN4RsWM8iTGZouDgjx7AApJ?=
 =?us-ascii?q?W1ci8KyJE9yB7ebfyKa4eI4hP/VOaRPDd3n2hpd664hxa390Wr1+7yVtGs3V?=
 =?us-ascii?q?pXoSdIncPAu3AQ2xDJ9MSKReVx8l281TuJygvd8PtLIVoumqreM5Mhx7kwmY?=
 =?us-ascii?q?cNvknbBS/2nVn2jLeRdkU55uik8+Tnbavipp+bL4J0lhvxMr4vmsyiGuQ0KA?=
 =?us-ascii?q?kOX26V+eS7z73s41H2TK9Wjvw2jqbZsJfaKd4dpqGlGA9azpwv6xO+DzeiyN?=
 =?us-ascii?q?gYnH8HI0xZeB+fkoTkNF7DLOr4APuimVigjjhmy+7cMrH8GpnNK2LMkLblfb?=
 =?us-ascii?q?Zz8U5czw8zwMhE551JEbEMO+7zW0/tu9zYCR81KQq0w/39B9ln2YMeXnyPDr?=
 =?us-ascii?q?eDMKzOqV+I+v4vI+6UaY8NvDbyMeUl5+L0jXAig1AQZrOp0oUKZ3C4BPtmP1?=
 =?us-ascii?q?+VbmbrgtcECW0KpBYxTPT2iF2eVj5ef22yULw45jE6DoKmEIjCS5uzgLyOwi?=
 =?us-ascii?q?i7BIdaZmNYBVCWF3fnaYGEV+0LaCKILc9riiYEWqS5S489yRGusxf3y71iLu?=
 =?us-ascii?q?rT4S0Ys4js28Rr6ODIjxE96yF7D8SH3GGRVW17gmQIRzpllJx49HRw1k3L9a?=
 =?us-ascii?q?Fln+ZSHNdTr6dRVg4nKYTWxsRgBtzyUx6HddCMHhLuWdiiADcsXvovzNIUJU?=
 =?us-ascii?q?VwAdOvilbExSX5LaUSkumwGJEs8q/al0P0LsJ5xmeOgLItlHE6U8BPMiugna?=
 =?us-ascii?q?c5+A/NUd2a236FnrqnIPxPlBXG832OmC/X5xBV?=
X-IPAS-Result: =?us-ascii?q?A2DjAgCou0Je/wHyM5BmHAEBAQEBBwEBEQEEBAEBgXuBf?=
 =?us-ascii?q?YEYVSASKoQViQOGaAEBAQaBN4lwiieHJAkBAQEBAQEBAQErDAEBg3tFAoJrO?=
 =?us-ascii?q?BMCEAEBAQQBAQEBAQUDAQFshTcMgjspAYMCAQUjFUEQCw4KAgImAgJXBgEMB?=
 =?us-ascii?q?gIBAYJjPwGCViUPqxqBMoVKgzaBOAaBDiqMPXmBB4E4D4JdPoJkAoR1gl4El?=
 =?us-ascii?q?0JGl2qCRIJOhH6OegYbmw8tjjeIbJRKIoFYKwgCGAghD4MnUBgNkhCKcSMDM?=
 =?us-ascii?q?I5oAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 11 Feb 2020 15:03:29 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 01BF2Xnc181333;
        Tue, 11 Feb 2020 10:02:33 -0500
Subject: Re: [PATCH v5] libselinux: Eliminate use of security_compute_user()
To:     Petr Lautrbach <plautrba@redhat.com>, selinux@vger.kernel.org
References: <20200211101438.403297-1-plautrba@redhat.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <46e177f4-bd5b-5c69-f8a6-acf1736bc62e@tycho.nsa.gov>
Date:   Tue, 11 Feb 2020 10:04:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200211101438.403297-1-plautrba@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/11/20 5:14 AM, Petr Lautrbach wrote:
> get_ordered_context_list() code used to ask the kernel to compute the complete
> set of reachable contexts using /sys/fs/selinux/user aka
> security_compute_user(). This set can be so huge so that it doesn't fit into a
> kernel page and security_compute_user() fails. Even if it doesn't fail,
> get_ordered_context_list() throws away the vast majority of the returned
> contexts because they don't match anything in
> /etc/selinux/targeted/contexts/default_contexts or
> /etc/selinux/targeted/contexts/users/
> 
> get_ordered_context_list() is rewritten to compute set of contexts based on
> /etc/selinux/targeted/contexts/users/ and
> /etc/selinux/targeted/contexts/default_contexts files and to return only valid
> contexts, using security_check_context(), from this set.
> 
> Fixes: https://github.com/SELinuxProject/selinux/issues/28
> 
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

This looks fine to me; I'll wait to see if Ondrej has any further 
comments, but you can add my:

Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

Then maybe in a decade we can actually remove /sys/fs/selinux/user...

