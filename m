Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B19C4320E
	for <selinux@archiver.kernel.org>; Wed,  4 Aug 2021 13:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2E7B60F58
	for <selinux@archiver.kernel.org>; Wed,  4 Aug 2021 13:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238433AbhHDNtb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 4 Aug 2021 09:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238412AbhHDNtb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 4 Aug 2021 09:49:31 -0400
Received: from agnus.defensec.nl (agnus.defensec.nl [IPv6:2001:985:d55d::711])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 11C9AC0613D5
        for <selinux@vger.kernel.org>; Wed,  4 Aug 2021 06:49:16 -0700 (PDT)
Received: from brutus (brutus.lan [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id E45B52A006A;
        Wed,  4 Aug 2021 15:49:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 agnus.defensec.nl E45B52A006A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defensec.nl;
        s=default; t=1628084954;
        bh=OlIczWDLvQTeRNfp8xNHnUtsj2RZBYd99It0DLB/WPs=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=NwSdnmrcoDuwrJr4/pP6gH6Ed8Z+2g7pABuYdNGd968t5KKpvp8Vu0pv60z/jkt8G
         IsssFOkFuF/RS/l/SuM3U22tGNQWXIcryd59R80k+4nRFku0F+kStPy7fbPcHFWLqn
         nJ0Le5OuNZ8tJATVdQtA+PqGAg46fqtnYSTVD7pg=
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Subject: Re: libsepol regressions
References: <871r7dtfbp.fsf@defensec.nl>
        <CAP+JOzQt1pxNMZuPK_dzdDHtshrrpEo1ynkFq7CaNpCG1n_JyA@mail.gmail.com>
        <878s1h7jc3.fsf@defensec.nl>
        <CAP+JOzTQULPF++1m+xbokU86dbheTAtoCfPn5+dkTf6ZyQ1HQw@mail.gmail.com>
Date:   Wed, 04 Aug 2021 15:49:11 +0200
In-Reply-To: <CAP+JOzTQULPF++1m+xbokU86dbheTAtoCfPn5+dkTf6ZyQ1HQw@mail.gmail.com>
        (James Carter's message of "Wed, 4 Aug 2021 09:33:22 -0400")
Message-ID: <874kc57220.fsf@defensec.nl>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

James Carter <jwcart2@gmail.com> writes:

> On Wed, Aug 4, 2021 at 3:36 AM Dominick Grift
> <dominick.grift@defensec.nl> wrote:
>>
>> James Carter <jwcart2@gmail.com> writes:
>>
>> > On Sun, Aug 1, 2021 at 10:32 AM Dominick Grift
>> > <dominick.grift@defensec.nl> wrote:
>> >>
>> >>
>> >> Fedora recently decided to pull in various libsepol patches from
>> >> master[1]
>> >>
>> >> My policy has broken down in various way's. Some changes make sense but
>> >> some others I have issues with.
>> >>
>> >> An example of something I never expected to be allowed in the first
>> >> place is re-declarations of blocks and recent changes exposed some instances
>> >> where I declared blocks multiple times and got away with it.
>> >>
>> >> However I also encountered issues that i am not sure how to deal
>> >> with.
>> >>
>> >> re-declarations of macros are no longer allowed:
>> >>
>> >
>> > Re-declarations were never supposed to be allowed (other than the
>> > declaration of types and typeattributes when using the -m flag), but
>> > there were not sufficient checks being done when copying the CIL AST
>> > when expanding macro calls, resolving the inheritance of blocks, and
>> > things like that.
>> >
>> > The result was behavior that depends on the rule order and one of the
>> > principles of CIL is that there would be no rule order dependencies.
>> >
>> >> Take this example:
>> >> https://github.com/DefenSec/dssp5/blob/dev/src/dev/termdev.cil
>> >>
>> >> Here I inherit a set of macros from the
>> >> "file.all_macro_template_chr_files" template and then I override some of these
>> >> macros by manually re-declaring them with slighty different content (the
>> >> xperm rules are appended).
>> >>
>> >> This use to be allowed but I am no longer allowed to redeclare macros.
>> >>
>> >
>> > I can see that this might be useful behavior.
>> >
>> >> This would not necessarily be a big problem IF this would instead work:
>> >>
>> >> diff --git a/src/dev/termdev.cil b/src/dev/termdev.cil
>> >> index 1c0fe66..4f067db 100644
>> >> --- a/src/dev/termdev.cil
>> >> +++ b/src/dev/termdev.cil
>> >> @@ -3,21 +3,9 @@
>> >>
>> >>  (block termdev
>> >>
>> >> -       (macro appendinherited_all_chr_files ((type ARG1))
>> >> -             (allow ARG1 typeattr appendinherited_chr_file)
>> >> -             (allowx ARG1 typeattr (ioctl chr_file (not (0x5412)))))
>> >> -
>> >> -       (macro readwriteinherited_all_chr_files ((type ARG1))
>> >> -             (allow ARG1 typeattr readwriteinherited_chr_file)
>> >> -             (allowx ARG1 typeattr (ioctl chr_file (not (0x5412)))))
>> >> -
>> >>         (macro type ((type ARG1))
>> >>               (typeattributeset typeattr ARG1))
>> >>
>> >> -       (macro writeinherited_all_chr_files ((type ARG1))
>> >> -             (allow ARG1 typeattr writeinherited_chr_file)
>> >> -             (allowx ARG1 typeattr (ioctl chr_file (not (0x5412)))))
>> >> -
>> >>         (typeattribute typeattr)
>> >>
>> >>         (blockinherit .file.all_macro_template_chr_files)
>> >> @@ -33,3 +21,12 @@
>> >>
>> >>               (allow typeattr termdev.typeatt
>> >>                      (chr_file (not (execmod mounton))))))
>> >> +
>> >> +(in termdev.appendinherited_all_chr_files
>> >> +    (allowx ARG1 typeattr (ioctl chr_file (not (0x5412)))))
>> >> +
>> >> +(in termdev.readwriteinherited_all_chr_files
>> >> +    (allowx ARG1 typeattr (ioctl chr_file (not (0x5412)))))
>> >> +
>> >> +(in termdev.writeinherited_all_chr_files
>> >> +    (allowx ARG1 typeattr (ioctl chr_file (not (0x5412)))))
>> >>
>> >> But the above in-statements cannot be resolved.
>> >>
>> >
>> > I think that overriding the macros would make more sense, but I'll
>> > have to think about it.
>> >
>> > It would be a pain, but you could do something like:
>> > (block B1
>> >   (macro M1 (...)
>> >     ...
>> >   )
>> >   (macro M2 (...)
>> >     ...
>> >   )
>> > )
>> >
>> > (block B2
>> >   (block parent
>> >     (blockinherit B1)
>> >   )
>> >   (macro M1 (...)
>> >     (call parent.M1 (...))
>> >     ...
>> >   )
>> >   (macro M2 (...)
>> >     (call parent.MA (...))
>> >     ...
>> >   )
>> > )
>> >
>> >> This is not the only instance where this approach does not work. I also
>> >> have templates that declare blocks. I use to be allowed to re-declare
>> >> these blocks so that I could add to them but this is no longer
>> >> allowed. However these blocks also cannot be resolved outside of the
>> >> templates, so I cannot use "in" to reference them.
>> >>
>> >> It seems as if the "in" blocks are resolved before the "blockinherit"
>> >> blocks are expanded.
>> >>
>> >
>> > It is true that in-statements are resolved before inheritance, so what
>> > you have above would not work.
>> >
>> > If you are just adding rules and not declarations, then you don't have
>> > to put the rules in the block.
>> > Example:
>> > (block B1
>> >   (block B
>> >     (type t)
>> >    )
>> > )
>> > (block B2
>> >   (blockinherit B1)
>> >   (allow B.t self (CLASS (PERM)))
>> > )
>>
>> Ive been trying to translate this to a actual use-case in my policy to
>> see if that would suffice.
>>
>> I have these high level "content" templates that basically allow you to
>> inherit a whole skeleton without filecon's because a skeleton can be
>> generic but filecon's are specific so they have to be added later.
>>
>> (block skel
>>   (type type)
>>   (allow ...)
>>   (block conf
>>   (type type)
>>   (allow ...))
>>   (block exec
>>   (type type)
>>   (allow ,,,))
>>   etc...)
>>
>> These skeletons can then be inherited and the filecons (and custom rules)
>> can be added later:
>>
>> (block myapp
>>   (blockinherit skel)
>>   (allow ...))
>>
>> With 3.2 I was able to mimic in-statements by re-declaring the
>> blocks so that I would be able to insert the filecons (and custom rules)
>> later:
>>
>> (block myapp
>>   (blockinherit shel)
>>   (allow ...)
>>   (block conf
>>     (filecon "/etc/myapp" file file_context))
>>   (block exec
>>     (filecon "/bin/myapp" file file_context)))
>>
>> If in-statements would be resolved after inheritance then I could do:
>>
>> (block myapp
>>   (blockiherit skel)
>>   (allow ...))
>>
>> (in myapp.conf
>>   (filecon "/etc/myapp" file file_context))
>>
>> (in myapp.exec
>>   (filecon "/bin/myapp" file file_context))
>>
>> Your suggestion would be suffice if I would use raw filecons instead of
>> context:
>>
>> (block myapp
>>   (blockinherit skel)
>>   (allow ...)
>>   (filecon "/etc/myapp" file (sys.id sys.role myapp.conf.type
>>   ((s0)(s0))))
>>   (filecon "/bin/myapp" file (sys.id sys.role myapp.exec.type
>>   ((s0)(s0)))))
>>
>> But then that would be yet another inconsistency that would be hard to explain:
>> Can only use file_context keyword in filecon if you don't use
>> inheritance.
>>
>> Not to mention macro's. If there is one thing I dislike then its having to
>> duplicate macros everywhere. I like to template macros from the ground
>> up to reduce points of failure and to encourage consistency. This
>> implies inheritance as well.
>>
>> I try not to use high level abstractions like these myself, but the idea
>> is that users of my policy are able to create/script higher level abstractions
>> on top of my policy. So that they can for example create policy
>> generation scripts using higher level templates.
>>
>> This is why consistency matters to me. I can get used to buts-and-ifs but can
>> the end-user of my policy do that as well?
>>
>> Eventually I envision something like:
>>
>> ;; generic high level base template used in a script created by end-users
>> (block myapp
>>   (blockinherit skel))
>>
>> ;; custom stuff added by the script based on script input
>> (in myapp
>>   (allow type self (class (perm))))
>>
>> (in myapp.conf
>>   (filecon "/etc/myapp" file file_context)
>>   (call .tmp.associate (type))
>>
>> (in myapp.exec
>>   (filecon "/bin/myapp" file file_context))
>>
>> (in user
>>   (call .myapp.run (type)))
>>
>
> I am definitely sympathetic to this use case and feel that you have
> identified a gap in CIL's capabilities that should be filled. But like
> I said, it will have to have a different name. I don't think that it
> will be too hard to add, but we'll see.

Yes sure I don't mind the name. Just wanted to ensure we arent
overlooking something.

>
> Thanks for details,
> Jim
>
>> >
>> > It might be possible to attempt to resolve all in-statements before
>> > inheritance as what currently happens and then try to resolve any
>> > remaining in-statements after inheritance has been resolved.
>> >
>> > I'll have to think about the problem a bit.
>> >
>> > Thanks for the questions,
>> > Jim
>> >
>> >
>> >
>> > The problem
>> >> [1] https://src.fedoraproject.org/rpms/libsepol/c/c59879b8aa30ceb601ac4e449ee5e958c6659fbc?branch=rawhide
>> >>
>> >> --
>> >> gpg --locate-keys dominick.grift@defensec.nl
>> >> Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
>> >> https://sks-keyservers.net/pks/lookup?op=get&search=0xDA7E521F10F64098
>> >> Dominick Grift
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
