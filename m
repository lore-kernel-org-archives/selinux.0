Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 363BFC433E0
	for <selinux@archiver.kernel.org>; Thu, 18 Mar 2021 14:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A91C64EF9
	for <selinux@archiver.kernel.org>; Thu, 18 Mar 2021 14:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbhCROO5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Mar 2021 10:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbhCROOb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Mar 2021 10:14:31 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2EAC06174A
        for <selinux@vger.kernel.org>; Thu, 18 Mar 2021 07:14:31 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id f73-20020a9d03cf0000b02901b4d889bce0so5283783otf.12
        for <selinux@vger.kernel.org>; Thu, 18 Mar 2021 07:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=INpFsqo7fZxIQDIzy7B8XrBTyS6ugyNDQ+3agK31LiY=;
        b=uyVeI/KDMDQKg9O01yJWM0Chxt00nimvhtlDZBiQgh3KiHw3ST9PFPBiVFp1DCGy0d
         0Ytd2RRDocGigl3orzji0cDUvCeExGlu6DiSjHVvc/capVRsNaXLiS+m8VioJAR21rvd
         a7eQndU73HDVsNHWr5Hu2IrQElQgCiIuCXLTYqevgjMRKocJcFSHZpdDaQ/Y/ve7EKLK
         Po94vYNmzeVefmezMLk1u4jeyblVIkF8UBllxw1LNhrcD4XT3G/BsyMb3Sa+FiVe5MEe
         NG/GFAdtmztLERzn84P/sHGWsL9E4hz1zvQRyfmefmRGzSRvpNCRDh1cdKqTFVXlVR2b
         IhdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=INpFsqo7fZxIQDIzy7B8XrBTyS6ugyNDQ+3agK31LiY=;
        b=igWmIYslRkCzcnxPOQo2fDNXkmmNlD4DAB1AVeSTWPuOIiapS9sCCfZWAnT8oM9bfC
         vWuGFPYNbXkP+8LiKNV+jV2jY8xgpH1TogCj8V9iEOIF9tFWdV1r6cbrfVJ3Xbrv4ZF+
         Ev2h7BC7LHDcbNRdW6znBj7WmWSZdeOb2yM2i9BoBMqD/W7pj4gVYtHTt0obzB9NztDN
         AWxO0tYdKawxzaqyCYSqD0qwFQDQrPp0RXWaqRqGsu4qZJUXxGh9w96WMGjOJ9/sHkY9
         xjbb+tk9zMui3x0TZqGkpkso1prf7bfI9sngLGClEcYs6p+UPBHOtZIkYTKAmdIu0yma
         FGpA==
X-Gm-Message-State: AOAM532yj1k995UMgsdLqJQqVPWE5p4QED03c81fpwVUoauX85JO8IEF
        Vx/OqYdCV6gp8FXvsq+rcBJPZaKdUcJD3btrph0=
X-Google-Smtp-Source: ABdhPJyQautdeTlKe+z0oh+jeoYkF1eQffzhZw4y1ftEKvWTyyhdU7ra/7TBw/ACiHnjbtzTxcG6MB62EkGn7E7UAoo=
X-Received: by 2002:a9d:6296:: with SMTP id x22mr7371452otk.196.1616076870534;
 Thu, 18 Mar 2021 07:14:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210316203943.47733-1-jwcart2@gmail.com> <CAJfZ7=m0OfP6GCEJDY6zX=XJYPU=CZh+XsOp4Fh1YtinhrmxfA@mail.gmail.com>
In-Reply-To: <CAJfZ7=m0OfP6GCEJDY6zX=XJYPU=CZh+XsOp4Fh1YtinhrmxfA@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 18 Mar 2021 10:14:19 -0400
Message-ID: <CAP+JOzQgRJ3HtuPT6L96zOZQxxRMptxg9nRRMeLBoco0=o1rSg@mail.gmail.com>
Subject: Re: [PATCH 1/2] libsepol: Write "NO_IDENTIFIER" for empty constraint expression
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Mar 17, 2021 at 5:29 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Tue, Mar 16, 2021 at 9:40 PM James Carter <jwcart2@gmail.com> wrote:
> >
> > If a role attribute with no roles associated with it is used in a
> > constraint expression, then the role bitmap will be empty. This is
> > not a problem for the kernel, but does cause problems when
> > converting a kernel policy to policy.conf.
> >
> > When creating a policy.conf from a kernel policy, if an empty bitmap
> > is encountered, use the string "NO_IDENTIFIER". An error will occur
> > if an attempt is made to compile the resulting policy, but this is
> > better than exiting with an error without creating a policy.conf.
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
>
> For these 2 patches:
> Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>

These 2 patches have been merged.
Thanks,
Jim

> > ---
> >  libsepol/src/kernel_to_conf.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.c
> > index a22f196d..263f9639 100644
> > --- a/libsepol/src/kernel_to_conf.c
> > +++ b/libsepol/src/kernel_to_conf.c
> > @@ -186,7 +186,7 @@ static char *constraint_expr_to_str(struct policydb *pdb, struct constraint_expr
> >                                         names = ebitmap_to_str(&curr->names, pdb->p_role_val_to_name, 1);
> >                                 }
> >                                 if (!names) {
> > -                                       goto exit;
> > +                                       names = strdup("NO_IDENTIFIER");
> >                                 }
> >                                 new_val = create_str("%s %s %s", 3, attr1, op, names);
> >                                 free(names);
> > --
> > 2.26.2
> >
>
