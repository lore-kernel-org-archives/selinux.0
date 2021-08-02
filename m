Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3517C4338F
	for <selinux@archiver.kernel.org>; Mon,  2 Aug 2021 06:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8136E610A2
	for <selinux@archiver.kernel.org>; Mon,  2 Aug 2021 06:58:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232456AbhHBG6u (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 2 Aug 2021 02:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232443AbhHBG6u (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 2 Aug 2021 02:58:50 -0400
X-Greylist: delayed 59761 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 01 Aug 2021 23:58:41 PDT
Received: from agnus.defensec.nl (agnus.defensec.nl [IPv6:2001:985:d55d::711])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 110D4C06175F
        for <selinux@vger.kernel.org>; Sun,  1 Aug 2021 23:58:40 -0700 (PDT)
Received: from brutus (brutus.lan [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id 6FA672A008A
        for <selinux@vger.kernel.org>; Mon,  2 Aug 2021 08:58:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 agnus.defensec.nl 6FA672A008A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defensec.nl;
        s=default; t=1627887519;
        bh=EZDqdp4yIhtCBwB8gnPOPG4cR7SKq+VQNiEeHe/g6g8=;
        h=From:To:Subject:References:Date:In-Reply-To:From;
        b=QI6SYuBLy04GIFHiseTHwRfSoIsRsu7o+7//ICU1kQF0m77NoEMGTcvoWKtCjeGgL
         KwqW760N/ZsU2PxqJyq38Fmr2jORUccplHmOYIo+KhUOAQ7Kt2dUxW+EmYA5jS58tT
         9DlGsAbTJxKqAdMu9UjxBc0uvlK6KX950000LK9Q=
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     selinux@vger.kernel.org
Subject: Re: libsepol regressions
References: <871r7dtfbp.fsf@defensec.nl> <87k0l57yvc.fsf@defensec.nl>
Date:   Mon, 02 Aug 2021 08:58:36 +0200
In-Reply-To: <87k0l57yvc.fsf@defensec.nl> (Dominick Grift's message of "Sun,
        01 Aug 2021 21:23:35 +0200")
Message-ID: <87fsvs8h9f.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Dominick Grift <dominick.grift@defensec.nl> writes:

> Dominick Grift <dominick.grift@defensec.nl> writes:
>
>> Fedora recently decided to pull in various libsepol patches from
>> master[1]

Here is another simplified take:

Why does this work?

(sid kernel)
(sidorder (kernel))
(class CLASS1 (PERM1 PERM2))
(classorder (unordered CLASS1))
(block test1
(type type1)
(block conf1
(type type1)))
(in test1.conf1
(allow type self (CLASS1 (PERM1))))

> [kcinimod@myguest tests]$ secilc testa.cil
> [kcinimod@myguest tests]$ seinfo policy.33 -t

> Types: 2
>   test1.conf1.type1
>   test1.type1
> [kcinimod@myguest tests]$

Why does this not work?

(sid kernel)
(sidorder (kernel))
(class CLASS2 (PERM1 PERM2))
(classorder (unordered CLASS2))
(block template2
(type type2)
(allow type2 self (CLASS2 (PERM1)))
(block conf2
(type type2)))
(block test2
(blockinherit template2))
(in test2.conf2
(allow type2 self (CLASS2 (PERM2))))

> [kcinimod@myguest tests]$ secilc testb.cil
> Failed to resolve in-statement at testb.cil:12
> Failed to resolve AST
> Failed to compile cildb: -1

I would like to be able to understand from a user perspective. What is
the difference between test1.conf1 and test2.conf2? Why can they not
both be resolved consistently?

What are the implications of this limitation? Does this mean that blocks
that declare blocks and macros cannot be reliably inherited?

If we are not able to reliably declare blocks and macros inside
containers then should we be allowed to do this in the first place? And
what purpose remains there for blockinherit and in given the above?

>
> Here are two examples (test1.cil and test2.cil)  that I think
> demonstrate some of my issues. Comment out the ";;the culprit" blocks to see
> it fail.
>
> In the test1.cil scenario I previously was able to get around this by
> re-declaring the macro.
>
> In the test2.cil scenario I previously was able to get around this by
> re-declaring the block.
>
> I do not mind not being allowed to re-declare macros and blocks
> but then I would appreciate if I could use "in" to insert into them
> instead. If I cannot either re-declare nor "insert into" then templates
> become pretty useless due to the limitations.
>
>  ---
>
> cat > test1.cil <<EOF
> ;; what is the point of templates when you cannot access them?
>
> (sid kernel)
> (sidorder (kernel))
> (class CLASS1 (PERM1 PERM2))
> (classorder (unordered CLASS1))
>
> (type type)
> (typeattribute typeattr) 
>
> (block block_a1
> (block block_a2
> (blockabstract block_a2)
> (macro macro_a1 ((type ARG1))
> (allow ARG1 type (CLASS1 (PERM1))))))
>
> (block block_b1
> (type type)
> (blockinherit block_a1.block_a2))
>
> (block block_c1
> (type type)
> (call block_b1.macro_a1 (type)))
>
> (block block_d1
> (type type)
> (blockinherit block_a1.block_a2))
>
> ;;the culprit
> ;;(in block_d1.macro_a1
> ;;(allow ARG1 type (CLASS (PERM2))))
>
> (block block_e1
> (type type)
> (call block_d1.macro_a1 (type)))
> EOF
> secilc test1.cil
>
>  ---
>
> cat > test2.cil <<EOF
> ;; what is the point of templates when you cannot access them?
>
> (sid kernel)
> (sidorder (kernel))
> (class CLASS1 (PERM1 PERM2))
> (classorder (unordered CLASS1))
>
> (type type)
> (typeattribute typeattr) 
>
> (block block_a1
> (type type)
> (allow type self (CLASS1 (PERM1)))
> (block block_a2
> (blockabstract block_a2)
> (type type)
> (allow type self (CLASS1 (PERM1)))
> (block block_a3
> (type type)
> (allow type self (CLASS1 (PERM1))))))
>
> (block block_b1
> (blockinherit block_a1.block_a2)
> (allow type self (CLASS1 (PERM2))))
>
> ;;the culprit
> ;;(in block_b1.block_a3
> ;;(block block_b2
> ;;(type type)))
> EOF
> secilc test2.cil
>
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
>> This is not the only instance where this approach does not work. I also
>> have templates that declare blocks. I use to be allowed to re-declare
>> these blocks so that I could add to them but this is no longer
>> allowed. However these blocks also cannot be resolved outside of the
>> templates, so I cannot use "in" to reference them.
>>
>> It seems as if the "in" blocks are resolved before the "blockinherit"
>> blocks are expanded.
>>
>> [1] https://src.fedoraproject.org/rpms/libsepol/c/c59879b8aa30ceb601ac4e449ee5e958c6659fbc?branch=rawhide

-- 
gpg --locate-keys dominick.grift@defensec.nl
Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
https://sks-keyservers.net/pks/lookup?op=get&search=0xDA7E521F10F64098
Dominick Grift
