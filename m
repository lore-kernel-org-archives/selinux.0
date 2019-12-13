Return-Path: <SRS0=c00g=2D=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89712C5ED65
	for <selinux@archiver.kernel.org>; Fri, 13 Dec 2019 20:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD58C2473D
	for <selinux@archiver.kernel.org>; Fri, 13 Dec 2019 20:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="dvOIVLEg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbfLMPxF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 13 Dec 2019 10:53:05 -0500
Received: from UPDC19PA22.eemsg.mail.mil ([214.24.27.197]:29330 "EHLO
        UPDC19PA22.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727927AbfLMPxF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 13 Dec 2019 10:53:05 -0500
X-EEMSG-check-017: 37977398|UPDC19PA22_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.69,309,1571702400"; 
   d="scan'208";a="37977398"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UPDC19PA22.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 13 Dec 2019 15:53:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1576252382; x=1607788382;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=RHoHqmXXMWBzpbL6QLyO0OIOOvPxvRD6+xia5a7mUI0=;
  b=dvOIVLEgCwgjf59klO5k9u5ufqfi2PrEFgyajdxTFx7voyFgXl3H/ilY
   RZm5hrjLd7fvo+phQjUu5NRW7ZbE3h/aBZIwO7+tP4r6KeKo9cNoYaKAc
   SM+2LOIBd6SR+ZwPbLCqGtGhMSoGDTBt4K4QyZeyaMnaIUwErPDt8Gy8k
   gKdcOpRvHNLaDiiriFf91pn0WVLxkyn5k5H54oHjAbJ7iZMtgMqp2sdXx
   gSEufes1rgx/kl1S8wQkTjw2IAvZnA6k8M3qEbUB0bO6y1Qf5Cm6kR7nV
   beXBAxTS/hXPfnVBT25eJk/pIH17ENijIEBCn/u8n1G59jcXcHxIQizrz
   Q==;
X-IronPort-AV: E=Sophos;i="5.69,309,1571702400"; 
   d="scan'208";a="31085695"
IronPort-PHdr: =?us-ascii?q?9a23=3AbZd13h/SJ3DS//9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B+0ugfIJqq85mqBkHD//Il1AaPAdyArasV2qGG6+jJYi8p2d65qncMcZhBBV?=
 =?us-ascii?q?cuqP49uEgeOvODElDxN/XwbiY3T4xoXV5h+GynYwAOQJ6tL1LdrWev4jEMBx?=
 =?us-ascii?q?7xKRR6JvjvGo7Vks+7y/2+94fcbglVijexe65+IRGyoAnetcQanZZpJ7osxB?=
 =?us-ascii?q?fOvnZGYfldy3lyJVKUkRb858Ow84Bm/i9Npf8v9NNOXLvjcaggQrNWEDopM2?=
 =?us-ascii?q?Yu5M32rhbDVheA5mEdUmoNjBVFBRXO4QzgUZfwtiv6sfd92DWfMMbrQ704RS?=
 =?us-ascii?q?iu4qF2QxLzliwJKyA2/33WisxojaJUvhShpwBkw4XJZI2ZLedycr/Bcd8fQ2?=
 =?us-ascii?q?dOUNxRVyhcCY2iaYUBAfcKMeJBo4Tzo1YCqB2zDhSuCuzy0D9FnmL407M00+?=
 =?us-ascii?q?ohEg/I0gIvEN0Mv3vIo9v4L7sSXOOvwaXU0TnOYfFb1DHg44bIaBAhpvSMUK?=
 =?us-ascii?q?ptf8rN10YvDwPFgUuWqYf4Ij2V0/4Cs2yf7+V+VeOklmkqqxpsrTi03coslo?=
 =?us-ascii?q?nIiZ4VylDD7yl5xp01KseiRE50Zt6kDoJduieHPIV4RcMiRntnuCc8yrAevZ?=
 =?us-ascii?q?66ci4KxI4hxxHBd/yKdZWD7BH7VOuJPDt1i31odKi/ihqv60Ss1OLxWteu3F?=
 =?us-ascii?q?pXqCdOj8PCuWoX1xPJ78iKUv59/kC81jmRzw3T8eREIVwslarcNp4h3qY8lp?=
 =?us-ascii?q?oNvkTHGS/7gFn2g7WMdkUl5+io8P7rYrTgpp+SMI90kR/xPbg0lsyjAeU3Lg?=
 =?us-ascii?q?gOX2+B9eS6yLLj5lH2TK9Pjv03lqnVqJHaJcIFqa6lGwJZz4ku5hmlAzqmzd?=
 =?us-ascii?q?gUh2cLIV1bdB6dkoTlI1TOL+r5Dfe7jVSsijBrx/XeM736H5rNNWPOkKvhfL?=
 =?us-ascii?q?lh605czxA/zdZE551OEL0BL/XzWlHpuNzCEhA5KxC0w/rgCNhl2IIRR2SPAq?=
 =?us-ascii?q?+EMKPTqlKI6ewuI+yWa48UvDbxMfcl5vDzjXMjh1ASYLSp14MNaH+kBvRmP1?=
 =?us-ascii?q?mZYX30j9cZC2gKow4+QffyiFKYTD5TY2++X6c75jE8EoKpE53PSZyqgLyExC?=
 =?us-ascii?q?27BIFZZnhaClCQFnflb56EVOkIaCKTJM9hjzMFWKO/S48uyx6urhX2y7l5Ie?=
 =?us-ascii?q?rO/C0Xq5bj2MJy5+3JmhE47SZ0ANiF02GRU2F0mXsFRzwo069hukxy1lCD0a?=
 =?us-ascii?q?97g/FDCdNT5+lJUgA/NZ7d0ux6Dsr+WgXbfteGUFymWMmpASktTtItxN8De0?=
 =?us-ascii?q?R9FMusjhDNwSqnGLAVl7uMBJw79qLTwWL9KNp6y3bDzKMhlUUpQtNTNW26ga?=
 =?us-ascii?q?5y7w/TB4vOk0WCkaalb7gT0zDW+WeZ02WBoUFYXxRsUanfQX8fYU7W/pzF4R?=
 =?us-ascii?q?b9QrmuFLVvAAtIz8HKfrRHbN30jH1JW/LqOdCYbH2s3Wq8GEDb6KmLad/RZ2?=
 =?us-ascii?q?gF3CjbQHMBmgQX8GfOYRMyHQ+9smneC3poDlupbETyp7ot4EinR1M5mlnZJ3?=
 =?us-ascii?q?Zq0KC4r1tM3q2R?=
X-IPAS-Result: =?us-ascii?q?A2CHAgClsvNd/wHyM5BlDg4BAQEBAQcBAREBBAQBAYF+g?=
 =?us-ascii?q?XSBGFUgEiqEA4kDhm8BAQEBAQEGgRIlgQGIaJFGCQEBAQEBAQEBAScQAQGEQ?=
 =?us-ascii?q?AKCMzgTAhABAQEEAQEBAQEFAwEBbIU3DII7KQGCeQEBAQECASMPAQVBEAsYA?=
 =?us-ascii?q?gIjAwICRhEGDQYCAQGCXz8BglIFIKw0dYEyhDoBCwGBCIMygUIGgQ4ojDJ5g?=
 =?us-ascii?q?QeBEScMA4IoNT6CZAEDhHGCXgSNFoJbh1iXJoI6gjyEaI5PBhuaQZcXlAIig?=
 =?us-ascii?q?VgrCAIYCCEPgycfMREUlV6FP1kjAzCQGwEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 13 Dec 2019 15:53:01 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id xBDFqhB1262840;
        Fri, 13 Dec 2019 10:52:44 -0500
Subject: Re: Does anyone use RANDSTRUCT?
To:     Wenhui Zhang <wenhui@gwmail.gwu.edu>
Cc:     Paul Moore <paul@paul-moore.com>,
        SELinux <selinux@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Ondrej Mosnacek <omosnace@redhat.com>
References: <bf727420-b7bd-d3e9-a597-812922ba20a3@tycho.nsa.gov>
 <CAOSEQ1qhxdA+JW4M6rOqjzTuMXu2hr0jxRt9NfkuEcWW7-_BEQ@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <8d3101fa-745b-d709-4196-e3492c975986@tycho.nsa.gov>
Date:   Fri, 13 Dec 2019 10:53:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAOSEQ1qhxdA+JW4M6rOqjzTuMXu2hr0jxRt9NfkuEcWW7-_BEQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 12/13/19 10:45 AM, Wenhui Zhang wrote:
> It seems like most of Selinux functions are static inline , no symbols 
> are exposed to symbol table.
> IMHO, randomization is not necessary if not reflected in symbol table ?

RANDSTRUCT isn't about randomization of code; it is about randomization 
of data structure layout. See https://lwn.net/Articles/722293/ for some 
background.

Also, your assumption is wrong but that's not germane to this thread so 
I won't discuss it further here.

> 
> On Fri, Dec 13, 2019, 10:41 AM Stephen Smalley <sds@tycho.nsa.gov 
> <mailto:sds@tycho.nsa.gov>> wrote:
> 
>     See $(subject). If yes, there are some obvious candidates among the
>     SELinux data structures for randomized layouts to avoid fixed locations
>     for enforcing, initialized, etc.  If not, then no point in pursuing it.
>     Doesn't look like Fedora enables it, probably because they'd have to
>     publish the random seeds anyway for third party kernel modules.  But
>     maybe it would be useful for some distros/users?  ChromeOS?  Android?
> 

