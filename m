Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BBDCC4320E
	for <selinux@archiver.kernel.org>; Mon,  9 Aug 2021 14:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 816C66101D
	for <selinux@archiver.kernel.org>; Mon,  9 Aug 2021 14:44:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233724AbhHIOot (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 9 Aug 2021 10:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234365AbhHIOoZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 9 Aug 2021 10:44:25 -0400
Received: from agnus.defensec.nl (agnus.defensec.nl [IPv6:2001:985:d55d::711])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 294D4C06179C
        for <selinux@vger.kernel.org>; Mon,  9 Aug 2021 07:43:45 -0700 (PDT)
Received: from brutus (brutus.lan [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id 131212A006A;
        Mon,  9 Aug 2021 16:43:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 agnus.defensec.nl 131212A006A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defensec.nl;
        s=default; t=1628520223;
        bh=J70/2DbtUEypuA5oXdkVz9/ZkXMbJKFm7knAqZas2So=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=SV2ol/yZeGc+uk55KrBfjaGXsasyejGT6oiEI+fHBOTs6gLrDxbLqzqG7U1lKDEm2
         2p3e6DvZgZtj2Cgnu7SmxPV1mETl/zb0zdStEWpf1PbfXKaK7k3weOJKoL/6Ahz5ak
         o3kqVcr/M7biyhWteacmsJoq/jv8nCkaGrkiRgbQ=
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     James Carter <jwcart2@gmail.com>
Cc:     Petr Lautrbach <plautrba@redhat.com>,
        SElinux list <selinux@vger.kernel.org>
Subject: Re: lets think about 3.3 release
References: <87fsvmu2xa.fsf@redhat.com>
        <CAP+JOzRb0vE94arDdF6SxB3Mn-82+ztRi0OjyGRzqjAd3=ck_A@mail.gmail.com>
Date:   Mon, 09 Aug 2021 16:43:39 +0200
In-Reply-To: <CAP+JOzRb0vE94arDdF6SxB3Mn-82+ztRi0OjyGRzqjAd3=ck_A@mail.gmail.com>
        (James Carter's message of "Mon, 9 Aug 2021 10:01:10 -0400")
Message-ID: <87tujy4r1g.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

James Carter <jwcart2@gmail.com> writes:

> On Fri, Aug 6, 2021 at 2:29 PM Petr Lautrbach <plautrba@redhat.com> wrote:
>>
>> Hello,
>>
>> I's about 184 commits and 5 months since the last release so I think
>> it's time to slowly stop the development and start with 3.3 release
>> candidates.
>>
>> According to patchwork, there are few patches in queue which need to be
>> reviewed, or which were reviewed and some change for requested:
>>
>> * https://patchwork.kernel.org/patch/11436955/ New [RFC]
>> libsepol,secilc,policycoreutils: add unprivileged sandboxing
>> capability
>> * https://patchwork.kernel.org/patch/11668455/ New selinux: make use of variables when defining libdir and includedir
>>
>> old, without any activity for a long time
>>
>> * https://patchwork.kernel.org/patch/12291637/ New [v2] checkpolicy: fix the leak memory when uses xperms
>>
>> changes requested
>>
>> * https://patchwork.kernel.org/patch/12372487/ New [v2] libselinux: add lock callbacks
>> * https://patchwork.kernel.org/patch/12377593/ New libselinux/utils: drop requirement to combine compiling and linking
>>
>> no response yet
>>
>> * https://patchwork.kernel.org/patch/12420657/ New [userspace]  libsepol/cil: remove obsolete comment
>>
>> acked, ready to be merged
>>
>> * https://patchwork.kernel.org/patch/12422971/ New mcstrans: Improve mlstrans-test output
>>
>> no response yet
>>
>>
>> if I missed something please tell me.
>>
>>
>> There's one issue opened on the mailing list
>>
>> https://lore.kernel.org/selinux/874kc57220.fsf@defensec.nl/T/#t -
>> libsepol regressions
>>
>
> I am working to address this and hope to have something out in the
> next couple of days. I am also working on fixing some issues with the
> line mark stuff in CIL. It would be nice to have both of these in the
> next release, but I don't think they need to hold things up either.
> Jim

It's too soon for me to start worrying about this but:

I don't care if my dssp5 policy breaks due to this regression (that is
what it is) because other than me no one probably uses it, but I also
maintain a policy for OpenWrt which relies on this functionality (or
allowing duplicate blocks, macros) and I would not want to have this
break there come 3.3.

>
>> If you agree and there's no obejction I can start with preparation and
>> plan to release 3.3-rc1 on Wed Aug 18 2021
>>
>>
>> Petr
>>

-- 
gpg --locate-keys dominick.grift@defensec.nl
Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
https://sks-keyservers.net/pks/lookup?op=get&search=0xDA7E521F10F64098
Dominick Grift
