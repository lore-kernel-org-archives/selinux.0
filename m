Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E761C433EF
	for <selinux@archiver.kernel.org>; Fri,  3 Sep 2021 08:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EBC160F9C
	for <selinux@archiver.kernel.org>; Fri,  3 Sep 2021 08:37:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348352AbhICIim (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 3 Sep 2021 04:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348310AbhICIil (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 3 Sep 2021 04:38:41 -0400
Received: from agnus.defensec.nl (agnus.defensec.nl [IPv6:2001:985:d55d::711])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 348F3C061575
        for <selinux@vger.kernel.org>; Fri,  3 Sep 2021 01:37:40 -0700 (PDT)
Received: from brutus (brutus.lan [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id 956E52A0086;
        Fri,  3 Sep 2021 10:37:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 agnus.defensec.nl 956E52A0086
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defensec.nl;
        s=default; t=1630658258;
        bh=sulTt96qMQAqshyPd5vUS1qEj4QrJRwDeFmTRqtn8Zs=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=PbUjTOkyiN6nHtKTZK4ddGy+/aADi2v6KDW7LLPA2tqFZxf2zg49G/WuUadahDeuh
         6Qr0a+60xoJucs0ZbrmNiBq13TINkX9q07Utwm7kD8iIsW0AobxcNNDL7JGRcxMMlO
         FlsmdoiDAQF2eF9DjJ8dRdeldXr1lvEfIF+LdO4o=
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     selinux@vger.kernel.org
Subject: Re: lets think about 3.3 release
References: <87fsvmu2xa.fsf@redhat.com> <87zgsu9j9c.fsf@redhat.com>
Date:   Fri, 03 Sep 2021 10:37:35 +0200
In-Reply-To: <87zgsu9j9c.fsf@redhat.com> (Petr Lautrbach's message of "Fri, 03
        Sep 2021 10:05:19 +0200")
Message-ID: <87pmtq8374.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Petr Lautrbach <plautrba@redhat.com> writes:

> Petr Lautrbach <plautrba@redhat.com> writes:
>
>> Hello,
>>
>> I's about 184 commits and 5 months since the last release so I think
>> it's time to slowly stop the development and start with 3.3 release
>> candidates.
>
>
> Currently patchwork contains just these patches which should be relevant
> to 3.3:
>
> https://patchwork.kernel.org/patch/12435365/ New [1/2] libsepol/cil:
> Improve in-statement to allow use after inheritance
> https://patchwork.kernel.org/patch/12435363/ New [2/2] libsepol/secilc/docs: Update the CIL documentation

Strictly speaking these can probably wait until after 3.3 although it would
be nice to get this in.

Maybe eventually some day in the distant future we can re-consider
disallowing duplicate macro and block declarations in favor of this functionality.

>
> These are probably superseeded already, but I'm not sure. Please take a look.
>
>
> https://patchwork.kernel.org/patch/12470297/ New [1/3,v2] libsepol/cil: Remove redundant syntax checking
> https://patchwork.kernel.org/patch/12470301/ New [2/3,v2]
> libsepol/cil: Use size_t for len in __cil_verify_syntax()
> https://patchwork.kernel.org/patch/12470299/ New [3/3,v2]
> libsepol/cil: Fix syntax checking in __cil_verify_syntax()
>
> Wait for review.
>
> So I think selinux-3.3-rc1 can be released on next Wednesday 2021-09-08
>
> If you have any concerns, comments or suggestion, let us know.
>
> Also I really don't understand all the changes in libsepol so please help me
> to collect release notes information for it. I'll post a release notes
> draft with other components later today.
>
>
> Thanks,
>
> Petr
>
>

-- 
gpg --locate-keys dominick.grift@defensec.nl
Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
https://sks-keyservers.net/pks/lookup?op=get&search=0xDA7E521F10F64098
Dominick Grift
