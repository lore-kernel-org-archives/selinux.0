Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8FE2C4332F
	for <selinux@archiver.kernel.org>; Wed,  9 Nov 2022 13:48:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbiKINsV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Nov 2022 08:48:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiKINsU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Nov 2022 08:48:20 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CAF815FF7
        for <selinux@vger.kernel.org>; Wed,  9 Nov 2022 05:48:19 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id j16so25619649lfe.12
        for <selinux@vger.kernel.org>; Wed, 09 Nov 2022 05:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fMKwV1p6FpAZwj3aEtjScWqPRDMmPn2fAurG2eJGF9I=;
        b=GVkpG4HkSI8CiPbMmg8+LcEwiYg2C2+giLXBMerFyElPjaqLPUKDLaoxtbE4ItrAnI
         Q5jp5bz64gNokn9R3bUNKFwXjowWwJPAdmTaXKD3v5/uk8UUYUerDxM92UZSjqd4PyTH
         C2WgeZ5nTC/raCP/3zy3AD/xZgtVneAE5WTVotpmIYQpmgZ2ZdfbdqG3fpfDBcyez02K
         tBiq0wx97lNL12L2QJ/CIMSVIqzO3Ns1rTjNEwo/Vj/mhHgopCEiLgWvDKLcCDDwHKHn
         iIZ5ZjFhUv+861nnUVXV4izTCApIL3+gj8MrSmomA65jiLF7AzU8xMFoORlHuUXbmK45
         0z4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fMKwV1p6FpAZwj3aEtjScWqPRDMmPn2fAurG2eJGF9I=;
        b=YICkRCq5Fv5oHS8tZNMT3gSciXq+DehwaJ28CLjC9Ws1g27PTRvAWJW63wqz2dtyEd
         SpVRpkekBrGX+NmYUxm/hzBxdaGpWj8qk8KW2v1Y93aVvqcggL7iVl7ju7uMtLuXSpAv
         8IP6iJy5HzBTaSJH2anIyKeh5H3D9RT/YEFLgclHZrQuft7+tcfqucf6OeGshkPwWvkb
         IbI/GnZ8J645KQrz/AKiW7pOQ5ZgV2qqowSbuMeYlFtTTcPJf1D/JUxA27pZ0Ucmbw/w
         5RITwl+aRZEPDmp7IQPahP6+pE0LrGesHzGJ5tNOHjExMRzilFFHhRY8w6S0i+Z0KUHQ
         OJwA==
X-Gm-Message-State: ACrzQf1NDWxUUFAclFpT7WYoqfxAIIDLABRwMeZv6EhqzN7GZJwqM4be
        ZWlh90MNn0Iwkn9Jj0+e+5D0aV7atCwN7VjMUqA=
X-Google-Smtp-Source: AMsMyM5HT+E2ozUHrA5R6PM+btBc8xwXNKzxKh0YG47ljCUgiiNHg0kOAuBBZaQV92h+TKaMmlWeOmDIx/4/ahTmN/w=
X-Received: by 2002:a19:791b:0:b0:4b0:ab95:f07 with SMTP id
 u27-20020a19791b000000b004b0ab950f07mr19202350lfc.30.1668001698038; Wed, 09
 Nov 2022 05:48:18 -0800 (PST)
MIME-Version: 1.0
References: <20221031164617.3096227-1-vmojzis@redhat.com> <CAP+JOzQgPGLxD32ezck6anpdWCjTOeK6MX=3RadQS7iitV_F6g@mail.gmail.com>
In-Reply-To: <CAP+JOzQgPGLxD32ezck6anpdWCjTOeK6MX=3RadQS7iitV_F6g@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 9 Nov 2022 08:48:06 -0500
Message-ID: <CAP+JOzSUa46xi9N9MRoB7qALY0wq2vKxCEe5CJoeoKrkH-7FLA@mail.gmail.com>
Subject: Re: [PATCH] libselinux: Ignore missing directories when -i is used
To:     Vit Mojzis <vmojzis@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Nov 7, 2022 at 2:34 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Mon, Oct 31, 2022 at 12:51 PM Vit Mojzis <vmojzis@redhat.com> wrote:
> >
> > Currently "-i" only ignores a file whose parent directory exists. Start also
> > ignoring paths with missing components.
> >
> > Fixes:
> >   # restorecon -i -v -R /var/log/missingdir/missingfile; echo $?
> >   255
> >   restorecon: SELinux: Could not get canonical path for /var/log/missingdir/missingfile restorecon: No such file or directory.
> >
> > Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> >  libselinux/src/selinux_restorecon.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
> > index 2d24559f..6b5f6921 100644
> > --- a/libselinux/src/selinux_restorecon.c
> > +++ b/libselinux/src/selinux_restorecon.c
> > @@ -1108,6 +1108,10 @@ static int selinux_restorecon_common(const char *pathname_orig,
> >                         pathname = realpath(pathname_orig, NULL);
> >                         if (!pathname) {
> >                                 free(basename_cpy);
> > +                               /* missing parent directory */
> > +                               if (state.flags.ignore_noent && errno == ENOENT) {
> > +                                       return 0;
> > +                               }
> >                                 goto realpatherr;
> >                         }
> >                 } else {
> > @@ -1121,6 +1125,9 @@ static int selinux_restorecon_common(const char *pathname_orig,
> >                         free(dirname_cpy);
> >                         if (!pathdnamer) {
> >                                 free(basename_cpy);
> > +                               if (state.flags.ignore_noent && errno == ENOENT) {
> > +                                       return 0;
> > +                               }
> >                                 goto realpatherr;
> >                         }
> >                         if (!strcmp(pathdnamer, "/"))
> > --
> > 2.37.3
> >
