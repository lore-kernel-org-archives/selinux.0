Return-Path: <SRS0=6oqa=Y7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4625EC5DF60
	for <selinux@archiver.kernel.org>; Thu,  7 Nov 2019 18:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0522B21882
	for <selinux@archiver.kernel.org>; Thu,  7 Nov 2019 18:07:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="h90puFGM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725813AbfKGSHj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 7 Nov 2019 13:07:39 -0500
Received: from UCOL19PA37.eemsg.mail.mil ([214.24.24.197]:34420 "EHLO
        UCOL19PA37.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbfKGSHj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 7 Nov 2019 13:07:39 -0500
X-EEMSG-check-017: 46963521|UCOL19PA37_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.68,278,1569283200"; 
   d="scan'208";a="46963521"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UCOL19PA37.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 07 Nov 2019 18:07:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1573150051; x=1604686051;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=vvLmVeVv8Dr6Rhn9vieimlXxOpHGAsRhdMhrv4fUeRc=;
  b=h90puFGMl7I/HF4k3EwgLq29q04jXhq5iP1j9NDYCaXeOXSCpf0KLYf5
   b3+/8y/q1TX4Rt+MH04gP6W5QY+AFu4zGMMqrGbMzmIXGh7FZb9du/1zj
   7JO7e29NUOjqWqHIWvCsKsQmUFDQOqMDMp7BAnliaBn58Y/Y6pSb7TR7R
   bDjnfU1TR87DDOebsprpjO7FS5G0T9YV/p3UlYpG0BGmJRPBAQj4cLo0X
   C7cw+ufojfj3IiFYYgIt9isGmLy6DQBrOdInpFWPtxhKcNvGHUMMaQLjv
   1Brz2xB/qY16moPkYX8wAT1bw8/qz/tCBlRPFax6fgdmCfXQboZjmZZ6P
   w==;
X-IronPort-AV: E=Sophos;i="5.68,278,1569283200"; 
   d="scan'208";a="29880844"
IronPort-PHdr: =?us-ascii?q?9a23=3AZIfWbRYkLXbyoAuIMSZpQ/j/LSx+4OfEezUN45?=
 =?us-ascii?q?9isYplN5qZr8q4bnLW6fgltlLVR4KTs6sC17ON9fm5CCdZucjJmUtBWaQEbw?=
 =?us-ascii?q?UCh8QSkl5oK+++Imq/EsTXaTcnFt9JTl5v8iLzG0FUHMHjew+a+SXqvnYdFR?=
 =?us-ascii?q?rlKAV6OPn+FJLMgMSrzeCy/IDYbxlViDanbr5+MRu7oR/MusULhYZuJbs9xg?=
 =?us-ascii?q?fIr3BVZ+lY2GRkKE6JkR3h/Mmw5plj8ypRu/Il6cFNVLjxcro7Q7JFEjkoKn?=
 =?us-ascii?q?g568L3uxbNSwuP/WYcXX4NkhVUGQjF7Qr1UYn3vyDnq+dywiiaPcnxTbApRT?=
 =?us-ascii?q?Sv6rpgRRH0hCsbMTMy7XragdJsgq1FvB2hpgR/w4/Kb4GTKPp+Zb7WcdcDSW?=
 =?us-ascii?q?ZcQspdSylND4WyYIsVC+oKIPhWoY/zqVATqReyHAmhCefqxjJOm3T437A10/?=
 =?us-ascii?q?45HA/bwgIgEdIAvnfaotr7O6gdU/y6wqbTwDXfbf5bwyvx5JTGfx0jp/yHQL?=
 =?us-ascii?q?J+cdDWyUkqDw7Lk0mQppL9PzOVyOsNtXWQ4fdlVe21j24nrx9+oziyzcorkY?=
 =?us-ascii?q?nGm5kVx0vY9SR53Ik1Jdq4RFR9Yd6/CpRcrS6aN4xoQs47RWxjpSU0yqUetJ?=
 =?us-ascii?q?KmcyUHx44ryh7CZ/CdbYSF7QzvWPyMLTp+mXlrYqiwhwyo/kil0uD8U86030?=
 =?us-ascii?q?tUoSddidnMs2wN1wTU6siaVvtx5keh1iiL1wDU8uxEPVo7lbDaK5482b48jI?=
 =?us-ascii?q?YTsETfES/2n0X6lqmWeVk/+ue08ejnZ7TmppuEO491jAHxLLgul9SiDek3PQ?=
 =?us-ascii?q?UCRWiW9fmm2LH98kD1Xq9GguAunqncqp/aJMAbpqCjAw9S14Yu8w2/ACq90N?=
 =?us-ascii?q?kDgXkGLE5KeBKAj4TzPVHOO+r3Ae2wg1Srjjdn3+rGMaH5ApXRMnjDl6/sfa?=
 =?us-ascii?q?5n5E5BzAo+1shf6IhJCrEFOf7zX0jxtNvCDhAnKQC73+HnCNBl3IMERW2PGr?=
 =?us-ascii?q?OZML/VsVKQ/eIgPe2MZI4TuDbgJPko/ODujXAnll8HZ6Wp3oUYaGq+Hvt4J0?=
 =?us-ascii?q?WVe33sgs0OETRCgg1rdOX3jBWnVjlJaj7mR6sh4hkjAZ+iSILEQZqgxreG2X?=
 =?us-ascii?q?HoMIdRYzV9Fl2UEXruP76BUvMIZTPadtRtiRQYRLOhTMknzhjouwjknek0Zt?=
 =?us-ascii?q?HI8zEV4MqwnON+4PfewFRrqG15?=
X-IPAS-Result: =?us-ascii?q?A2CgAABqXMRd/wHyM5BkHAEBAQEBBwEBEQEEBAEBgW0EA?=
 =?us-ascii?q?QELAYFzLIFBMiqEKZEFJYlkkUMJAQEBAQEBAQEBNAECAQGEQAKEDiQ3Bg4CD?=
 =?us-ascii?q?gEBAQQBAQEBAQUDAQFshUOCOykBgmwBAQEBAgEjFUEQCxgCAiYCAlcGDQYCA?=
 =?us-ascii?q?QGCXz+CUwUgsgp1gTKFToMzgUiBDigBjBMYeIEHgREnDIJfPodVgl4ElWZhR?=
 =?us-ascii?q?ZZ4gi6CNpMFBhuZcqpAI4FYKwgCGAghD4MnUBEUkEIXFY4sIwMwgQUBAZAuA?=
 =?us-ascii?q?QE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 07 Nov 2019 18:07:31 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id xA7I7Tmb003789;
        Thu, 7 Nov 2019 13:07:29 -0500
Subject: Re: [RFC PATCH] selinux: add SELinux hooks for lockdown integrity and
 confidentiality
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org
References: <20191030131633.9356-1-sds@tycho.nsa.gov>
 <CAHC9VhQG=2VwJiM=LrZxZaSXWELbsu61pw2ynNgL0NAO+SvYMA@mail.gmail.com>
 <de944969-6d9f-8fbd-ffe1-4f9bdd7410f2@tycho.nsa.gov>
 <CAHC9VhSzoDnHK+fDXocShQALW32ctoOOC7GOeb_tEQsnm-1d0g@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <14181dcc-aa6f-8fbb-6244-08ed39591f30@tycho.nsa.gov>
Date:   Thu, 7 Nov 2019 13:07:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAHC9VhSzoDnHK+fDXocShQALW32ctoOOC7GOeb_tEQsnm-1d0g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 11/7/19 12:48 PM, Paul Moore wrote:
 > On Thu, Oct 31, 2019 at 10:01 AM Stephen Smalley <sds@tycho.nsa.gov> 
wrote:
> That is an interesting question: do we consider dmesg output to be
> part of the stable kernel API?  My hunch would be "no", as I've seen
> things change quite a bit there over the years, but IANL (I Am Not
> Linus).  However, that said, logging a reason string via audit seems
> like a good idea (especially since there is presently a many-to-one
> mapping between reasons and the SELinux permission).  Further, while
> the audit field name is part of the kernel API, the value is much more
> open.

Ok, any preferences on the audit field name or should we just create one 
and cc linux-audit on the next RFC?  lockdown_reason=?

>> I also wasn't sure about the pr_warn() above.  If we reach it, it is
>> effectively a kernel bug. We could mirror what the lockdown module does
>> in lockdown_is_locked_down(), i.e. use WARN() instead.  Of course, the
>> SELinux hook won't even be reached in this case if the lockdown module
>> is enabled, but the lockdown module could be disabled so I guess we need
>> to check it too.
> 
> Since this seems security relevant, I wonder if we should be using SELINUX_ERR?

The benefit of a WARN() is that it will give us a stack trace showing 
the offending caller in the kernel, which would be useful since it would 
be a buggy caller passing an invalid lockdown reason (LOCKDOWN_NONE or 
 >= LOCKDOWN_CONFIDENTIALITY_MAX).  pr_warn() or audit_log() won't give 
us that info.  We could do both of course.

