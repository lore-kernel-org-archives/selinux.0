Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A64C432BE
	for <selinux@archiver.kernel.org>; Thu, 26 Aug 2021 13:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16B3160FC1
	for <selinux@archiver.kernel.org>; Thu, 26 Aug 2021 13:21:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233789AbhHZNWD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 26 Aug 2021 09:22:03 -0400
Received: from agnus.defensec.nl ([80.100.19.56]:41786 "EHLO agnus.defensec.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229844AbhHZNWD (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 26 Aug 2021 09:22:03 -0400
Received: from brutus (brutus.lan [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id EAD812A00B8;
        Thu, 26 Aug 2021 15:21:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 agnus.defensec.nl EAD812A00B8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defensec.nl;
        s=default; t=1629984075;
        bh=UpZRy070Bb0UFawomW4gcgDORhjBnF5cjq5zNk+OtPQ=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=FLdxqEVUVH5xMSaxWtDgpP9UFHEmyxtJexGGwQiAHkuhCTewAVH48FphAIljUPSn0
         S0QIbJXTgIi50jbIgSKhaIoWa1DEsSz3X98yWx4Vkz+nKBUiNkACEduP1iqNWIIzbC
         j4umKFX3yKNIs46FC0tjEdO4t8ViLzV+T7IStKJo=
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     Vit Mojzis <vmojzis@redhat.com>
Cc:     selinux@vger.kernel.org, Lukas Vrabec <lvrabec@redhat.com>
Subject: Re: Cil block inheritance
References: <81ea2624-ace9-4d86-9506-d6527a770cf6@redhat.com>
        <877dg8l83w.fsf@defensec.nl>
        <ce82e933-ceb8-a293-c57e-6dd6f8c31254@redhat.com>
Date:   Thu, 26 Aug 2021 15:21:12 +0200
In-Reply-To: <ce82e933-ceb8-a293-c57e-6dd6f8c31254@redhat.com> (Vit Mojzis's
        message of "Thu, 26 Aug 2021 14:38:30 +0200")
Message-ID: <8735qwl4tz.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Vit Mojzis <vmojzis@redhat.com> writes:

> On 26. 08. 21 14:10, Dominick Grift wrote:
>> Vit Mojzis <vmojzis@redhat.com> writes:
>>
>>> Hi,
>>> recent changes in block inheritance broke our use case where we use
>>> block inheritance for generating container policies
>>> (https://github.com/containers/udica/tree/main/udica/templates). Basica=
lly
>>> the policy is composed by inheriting selected "template" blocks, all
>>> of which inherit "container" block, so that they can use types defined
>>> there.
>>>
>>> Reproducer:
>>> (block template1 (type t) )
>>> (block template2 (blockinherit template1))
>>> (block b (blockinherit template1) (blockinherit template2))
>> In this example there is no point in inheriting template1, because
>> template2 already inherits it.
>>
>> (block template1
>>         (type t))
>> (block template2
>>         (blockinherit template1))
>> (block b (blockinherit template2)
>>         (allow t t (file (read))))
>>
>> semodule -i test.cil
>> seinfo -t b.t
> Sure, but with more templates (as we have in udica) we get the same issue.
>
> (block template1 (type t) )
> (block template2 (blockinherit template1))
> (block template3 (blockinherit template1))
> (block b (blockinherit template2) (blockinherit template3))

This boils down to the same as above, yes.

>
> # semodule -i test.cil
> Re-declaration of type t
> Previous declaration of type at /var/lib/selinux/targeted/tmp/modules/400=
/test/cil:1
> Failed to copy block contents into blockinherit
> Failed to resolve AST
> semodule:  Failed!
>
>
> Template2 and template3 mostly inherit template1 for the type defined
> there (so that they can define rules containing the type).
>
>>
>>> #semodule -i test.cil
>>> Re-declaration of type t
>>> Previous declaration of type at
>>> /var/lib/selinux/targeted/tmp/modules/400/test/cil:1
>>> Failed to copy block contents into blockinherit
>>> Failed to resolve AST
>>> semodule: Failed!
>>>
>>> This used to work just fine.
>>>
>>> The following workaround seems to be working as intended, but I'm not
>>> sure if it's the best approach. Types are only defined in template1
>>> and the rest contains "optional" block, so that I can use types
>>> defined in template1).
>>>
>>> (block template1 (type t))
>>> (block template2
>>>  =C2=A0=C2=A0 =C2=A0 (optional o
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0 (allow t t ( file ( read )=
))
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 )
>>> )
>>> (block b (blockinherit template1) (blockinherit template2))
>> You can just do something like this:
>>
>> (block template1 (type t))
>> (block template2 (blockinherit template1) (optional o (allow t t (file
>> (read))))
>> (block b (blockinherit template2))
>> semodule -i test.cil
>> sesearch -A -t b.t
> With more templates, this break as well.
>
> But the following works:
>
> (block template1 (type t))
> (block template2 (optional o (allow t t (file (read)))))
> (block template3 (optional o (allow t t (file (write)))))
> (block b (blockinherit template1) (blockinherit template2) (blockinherit =
template3))
>
> #semodule -i test.cil
> #sesearch -A -s b.t
> allow b.t b.t:file { read write };
>
> Again, I'm not sure if this is the best solution, just the only one I man=
aged to get working.

Looks good enough to me (if it works then it works). I am just surprised th=
at
the duplicate 'o' optional block is allowed.

Duplicate type declarations are no longer allowed as you noticed, but
fortunately you do not need them.

Whether this eventually is the best solution probably depends on other
aspects of the policy and on the requirements.

>
> Vit
>
>>> #semodule -i test.cil
>>> #sesearch -A -s b.t
>>> allow b.t b.t:file read;
>>>
>>> Any pointers would be appreciated.
>>>
>>> Thank you.
>>>
>>> Vit
>>>
>

--=20
gpg --locate-keys dominick.grift@defensec.nl
Key fingerprint =3D FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0xDA7E521F10F64098
Dominick Grift
