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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F47C4338F
	for <selinux@archiver.kernel.org>; Mon,  2 Aug 2021 14:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27D3D60F70
	for <selinux@archiver.kernel.org>; Mon,  2 Aug 2021 14:50:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234132AbhHBOum (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 2 Aug 2021 10:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233925AbhHBOul (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 2 Aug 2021 10:50:41 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D07C06175F
        for <selinux@vger.kernel.org>; Mon,  2 Aug 2021 07:50:31 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id t1-20020a4a54010000b02902638ef0f883so4442713ooa.11
        for <selinux@vger.kernel.org>; Mon, 02 Aug 2021 07:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wWUwxl4CatMTNG8eVhITvHCrMnxFZyr6N9zxYzTeAeY=;
        b=ntXqB4e9za7GJPtJnV/RFq7AL0IfYYG/oU6hLYYreuQAbgLyGLuk94erygXmiGiycl
         j4zKcBZSQlyhBP57PFzAkbrQLy/yVxjbmrFyA+3gheIR5/xwys0ydD4bIMhqGPjRFbPS
         xremBywZkDcesNRg2/FOoAEkYbN/DrPHrYX4jEwLmlJiWO3O1c9ozakOPAP47T4+WtJv
         80a8l0UW+DHF/s/CDxbTnlf9QiLrDd9IfrAvQ9a4NSpP7nBYWwA7HdSI0gaTvpEQOIPr
         YMLjp8R1zmEpnywUZSAn5TTxbJk776OOFfyVNf0IYzhcPJxT6m+GgtCDs3amwxqT1dmG
         E4Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wWUwxl4CatMTNG8eVhITvHCrMnxFZyr6N9zxYzTeAeY=;
        b=Wa5imExAv3nRNaboZW1AmZy3im6SmTm8kuxpJo+9+yCPRZyN/oAZF61no7bK0xRffx
         vFPQvC6CSZZg+oofaKe06ZQlUbsy00J8hjYHXuMFBghQv+Ig1EOeyAcVtiq+ewLo1MQ+
         00UcfbHWnm485dTusqbWQQSgbdIJWPSIiMLXmVXUhybljM/EqEL98vyT4nyttgsPJare
         sOVPkHCxL7XsfNGncqfWSxPXyiD6LeF5meS0QmmTyW0EMBg1tRcQMDXq4/9c/HlQP8F5
         bsLjYnI9R8RiWcaZLZ0VyxNxUccXPm+hCAxuexE3SuUH+7zdWUNUpL1J+AJNaSTOiHRW
         5aIA==
X-Gm-Message-State: AOAM532qwhrib3iFmRHYepk5BZ4Me9ipFN6iI5vBdKDj+/aamez6O5D/
        Hq5HPFPXSLyq3TMFr6/XFSX9i6ZMrod48STxUbe39xbjSJ8=
X-Google-Smtp-Source: ABdhPJxzmsWaP4HDwU6NTOyLdaSiwjF/aVs6PyWVcXAmYUNlI1rUZ8umSuUuar2ab49dQpOs+srgCpw+pQ8cRY/aDIw=
X-Received: by 2002:a4a:c387:: with SMTP id u7mr10804023oop.59.1627915830462;
 Mon, 02 Aug 2021 07:50:30 -0700 (PDT)
MIME-Version: 1.0
References: <871r7dtfbp.fsf@defensec.nl>
In-Reply-To: <871r7dtfbp.fsf@defensec.nl>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 2 Aug 2021 10:50:19 -0400
Message-ID: <CAP+JOzQt1pxNMZuPK_dzdDHtshrrpEo1ynkFq7CaNpCG1n_JyA@mail.gmail.com>
Subject: Re: libsepol regressions
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Aug 1, 2021 at 10:32 AM Dominick Grift
<dominick.grift@defensec.nl> wrote:
>
>
> Fedora recently decided to pull in various libsepol patches from
> master[1]
>
> My policy has broken down in various way's. Some changes make sense but
> some others I have issues with.
>
> An example of something I never expected to be allowed in the first
> place is re-declarations of blocks and recent changes exposed some instances
> where I declared blocks multiple times and got away with it.
>
> However I also encountered issues that i am not sure how to deal
> with.
>
> re-declarations of macros are no longer allowed:
>

Re-declarations were never supposed to be allowed (other than the
declaration of types and typeattributes when using the -m flag), but
there were not sufficient checks being done when copying the CIL AST
when expanding macro calls, resolving the inheritance of blocks, and
things like that.

The result was behavior that depends on the rule order and one of the
principles of CIL is that there would be no rule order dependencies.

> Take this example:
> https://github.com/DefenSec/dssp5/blob/dev/src/dev/termdev.cil
>
> Here I inherit a set of macros from the
> "file.all_macro_template_chr_files" template and then I override some of these
> macros by manually re-declaring them with slighty different content (the
> xperm rules are appended).
>
> This use to be allowed but I am no longer allowed to redeclare macros.
>

I can see that this might be useful behavior.

> This would not necessarily be a big problem IF this would instead work:
>
> diff --git a/src/dev/termdev.cil b/src/dev/termdev.cil
> index 1c0fe66..4f067db 100644
> --- a/src/dev/termdev.cil
> +++ b/src/dev/termdev.cil
> @@ -3,21 +3,9 @@
>
>  (block termdev
>
> -       (macro appendinherited_all_chr_files ((type ARG1))
> -             (allow ARG1 typeattr appendinherited_chr_file)
> -             (allowx ARG1 typeattr (ioctl chr_file (not (0x5412)))))
> -
> -       (macro readwriteinherited_all_chr_files ((type ARG1))
> -             (allow ARG1 typeattr readwriteinherited_chr_file)
> -             (allowx ARG1 typeattr (ioctl chr_file (not (0x5412)))))
> -
>         (macro type ((type ARG1))
>               (typeattributeset typeattr ARG1))
>
> -       (macro writeinherited_all_chr_files ((type ARG1))
> -             (allow ARG1 typeattr writeinherited_chr_file)
> -             (allowx ARG1 typeattr (ioctl chr_file (not (0x5412)))))
> -
>         (typeattribute typeattr)
>
>         (blockinherit .file.all_macro_template_chr_files)
> @@ -33,3 +21,12 @@
>
>               (allow typeattr termdev.typeatt
>                      (chr_file (not (execmod mounton))))))
> +
> +(in termdev.appendinherited_all_chr_files
> +    (allowx ARG1 typeattr (ioctl chr_file (not (0x5412)))))
> +
> +(in termdev.readwriteinherited_all_chr_files
> +    (allowx ARG1 typeattr (ioctl chr_file (not (0x5412)))))
> +
> +(in termdev.writeinherited_all_chr_files
> +    (allowx ARG1 typeattr (ioctl chr_file (not (0x5412)))))
>
> But the above in-statements cannot be resolved.
>

I think that overriding the macros would make more sense, but I'll
have to think about it.

It would be a pain, but you could do something like:
(block B1
  (macro M1 (...)
    ...
  )
  (macro M2 (...)
    ...
  )
)

(block B2
  (block parent
    (blockinherit B1)
  )
  (macro M1 (...)
    (call parent.M1 (...))
    ...
  )
  (macro M2 (...)
    (call parent.MA (...))
    ...
  )
)

> This is not the only instance where this approach does not work. I also
> have templates that declare blocks. I use to be allowed to re-declare
> these blocks so that I could add to them but this is no longer
> allowed. However these blocks also cannot be resolved outside of the
> templates, so I cannot use "in" to reference them.
>
> It seems as if the "in" blocks are resolved before the "blockinherit"
> blocks are expanded.
>

It is true that in-statements are resolved before inheritance, so what
you have above would not work.

If you are just adding rules and not declarations, then you don't have
to put the rules in the block.
Example:
(block B1
  (block B
    (type t)
   )
)
(block B2
  (blockinherit B1)
  (allow B.t self (CLASS (PERM)))
)

It might be possible to attempt to resolve all in-statements before
inheritance as what currently happens and then try to resolve any
remaining in-statements after inheritance has been resolved.

I'll have to think about the problem a bit.

Thanks for the questions,
Jim



The problem
> [1] https://src.fedoraproject.org/rpms/libsepol/c/c59879b8aa30ceb601ac4e449ee5e958c6659fbc?branch=rawhide
>
> --
> gpg --locate-keys dominick.grift@defensec.nl
> Key fingerprint = FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
> https://sks-keyservers.net/pks/lookup?op=get&search=0xDA7E521F10F64098
> Dominick Grift
