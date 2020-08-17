Return-Path: <SRS0=6AtE=B3=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E400C433E3
	for <selinux@archiver.kernel.org>; Mon, 17 Aug 2020 18:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 362742078E
	for <selinux@archiver.kernel.org>; Mon, 17 Aug 2020 18:08:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b="YaW26ngE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388257AbgHQSIz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:08:55 -0400
Received: from agnus.defensec.nl ([80.100.19.56]:51158 "EHLO agnus.defensec.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388357AbgHQSIc (ORCPT <rfc822;selinux@vger.kernel.org>);
        Mon, 17 Aug 2020 14:08:32 -0400
Received: from brutus (brutus.lan [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id 4F9762A1283;
        Mon, 17 Aug 2020 20:08:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 agnus.defensec.nl 4F9762A1283
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defensec.nl;
        s=default; t=1597687708;
        bh=ODXlLwlyZfOT/21dD0lIV/M8ir2mHqlZ8gSYC1WPJZU=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=YaW26ngENK8pksBxr+0saWOcFcKJfu8M5EA2G59tKZQUjL7JI6iWu7gSI4+Ka5u5j
         vHrSbQ0mAlWhblTEJxD1wErUHQ/HS74hM0yP3AgVosiFScRy0TSEcA8K9X4QjlJtmG
         IGUXsFovIVqbvZUk6jEz0PYMpzl+c0/7Nx28ItfI=
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     James Carter <jwcart2@gmail.com>
Cc:     bauen1 <j2468h@googlemail.com>, selinux <selinux@vger.kernel.org>
Subject: Re: Resource usage of CIL compared to HLL
References: <2ce8defb-523c-01c0-560c-7881d0a99416@gmail.com>
        <CAP+JOzStOhn92uN_04R8JbVy1_5noQUVfoG-O6+2WnsKG8tcdw@mail.gmail.com>
Date:   Mon, 17 Aug 2020 20:08:23 +0200
In-Reply-To: <CAP+JOzStOhn92uN_04R8JbVy1_5noQUVfoG-O6+2WnsKG8tcdw@mail.gmail.com>
        (James Carter's message of "Mon, 17 Aug 2020 13:49:41 -0400")
Message-ID: <ypjlo8n9p2lk.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

James Carter <jwcart2@gmail.com> writes:

> On Mon, Aug 17, 2020 at 9:48 AM bauen1 <j2468h@googlemail.com> wrote:
>>
>> Hi,
>>
>> I usually test all my patches against refpolicy and my own cil
>> policy (https://gitlab.com/bauen1/bauen1-policy/) on small VMs in
>> the range of 1 vcpu, 512mb memory and a few gb of disk space
>> (Comparable to the cheapest VPS plan you can get and still run
>> reasonable stuff on).
>> Recently I've started hitting the memory limit while building my cil policy using semodule / secilc.
>>
>> I've found that secilc can easily hit ~400mb memory usage while building dssp3 or ~260mb while building my policy.
>> semodule invokes the same functions as secilc to build the policy
>> but requires somewhere between 100mb - 200mb for whatever it is
>> doing.
>> Running semodule against a normal refpolicy installation only requires ~160mb memory total.
>> This means that installing refpolicy on my VMs is not an issue, but
>> even my CIL policy that is far from complete will easily OOM the
>> machine.
>> While adding additional memory isn't really an issue, I'm a bit
>> annoyed that building an incomplete CIL policy requires ~2.8 times
>> the memory that a complete refpolicy requires.
>>
>> After a bit of testing using valgrind, I believe this is mostly due
>> to the way CIL handles blockinherit by duplicating the entire AST of
>> the original block into the target.
>> This works very well and is very simple, but also doesn't scale very well.
>> For example my policy has a few "base templates",
>> e.g. `file.template` that contain a lot of general use macros,
>> e.g. `relabel_files`, `manage_blk_files`. A similar approach is
>> taken by grift in dssp3.
>> All of these macros (~130) are copied to every block containing a file type (only ~470) resulting in a lot of duplicate memory.
>>
>> Is it even possible to change libsepol, e.g. to use a COW for
>> copy_ast_tree (and similiar) or is this behavior required e.g. for
>> `in` or would a change not be worth it due to additional complexity
>> ?
>>
>
> Long before we developed CIL I had experimented with parsing Refpolicy
> with a lua program that I created. I was really worried about memory
> usage when developing that, so I did not copy anything. When it was
> proposed to copy the AST for CIL I was sceptical and reworked my lua
> program to see what the impact would be. It turned out to be easier to
> do, faster, and did not require any more memory. The memory lost due
> to copying the AST was made up by not having as many symbol tables.
>
> If a lot of the macros that are being inherited are not used, then it
> might be worthwhile to add a step to remove unused macros. Of course,
> to really save the memory usage only the macros that are going to be
> used should be copied, but I don't think that would be easy to do.
>
> I will admit that I am not a big user of inheritance. What is gained
> from inheriting all of the macros like that?

consistency and comprehensiveness.

In reffpolicy based policy its tempting to quickly copy and paste macros
when you need them, leading to all kinds of inconsistencies ranging from
descriptions that are wrong because one forgot to edit it after a copy
paste to inconsistent macro names because it can be hard to be
consistent with naming. Consistency is very important as there is almost
nothing as annoying as guessing an interface/macro name wrong time after
time because of an inconsistency.

Having a comphrensive collection of inherited macros means that most of
the time you dont have to deal with/worry about creating macros. It might also come
in handy later if at some point an CIL-aware audit2allow -R type
functionality arrives.

That at one point was a pain point with refpolicy I believe were
audit2allow -R wouldnt suggest an interface to use because the interface did not
exist. By predefining all macros you ensure that audit2allow -R finds
something.

>
> Thanks for the report. I will take a look to see if there might be a
> fairly easy way to improve the situation.
> Jim

-- 
gpg --locate-keys dominick.grift@defensec.nl
Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
https://sks-keyservers.net/pks/lookup?op=get&search=0xDA7E521F10F64098
Dominick Grift
