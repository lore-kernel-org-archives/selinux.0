Return-Path: <SRS0=UID1=TY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA2AC072B5
	for <selinux@archiver.kernel.org>; Fri, 24 May 2019 16:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91E4F2081C
	for <selinux@archiver.kernel.org>; Fri, 24 May 2019 16:02:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="mJNjPkAd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389812AbfEXQC2 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 24 May 2019 12:02:28 -0400
Received: from uhil19pa12.eemsg.mail.mil ([214.24.21.85]:10449 "EHLO
        uhil19pa12.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389710AbfEXQC2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 24 May 2019 12:02:28 -0400
X-EEMSG-check-017: 414667357|UHIL19PA12_EEMSG_MP10.csd.disa.mil
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by uhil19pa12.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 24 May 2019 16:02:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1558713745; x=1590249745;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=wgMX4W8rae9N9ueFqZeaioBPcdDiaQ8lXMpFNFdJKnQ=;
  b=mJNjPkAdkHmkr770ZGVzY9fg8dMCvACTDjYEFtfm0Kr89dOtmckiKJDD
   neJvytWlosIXPGuzBwqQVy1evpthUmy1hMnFvCKW9JbA5luQR4Hj6rn5O
   T2dmEPrlYrgNZFhbqujDN9n950MwihTmB01YiZ3fR8/UPiNsHz7cLhF9s
   bd9cnIjVx4f9lb795ZHi9askHvCYZkODc3Xeh3smFRAvMJb22dyEpOs1E
   9E/XxOZXS6tSZHuJSR+RBsXIYVft4O5fp+S+zeqvRAPf7q1R0kc7Bu0+x
   NtsD25ruzkmHhkVN9q4L6iJCvFjsVvhcHEk/t/+Vr8VwqLmfaROm0Azqo
   w==;
X-IronPort-AV: E=Sophos;i="5.60,507,1549929600"; 
   d="scan'208";a="28154689"
IronPort-PHdr: =?us-ascii?q?9a23=3As9CTzBF6oJQBbDmQHOSA+p1GYnF86YWxBRYc79?=
 =?us-ascii?q?8ds5kLTJ76p8i5bnLW6fgltlLVR4KTs6sC17OP9fm5BydRv96oizMrSNR0TR?=
 =?us-ascii?q?gLiMEbzUQLIfWuLgnFFsPsdDEwB89YVVVorDmROElRH9viNRWJ+iXhpTEdFQ?=
 =?us-ascii?q?/iOgVrO+/7BpDdj9it1+C15pbffxhEiCCybL9vMRm6txjdutQXjIdtLqs8yw?=
 =?us-ascii?q?bCr2dVdehR2W5mP0+YkQzm5se38p5j8iBQtOwk+sVdT6j0fLk2QKJBAjg+PG?=
 =?us-ascii?q?87+MPktR/YTQuS/XQcSXkZkgBJAwfe8h73WIr6vzbguep83CmaOtD2TawxVD?=
 =?us-ascii?q?+/4apnVAPkhSEaPDMi7mrZltJ/g75aoBK5phxw3YjUYJ2ONPFjeq/RZM4WSX?=
 =?us-ascii?q?ZdUspUUSFODJm8b48SBOQfO+hWoZT2q18XoRegCwSgAeXiwSJKiHDrx603y/?=
 =?us-ascii?q?kvHx/I3AIgHNwAvnrbo9r3O6gOXu6417XIwDfZYv9KxTvw5orFfxY8qv+MR7?=
 =?us-ascii?q?Jwds/RxFEtFwLLklqfs5blPy+L2u8QtGWb7eRhWv61hG49twF9vCOixtssi4?=
 =?us-ascii?q?bVhoIVzUrI9SNiwIkvP9G4R0l7YcC9HZZWqiqUOYx2QsY4TGFpviY30qYGuZ?=
 =?us-ascii?q?2gfCQTy5Qo2R7ea+eZfIiS/BLsSvyRISxiiHJjZr2/mw6+8VS6yuLmSMm00U?=
 =?us-ascii?q?1KojNZndnNrHwN0AbT6seBR/Bg/UmhwS6C2x3c5+xLO0w5lbfXJ4Q/zrM/iJ?=
 =?us-ascii?q?Yfq1nPEynrk0vslqCWbF8r+u2w5uTiZbXpu4GTOpdvigH7LqQugsu/AfkkMg?=
 =?us-ascii?q?QWX2iU5+C81Lr78E3lWrpKlPw2krTCsJzAOcQaprK2Aw9S0oo57RawEyym38?=
 =?us-ascii?q?gCkXkCLVJFfAqLj4nvO17QPPD1FeqzjlujnTtxx/3KI6ftDovCI3TdirvtYK?=
 =?us-ascii?q?5x60tGxwoyydBf6YhUCrYEIP/rWE/wusDXAQUjMwyo3erqE8l914MCVmKPBa?=
 =?us-ascii?q?+VKqXSsUSS6e41LOmMY5EVtC7nK/c5//7ukWM5mVgFcKmu2JsXb2u4HvJ8LE?=
 =?us-ascii?q?qFf3Xhmc0BHnkXsQo+VuPqlEeOXiJUZ3a3R6g8/C00CJq6DYffQYCgmKGO0z?=
 =?us-ascii?q?2nEZFMYWBGFE6DEW3yd4WFRvgDdjmfIsBkkjMeVLihT5Ut2g2ptA//07BnNP?=
 =?us-ascii?q?bb+jUEtZL/09h4//bTmg829Tx1CcSdzm6MQnpqnmMHWTA2xrpzoU9jxVeZ16?=
 =?us-ascii?q?h3nfhYGcZU5/NTXQdpfaLbmst8B8r/WErkecyPQV2rQZ3yBjQ2VdQ4yNImeU?=
 =?us-ascii?q?txG9y+yBvE2nzuS5MSkr2NBZc3uo3G3nbtb5Jxwn2A07cslUMnTsZnOmivh6?=
 =?us-ascii?q?o5/A/WUd3niUKcwqS1fq0GwHSFoGWcxmOUoBtwTB97UaKDW2sWIETRs4KqtQ?=
 =?us-ascii?q?v5U7ayBOF/YUN6wsmYJ/4PM4eygA=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2DhBAAzFehc/wHyM5BfBhoBAQEBAQIBAQEBBwIBAQEBg?=
 =?us-ascii?q?WWBZyppUQEyKIQTiHuMHYlAiQ6IBQkBAQEBAQEBAQErCQECAQGCEoFoRgKCP?=
 =?us-ascii?q?yM4EwEDAQEBBAEBAQEDAQFsHAyCOikBgmcBBSMVNAoDEAsJBQoCAiYCAiE2B?=
 =?us-ascii?q?gEMBgIBAYJfPwGBagMdD6YKgS+EMgGBFIJDDV2BRoEMKItTgVZAgREngms+g?=
 =?us-ascii?q?houGQQYgTmDGIJYBIEtAYoPh0hSlDM9BgOCD4VdVoFvhw2DXQYbgwaTO4xoh?=
 =?us-ascii?q?wCBWI8jIYFXKwpBgWiBTgkKgjOGD4IDO4VbIwMwgQYBAY4FAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 24 May 2019 16:02:05 +0000
Received: from localhost.localdomain (moss-lions [192.168.25.4])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x4OG25Aa003414;
        Fri, 24 May 2019 12:02:05 -0400
Subject: Re: [Non-DoD Source] Re: [PATCH userspace 0/4] Remove redundant rules
 when building policydb
To:     Ondrej Mosnacek <omosnace@redhat.com>,
        Dominick Grift <dac.override@gmail.com>
Cc:     selinux@vger.kernel.org
References: <20190523102449.9621-1-omosnace@redhat.com>
 <20190523131455.GA30512@brutus.lan> <20190523133947.GB30512@brutus.lan>
 <CAFqZXNv0cWnp3urHhCowFVKiypzsb52a2+dQ4G+0cjRdcEUwAg@mail.gmail.com>
From:   jwcart2 <jwcart2@tycho.nsa.gov>
Message-ID: <1c3321c9-f7d2-815a-c288-07ae7409b8d8@tycho.nsa.gov>
Date:   Fri, 24 May 2019 12:02:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAFqZXNv0cWnp3urHhCowFVKiypzsb52a2+dQ4G+0cjRdcEUwAg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 5/23/19 10:08 AM, Ondrej Mosnacek wrote:
> On Thu, May 23, 2019 at 3:40 PM Dominick Grift <dac.override@gmail.com> wrote:
>> On Thu, May 23, 2019 at 03:14:55PM +0200, Dominick Grift wrote:
>>> On Thu, May 23, 2019 at 12:24:45PM +0200, Ondrej Mosnacek wrote:
>>>> This series implements an optional optimization step when building
>>>> a policydb via semodule or secilc, which identifies and removes rules
>>>> that are redundant -- i.e. they are already covered by a more general
>>>> rule based on attribute inheritance.
>>>
>>> Some stats with dssp2-standard:
>>>
>>> [kcinimod@myguest dssp2-standard]$ time secilc -n `find . -name *.cil` -o policy.31.noopt
>>>
>>> real    0m9.278s
>>> user    0m7.036s
>>> sys     0m2.017s
>>> [kcinimod@myguest dssp2-standard]$ time secilc `find . -name *.cil` -o policy.31.opt
>>>
>>> real    0m19.343s
>>> user    0m16.939s
>>> sys     0m2.027s
>>> [kcinimod@myguest dssp2-standard]$ ls -lh policy.*
>>> -rw-rw-r--. 1 kcinimod kcinimod 2.4M May 23 15:11 policy.31.noopt
>>> -rw-rw-r--. 1 kcinimod kcinimod 2.3M May 23 15:12 policy.31.opt
>>>
>>> Was unable to see the actual diff as sediff got oom-killed on me
>>
>> According to percentage calculator thats roughly a 4 percent gain size-wise at a 47 percent performance penalty.
>> Looks like dssp2-standard is pretty efficient as it is.
> 
> Hmm, yeah, looks like I'll have to make it opt-in after all... or add
> some heuristic to decide if running the optimization is really worth
> it.
> 

Opt-in makes sense. How about just using 'O' for the option?

Jim

>>
>>>
>>>>
>>>> Since the performance penalty of this additional step is very small
>>>> (it adds about 1 s to the current running time of ~20-30 s [1]) and
>>>> it can have a big positive effect on the number of rules in policy
>>>> (it manages to remove ~40% AV rules from Fedora 29 policy), the
>>>> optimization is enabled by default and can be turned off using a
>>>> command-line option (--no-optimize) in secilc and semodule [2].
>>>>
>>>> The optimization routine eliminates:
>>>>   * all allow/neverallow/dontaudit/auditallow rules (including xperm
>>>>     variants) that are covered by another more general rule,
>>>>   * all conditional versions of the above rules that are covered by a
>>>>     more general rule either in the unconditional table or in the same
>>>>     branch of the same conditional.
>>>>
>>>> The optimization doesn't process other rules, since they currently
>>>> do not support attributes. There is some room left for more precise
>>>> optimization of conditional rules, but it would likely bring only
>>>> little additional benefit.
>>>>
>>>> When the policy is mostly or fully expanded, the optimization should
>>>> be turned off. If it isn't, the policy build time will increase a lot
>>>> for no benefit. However, the complexity of optimization will be only
>>>> linear w.r.t. the number of rules and so the impact should not be
>>>> catastrophic. (When testing with secilc on a subset of Fedora policy
>>>> with -X 100000 the build time was 1.7 s with optimization vs. 1 s
>>>> without it.)
>>>>
>>>> Tested live on my Fedora 29 devel machine under normal use. No unusual
>>>> AVCs were observed with optimized policy loaded.
>>>>
>>>> Travis build passed: https://travis-ci.org/WOnder93/selinux/builds/536157427
>>>>
>>>> NOTE: The xperm rule support wasn't tested -- I would welcome some
>>>>        peer review/testing of this part.
>>>>
>>>> [1] As measured on my machine (Fedora 29 policy, x86_64).
>>>> [2] I have no problem with switching it to opt-in if that is preferred.
>>>>
>>>> Ondrej Mosnacek (4):
>>>>    libsepol: add a function to optimize kernel policy
>>>>    secilc: optimize policy before writing
>>>>    libsemanage: optimize policy on rebuild
>>>>    semodule: add flag to disable policy optimization
>>>>
>>>>   libsemanage/include/semanage/handle.h      |   4 +
>>>>   libsemanage/src/direct_api.c               |   7 +
>>>>   libsemanage/src/handle.c                   |  13 +
>>>>   libsemanage/src/handle.h                   |   1 +
>>>>   libsemanage/src/libsemanage.map            |   5 +
>>>>   libsepol/include/sepol/policydb.h          |   5 +
>>>>   libsepol/include/sepol/policydb/policydb.h |   2 +
>>>>   libsepol/src/libsepol.map.in               |   5 +
>>>>   libsepol/src/optimize.c                    | 370 +++++++++++++++++++++
>>>>   libsepol/src/policydb_public.c             |   5 +
>>>>   policycoreutils/semodule/semodule.c        |  12 +-
>>>>   secilc/secilc.c                            |  16 +-
>>>>   12 files changed, 442 insertions(+), 3 deletions(-)
>>>>   create mode 100644 libsepol/src/optimize.c
>>>>
>>>> --
>>>> 2.20.1
>>>>
>>>
>>> --
>>> Key fingerprint = 5F4D 3CDB D3F8 3652 FBD8 02D5 3B6C 5F1D 2C7B 6B02
>>> https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
>>> Dominick Grift
>>
>>
>>
>> --
>> Key fingerprint = 5F4D 3CDB D3F8 3652 FBD8 02D5 3B6C 5F1D 2C7B 6B02
>> https://sks-keyservers.net/pks/lookup?op=get&search=0x3B6C5F1D2C7B6B02
>> Dominick Grift
> 
> 
> 


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
