Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1308BC4338F
	for <selinux@archiver.kernel.org>; Tue,  3 Aug 2021 13:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9F446023E
	for <selinux@archiver.kernel.org>; Tue,  3 Aug 2021 13:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235954AbhHCNgL (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 3 Aug 2021 09:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236292AbhHCNgJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 3 Aug 2021 09:36:09 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E427C06179B
        for <selinux@vger.kernel.org>; Tue,  3 Aug 2021 06:35:24 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id x15so28123744oic.9
        for <selinux@vger.kernel.org>; Tue, 03 Aug 2021 06:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t6QkbiSjFCL9iVHJnclQ4sXbyUNENyBWBZYudF9gZV0=;
        b=W4swLFOOi2GZDPcghq6Hzcu7Z4q8lWz5RXNqttPqxXrnUraErSRJBCBoBCIYJ06D+F
         kgyskiadGxJ6GcrZQfT266ZiGlNGnFpVLvLW7o6v5E3eHfwTbaOJaHxiAwJ6MLHXJykr
         fKN/9+M8ZSGZfufpRfbIpQXDl2VjO2wuyzpj8v0b7V+hh+ELtzz5kf9LFyk4O+y+2Db/
         puQRYCQ6suJWncOvX6TUbBIO+k/WVUmeJYd81NFFXv0Bea904nTy5WBaExa7NVp3W7z3
         TwguZ1pnkS+WzA4i5vgpEVkueiYenpsaosLfUub6m5HozfxXlr8oCSX1ZQmX7j6i27Xs
         YIBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t6QkbiSjFCL9iVHJnclQ4sXbyUNENyBWBZYudF9gZV0=;
        b=HYWAfLavGfG6osiflY7aSe+FgbKWOugzV91GAUHC7hTXj1O/wnCFo2npaf/NxgiQTK
         nwkBNTUtiXrwMF688uoKp+F91madDIFvuGW7aSNcA+3M0PnPvfQXYOlkSaN/ZVqLfWWw
         kTdlDTM6tjiYk847HtXeCPDkkQFDQLNCYH271hnTgbghMOYVm+hNIc0mkoHpHHv1IqUy
         s53ENJrTjHOxKuob2Mme3hxGIbpDWVjrDnbOUfFDvKLeSDzzVSpl5U3P9bYYn4iWzRH2
         SUiFUvOXJM8EWyj03g3moMbO7+OzDZTaQm/t71B8nO7q5urYio9/6moO6tSQd7RcCCB4
         Av4A==
X-Gm-Message-State: AOAM5322EAKsRlaUTviiAVXo8MITWrs+q6w+7iPj0PnUE8UPqCWwPAsy
        AsuHQOLbZa3XGI2gOeqsX5w6DspVHHOAq4+MAIaV4/BZbVw=
X-Google-Smtp-Source: ABdhPJyBTGmUV3DWr05ov0/Gv0Sg5ZUTTHJ39JSRiqAy/CdUe3pUF7H27/TlyGolwq4AYqEcPmdhjFBXSpU3TvmFkHM=
X-Received: by 2002:aca:dc44:: with SMTP id t65mr876264oig.16.1627997723449;
 Tue, 03 Aug 2021 06:35:23 -0700 (PDT)
MIME-Version: 1.0
References: <871r7dtfbp.fsf@defensec.nl> <CAP+JOzQt1pxNMZuPK_dzdDHtshrrpEo1ynkFq7CaNpCG1n_JyA@mail.gmail.com>
 <877dh398yi.fsf@defensec.nl> <87zgty7t9q.fsf@defensec.nl>
In-Reply-To: <87zgty7t9q.fsf@defensec.nl>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 3 Aug 2021 09:35:12 -0400
Message-ID: <CAP+JOzRoL-AFGejtHNQG38ZCtNK+qi_t8qq-F6h8Bu82YLHygA@mail.gmail.com>
Subject: Re: libsepol regressions
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Aug 3, 2021 at 5:49 AM Dominick Grift
<dominick.grift@defensec.nl> wrote:
>
> Dominick Grift <dominick.grift@defensec.nl> writes:
>
> > James Carter <jwcart2@gmail.com> writes:
> >
> >> On Sun, Aug 1, 2021 at 10:32 AM Dominick Grift
> >> <dominick.grift@defensec.nl> wrote:
> >>>
> >>>
> >>> Fedora recently decided to pull in various libsepol patches from
> >>> master[1]
> >>>
> >>> My policy has broken down in various way's. Some changes make sense but
> >>> some others I have issues with.
> >>>
> >>> An example of something I never expected to be allowed in the first
> >>> place is re-declarations of blocks and recent changes exposed some instances
> >>> where I declared blocks multiple times and got away with it.
> >>>
> >>> However I also encountered issues that i am not sure how to deal
> >>> with.
> >>>
> >>> re-declarations of macros are no longer allowed:
> >>>
> >>
> >> Re-declarations were never supposed to be allowed (other than the
> >> declaration of types and typeattributes when using the -m flag), but
> >> there were not sufficient checks being done when copying the CIL AST
> >> when expanding macro calls, resolving the inheritance of blocks, and
> >> things like that.
> >>
> >> The result was behavior that depends on the rule order and one of the
> >> principles of CIL is that there would be no rule order dependencies.
> >
> > True and I like to be clear about this upfront that from what I can tell
> > now I wouldnt mind refusing re-declaration of block and macro *IF* we
> > can reliably use "in" consistently and that is currently not the case.
> >
> > Allowing re-declaration of macros does give more flexibility because it
> > allows you to re-define whole macros as opposed to in-statements only allowing
> > you to append to existing macros, but that limitation would be something
> > I could live with.
>
> After thinking about the above statement for a bit I started to doubt
> the claim that re-declaring a macro allows you to fully replace it. It
> is actually a true statement.
>
> The added value of being allowed to replace macros over allowing you to
> "insert into" existing macros is low in my opinion though and i stick to
> my suggestion that allowing in-statements regardless whether you
> insert-into a namespace declared manually or using inheritance should be
> possible.
>
> I would probably just don't allow re-declaring macros, blocks and
> optionals for simplicity and instead I would focus on makeing
> in-statements work more intuitively.
>
> The 3.2 behavior of re-declaring blocks and macros is inconsistent
> anyway because:
>
> re-declaring a macro redefines the whole thing
> re-declaring a block just behaves as a in-statement and allows you to
> insert into an existing block when a in-statement cannot be resolved.
>
> It seems as if we were allowed to re-declare macros and blocks just to
> avoid having to address the current limitations of in-statements.
>
> Best to just address the current in-statement limiations head-on
> IMHO. Then we don't really need those block/macro re-declarations either
> AFAIK.
>
> It will yield a consistent and intuitive behavior, which minimizes confusion.
>
> Its just hard to explain to a user:
>
> You cannot insert into a1.b2 because b2 comes from inheritance but you
> can insert into a1.b3 because a1.b3 was declared manually.
>
> That is just unwieldy.
>
> >
> > The thing is that for me its more important the "in" works reliably in
> > the longer run. I mean even if I would be allowed to re-declare macros
> > that then still would not allow be to re-declare blocks and I would like
> > to have the ability to append to existing blocks.
> >

The problem with the in-statement is that you might want to work
differently depending on the circumstances.

Imagine that you have the following:

(block b1
  (macro m (...)
    ...
  )
 ...
)

(in b1.m
  (allow ...)
)

(block b2
 (blockinherit b1)
 ...
)

How should the in-statement for b1.m behave?
You might want the in-statement to be resolved before any inheritance,
so that the inherited instance was also changed (imagine block b1
being inherited many times), but it is also possible that you only
want the change to happen for block b1. For better or worse, the
decision was made to have the in-statement be resolved before
inheritance is processed.

We can't change that behavior now, but I do see that there is a need
to support changing only specific instances.

I am thinking about creating a new rule that would act like an
in-statement, but be processed after inheritance. Not sure about the
name though: "append", "add", "addto", "with", "within"?

Jim


> >>
> >>> Take this example:
> >>> https://github.com/DefenSec/dssp5/blob/dev/src/dev/termdev.cil
> >>>
> >>> Here I inherit a set of macros from the
> >>> "file.all_macro_template_chr_files" template and then I override some of these
> >>> macros by manually re-declaring them with slighty different content (the
> >>> xperm rules are appended).
> >>>
> >>> This use to be allowed but I am no longer allowed to redeclare macros.
> >>>
> >>
> >> I can see that this might be useful behavior.
> >
> > Yes it is useful but I believe that "in" statements should work
> > consistently regardless simply because it is not intuitive that you can
> > only insert into containers that were not declared using templates.
> >
> > One should be able to insert into containers regardless of how they were
> > constructed IMHO.
> >
> >>
> >>> This would not necessarily be a big problem IF this would instead work:
> >>>
> >>> diff --git a/src/dev/termdev.cil b/src/dev/termdev.cil
> >>> index 1c0fe66..4f067db 100644
> >>> --- a/src/dev/termdev.cil
> >>> +++ b/src/dev/termdev.cil
> >>> @@ -3,21 +3,9 @@
> >>>
> >>>  (block termdev
> >>>
> >>> -       (macro appendinherited_all_chr_files ((type ARG1))
> >>> -             (allow ARG1 typeattr appendinherited_chr_file)
> >>> -             (allowx ARG1 typeattr (ioctl chr_file (not (0x5412)))))
> >>> -
> >>> -       (macro readwriteinherited_all_chr_files ((type ARG1))
> >>> -             (allow ARG1 typeattr readwriteinherited_chr_file)
> >>> -             (allowx ARG1 typeattr (ioctl chr_file (not (0x5412)))))
> >>> -
> >>>         (macro type ((type ARG1))
> >>>               (typeattributeset typeattr ARG1))
> >>>
> >>> -       (macro writeinherited_all_chr_files ((type ARG1))
> >>> -             (allow ARG1 typeattr writeinherited_chr_file)
> >>> -             (allowx ARG1 typeattr (ioctl chr_file (not (0x5412)))))
> >>> -
> >>>         (typeattribute typeattr)
> >>>
> >>>         (blockinherit .file.all_macro_template_chr_files)
> >>> @@ -33,3 +21,12 @@
> >>>
> >>>               (allow typeattr termdev.typeatt
> >>>                      (chr_file (not (execmod mounton))))))
> >>> +
> >>> +(in termdev.appendinherited_all_chr_files
> >>> +    (allowx ARG1 typeattr (ioctl chr_file (not (0x5412)))))
> >>> +
> >>> +(in termdev.readwriteinherited_all_chr_files
> >>> +    (allowx ARG1 typeattr (ioctl chr_file (not (0x5412)))))
> >>> +
> >>> +(in termdev.writeinherited_all_chr_files
> >>> +    (allowx ARG1 typeattr (ioctl chr_file (not (0x5412)))))
> >>>
> >>> But the above in-statements cannot be resolved.
> >>>
> >>
> >> I think that overriding the macros would make more sense, but I'll
> >> have to think about it.
> >
> > Maybe, but I think that regardless this should just have worked. Would
> > you not agree? Are there unsurmountable technical difficulties?
> >
> >>
> >> It would be a pain, but you could do something like:
> >> (block B1
> >>   (macro M1 (...)
> >>     ...
> >>   )
> >>   (macro M2 (...)
> >>     ...
> >>   )
> >> )
> >>
> >> (block B2
> >>   (block parent
> >>     (blockinherit B1)
> >>   )
> >>   (macro M1 (...)
> >>     (call parent.M1 (...))
> >>     ...
> >>   )
> >>   (macro M2 (...)
> >>     (call parent.MA (...))
> >>     ...
> >>   )
> >> )
> >>
> >>> This is not the only instance where this approach does not work. I also
> >>> have templates that declare blocks. I use to be allowed to re-declare
> >>> these blocks so that I could add to them but this is no longer
> >>> allowed. However these blocks also cannot be resolved outside of the
> >>> templates, so I cannot use "in" to reference them.
> >>>
> >>> It seems as if the "in" blocks are resolved before the "blockinherit"
> >>> blocks are expanded.
> >>>
> >>
> >> It is true that in-statements are resolved before inheritance, so what
> >> you have above would not work.
> >
> > That seems unintuitive to me. I mean you can properly inherit blocks
> > with all bells and whistless as long as the block does not inherit. If
> > it inherits then bets are off. That seems inconsistent.
> >
> >>
> >> If you are just adding rules and not declarations, then you don't have
> >> to put the rules in the block.
> >> Example:
> >> (block B1
> >>   (block B
> >>     (type t)
> >>    )
> >> )
> >> (block B2
> >>   (blockinherit B1)
> >>   (allow B.t self (CLASS (PERM)))
> >> )
> >
> > Yes sure theres alway's a hack and if all else fails then I guess I will
> > have to explore my options, but it feels wrong.
> >
> >>
> >> It might be possible to attempt to resolve all in-statements before
> >> inheritance as what currently happens and then try to resolve any
> >> remaining in-statements after inheritance has been resolved.
> >>
> >> I'll have to think about the problem a bit.
> >
> > Thanks!
> >
> >>
> >> Thanks for the questions,
> >> Jim
> >>
> >>
> >>
> >> The problem
> >>> [1] https://src.fedoraproject.org/rpms/libsepol/c/c59879b8aa30ceb601ac4e449ee5e958c6659fbc?branch=rawhide
> >>>
> >>> --
> >>> gpg --locate-keys dominick.grift@defensec.nl
> >>> Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
> >>> https://sks-keyservers.net/pks/lookup?op=get&search=0xDA7E521F10F64098
> >>> Dominick Grift
>
> --
> gpg --locate-keys dominick.grift@defensec.nl
> Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
> https://sks-keyservers.net/pks/lookup?op=get&search=0xDA7E521F10F64098
> Dominick Grift
