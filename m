Return-Path: <SRS0=wfQh=3L=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66603C2D0DB
	for <selinux@archiver.kernel.org>; Wed, 22 Jan 2020 13:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2A0E24125
	for <selinux@archiver.kernel.org>; Wed, 22 Jan 2020 13:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="PnaPbh3y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725802AbgAVNg2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 22 Jan 2020 08:36:28 -0500
Received: from UPDC19PA24.eemsg.mail.mil ([214.24.27.199]:2387 "EHLO
        UPDC19PA24.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgAVNg1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 22 Jan 2020 08:36:27 -0500
X-EEMSG-check-017: 48330441|UPDC19PA24_ESA_OUT06.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,350,1574121600"; 
   d="scan'208";a="48330441"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UPDC19PA24.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 22 Jan 2020 13:34:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1579700062; x=1611236062;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=Gkh51dphrWTsKT4oDwpHBdw5PQWweySrLUzaugFpNZw=;
  b=PnaPbh3ysLWG/92C3U4Fr1r62aLWAuyCPIvZ1rIU5Ee+s8CWibeTGtZV
   Mihd6euuHuyooCW4IU8czs1SoM4RkExwrU7U3JsFC4sZO81M8uENgBlty
   7lrDyCaXCNsE08i0Pfs8beOw9QT7usq9PgydJM3Z/Icyfvd19SC9M2DFy
   guRns9+Fa6r5mtiBFddXjUyFFitA1DXnBwqtEPltTZgWwuFs0GTzaoFto
   wA0b+SbS/gRbpYzE+HLFBcYsrQV7xt1Ij6yKc0xFw3AwB5Fo6d+CZRt8k
   cYLVv9T4z4ASK85zJ6fh8GUoJh69GDx1N/d5LsL1YLvtXXih3thbIEi9o
   g==;
X-IronPort-AV: E=Sophos;i="5.70,350,1574121600"; 
   d="scan'208";a="32194074"
IronPort-PHdr: =?us-ascii?q?9a23=3AheRCnBc/PUvGFQrgg0vutEdglGMj4u6mDksu8p?=
 =?us-ascii?q?Mizoh2WeGdxc26bByN2/xhgRfzUJnB7Loc0qyK6vymAzRLvcnJ8ChbNsAVDF?=
 =?us-ascii?q?ld0YRetjdjKfbNMVf8Iv/uYn5yN+V5f3ghwUuGN1NIEt31fVzYry76xzcTHh?=
 =?us-ascii?q?LiKVg9fbytScbdgMutyu+95YDYbRlWizqhe7NyKwi9oRnMusUMjoZuN6k8xg?=
 =?us-ascii?q?HXrndUdOhbymFlLk+Xkxrg+8u85pFu/zletv4768JMTaD2dLkkQLJFCzgrL3?=
 =?us-ascii?q?o779DxuxnZSguP6HocUmEInRdNHgPI8hL0UIrvvyXjruZy1zWUMsPwTbAvRD?=
 =?us-ascii?q?St9LxrRwPyiCcGLDE27mfagdFtga1BoRKhoxt/w5PIYIyQKfFzcL/Rcc8cSG?=
 =?us-ascii?q?FcRctaSTBPDZ2gYIsOF+oBPPhXr4/hp1sVsBCyARCgCP7zxjNUg3P726M10/?=
 =?us-ascii?q?4lEQrbwgIuGdwAu2nQoNnsOqofVeW5wa/VxjvBcvxWwy/w5pXWfBAvof+CXr?=
 =?us-ascii?q?x+fsTexkYtCwzLgU6dqZDmMj6PyugBr2aW4uhmWOmyi2AnsQZxoj23y8kxlo?=
 =?us-ascii?q?nGmJoVylDa+iV/3Y07ONi4R1R/Yd6gDpRRtzyROoxtQsw/WGFlozo6y70atp?=
 =?us-ascii?q?67eygG0pInxwXFZPCdfIiI5QzjWf+XLDxlinxlf7e/iAyz8Uim0uDzTc600F?=
 =?us-ascii?q?FWripBk9nMsGoB2ADU6siCUvd98Uah2SqP1wDO8e5IO1w7la3eK5Mn37U+lY?=
 =?us-ascii?q?ITvFzeEiL5l0j6lq+belg+9uS25OnrfK/qqoKaOoRpkA/xKL4ulda6AekgNw?=
 =?us-ascii?q?gOWHWU9vqk2b34+E35XK1KjvorkqnFqJzaJdoUpqq+AwJNzoYs8Qy/Dza70N?=
 =?us-ascii?q?QDh3UHLVRFeByAj4jyJV7BPOr0Deu/gluwkDdrwOrKPrv9DZXWMnfPirLhfb?=
 =?us-ascii?q?d560JEyQozy85Q545MB70cL//+VVX9udzFAhMjLQC5zPjrBM9g2o8GXGKAGK?=
 =?us-ascii?q?6ZMKfcsV+S4eIvJvGBZJQItzbmMPUl+/7vgmM5mV8aZ6Wp24AXZ2qiEvRpJE?=
 =?us-ascii?q?WZf2Lggs0dHmcSogo+UOvqhUWaUT5XfXmyQr485isgB428ForDXJ6ij6GB3C?=
 =?us-ascii?q?ihAp1afHxJCleJEX3wbYWLR+8MaD6OIs9mijEETqauS4sg1RGoqQ/7xKFqLv?=
 =?us-ascii?q?Tb+iIGr5Lvztt16PPJlRE06zN0C96R02aXT2F7hmkIXSM53LhjoUxhzVeOyb?=
 =?us-ascii?q?N3g/1cFdxX/f9GTh02NYTbz+NhFd/yQB7BfsySRVapR9WpGzAxTtYrz9ASZE?=
 =?us-ascii?q?Z9Hs2ojgrf0CqyH78Vi7uLCYQs8q3CxHf+OcB9y3fa1KkmlFQmQ9VAOnO4ia?=
 =?us-ascii?q?Jl8AjTHYHJwA2lkPOSeLgGlArE6XuZx2OFvAkMSAp5TLnfV3k3fEbard3loE?=
 =?us-ascii?q?jFSun9J64gN1561cOaKqZMIubshFFCSearbM/SeEqtimywAlCO3brKY430LT?=
 =?us-ascii?q?ZOlB7BAVQJxlhAtU2NMhIzU2L4+DPT?=
X-IPAS-Result: =?us-ascii?q?A2AQAwBySyhe/wHyM5BlHAEBAQEBBwEBEQEEBAEBgXuBe?=
 =?us-ascii?q?AWBGFUgEiqEEokDhm8GgRIliW6KJYckCQEBAQEBAQEBAS0KAQGDe0UCgj44E?=
 =?us-ascii?q?wIQAQEBBAEBAQEBBQMBAWyFNwyCOykBgnoBBSMPAQVBEAsOCgICJgICVwYNB?=
 =?us-ascii?q?gIBAYJjPwGCViUPrl2BMoVKgzeBOAaBDiqMMHmBB4E4DAOCXT6CZAIChHGCX?=
 =?us-ascii?q?gSOC4ltl1qCQ4JLhHSObgYbmnctlxOUNyKBWCsIAhgIIQ87gmxQGA2IDReDU?=
 =?us-ascii?q?IpxIwMwAguNZAEB?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 22 Jan 2020 13:34:21 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 00MDXaif150319;
        Wed, 22 Jan 2020 08:33:38 -0500
Subject: Re: [PATCH] libselinux: Eliminate use of security_compute_user()
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     selinux@vger.kernel.org,
        William Roberts <bill.c.roberts@gmail.com>,
        "Christopher J. PeBenito" <pebenito@ieee.org>
References: <20190509084204.26198-1-plautrba@redhat.com>
 <43a3624a-2217-f504-0195-13e4423c7b63@tycho.nsa.gov>
 <pjdsgtexwtm.fsf@redhat.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <d533b6fe-9606-185d-caa6-8c71c09d7ee1@tycho.nsa.gov>
Date:   Wed, 22 Jan 2020 08:35:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <pjdsgtexwtm.fsf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 5/16/19 11:07 AM, Petr Lautrbach wrote:
> 
> Stephen Smalley <sds@tycho.nsa.gov> writes:
> 
>> On 5/9/19 4:42 AM, Petr Lautrbach wrote:
>>> get_ordered_context_list() code used to ask the kernel to compute the 
>>> complete
>>> set of reachable contexts using /sys/fs/selinux/user aka
>>> security_compute_user(). This set can be so huge so that it doesn't 
>>> fit into a
>>> kernel page and security_compute_user() fails. Even if it doesn't fail,
>>> get_ordered_context_list() throws away the vast majority of the returned
>>> contexts because they don't match anything in
>>> /etc/selinux/targeted/contexts/default_contexts or
>>> /etc/selinux/targeted/contexts/users/
>>>
>>> get_ordered_context_list() is rewritten to compute set of contexts 
>>> based on
>>> /etc/selinux/targeted/contexts/users/ and
>>> /etc/selinux/targeted/contexts/default_contexts files and to return 
>>> only valid
>>> contexts, using security_check_context(), from this set.
>>>
>>> Fixes: https://github.com/SELinuxProject/selinux/issues/28
>>>
>>> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
>>> ---
<snip>
>> I think the main potential stumbling block here is the MLS range 
>> component. The
>> kernel policy defines the default level and allowed range for the 
>> (SELinux)
>> user, and uses this information in the kernel function 
>> mls_setup_user_range(),
>> https://elixir.bootlin.com/linux/latest/source/security/selinux/ss/mls.c#L402, 
>>
>> to determine the most suitable MLS range for the user session, based 
>> on both the
>> from-context and the user default and range from the kernel policy.  
>> Just using
>> the level from the from-context could fail if the user isn't 
>> authorized to
>> operate at that level, and even if the user is authorized to operate 
>> at that
>> level, it could introduce a change in the default behavior if the 
>> user's default
>> level differs. I think when we have discussed this in the past on the 
>> list, we
>> were going to either export the user's default level and range 
>> information from
>> the kernel via selinuxfs and replicate the mls_setup_user_ranges() 
>> logic in
>> userspace, or have it automatically extracted from the kernel policy 
>> during
>> policy build into a userspace configuration file that could be used 
>> directly by
>> userspace.  Or something like that.  This gets a bit tricky though in 
>> that the
>> logic involves comparing MLS levels, which is intrinsically 
>> policy-specific
>> logic, and thus if we wanted to truly replicate it in userspace, we'd 
>> probably
>> need to use libsepol.  Ugh. Maybe the kernel could just provide a simple
>> selinuxfs interface for computing the result of mls_setup_user_range() 
>> and
>> return that piece.
>>
>> That said, I don't know to what extent anyone is relying on this logic 
>> and to
>> what extent it is obsoleted by the use of the level/range from 
>> seusers.  It
>> looks like today we are replacing the level/range in the original 
>> from-context
>> with the one from seusers before calling this code, in which case the 
>> fromlevel
>> is in fact the one we ultimately want to use.  So perhaps this doesn't 
>> matter
>> and we can just go with your approach.
> 
> The problem is much complicated than I originally thought and this
> patch changes the behavior of get_ordered_context_list what is probably
> not acceptable.
> 
> I'll do more tests and think about it the light of new (for me)
> information.
> 
> Thanks all for reviews and inputs.

I would like to re-visit this patch again.  I did some looking at how 
get_ordered_context_list() and its variant interfaces are currently 
being used by callers, and at the internal logic of 
get_ordered_context_list() in userspace and mls_setup_user_ranges() in 
the kernel.  Since we are already substituting the range/level from 
seusers into the from-context before calling security_compute_user(), 
and since the only sensible configuration of seusers would be to use a 
range/level that falls within (or is identical to) the SELinux user's 
authorized range, I don't think your patch is likely to break anything. 
There are corner cases where it could yield a different result but I 
would be surprised if such corner cases are in real use and arguably 
they would be configuration errors.  Consequently, I think we should 
refresh your patch, address any comments made on it previously, and 
submit it for merging and try it out.  If we encounter any real world 
breakage from it, we can consider adding a new selinuxfs node that 
exports the kernel's mls_setup_user_ranges() logic and rework 
get_ordered_context_list() to use that to obtain the MLS portion of the 
context, but I don't think it is worth doing that without a real example 
where simply applying your patch breaks something.  Thoughts?
