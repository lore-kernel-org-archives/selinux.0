Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC517C4338F
	for <selinux@archiver.kernel.org>; Wed,  4 Aug 2021 13:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2DA760E96
	for <selinux@archiver.kernel.org>; Wed,  4 Aug 2021 13:33:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237762AbhHDNds (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 4 Aug 2021 09:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236799AbhHDNds (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 4 Aug 2021 09:33:48 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5E3C0613D5
        for <selinux@vger.kernel.org>; Wed,  4 Aug 2021 06:33:34 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 68-20020a9d0f4a0000b02904b1f1d7c5f4so1605606ott.9
        for <selinux@vger.kernel.org>; Wed, 04 Aug 2021 06:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iX1b9owHQb5mk+U536amxdkS773MfzCyf0aX+jWznrw=;
        b=ghYFC8sH4a1JjhuA5UIXQrnKB8EJANMpc8LSd+/XDi1ORTgPWMEJuY4mP48udssg4i
         uN+51mjmi5zLYFjbKfeLXRfg+RIhLprh/gkxEpITW/lUohNBZ601nJwH7hKYncTwXkuv
         oKr0c1QSzk1jIjnxUwH1XQNUcwjwuOOYio4LhSu0Wm1vLTdbDAVUC3aGPmFatNtB6CcZ
         dqF3iKA/M4HBn+hi1FgC8TwkNCMIBaM6ZoB5iklhMK+hBrlXsKKpbPD5fPNeL0OUs716
         lvZPRaEYrLJpEmP6c17vb49GoAc5VRa89l+yjmH+0W58zzK+9CgRALV0QsJyJlUoEwnk
         okLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iX1b9owHQb5mk+U536amxdkS773MfzCyf0aX+jWznrw=;
        b=H0Xb0j9J0y6bAdIdLa5gISMwKbGra2aNEN6wG5eXJwDTW/zkrvoha9jgdYGMrw0tdb
         6cjVbeyfPcMP8fmgo/AqmnIcIhAGzeFfPKiMWIleSnAvj50QGAOdOQea/GL167K0IREm
         qI70PBA2CDUZtw7qhThiZ1MO6cP0tsGAvTCtfFEW2Bjc3CYsy42583TEEbSRJI5yLr1D
         3+ZguolIO8qwEB7qYP0t2ohhfY4VKmntQm/Cf4UbRGgUbp5kjJ90psaLahMrcJP8IVN2
         aphRJkblGbMTeMmj9VzfZXWToMhAKPQNVbikK/tfv4byR3tlbG4uHz1Kizz/IyfVC389
         6eMw==
X-Gm-Message-State: AOAM5324CrYYO0q/Gao4Rt+LzYV/EQ7DXeJ1qem+Q9FnQuFxWdDl4d2y
        7ofuoyGn6w1H6QGy7SGr3Pa0YaGbJrcBEKIqQv/05P0DOfY=
X-Google-Smtp-Source: ABdhPJw59l6JU7BW1We+IFVMdIrH11Ga6Pj+ZEss/CkvMa7uF16mdsuasojIxkqnK7srFNN5anrm6uhJ1r/FHpoosfM=
X-Received: by 2002:a9d:63c6:: with SMTP id e6mr19213225otl.295.1628084013844;
 Wed, 04 Aug 2021 06:33:33 -0700 (PDT)
MIME-Version: 1.0
References: <871r7dtfbp.fsf@defensec.nl> <CAP+JOzQt1pxNMZuPK_dzdDHtshrrpEo1ynkFq7CaNpCG1n_JyA@mail.gmail.com>
 <878s1h7jc3.fsf@defensec.nl>
In-Reply-To: <878s1h7jc3.fsf@defensec.nl>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 4 Aug 2021 09:33:22 -0400
Message-ID: <CAP+JOzTQULPF++1m+xbokU86dbheTAtoCfPn5+dkTf6ZyQ1HQw@mail.gmail.com>
Subject: Re: libsepol regressions
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Aug 4, 2021 at 3:36 AM Dominick Grift
<dominick.grift@defensec.nl> wrote:
>
> James Carter <jwcart2@gmail.com> writes:
>
> > On Sun, Aug 1, 2021 at 10:32 AM Dominick Grift
> > <dominick.grift@defensec.nl> wrote:
> >>
> >>
> >> Fedora recently decided to pull in various libsepol patches from
> >> master[1]
> >>
> >> My policy has broken down in various way's. Some changes make sense but
> >> some others I have issues with.
> >>
> >> An example of something I never expected to be allowed in the first
> >> place is re-declarations of blocks and recent changes exposed some instances
> >> where I declared blocks multiple times and got away with it.
> >>
> >> However I also encountered issues that i am not sure how to deal
> >> with.
> >>
> >> re-declarations of macros are no longer allowed:
> >>
> >
> > Re-declarations were never supposed to be allowed (other than the
> > declaration of types and typeattributes when using the -m flag), but
> > there were not sufficient checks being done when copying the CIL AST
> > when expanding macro calls, resolving the inheritance of blocks, and
> > things like that.
> >
> > The result was behavior that depends on the rule order and one of the
> > principles of CIL is that there would be no rule order dependencies.
> >
> >> Take this example:
> >> https://github.com/DefenSec/dssp5/blob/dev/src/dev/termdev.cil
> >>
> >> Here I inherit a set of macros from the
> >> "file.all_macro_template_chr_files" template and then I override some of these
> >> macros by manually re-declaring them with slighty different content (the
> >> xperm rules are appended).
> >>
> >> This use to be allowed but I am no longer allowed to redeclare macros.
> >>
> >
> > I can see that this might be useful behavior.
> >
> >> This would not necessarily be a big problem IF this would instead work:
> >>
> >> diff --git a/src/dev/termdev.cil b/src/dev/termdev.cil
> >> index 1c0fe66..4f067db 100644
> >> --- a/src/dev/termdev.cil
> >> +++ b/src/dev/termdev.cil
> >> @@ -3,21 +3,9 @@
> >>
> >>  (block termdev
> >>
> >> -       (macro appendinherited_all_chr_files ((type ARG1))
> >> -             (allow ARG1 typeattr appendinherited_chr_file)
> >> -             (allowx ARG1 typeattr (ioctl chr_file (not (0x5412)))))
> >> -
> >> -       (macro readwriteinherited_all_chr_files ((type ARG1))
> >> -             (allow ARG1 typeattr readwriteinherited_chr_file)
> >> -             (allowx ARG1 typeattr (ioctl chr_file (not (0x5412)))))
> >> -
> >>         (macro type ((type ARG1))
> >>               (typeattributeset typeattr ARG1))
> >>
> >> -       (macro writeinherited_all_chr_files ((type ARG1))
> >> -             (allow ARG1 typeattr writeinherited_chr_file)
> >> -             (allowx ARG1 typeattr (ioctl chr_file (not (0x5412)))))
> >> -
> >>         (typeattribute typeattr)
> >>
> >>         (blockinherit .file.all_macro_template_chr_files)
> >> @@ -33,3 +21,12 @@
> >>
> >>               (allow typeattr termdev.typeatt
> >>                      (chr_file (not (execmod mounton))))))
> >> +
> >> +(in termdev.appendinherited_all_chr_files
> >> +    (allowx ARG1 typeattr (ioctl chr_file (not (0x5412)))))
> >> +
> >> +(in termdev.readwriteinherited_all_chr_files
> >> +    (allowx ARG1 typeattr (ioctl chr_file (not (0x5412)))))
> >> +
> >> +(in termdev.writeinherited_all_chr_files
> >> +    (allowx ARG1 typeattr (ioctl chr_file (not (0x5412)))))
> >>
> >> But the above in-statements cannot be resolved.
> >>
> >
> > I think that overriding the macros would make more sense, but I'll
> > have to think about it.
> >
> > It would be a pain, but you could do something like:
> > (block B1
> >   (macro M1 (...)
> >     ...
> >   )
> >   (macro M2 (...)
> >     ...
> >   )
> > )
> >
> > (block B2
> >   (block parent
> >     (blockinherit B1)
> >   )
> >   (macro M1 (...)
> >     (call parent.M1 (...))
> >     ...
> >   )
> >   (macro M2 (...)
> >     (call parent.MA (...))
> >     ...
> >   )
> > )
> >
> >> This is not the only instance where this approach does not work. I also
> >> have templates that declare blocks. I use to be allowed to re-declare
> >> these blocks so that I could add to them but this is no longer
> >> allowed. However these blocks also cannot be resolved outside of the
> >> templates, so I cannot use "in" to reference them.
> >>
> >> It seems as if the "in" blocks are resolved before the "blockinherit"
> >> blocks are expanded.
> >>
> >
> > It is true that in-statements are resolved before inheritance, so what
> > you have above would not work.
> >
> > If you are just adding rules and not declarations, then you don't have
> > to put the rules in the block.
> > Example:
> > (block B1
> >   (block B
> >     (type t)
> >    )
> > )
> > (block B2
> >   (blockinherit B1)
> >   (allow B.t self (CLASS (PERM)))
> > )
>
> Ive been trying to translate this to a actual use-case in my policy to
> see if that would suffice.
>
> I have these high level "content" templates that basically allow you to
> inherit a whole skeleton without filecon's because a skeleton can be
> generic but filecon's are specific so they have to be added later.
>
> (block skel
>   (type type)
>   (allow ...)
>   (block conf
>   (type type)
>   (allow ...))
>   (block exec
>   (type type)
>   (allow ,,,))
>   etc...)
>
> These skeletons can then be inherited and the filecons (and custom rules)
> can be added later:
>
> (block myapp
>   (blockinherit skel)
>   (allow ...))
>
> With 3.2 I was able to mimic in-statements by re-declaring the
> blocks so that I would be able to insert the filecons (and custom rules)
> later:
>
> (block myapp
>   (blockinherit shel)
>   (allow ...)
>   (block conf
>     (filecon "/etc/myapp" file file_context))
>   (block exec
>     (filecon "/bin/myapp" file file_context)))
>
> If in-statements would be resolved after inheritance then I could do:
>
> (block myapp
>   (blockiherit skel)
>   (allow ...))
>
> (in myapp.conf
>   (filecon "/etc/myapp" file file_context))
>
> (in myapp.exec
>   (filecon "/bin/myapp" file file_context))
>
> Your suggestion would be suffice if I would use raw filecons instead of
> context:
>
> (block myapp
>   (blockinherit skel)
>   (allow ...)
>   (filecon "/etc/myapp" file (sys.id sys.role myapp.conf.type
>   ((s0)(s0))))
>   (filecon "/bin/myapp" file (sys.id sys.role myapp.exec.type
>   ((s0)(s0)))))
>
> But then that would be yet another inconsistency that would be hard to explain:
> Can only use file_context keyword in filecon if you don't use
> inheritance.
>
> Not to mention macro's. If there is one thing I dislike then its having to
> duplicate macros everywhere. I like to template macros from the ground
> up to reduce points of failure and to encourage consistency. This
> implies inheritance as well.
>
> I try not to use high level abstractions like these myself, but the idea
> is that users of my policy are able to create/script higher level abstractions
> on top of my policy. So that they can for example create policy
> generation scripts using higher level templates.
>
> This is why consistency matters to me. I can get used to buts-and-ifs but can
> the end-user of my policy do that as well?
>
> Eventually I envision something like:
>
> ;; generic high level base template used in a script created by end-users
> (block myapp
>   (blockinherit skel))
>
> ;; custom stuff added by the script based on script input
> (in myapp
>   (allow type self (class (perm))))
>
> (in myapp.conf
>   (filecon "/etc/myapp" file file_context)
>   (call .tmp.associate (type))
>
> (in myapp.exec
>   (filecon "/bin/myapp" file file_context))
>
> (in user
>   (call .myapp.run (type)))
>

I am definitely sympathetic to this use case and feel that you have
identified a gap in CIL's capabilities that should be filled. But like
I said, it will have to have a different name. I don't think that it
will be too hard to add, but we'll see.

Thanks for details,
Jim

> >
> > It might be possible to attempt to resolve all in-statements before
> > inheritance as what currently happens and then try to resolve any
> > remaining in-statements after inheritance has been resolved.
> >
> > I'll have to think about the problem a bit.
> >
> > Thanks for the questions,
> > Jim
> >
> >
> >
> > The problem
> >> [1] https://src.fedoraproject.org/rpms/libsepol/c/c59879b8aa30ceb601ac4e449ee5e958c6659fbc?branch=rawhide
> >>
> >> --
> >> gpg --locate-keys dominick.grift@defensec.nl
> >> Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
> >> https://sks-keyservers.net/pks/lookup?op=get&search=0xDA7E521F10F64098
> >> Dominick Grift
>
> --
> gpg --locate-keys dominick.grift@defensec.nl
> Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
> https://sks-keyservers.net/pks/lookup?op=get&search=0xDA7E521F10F64098
> Dominick Grift
