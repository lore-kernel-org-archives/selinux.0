Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81EBCC4338F
	for <selinux@archiver.kernel.org>; Tue,  3 Aug 2021 09:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64D2560F8F
	for <selinux@archiver.kernel.org>; Tue,  3 Aug 2021 09:49:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235237AbhHCJtZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 3 Aug 2021 05:49:25 -0400
Received: from agnus.defensec.nl ([80.100.19.56]:54438 "EHLO agnus.defensec.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235193AbhHCJtZ (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 3 Aug 2021 05:49:25 -0400
Received: from brutus (brutus.lan [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id ECDAC2A008A;
        Tue,  3 Aug 2021 11:49:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 agnus.defensec.nl ECDAC2A008A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defensec.nl;
        s=default; t=1627984149;
        bh=utaDZaj6+2cgrj0IqIu+UTZQurVkClLSMKE8g/AMswQ=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=gtS1NQKdUzwak/Yzgz6Ql304f9/CKxO8n4Da1w3WoYeqVdwHjOb592WIz6vr3ahYi
         XSOcFUSSOD1fNSzFl05pDJ3GJeYVyVp76rl8GlaEmIDdVf5ECoBie+NLdiwzsZzHeF
         T0X7NjaVnLax+FX1gW7epkILP53CZcenaq8gM5+4=
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Subject: Re: libsepol regressions
References: <871r7dtfbp.fsf@defensec.nl>
        <CAP+JOzQt1pxNMZuPK_dzdDHtshrrpEo1ynkFq7CaNpCG1n_JyA@mail.gmail.com>
        <877dh398yi.fsf@defensec.nl>
Date:   Tue, 03 Aug 2021 11:49:05 +0200
In-Reply-To: <877dh398yi.fsf@defensec.nl> (Dominick Grift's message of "Mon,
        02 Aug 2021 17:12:37 +0200")
Message-ID: <87zgty7t9q.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Dominick Grift <dominick.grift@defensec.nl> writes:

> James Carter <jwcart2@gmail.com> writes:
>
>> On Sun, Aug 1, 2021 at 10:32 AM Dominick Grift
>> <dominick.grift@defensec.nl> wrote:
>>>
>>>
>>> Fedora recently decided to pull in various libsepol patches from
>>> master[1]
>>>
>>> My policy has broken down in various way's. Some changes make sense but
>>> some others I have issues with.
>>>
>>> An example of something I never expected to be allowed in the first
>>> place is re-declarations of blocks and recent changes exposed some instances
>>> where I declared blocks multiple times and got away with it.
>>>
>>> However I also encountered issues that i am not sure how to deal
>>> with.
>>>
>>> re-declarations of macros are no longer allowed:
>>>
>>
>> Re-declarations were never supposed to be allowed (other than the
>> declaration of types and typeattributes when using the -m flag), but
>> there were not sufficient checks being done when copying the CIL AST
>> when expanding macro calls, resolving the inheritance of blocks, and
>> things like that.
>>
>> The result was behavior that depends on the rule order and one of the
>> principles of CIL is that there would be no rule order dependencies.
>
> True and I like to be clear about this upfront that from what I can tell
> now I wouldnt mind refusing re-declaration of block and macro *IF* we
> can reliably use "in" consistently and that is currently not the case.
>
> Allowing re-declaration of macros does give more flexibility because it
> allows you to re-define whole macros as opposed to in-statements only allowing
> you to append to existing macros, but that limitation would be something
> I could live with.

After thinking about the above statement for a bit I started to doubt
the claim that re-declaring a macro allows you to fully replace it. It
is actually a true statement.

The added value of being allowed to replace macros over allowing you to
"insert into" existing macros is low in my opinion though and i stick to
my suggestion that allowing in-statements regardless whether you
insert-into a namespace declared manually or using inheritance should be
possible.

I would probably just don't allow re-declaring macros, blocks and
optionals for simplicity and instead I would focus on makeing
in-statements work more intuitively.

The 3.2 behavior of re-declaring blocks and macros is inconsistent
anyway because:

re-declaring a macro redefines the whole thing
re-declaring a block just behaves as a in-statement and allows you to
insert into an existing block when a in-statement cannot be resolved.

It seems as if we were allowed to re-declare macros and blocks just to
avoid having to address the current limitations of in-statements.

Best to just address the current in-statement limiations head-on
IMHO. Then we don't really need those block/macro re-declarations either
AFAIK.

It will yield a consistent and intuitive behavior, which minimizes confusion.

Its just hard to explain to a user:

You cannot insert into a1.b2 because b2 comes from inheritance but you
can insert into a1.b3 because a1.b3 was declared manually.

That is just unwieldy.

>
> The thing is that for me its more important the "in" works reliably in
> the longer run. I mean even if I would be allowed to re-declare macros
> that then still would not allow be to re-declare blocks and I would like
> to have the ability to append to existing blocks.
>
>>
>>> Take this example:
>>> https://github.com/DefenSec/dssp5/blob/dev/src/dev/termdev.cil
>>>
>>> Here I inherit a set of macros from the
>>> "file.all_macro_template_chr_files" template and then I override some of these
>>> macros by manually re-declaring them with slighty different content (the
>>> xperm rules are appended).
>>>
>>> This use to be allowed but I am no longer allowed to redeclare macros.
>>>
>>
>> I can see that this might be useful behavior.
>
> Yes it is useful but I believe that "in" statements should work
> consistently regardless simply because it is not intuitive that you can
> only insert into containers that were not declared using templates.
>
> One should be able to insert into containers regardless of how they were
> constructed IMHO.
>
>>
>>> This would not necessarily be a big problem IF this would instead work:
>>>
>>> diff --git a/src/dev/termdev.cil b/src/dev/termdev.cil
>>> index 1c0fe66..4f067db 100644
>>> --- a/src/dev/termdev.cil
>>> +++ b/src/dev/termdev.cil
>>> @@ -3,21 +3,9 @@
>>>
>>>  (block termdev
>>>
>>> -       (macro appendinherited_all_chr_files ((type ARG1))
>>> -             (allow ARG1 typeattr appendinherited_chr_file)
>>> -             (allowx ARG1 typeattr (ioctl chr_file (not (0x5412)))))
>>> -
>>> -       (macro readwriteinherited_all_chr_files ((type ARG1))
>>> -             (allow ARG1 typeattr readwriteinherited_chr_file)
>>> -             (allowx ARG1 typeattr (ioctl chr_file (not (0x5412)))))
>>> -
>>>         (macro type ((type ARG1))
>>>               (typeattributeset typeattr ARG1))
>>>
>>> -       (macro writeinherited_all_chr_files ((type ARG1))
>>> -             (allow ARG1 typeattr writeinherited_chr_file)
>>> -             (allowx ARG1 typeattr (ioctl chr_file (not (0x5412)))))
>>> -
>>>         (typeattribute typeattr)
>>>
>>>         (blockinherit .file.all_macro_template_chr_files)
>>> @@ -33,3 +21,12 @@
>>>
>>>               (allow typeattr termdev.typeatt
>>>                      (chr_file (not (execmod mounton))))))
>>> +
>>> +(in termdev.appendinherited_all_chr_files
>>> +    (allowx ARG1 typeattr (ioctl chr_file (not (0x5412)))))
>>> +
>>> +(in termdev.readwriteinherited_all_chr_files
>>> +    (allowx ARG1 typeattr (ioctl chr_file (not (0x5412)))))
>>> +
>>> +(in termdev.writeinherited_all_chr_files
>>> +    (allowx ARG1 typeattr (ioctl chr_file (not (0x5412)))))
>>>
>>> But the above in-statements cannot be resolved.
>>>
>>
>> I think that overriding the macros would make more sense, but I'll
>> have to think about it.
>
> Maybe, but I think that regardless this should just have worked. Would
> you not agree? Are there unsurmountable technical difficulties?
>
>>
>> It would be a pain, but you could do something like:
>> (block B1
>>   (macro M1 (...)
>>     ...
>>   )
>>   (macro M2 (...)
>>     ...
>>   )
>> )
>>
>> (block B2
>>   (block parent
>>     (blockinherit B1)
>>   )
>>   (macro M1 (...)
>>     (call parent.M1 (...))
>>     ...
>>   )
>>   (macro M2 (...)
>>     (call parent.MA (...))
>>     ...
>>   )
>> )
>>
>>> This is not the only instance where this approach does not work. I also
>>> have templates that declare blocks. I use to be allowed to re-declare
>>> these blocks so that I could add to them but this is no longer
>>> allowed. However these blocks also cannot be resolved outside of the
>>> templates, so I cannot use "in" to reference them.
>>>
>>> It seems as if the "in" blocks are resolved before the "blockinherit"
>>> blocks are expanded.
>>>
>>
>> It is true that in-statements are resolved before inheritance, so what
>> you have above would not work.
>
> That seems unintuitive to me. I mean you can properly inherit blocks
> with all bells and whistless as long as the block does not inherit. If
> it inherits then bets are off. That seems inconsistent.
>
>>
>> If you are just adding rules and not declarations, then you don't have
>> to put the rules in the block.
>> Example:
>> (block B1
>>   (block B
>>     (type t)
>>    )
>> )
>> (block B2
>>   (blockinherit B1)
>>   (allow B.t self (CLASS (PERM)))
>> )
>
> Yes sure theres alway's a hack and if all else fails then I guess I will
> have to explore my options, but it feels wrong.
>
>>
>> It might be possible to attempt to resolve all in-statements before
>> inheritance as what currently happens and then try to resolve any
>> remaining in-statements after inheritance has been resolved.
>>
>> I'll have to think about the problem a bit.
>
> Thanks!
>
>>
>> Thanks for the questions,
>> Jim
>>
>>
>>
>> The problem
>>> [1] https://src.fedoraproject.org/rpms/libsepol/c/c59879b8aa30ceb601ac4e449ee5e958c6659fbc?branch=rawhide
>>>
>>> --
>>> gpg --locate-keys dominick.grift@defensec.nl
>>> Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
>>> https://sks-keyservers.net/pks/lookup?op=get&search=0xDA7E521F10F64098
>>> Dominick Grift

-- 
gpg --locate-keys dominick.grift@defensec.nl
Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
https://sks-keyservers.net/pks/lookup?op=get&search=0xDA7E521F10F64098
Dominick Grift
