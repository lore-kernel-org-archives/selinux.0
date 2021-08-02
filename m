Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C15C4338F
	for <selinux@archiver.kernel.org>; Mon,  2 Aug 2021 15:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C9D560FF2
	for <selinux@archiver.kernel.org>; Mon,  2 Aug 2021 15:12:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234690AbhHBPMx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 2 Aug 2021 11:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234856AbhHBPMx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 2 Aug 2021 11:12:53 -0400
Received: from agnus.defensec.nl (agnus.defensec.nl [IPv6:2001:985:d55d::711])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E3326C06175F
        for <selinux@vger.kernel.org>; Mon,  2 Aug 2021 08:12:42 -0700 (PDT)
Received: from brutus (brutus.lan [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id 7E5F92A006A;
        Mon,  2 Aug 2021 17:12:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 agnus.defensec.nl 7E5F92A006A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defensec.nl;
        s=default; t=1627917160;
        bh=yRRqivS2IjSsgKrPrJ9OxE09beHKP4t2RH1mVKcK3P4=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=mPkxlcRCyrYvmW1gOEA79Uc9I+h2EGRkD5Hua1PIjrnQecQyoACg22mC44uj9vTQE
         DYaZ9A4neXdjuDdIxKu3GVVntH34xzRxoHJsVjqCyT3aWf6/fDbC0xgxIlB2vy7fI4
         TXKoHhfeOvqEa12J24aLkutsUAAC8OMVOE7ow2YI=
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Subject: Re: libsepol regressions
References: <871r7dtfbp.fsf@defensec.nl>
        <CAP+JOzQt1pxNMZuPK_dzdDHtshrrpEo1ynkFq7CaNpCG1n_JyA@mail.gmail.com>
Date:   Mon, 02 Aug 2021 17:12:37 +0200
In-Reply-To: <CAP+JOzQt1pxNMZuPK_dzdDHtshrrpEo1ynkFq7CaNpCG1n_JyA@mail.gmail.com>
        (James Carter's message of "Mon, 2 Aug 2021 10:50:19 -0400")
Message-ID: <877dh398yi.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

James Carter <jwcart2@gmail.com> writes:

> On Sun, Aug 1, 2021 at 10:32 AM Dominick Grift
> <dominick.grift@defensec.nl> wrote:
>>
>>
>> Fedora recently decided to pull in various libsepol patches from
>> master[1]
>>
>> My policy has broken down in various way's. Some changes make sense but
>> some others I have issues with.
>>
>> An example of something I never expected to be allowed in the first
>> place is re-declarations of blocks and recent changes exposed some instances
>> where I declared blocks multiple times and got away with it.
>>
>> However I also encountered issues that i am not sure how to deal
>> with.
>>
>> re-declarations of macros are no longer allowed:
>>
>
> Re-declarations were never supposed to be allowed (other than the
> declaration of types and typeattributes when using the -m flag), but
> there were not sufficient checks being done when copying the CIL AST
> when expanding macro calls, resolving the inheritance of blocks, and
> things like that.
>
> The result was behavior that depends on the rule order and one of the
> principles of CIL is that there would be no rule order dependencies.

True and I like to be clear about this upfront that from what I can tell
now I wouldnt mind refusing re-declaration of block and macro *IF* we
can reliably use "in" consistently and that is currently not the case.

Allowing re-declaration of macros does give more flexibility because it
allows you to re-define whole macros as opposed to in-statements only allowing
you to append to existing macros, but that limitation would be something
I could live with.

The thing is that for me its more important the "in" works reliably in
the longer run. I mean even if I would be allowed to re-declare macros
that then still would not allow be to re-declare blocks and I would like
to have the ability to append to existing blocks.

>
>> Take this example:
>> https://github.com/DefenSec/dssp5/blob/dev/src/dev/termdev.cil
>>
>> Here I inherit a set of macros from the
>> "file.all_macro_template_chr_files" template and then I override some of these
>> macros by manually re-declaring them with slighty different content (the
>> xperm rules are appended).
>>
>> This use to be allowed but I am no longer allowed to redeclare macros.
>>
>
> I can see that this might be useful behavior.

Yes it is useful but I believe that "in" statements should work
consistently regardless simply because it is not intuitive that you can
only insert into containers that were not declared using templates.

One should be able to insert into containers regardless of how they were
constructed IMHO.

>
>> This would not necessarily be a big problem IF this would instead work:
>>
>> diff --git a/src/dev/termdev.cil b/src/dev/termdev.cil
>> index 1c0fe66..4f067db 100644
>> --- a/src/dev/termdev.cil
>> +++ b/src/dev/termdev.cil
>> @@ -3,21 +3,9 @@
>>
>>  (block termdev
>>
>> -       (macro appendinherited_all_chr_files ((type ARG1))
>> -             (allow ARG1 typeattr appendinherited_chr_file)
>> -             (allowx ARG1 typeattr (ioctl chr_file (not (0x5412)))))
>> -
>> -       (macro readwriteinherited_all_chr_files ((type ARG1))
>> -             (allow ARG1 typeattr readwriteinherited_chr_file)
>> -             (allowx ARG1 typeattr (ioctl chr_file (not (0x5412)))))
>> -
>>         (macro type ((type ARG1))
>>               (typeattributeset typeattr ARG1))
>>
>> -       (macro writeinherited_all_chr_files ((type ARG1))
>> -             (allow ARG1 typeattr writeinherited_chr_file)
>> -             (allowx ARG1 typeattr (ioctl chr_file (not (0x5412)))))
>> -
>>         (typeattribute typeattr)
>>
>>         (blockinherit .file.all_macro_template_chr_files)
>> @@ -33,3 +21,12 @@
>>
>>               (allow typeattr termdev.typeatt
>>                      (chr_file (not (execmod mounton))))))
>> +
>> +(in termdev.appendinherited_all_chr_files
>> +    (allowx ARG1 typeattr (ioctl chr_file (not (0x5412)))))
>> +
>> +(in termdev.readwriteinherited_all_chr_files
>> +    (allowx ARG1 typeattr (ioctl chr_file (not (0x5412)))))
>> +
>> +(in termdev.writeinherited_all_chr_files
>> +    (allowx ARG1 typeattr (ioctl chr_file (not (0x5412)))))
>>
>> But the above in-statements cannot be resolved.
>>
>
> I think that overriding the macros would make more sense, but I'll
> have to think about it.

Maybe, but I think that regardless this should just have worked. Would
you not agree? Are there unsurmountable technical difficulties?

>
> It would be a pain, but you could do something like:
> (block B1
>   (macro M1 (...)
>     ...
>   )
>   (macro M2 (...)
>     ...
>   )
> )
>
> (block B2
>   (block parent
>     (blockinherit B1)
>   )
>   (macro M1 (...)
>     (call parent.M1 (...))
>     ...
>   )
>   (macro M2 (...)
>     (call parent.MA (...))
>     ...
>   )
> )
>
>> This is not the only instance where this approach does not work. I also
>> have templates that declare blocks. I use to be allowed to re-declare
>> these blocks so that I could add to them but this is no longer
>> allowed. However these blocks also cannot be resolved outside of the
>> templates, so I cannot use "in" to reference them.
>>
>> It seems as if the "in" blocks are resolved before the "blockinherit"
>> blocks are expanded.
>>
>
> It is true that in-statements are resolved before inheritance, so what
> you have above would not work.

That seems unintuitive to me. I mean you can properly inherit blocks
with all bells and whistless as long as the block does not inherit. If
it inherits then bets are off. That seems inconsistent.

>
> If you are just adding rules and not declarations, then you don't have
> to put the rules in the block.
> Example:
> (block B1
>   (block B
>     (type t)
>    )
> )
> (block B2
>   (blockinherit B1)
>   (allow B.t self (CLASS (PERM)))
> )

Yes sure theres alway's a hack and if all else fails then I guess I will
have to explore my options, but it feels wrong.

>
> It might be possible to attempt to resolve all in-statements before
> inheritance as what currently happens and then try to resolve any
> remaining in-statements after inheritance has been resolved.
>
> I'll have to think about the problem a bit.

Thanks!

>
> Thanks for the questions,
> Jim
>
>
>
> The problem
>> [1] https://src.fedoraproject.org/rpms/libsepol/c/c59879b8aa30ceb601ac4e449ee5e958c6659fbc?branch=rawhide
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
