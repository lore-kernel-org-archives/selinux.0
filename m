Return-Path: <SRS0=Tm5b=76=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFBC6C433E0
	for <selinux@archiver.kernel.org>; Wed, 17 Jun 2020 15:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 716E420897
	for <selinux@archiver.kernel.org>; Wed, 17 Jun 2020 15:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b="JUHLRjSN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbgFQPaN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 17 Jun 2020 11:30:13 -0400
Received: from agnus.defensec.nl ([80.100.19.56]:60738 "EHLO agnus.defensec.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726878AbgFQPaM (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 17 Jun 2020 11:30:12 -0400
Received: from brutus (brutus.lan [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id D9C1F2A06FB;
        Wed, 17 Jun 2020 17:30:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 agnus.defensec.nl D9C1F2A06FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defensec.nl;
        s=default; t=1592407806;
        bh=J+0Fpre7zVY+09xI5br9ibnJSMak/JEzMaKA6IxtJu8=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=JUHLRjSN6SnZyQTbSdkVg43cALuFysEv0OlPHYV3RQzIZ9tgfiG8YUthyy56BBmYt
         l2Ku0AWQBY4jvd+hetgszIypUb07msbAQZdIA0abMKTOoEPPKobSwt2siONXSYGvdM
         d61S1u9E5iXXX561IqJo8rXB0SCXNIHokHFTlW+A=
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Dac Override <dac.override@gmail.com>,
        bauen1 <j2468h@googlemail.com>, selinux <selinux@vger.kernel.org>
Subject: Re: Minimal CIL policy requires process class with transition permission
References: <3a60cdb1-3e30-da2a-8225-abfdc0f6b3d7@gmail.com>
        <CAEjxPJ4+cVRjWZ3=j7DoOadBarZBteqAsanCTp+fnH+ztpER9g@mail.gmail.com>
        <CAEjxPJ7rygAQjqYBiYHRw__cJjO4mJdV_7K38aG=i19s2_-FNg@mail.gmail.com>
        <CAJVWAV2x42n-5TJa+v=KkETao2jvL3qMPD9PKm9HzKXaGi6V0w@mail.gmail.com>
        <CAEjxPJ7LpVVpqyygve71K+Pr-w34w3DZgNAJqocbRAV=RVKMhg@mail.gmail.com>
Date:   Wed, 17 Jun 2020 17:30:00 +0200
In-Reply-To: <CAEjxPJ7LpVVpqyygve71K+Pr-w34w3DZgNAJqocbRAV=RVKMhg@mail.gmail.com>
        (Stephen Smalley's message of "Wed, 17 Jun 2020 11:23:10 -0400")
Message-ID: <ypjlsgetoglj.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Stephen Smalley <stephen.smalley.work@gmail.com> writes:

> On Wed, Jun 17, 2020 at 10:12 AM Dac Override <dac.override@gmail.com> wrote:
>> Speaking for myself here. I want to be able to clarify as much as
>> possible, without having to resort to: "this is added because of some
>> kernel internal", because those aspects distract when you try to learn
>> how to write a policy from scratch. Things tend to stick better when
>> you understand their purpose.
>
> Yes, it is mostly a legacy of the original tight coupling of kernel
> classes/permissions to policy and hardcoded assumptions about
> different default behaviors for processes (subjects) versus objects
> (which these days are at least mostly configurable via default rules
> and the like).  So we could probably eliminate the hard requirement
> here on process transition.  Just not sure it would yield a very
> usable system if you loaded such a policy.

In theory it should, if you have handleunknown set to allow, which is
recommended in the phase.

>
>> The situation is improving though. I don't think we were able to write
>> a policy by just being aware of this "process transition" internal in
>> the recent past. The lifting of the classordering make it possible to
>> start with just "process transition" and then get all the classes and
>> perms from dmesg as you go without having to be aware of all the
>> classes and perms needed (let alone any ordering as now you can just
>> all unorder it)
>>
>> Another path in this picture is the ability to omit unused isids, It
>> just does not help trying to explain "were just adding these sids and
>> sidcons due to some kernel internals" Now we can just stick to used
>> sidcons and explain why they are needed.
>>
>> So aside from the "process transition" secret sauce, I think the only
>> other aspect that might be hard to explain are the sidorder and the
>> need for sidorder.
>>
>> But other than the above now writing a policy from scratch is just
>> easier. Thanks for that.
>
> You're welcome.  Another thorny spot for new policy writers is likely
> when/how to use the various fs_use_* rules and when to use genfscon
> (and at what granularity); script/selinux/mdp at least will
> auto-generate a sane default set for you based on kernel
> configuration.  And unfortunately we've grown a set of hardcoded logic
> around specific filesystem types that need to get generalized and
> turned into policy-driven rules, as per
> https://github.com/SELinuxProject/selinux-kernel/issues/2.

I agree

-- 
gpg --locate-keys dominick.grift@defensec.nl
Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
https://sks-keyservers.net/pks/lookup?op=get&search=0xDA7E521F10F64098
Dominick Grift
