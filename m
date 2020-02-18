Return-Path: <SRS0=OQot=4G=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04050C34026
	for <selinux@archiver.kernel.org>; Tue, 18 Feb 2020 16:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D080422527
	for <selinux@archiver.kernel.org>; Tue, 18 Feb 2020 16:17:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="jtPQ5a12"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgBRQR4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 18 Feb 2020 11:17:56 -0500
Received: from USAT19PA23.eemsg.mail.mil ([214.24.22.197]:3165 "EHLO
        USAT19PA23.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbgBRQR4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 18 Feb 2020 11:17:56 -0500
X-EEMSG-check-017: 78854048|USAT19PA23_ESA_OUT04.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.70,456,1574121600"; 
   d="scan'208";a="78854048"
Received: from emsm-gh1-uea11.ncsc.mil ([214.29.60.3])
  by USAT19PA23.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 18 Feb 2020 16:17:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1582042642; x=1613578642;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=hpJnaT/iUwbNHciWu54+NuA/6r9iZ44LAhK5XxO/ixY=;
  b=jtPQ5a1260YZ5lpI0J4LiSahpwxLuKrLC/V6turda909S3fOHN7px39E
   NSLs/7AgJ5g04HX2OZwEGo8OkE8TVldKLMI9WtsTgz1WnnkdL+lvxu0wx
   TfPUEHU7gQg0HReJy8N+VMP8z2hKP+nq1weAVEQ7mwdH4cqvuHeNxeP3E
   kLbnaAWFB+7M2VvuRnoHPSMHJvb2anBelfZ52ny8aiQi0dWaonDyenW77
   uRA+/LJ8/dr6tn3BtAdrB0rk0/du+s9iFJrerXU6EPQ2DWRNLRAcXxKe+
   fVbqbHc2pZDy0V7f/EWPUT5IuYu42xNT++LHtLu2LQ5pLiWx708wM0cMI
   w==;
X-IronPort-AV: E=Sophos;i="5.70,456,1574121600"; 
   d="scan'208";a="39232339"
IronPort-PHdr: =?us-ascii?q?9a23=3ASKwm5RyouUTp1NzXCy+O+j09IxM/srCxBDY+r6?=
 =?us-ascii?q?Qd2u4WIJqq85mqBkHD//Il1AaPAdyHra0UwLqI+4nbGkU+or+5+EgYd5JNUx?=
 =?us-ascii?q?JXwe43pCcHRPC/NEvgMfTxZDY7FskRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQ?=
 =?us-ascii?q?viPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiCeybL9oLhi7rgrdu8oXjIB/Nqs/1x?=
 =?us-ascii?q?zFr2dHdOhR2W5mP0+YkQzm5se38p5j8iBQtOwk+sVdT6j0fLk2QKJBAjg+PG?=
 =?us-ascii?q?87+MPktR/YTQuS/XQcSXkZkgBJAwfe8h73WIr6vzbguep83CmaOtD2TawxVD?=
 =?us-ascii?q?+/4apnVAPkhSEaPDMi7mrZltJ/g75aoBK5phxw3YjUYJ2ONPFjeq/RZM4WSX?=
 =?us-ascii?q?ZdUspUUSFODJm8b48SBOQfO+hWoZT2q18XoRawAQSgAeXiwSJKiHDrx603y/?=
 =?us-ascii?q?kvHx/I3AIgHNwAvnrbo9r3O6gOXu6417XIwDfZYv9KxTvw5orFfxY8qv+MR7?=
 =?us-ascii?q?Jwds/RxFEyGQPZkFqQsYzlMC2T1u8Qrmab6vBvVeari2E5qwB6vz+ixtwxhY?=
 =?us-ascii?q?nSnY8V1lDF+jl5wIYyP9G4TlV7bsS+HJtfsCGaKZJ7T8U/SG9roCY30qAKtJ?=
 =?us-ascii?q?G0cSQQyJkr2gTTZ+KIfoSW+B7vSeCcKipiin1/YrKwnROy/FClyu37S8a7zk?=
 =?us-ascii?q?5HrjFAktnQrnAN0AHT6tSfRvt94Eih3TGP2hjP6u5eO0A0lLfbK4U7zr4xkJ?=
 =?us-ascii?q?oTv0PDHjTol0rqlqOWakUl9fSo6+TgeLnmoIOTN5RohQ3kN6Qum8i/Dfw5Mg?=
 =?us-ascii?q?gIQWeb5fyx2KDs8ED2WrlHjuA6nrPHvJ3VO8gXvLO1DxdQ0ok56ha/Czmm0M?=
 =?us-ascii?q?4fnXkCNF9FYw+Ij5PyNlHSIPH3Efe/g1O2nDdt3PDJJKftAprKLnjdiLvhZ6?=
 =?us-ascii?q?py61ZAyAovytBS/5VUCrQGIPLoXE/+rsDXAQEiPgyu3enoFdV92ZkCWW6VHq?=
 =?us-ascii?q?CZN6bSu0eS5u0zO+mMeJMVuDHlJvg++fHuiX45mVkAfaimxpYXdn+4Eep8I0?=
 =?us-ascii?q?mDYnrjnM0BEWEUsQo6VuDqj0eCUTFLbXaoQ608/i07CJ6hDYrbXoCimqGB3C?=
 =?us-ascii?q?OgE51OfG9GF1SMHW7td4WDXPcMcjydLtV9nTwDULjyA7MmgDaouBX3yfJCKf?=
 =?us-ascii?q?HS8yYVttq3091y/Ovanhwa7zF4D82BlWqKSjcnsHkPQmoNwK1noUF7gmyG2K?=
 =?us-ascii?q?x8ju0QQcdf/NtVQww6Mtja1OU8BNfsDFGSNuyVQUqrF431SQo6Scg8lppXOB?=
 =?us-ascii?q?dw?=
X-IPAS-Result: =?us-ascii?q?A2BcAgDHDUxe/wHyM5BmHAEBAQEBBwEBEQEEBAEBgXuBf?=
 =?us-ascii?q?YFsASASKoQUiQOGXwMGgRIliXCPY4FnCQEBAQEBAQEBATcEAQGEQAKCJzgTA?=
 =?us-ascii?q?hABAQEFAQEBAQEFAwEBbIVDgjspAYMCAQUjBBFBEAsOCgICJgICVwYNBgIBA?=
 =?us-ascii?q?YJjP4JXJa0SfzOFSoNdgT6BDiqMPnmBB4ERJwwDgl0+hDGDKoJeBI1kBIlqR?=
 =?us-ascii?q?pdygkWCUJQDBhybJqw8IoFYKwgCGAghD4MnUBgNjigBF4EEAQiNNCMDMJBpA?=
 =?us-ascii?q?QE?=
Received: from tarius.tycho.ncsc.mil (HELO tarius.infosec.tycho.ncsc.mil) ([144.51.242.1])
  by emsm-gh1-uea11.NCSC.MIL with ESMTP; 18 Feb 2020 16:17:00 +0000
Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
        by tarius.infosec.tycho.ncsc.mil (8.14.7/8.14.4) with ESMTP id 01IGFu71045539;
        Tue, 18 Feb 2020 11:15:58 -0500
Subject: Re: [PATCH] selinux: reduce the use of hard-coded hash sizes
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
References: <20200217114943.67607-1-omosnace@redhat.com>
 <072c5073-3810-e2fd-ee54-fe8a5dc163df@tycho.nsa.gov>
 <CAFqZXNsm8TPp=60CLu6u2NH4oFBioXb_y1mLnVxvuWa=S9Qzfg@mail.gmail.com>
From:   Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <01b21144-1958-462f-b91b-e2d85a905e2e@tycho.nsa.gov>
Date:   Tue, 18 Feb 2020 11:18:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAFqZXNsm8TPp=60CLu6u2NH4oFBioXb_y1mLnVxvuWa=S9Qzfg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On 2/18/20 10:21 AM, Ondrej Mosnacek wrote:
> On Tue, Feb 18, 2020 at 3:59 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> On 2/17/20 6:49 AM, Ondrej Mosnacek wrote:
>>> Instead allocate hash tables with just the right size based on the
>>> actual number of elements (which is almost always known beforehand, we
>>> just need to defer the hashtab allocation to the right time). The only
>>> case when we don't know the size (with the current policy format) is the
>>> new filename transitions hashtable. Here I just left the existing value.
>>>
>>> After this patch, the time to load Fedora policy on x86_64 decreases
>>> from 950 ms to 220 ms. If the unconfined module is removed, it decreases
>>> from 870 ms to 170 ms. It is also likely that other operations are going
>>> to be faster, mainly string_to_context_struct() or mls_compute_sid(),
>>> but I didn't try to quantify that.
>>>
>>> The memory usage increases a bit after this patch, but only by ~1-2 MB
>>> (it is hard to measure precisely). I believe it is a small price to pay
>>> for the increased performance.
>>>
>>> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
>>> ---
>>>    security/selinux/ss/hashtab.c  | 21 ++++++++++++--
>>>    security/selinux/ss/hashtab.h  |  2 +-
>>>    security/selinux/ss/policydb.c | 53 +++++++++++++---------------------
>>>    security/selinux/ss/policydb.h |  2 --
>>>    4 files changed, 40 insertions(+), 38 deletions(-)
>>>
>>> diff --git a/security/selinux/ss/hashtab.c b/security/selinux/ss/hashtab.c
>>> index ebfdaa31ee32..554a91ef3f06 100644
>>> --- a/security/selinux/ss/hashtab.c
>>> +++ b/security/selinux/ss/hashtab.c
>>> @@ -27,6 +41,9 @@ struct hashtab *hashtab_create(u32 (*hash_value)(struct hashtab *h, const void *
>>>        p->nel = 0;
>>>        p->hash_value = hash_value;
>>>        p->keycmp = keycmp;
>>> +     if (!size)
>>> +             return p;
>>> +
>>>        p->htable = kmalloc_array(size, sizeof(*p->htable), GFP_KERNEL);
>>>        if (!p->htable) {
>>>                kfree(p);
>>
>> Thanks, this looks promising.  However, I was wondering: if we end up
>> with size == 0 (e.g. policy happens to have an empty table), does the
>> rest of the hashtab_* code always correctly handle the fact that
>> ->htable could be NULL?  Doesn't look obviously safe to me on a quick look.
> 
> Hm... it seems I didn't think this through when I was trying to handle
> this case. I was rebasing this patch all over the place as I was
> working on other changes in parallel, so maybe I just lost the safety
> somewhere along the way... I think I will just clamp the minimum size
> to 1, as that seems both safer and simpler. The extra 8-byte
> allocation shouldn't cost much (there are only O(number of classes +
> commons) hash tables and these make no sense to have 0 entries).

Hmm...on booting this kernel, I am seeing a number of calls to 
hashtab_create() with nel_hint==0 leading to size == 0 and nothing is 
obviously breaking, so maybe this is safe?


