Return-Path: <SRS0=0Nxr=BK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51113C433DF
	for <selinux@archiver.kernel.org>; Fri, 31 Jul 2020 07:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8BA920663
	for <selinux@archiver.kernel.org>; Fri, 31 Jul 2020 07:26:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=defensec.nl header.i=@defensec.nl header.b="avjZXks0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731574AbgGaH0S (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 Jul 2020 03:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731419AbgGaH0S (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 Jul 2020 03:26:18 -0400
Received: from agnus.defensec.nl (agnus.defensec.nl [IPv6:2001:985:d55d::711])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BC581C061574
        for <selinux@vger.kernel.org>; Fri, 31 Jul 2020 00:26:17 -0700 (PDT)
Received: from brutus (brutus.lan [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id ED8DC2A0EFE;
        Fri, 31 Jul 2020 09:26:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 agnus.defensec.nl ED8DC2A0EFE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defensec.nl;
        s=default; t=1596180376;
        bh=RJqVDW6aDCaKHd20adY2UIEUi0RfNHMPcZEiQAiSjXM=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=avjZXks0CWRFsroTv7v/iTk1RN4zwYtZ93Kobr7VJ5uPverrH9AKN2hZM/RWz/W68
         s/aUF5Dy4zbKOPAjrwiZbky9BhFqYpo7lspFOnowvQo7mZdjL7Exn06uUGuMo6jFYl
         0iYXqcGJNVkm8378NLWnHUCtxZN37kqFesKEUu/s=
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Subject: Re: [PATCH v3] secilc/docs: document expandtypeattribute
References: <20200730114555.915996-1-dominick.grift@defensec.nl>
        <20200730131149.928220-1-dominick.grift@defensec.nl>
        <CAP+JOzQMM5YpemgPXzAZew+oHiV6fgPuuY5WFSyQb2cEkFLwRA@mail.gmail.com>
Date:   Fri, 31 Jul 2020 09:26:11 +0200
In-Reply-To: <CAP+JOzQMM5YpemgPXzAZew+oHiV6fgPuuY5WFSyQb2cEkFLwRA@mail.gmail.com>
        (James Carter's message of "Thu, 30 Jul 2020 18:22:37 -0400")
Message-ID: <ypjlh7tom9gs.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

James Carter <jwcart2@gmail.com> writes:

> On Thu, Jul 30, 2020 at 9:14 AM Dominick Grift
> <dominick.grift@defensec.nl> wrote:
>>
>> This was added for Androids Treble in 2017.
>>
>> I was unsure whether this belongs in type_statements or in conditional_statements.
>>
>
> I think that it fits best with the type statements as you have it.
>
>> Signed-off-by: Dominick Grift <dominick.grift@defensec.nl>
>> ---
>> v2: overriden is overridden
>> v3: add link to README.md
>>
>>  secilc/docs/README.md              |  1 +
>>  secilc/docs/cil_type_statements.md | 38 ++++++++++++++++++++++++++++++
>>  2 files changed, 39 insertions(+)
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
>> index f9dd3a76..f819b3c6 100644
>> --- a/secilc/docs/cil_type_statements.md
>> +++ b/secilc/docs/cil_type_statements.md
>> @@ -213,6 +213,44 @@ This example is equivalent to `{ domain -kernel.process -ueventd.process -init.p
>>          )
>>      )
>>
>> +expandtypeattribute
>> +-------------------
>> +
>> +Allows expansion compiler defaults for one or more previously declared [`typeattribute`](cil_type_statements.md#typeattribute) identifiers to be overridden.
>
> The wording confused me at first.
> I think "Overrides the compiler defaults for the expansion of one ...
> identifiers." would be clearer.
>
>> +
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
>> +<td align="left"><p>One or more previously declared <code>typeattribute</code> identifiers.</p></td>
>> +</tr>
>> +<tr class="odd">
>> +<td align="left"><p><code>true | false</code></p></td>
>> +<td align="left"><p>Either true or false.</p></td>
>> +</tr>
>> +</tbody>
>> +</table>
>> +
>> +**Example:**
>> +
>> +This example will use the expandtypeattribute statement to forcibly expand a previously declared `domain` type attribute.
>> +
>> +    (expandtypeattribute domain true)
>> +
>
> It would be nice to have another example that shows a list of type
> attributes, so there is an example of that syntax as well.

I was looking into an example but turns out that either i am
misunderstanding this functionality or that it does not work as advertised:

Example:

1. compiler defaults to expand typeattributes with less
than four members
2. override pets and dogs expansion in policy

# cat > mytest.cil <<EOF
(sid mysid)
(sidorder (mysid))

(class myclass (mypermission))
(classorder (unordered myclass))

(type blue)
(type green)
(type red)
(typeattribute colors)
(typeattributeset colors (blue green red))

(type dog)
(type cat)
(type goldfish)
(typeattribute pets)
(typeattributeset pets (dog cat goldfish))

(dontaudit pets colors (myclass (mypermission)))

(expandtypeattribute (colors pets) false)
EOF

# secilc -v -X 4 mytest.cil
# sesearch policy.32 --dontaudit

>
> Thanks for doing this.
> Jim
>
>>  typebounds
>>  ----------
>>
>> --
>> 2.28.0.rc1
>>

-- 
gpg --locate-keys dominick.grift@defensec.nl
Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
https://sks-keyservers.net/pks/lookup?op=get&search=0xDA7E521F10F64098
Dominick Grift
