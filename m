Return-Path: <SRS0=nqp0=3Z=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8192C35247
	for <selinux@archiver.kernel.org>; Wed,  5 Feb 2020 18:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D62924681
	for <selinux@archiver.kernel.org>; Wed,  5 Feb 2020 18:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="E28dHb8x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbgBESAf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 5 Feb 2020 13:00:35 -0500
Received: from UPDC19PA24.eemsg.mail.mil ([214.24.27.199]:47478 "EHLO
        UPDC19PA24.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727122AbgBESAe (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 5 Feb 2020 13:00:34 -0500
X-EEMSG-check-017: 54980487|UPDC19PA24_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,406,1574121600"; 
   d="scan'208";a="54980487"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by UPDC19PA24.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 05 Feb 2020 18:00:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1580925632; x=1612461632;
  h=subject:to:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding;
  bh=lgc4Gk7njj4RsvvcWxit3pEXgwlip7o+9F/1iDiMqpU=;
  b=E28dHb8x1MOuQJybDp1j6uKTSTZ++OGfjUySrREtG2rTzCwXcFuVcrs9
   xU7HUb4bVesRnXFOv3CGfiTPAD5AvS1/HzkLg7eyZXrAJ4RdAWCtOkyRI
   dycenINBp/QZf6vkjnwGZ4cX0j6RpRGECml95al2YkezUO0bYEqNYsgxU
   9A9QVuOQo3yQeXxfdolYnpz1iQVhicnrkn0OyEHrbfV8p1DCUR4n81fiv
   8cWK2Cmm/awQ2MRFwv0K15jmnTFwncBBX7ndzDfl8G/RB56qDpM614oXd
   +ErsBWmeoEdbAMPsqPdPAiHxTOjPzTEQWOYLJLrW4FchIz8EShTZha//a
   w==;
X-IronPort-AV: E=Sophos;i="5.70,406,1574121600"; 
   d="scan'208";a="38713083"
IronPort-PHdr: =?us-ascii?q?9a23=3AA+mn+h83q4KoQf9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B21eIcTK2v8tzYMVDF4r011RmVBNmdtqsP0rKO++C4ACpcuM3H6ChDOLV3FD?=
 =?us-ascii?q?Y9wf0MmAIhBMPXQWbaF9XNKxIAIcJZSVV+9Gu6O0UGUOz3ZlnVv2HgpWVKQk?=
 =?us-ascii?q?a3OgV6PPn6FZDPhMqrye+y54fTYwJVjzahfL9+Nhq7oRjeu8UMgYZuN6k9xg?=
 =?us-ascii?q?bVrndUZu9awX9kKU+Jkxvz+8u98oRv/zhMt/4k6sVNTbj0c6MkQLJCET8oKX?=
 =?us-ascii?q?o15MrltRnCSQuA+H4RWXgInxRLHgbI8gj0Uo/+vSXmuOV93jKaPdDtQrAvRT?=
 =?us-ascii?q?ui9aZrRwT2hyoBKjU07XvYis10jKJcvRKhuxlyyJPabY2JKPZzeL7Wct0ARW?=
 =?us-ascii?q?pFQ81fSSpPDI2hZIcLFuYNI+JVo4z7qlATrxWxGBOsCfvyxDFWiH/43a403e?=
 =?us-ascii?q?ovHg7J3gMvA90AvW/IrNj2LqoeTfy5wafKwDjFcvhY2S396I/Nch05vP+MQa?=
 =?us-ascii?q?x/cdLRyUYxEQPOk0ieqYn/MDOR0uQCrWia5PdnWOK0lmEnsBp8oiSvx8gwio?=
 =?us-ascii?q?nJgZgZylbf9Spj2oo1Ktq4SFBibNOiDZBeuSaaN45sTcMjRWFloCk6yrwauZ?=
 =?us-ascii?q?67YSgF044ryALYa/yCa4SI5wjsVOCTLDtig3JlYr2/ihCv+kaj0u3xTtS43V?=
 =?us-ascii?q?lFoyZfktTAq2oB2wLc58SZUPdx40Gs0iuV2Q/J8OFLO0U0mLLeK54m37E/iI?=
 =?us-ascii?q?IesV/GHi/qgEX2i7KWdlk89uio9evnZrLmq4eAN4BukAH+M7kumtelDeQ5NA?=
 =?us-ascii?q?gOUW+b+f+i27L/50H5XLVLgeE2kqneqpzaI9gUprWlDANP14Yj6hK/Ay+n0N?=
 =?us-ascii?q?Qeg3YHMEpIdA+IgoXmIV3DIO30Ae2hj1mjjjtn3e3KMqXkAprXL3jDlLnhfa?=
 =?us-ascii?q?x6605Z0Acz1s1Q54lPB7EdIPP8Rk/xtNvCAh8/KAy72fzrCNp61oMAQW6PGL?=
 =?us-ascii?q?OWMLvOsV+U4eIiO/WDZIAUuTb6Lfgq+eXugGQ2mV8aeqmp0p8XZ269Hvt8Ik?=
 =?us-ascii?q?WZZWDgjcsGEWcPpgA+VvDliEWeUT5PYHa/R7k86S8/CIKnC4fDW4+sjaef3C?=
 =?us-ascii?q?e0AJJWfHpKClOSHnfycYWLRfMMZDiVIs97nTxXHYSmHqQhzxC1qA7zzY1IsP?=
 =?us-ascii?q?bI4SYYuNq339dn4Ovejjk98jt7C8mY2mCJCWpzmzVMDyQ72KF5vFxV1FiOy+?=
 =?us-ascii?q?57juZeGNgV4OlGASkgMpuJ9PB3E9D/XEr6e96NTFu3CoG9DSoZUsM6w9hIZV?=
 =?us-ascii?q?10XdqlkEaQjGKRH7YJmunTV9QP+aXG0i20fZdw?=
X-IPAS-Result: =?us-ascii?q?A2BMDwCPAjte/wHyM5BlHAEBAQEBBwEBEQEEBAEBgXsCg?=
 =?us-ascii?q?XuBGFUgEiqEFYkDhmQGgTeJcI9RgXoJAQEBAQEBAQEBKwwBAYN7RQKCXjsDD?=
 =?us-ascii?q?QIQAQEBBAEBAQEBBQMBAWyFNwyCOymDAwEFIw8BBVELGAICJgICVwYBDAgBA?=
 =?us-ascii?q?YJjPwGCViUPrQqBMoVKg0iBPoEOKgGMO3mBB4E4D4JdPoJkAgGEdIJeBJgAl?=
 =?us-ascii?q?2aCRIJOhHyOcwYbg0CXSYRfigOIapRZAwyBWCsIAhgIIQ+DJwkWMRgNkhCFF?=
 =?us-ascii?q?IVdIwMwAo5NAQE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 05 Feb 2020 18:00:30 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 015HxaTF225940;
        Wed, 5 Feb 2020 12:59:38 -0500
Subject: Re: IPv6 netmask in nodecon statement
To:     =?UTF-8?Q?Christian_G=c3=b6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
References: <CAJ2a_DeHkT3i2dW=A_3MywTK+pqcEmYfRg4BLRHSKiUxiqjLZg@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <12cfbae0-cb21-dba2-969d-b5e1daae9f2f@tycho.nsa.gov>
Date:   Wed, 5 Feb 2020 13:01:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAJ2a_DeHkT3i2dW=A_3MywTK+pqcEmYfRg4BLRHSKiUxiqjLZg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/5/20 12:23 PM, Christian Göttsche wrote:
> Hi,
> 
> what is the correct way of specifying an ipv6 netmask in the nodecon statement?
> I am searching for a valid netmask for localhost (::1).
> 'fe80::/10' should be one, but since the syntax does not support any
> prefix-length, this is not compiling.
> Using 'fe80::' seems to work fine, but setools is complaining [1].
> Or should I use the full netmask: 'ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff' ?
> 
> 
> [1]: https://github.com/SELinuxProject/setools/issues/40

I think the userspace uses inet_pton(3) to convert both the mask and the 
address strings to values, so it would have to be something accepted by 
inet_pton(3).

In theory one could alter the userspace scanners/parsers and code to 
also support the slash notation and use inet_net_pton(3) instead for the 
mask.  Don't think that was available when we started or at least didn't 
know about it and it is a non-standard interface,
http://man7.org/linux/man-pages/man3/inet_net_pton.3.html




