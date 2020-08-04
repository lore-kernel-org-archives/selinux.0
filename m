Return-Path: <SRS0=dV66=BO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D97FDC433DF
	for <selinux@archiver.kernel.org>; Tue,  4 Aug 2020 15:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CB142177B
	for <selinux@archiver.kernel.org>; Tue,  4 Aug 2020 15:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b="CVBYiEIi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbgHDPsz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 4 Aug 2020 11:48:55 -0400
Received: from agnus.defensec.nl ([80.100.19.56]:52230 "EHLO agnus.defensec.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725864AbgHDPsx (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 4 Aug 2020 11:48:53 -0400
Received: from brutus (brutus.lan [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id 6A5F82A100B;
        Tue,  4 Aug 2020 17:48:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 agnus.defensec.nl 6A5F82A100B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defensec.nl;
        s=default; t=1596556129;
        bh=DD0J8KEw7KV23wQriOYvIuGPCCcQxsg8MLHghNydYGk=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=CVBYiEIiNSKjp+L3YlYNLkE5oedgjOUm3aI5K9/gov6vTDG2Z8cjEvUoJ7OUyx3vt
         thxsZAGUEnxmWXJniTn7a7SFCv+ZQFwWDAdwSCaDYeyNF5k1zYfxomTIw5mZsopASO
         TRizs2tV9sOg0EX12d+oDJlr+tzD06UBjv0ZIThs=
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Subject: Re: [PATCH v4] secilc/docs: document expandtypeattribute
References: <CAP+JOzQMM5YpemgPXzAZew+oHiV6fgPuuY5WFSyQb2cEkFLwRA@mail.gmail.com>
        <20200802123421.222597-1-dominick.grift@defensec.nl>
        <CAP+JOzQ=wnAWHp7i6OVjpV58QxdFPT63ON7HOLuVHjoL8O2Oqg@mail.gmail.com>
        <ypjlft9298vi.fsf@defensec.nl>
        <CAP+JOzRgJmD8NE-_nY118G_h7B70Y70=jT1n8TimcMGPjDYFxw@mail.gmail.com>
Date:   Tue, 04 Aug 2020 17:48:46 +0200
In-Reply-To: <CAP+JOzRgJmD8NE-_nY118G_h7B70Y70=jT1n8TimcMGPjDYFxw@mail.gmail.com>
        (James Carter's message of "Tue, 4 Aug 2020 10:45:06 -0400")
Message-ID: <ypjlbljq8l9d.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

James Carter <jwcart2@gmail.com> writes:

> On Tue, Aug 4, 2020 at 3:18 AM Dominick Grift
> <dominick.grift@defensec.nl> wrote:
>>
>> James Carter <jwcart2@gmail.com> writes:
>>
>> > On Sun, Aug 2, 2020 at 8:39 AM Dominick Grift
>> > <dominick.grift@defensec.nl> wrote:
>> >>
>> >> This was added for Androids Treble in 2017.
>> >>
>> >> Signed-off-by: Dominick Grift <dominick.grift@defensec.nl>
>> >> ---
>> >> v2: overriden is overridden
>> >> v3: add link to README.md
>> >> v4: rephrase and add another example
>> >>
>> >>  secilc/docs/README.md              |  1 +
>> >>  secilc/docs/cil_type_statements.md | 44 ++++++++++++++++++++++++++++++
>> >>  2 files changed, 45 insertions(+)
>> >>
>> >> diff --git a/secilc/docs/README.md b/secilc/docs/README.md
>> >> index 3f1838e6..efab2a71 100644
>> >> --- a/secilc/docs/README.md
>> >> +++ b/secilc/docs/README.md
>> >> @@ -126,6 +126,7 @@ CIL (Common Intermediate Language)
>> >>    * [typealiasactual](cil_type_statements.md#typealiasactual)
>> >>    * [typeattribute](cil_type_statements.md#typeattribute)
>> >>    * [typeattributeset](cil_type_statements.md#typeattributeset)
>> >> +  * [expandtypeattribute](cil_type_statements.md#expandtypeattribute)
>> >>    * [typebounds](cil_type_statements.md#typebounds)
>> >>    * [typechange](cil_type_statements.md#typechange)
>> >>    * [typemember](cil_type_statements.md#typemember)
>> >> diff --git a/secilc/docs/cil_type_statements.md b/secilc/docs/cil_type_statements.md
>> >> index f9dd3a76..41f0f01a 100644
>> >> --- a/secilc/docs/cil_type_statements.md
>> >> +++ b/secilc/docs/cil_type_statements.md
>> >> @@ -213,6 +213,50 @@ This example is equivalent to `{ domain -kernel.process -ueventd.process -init.p
>> >>          )
>> >>      )
>> >>
>> >> +expandtypeattribute
>> >> +-------------------
>> >> +
>> >> +Overrides the compiler defaults for the expansion of one or more previously declared [`typeattribute`](cil_type_statements.md#typeattribute) identifiers.
>> >> +
>> >> +Note that this statement can be overridden at compile-time with `secilc -X SIZE` and that this functionality is not intended to override `secilc -X SIZE` for individual type attributes!
>> >> +
>>
>> <snip>
>> > When the value
>> > is false, the type attribute will not be removed from the policy, even
>> > if the default expand rules or "-X" option cause the rules involving
>> > the type attribute to be expanded.
>>
>> Yes but I cannot produce that. In my earlier test the type attribute
>> was expanded regardless of the -X option.
>>
>> In my test I instructed secilc to expand all attributes with more than 3
>> members (-X 4), then I added a expandtypeattribute statement telling
>> secilc to not expand pets and colors.
>>
>> The result was that it expanded pets and colors anyway.
>>
>
> I see the source of your confusion now. "-X 4" means that all
> attributes with LESS than 4 types associated with it will be expanded.

I think its important to clarify this in the documentation. ie:
expandattribute false will not work if you use -X (-X will override the
false statement)

I think that is unintuitive, I would actually want to be able to for
example expand all attributes with less then 4 members except a few
specific ones.

>
> Jim
>
>> >
>> > Thanks,
>> > Jim
>> >
>> >> +**Statement definition:**
>> >> +
>> >> +    (expandtypeattribute typeattribute_id true|false)
>> >> +
>> >> +**Where:**
>> >> +
>> >> +<table>
>> >> +<colgroup>
>> >> +<col width="25%" />
>> >> +<col width="75%" />
>> >> +</colgroup>
>> >> +<tbody>
>> >> +<tr class="odd">
>> >> +<td align="left"><p><code>expandtypeattribute</code></p></td>
>> >> +<td align="left"><p>The <code>expandtypeattribute</code> keyword.</p></td>
>> >> +</tr>
>> >> +<tr class="even">
>> >> +<td align="left"><p><code>typeattribute_id</code></p></td>
>> >> +<td align="left"><p>One or more previously declared
>> >> <code>typeattribute</code> identifiers. Multiple entries consist of
>> >> a space separated list enclosed in parentheses '()'.</p></td>
>> >> +</tr>
>> >> +<tr class="odd">
>> >> +<td align="left"><p><code>true | false</code></p></td>
>> >> +<td align="left"><p>Either true or false.</p></td>
>> >> +</tr>
>> >> +</tbody>
>> >> +</table>
>> >> +
>> >> +**Examples:**
>> >> +
>> >> +This example uses the expandtypeattribute statement to forcibly expand a previously declared `domain` type attribute.
>> >> +
>> >> +    (expandtypeattribute domain true)
>> >> +
>> >> +This example uses the expandtypeattribute statement to not expand
>> >> previously declared `file_type` and `port_type` type attributes
>> >> regardless of compiler defaults.
>> >> +
>> >> +    (expandtypeattribute (file_type port_type) false)
>> >> +
>> >>  typebounds
>> >>  ----------
>> >>
>> >> --
>> >> 2.28.0
>> >>
>>
>> --
>> gpg --locate-keys dominick.grift@defensec.nl
>> Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
>> https://sks-keyservers.net/pks/lookup?op=get&search=0xDA7E521F10F64098
>> Dominick Grift

-- 
gpg --locate-keys dominick.grift@defensec.nl
Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
https://sks-keyservers.net/pks/lookup?op=get&search=0xDA7E521F10F64098
Dominick Grift
