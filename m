Return-Path: <SRS0=dV66=BO=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5FAEC433DF
	for <selinux@archiver.kernel.org>; Tue,  4 Aug 2020 07:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C2912076C
	for <selinux@archiver.kernel.org>; Tue,  4 Aug 2020 07:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b="LP5uDQEE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729432AbgHDHSv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 4 Aug 2020 03:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727806AbgHDHSu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 4 Aug 2020 03:18:50 -0400
Received: from agnus.defensec.nl (agnus.defensec.nl [IPv6:2001:985:d55d::711])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CF6D0C06174A
        for <selinux@vger.kernel.org>; Tue,  4 Aug 2020 00:18:49 -0700 (PDT)
Received: from brutus (brutus.lan [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id 66DB42A0FFC;
        Tue,  4 Aug 2020 09:18:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 agnus.defensec.nl 66DB42A0FFC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defensec.nl;
        s=default; t=1596525526;
        bh=0iw6gqSXTn9JnKPbE1N0YoAucpWOBI9IhMA8t1/+9WY=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=LP5uDQEEPgTy2tSka8SJ7RifQ97dA1eqKOpEQctFnmQKzYvVmJXa064FwEEZaem7J
         xcYHftheWUSx2MoWizWCtuZRkJehc5k2092/nKjf8pDdMAHkg5+1Y3aK8pcwaa7N32
         ezR/Ee7PGYfOUx1fnVHqdno1n4MvbbnWupIPvTvI=
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Subject: Re: [PATCH v4] secilc/docs: document expandtypeattribute
References: <CAP+JOzQMM5YpemgPXzAZew+oHiV6fgPuuY5WFSyQb2cEkFLwRA@mail.gmail.com>
        <20200802123421.222597-1-dominick.grift@defensec.nl>
        <CAP+JOzQ=wnAWHp7i6OVjpV58QxdFPT63ON7HOLuVHjoL8O2Oqg@mail.gmail.com>
Date:   Tue, 04 Aug 2020 09:18:41 +0200
In-Reply-To: <CAP+JOzQ=wnAWHp7i6OVjpV58QxdFPT63ON7HOLuVHjoL8O2Oqg@mail.gmail.com>
        (James Carter's message of "Mon, 3 Aug 2020 16:56:50 -0400")
Message-ID: <ypjlft9298vi.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

James Carter <jwcart2@gmail.com> writes:

> On Sun, Aug 2, 2020 at 8:39 AM Dominick Grift
> <dominick.grift@defensec.nl> wrote:
>>
>> This was added for Androids Treble in 2017.
>>
>> Signed-off-by: Dominick Grift <dominick.grift@defensec.nl>
>> ---
>> v2: overriden is overridden
>> v3: add link to README.md
>> v4: rephrase and add another example
>>
>>  secilc/docs/README.md              |  1 +
>>  secilc/docs/cil_type_statements.md | 44 ++++++++++++++++++++++++++++++
>>  2 files changed, 45 insertions(+)
>>
>> diff --git a/secilc/docs/README.md b/secilc/docs/README.md
>> index 3f1838e6..efab2a71 100644
>> --- a/secilc/docs/README.md
>> +++ b/secilc/docs/README.md
>> @@ -126,6 +126,7 @@ CIL (Common Intermediate Language)
>>    * [typealiasactual](cil_type_statements.md#typealiasactual)
>>    * [typeattribute](cil_type_statements.md#typeattribute)
>>    * [typeattributeset](cil_type_statements.md#typeattributeset)
>> +  * [expandtypeattribute](cil_type_statements.md#expandtypeattribute)
>>    * [typebounds](cil_type_statements.md#typebounds)
>>    * [typechange](cil_type_statements.md#typechange)
>>    * [typemember](cil_type_statements.md#typemember)
>> diff --git a/secilc/docs/cil_type_statements.md b/secilc/docs/cil_type_statements.md
>> index f9dd3a76..41f0f01a 100644
>> --- a/secilc/docs/cil_type_statements.md
>> +++ b/secilc/docs/cil_type_statements.md
>> @@ -213,6 +213,50 @@ This example is equivalent to `{ domain -kernel.process -ueventd.process -init.p
>>          )
>>      )
>>
>> +expandtypeattribute
>> +-------------------
>> +
>> +Overrides the compiler defaults for the expansion of one or more previously declared [`typeattribute`](cil_type_statements.md#typeattribute) identifiers.
>> +
>> +Note that this statement can be overridden at compile-time with `secilc -X SIZE` and that this functionality is not intended to override `secilc -X SIZE` for individual type attributes!
>> +

<snip> 
> When the value
> is false, the type attribute will not be removed from the policy, even
> if the default expand rules or "-X" option cause the rules involving
> the type attribute to be expanded.

Yes but I cannot produce that. In my earlier test the type attribute
was expanded regardless of the -X option.

In my test I instructed secilc to expand all attributes with more than 3
members (-X 4), then I added a expandtypeattribute statement telling
secilc to not expand pets and colors.

The result was that it expanded pets and colors anyway.

>
> Thanks,
> Jim
>
>> +**Statement definition:**
>> +
>> +    (expandtypeattribute typeattribute_id true|false)
>> +
>> +**Where:**
>> +
>> +<table>
>> +<colgroup>
>> +<col width="25%" />
>> +<col width="75%" />
>> +</colgroup>
>> +<tbody>
>> +<tr class="odd">
>> +<td align="left"><p><code>expandtypeattribute</code></p></td>
>> +<td align="left"><p>The <code>expandtypeattribute</code> keyword.</p></td>
>> +</tr>
>> +<tr class="even">
>> +<td align="left"><p><code>typeattribute_id</code></p></td>
>> +<td align="left"><p>One or more previously declared
>> <code>typeattribute</code> identifiers. Multiple entries consist of
>> a space separated list enclosed in parentheses '()'.</p></td>
>> +</tr>
>> +<tr class="odd">
>> +<td align="left"><p><code>true | false</code></p></td>
>> +<td align="left"><p>Either true or false.</p></td>
>> +</tr>
>> +</tbody>
>> +</table>
>> +
>> +**Examples:**
>> +
>> +This example uses the expandtypeattribute statement to forcibly expand a previously declared `domain` type attribute.
>> +
>> +    (expandtypeattribute domain true)
>> +
>> +This example uses the expandtypeattribute statement to not expand
>> previously declared `file_type` and `port_type` type attributes
>> regardless of compiler defaults.
>> +
>> +    (expandtypeattribute (file_type port_type) false)
>> +
>>  typebounds
>>  ----------
>>
>> --
>> 2.28.0
>>

-- 
gpg --locate-keys dominick.grift@defensec.nl
Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
https://sks-keyservers.net/pks/lookup?op=get&search=0xDA7E521F10F64098
Dominick Grift
