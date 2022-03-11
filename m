Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11CF7C433F5
	for <selinux@archiver.kernel.org>; Fri, 11 Mar 2022 16:03:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350137AbiCKQEB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 11 Mar 2022 11:04:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350117AbiCKQDz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 11 Mar 2022 11:03:55 -0500
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81D819BE55
        for <selinux@vger.kernel.org>; Fri, 11 Mar 2022 08:02:50 -0800 (PST)
Received: by mail-oo1-xc29.google.com with SMTP id x26-20020a4a621a000000b00320d7d4af22so10979339ooc.4
        for <selinux@vger.kernel.org>; Fri, 11 Mar 2022 08:02:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9jENhBgCmfYJIF2SmfrvpVdUsxVwE94mbYbU5NL9fFs=;
        b=CnOiKq/ulREksEn2cIljYDZABhfypm9vxyHzmP8pr36V0r8SFSaHYAjlojd6NFVKQm
         iLK05+YTSzysQt4KQyuDNUioEY5wP6jq7Zix2JyYBkJElp9PtfpRp/e58aZ3LlrGXaBO
         pSreqLLZVLLjidmWgtEnMTPoSMCHXK3Nhs0R4nQypfwovlu/jBNOHj18hKVBylobrQ1p
         JQjnbX2XLTMuRpdF0TEqfHP/4C3iTVrCkViASnJJ/RtfVkBfaDH4ullopjhqdU2zS0P1
         AtoJSe8mdBupJUrZypuyoOpDSBWgNrbfn4Y7+GBu9AH5k2fIVrJzkONLmlPrkwEKH3u0
         oyaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9jENhBgCmfYJIF2SmfrvpVdUsxVwE94mbYbU5NL9fFs=;
        b=OCg/yLEnIPh8RCgji+0WcPe47xCDIeGbvPMTtRZFilWCdo1hSciK9nCjA3EvsceKi4
         g/ZoKA/jdaoZhyyfcVfW2LJPex+GgGFAU6XjzeVW4l7e0GHx6oTxwUbX4Qu9IEJjG1I6
         XJVzzr501ybthumdd0cQ+N2x5Ek27vqGwp0s8vPFx2lkxzoVhVoO4grbEAY5cZXE18X+
         WzIGDJ3qWe5Tkv/Pk2Scg+Bi8PV2/QG9lu71GZPQ0aF+2baCUF6I/UrRwyunDmSDhFHP
         HppHT47YpgHSs70cKHLjDEmWulRkdfuen+U6BZdnsEtkKAVIabVA8aNJxqs1Nw/LWIwP
         1gtQ==
X-Gm-Message-State: AOAM532AmKKE10cykGsV61e0zpSpkeX99oPLlFUH9In+JPEUV9gHLk4R
        SZCJZyhekLwbz/T44Edul6vtejno/3YcG5Q81l74Eg5L
X-Google-Smtp-Source: ABdhPJzC8QWWzGrfNqxC3vJeRv9LHMkQV3zpgzN1C2Vv/d1r2ebGEjyVALHkpgHOML82YV/yyUL3XNv5/kR1mfmvpsg=
X-Received: by 2002:a4a:b5c5:0:b0:321:248:bd50 with SMTP id
 u5-20020a4ab5c5000000b003210248bd50mr4899158ooo.50.1647014570178; Fri, 11 Mar
 2022 08:02:50 -0800 (PST)
MIME-Version: 1.0
References: <CAFqZXNtBmoVppmhgrxfzuZrQ+oksWeSHH_x7ZgG4Wa6VO05Dsw@mail.gmail.com>
 <20220218092057.394337-1-plautrba@redhat.com> <CAFqZXNvk3QZZChy7Uasp2E4FjQj4yUBmSCq_bVvFacZtPv=xJg@mail.gmail.com>
In-Reply-To: <CAFqZXNvk3QZZChy7Uasp2E4FjQj4yUBmSCq_bVvFacZtPv=xJg@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 11 Mar 2022 11:02:39 -0500
Message-ID: <CAP+JOzRVf9r980YjJd4Z1z7QH0oU5srtnE2oy3bEtppcDDtV7w@mail.gmail.com>
Subject: Re: [PATCH v2] policycoreutils/fixfiles: Use parallel relabeling
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Petr Lautrbach <plautrba@redhat.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Mar 2, 2022 at 7:21 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Fri, Feb 18, 2022 at 10:21 AM Petr Lautrbach <plautrba@redhat.com> wrote:
> > Commit 93902fc8340f ("setfiles/restorecon: support parallel relabeling")
> > implemented support for parallel relabeling in setfiles. This is
> > available for fixfiles now.
> >
> > Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> > ---
> >
> > - fixed echo commands for onboot
> >
> > policycoreutils/scripts/fixfiles   | 35 +++++++++++++++++-------------
> >  policycoreutils/scripts/fixfiles.8 | 17 ++++++++++-----
> >  2 files changed, 31 insertions(+), 21 deletions(-)
> >
> > diff --git a/policycoreutils/scripts/fixfiles b/policycoreutils/scripts/fixfiles
> > index 6fb12e0451a9..1ff4d9bdf04e 100755
> > --- a/policycoreutils/scripts/fixfiles
> > +++ b/policycoreutils/scripts/fixfiles
> [...]
> > @@ -342,17 +344,17 @@ esac
> >  }
> >  usage() {
> >         echo $"""
> > -Usage: $0 [-v] [-F] [-M] [-f] relabel
> > +Usage: $0 [-v] [-F] [-M] [-f] [-T nthreads] relabel
> >  or
> > -Usage: $0 [-v] [-F] [-B | -N time ] { check | restore | verify }
> > +Usage: $0 [-v] [-F] [-B | -N time ]  [-T nthreads] { check | restore | verify }
>
> There is an extra space added here, but that can be fixed up when applying.
>
> >  or
> > -Usage: $0 [-v] [-F] { check | restore | verify } dir/file ...
> > +Usage: $0 [-v] [-F] [-T nthreads] { check | restore | verify } dir/file ...
> >  or
> > -Usage: $0 [-v] [-F] -R rpmpackage[,rpmpackage...] { check | restore | verify }
> > +Usage: $0 [-v] [-F] [-T nthreads] -R rpmpackage[,rpmpackage...] { check | restore | verify }
> >  or
> > -Usage: $0 [-v] [-F] -C PREVIOUS_FILECONTEXT { check | restore | verify }
> > +Usage: $0 [-v] [-F] [-T nthreads] -C PREVIOUS_FILECONTEXT { check | restore | verify }
> >  or
> > -Usage: $0 [-F] [-M] [-B] onboot
> > +Usage: $0 [-F] [-M] [-B] [-T nthreads] onboot
> >  """
> >  }
> >
> [...]
>
> Acked-by: Ondrej Mosnacek <omosnace@redhat.com>
>

Applied (without the extra space)
Thanks,
Jim

> --
> Ondrej Mosnacek
> Software Engineer, Linux Security - SELinux kernel
> Red Hat, Inc.
>
