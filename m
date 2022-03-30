Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DDDAC433EF
	for <selinux@archiver.kernel.org>; Wed, 30 Mar 2022 19:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350516AbiC3TII (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 30 Mar 2022 15:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350514AbiC3TIE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 30 Mar 2022 15:08:04 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38CC82F387
        for <selinux@vger.kernel.org>; Wed, 30 Mar 2022 12:06:19 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-de3ca1efbaso22999290fac.9
        for <selinux@vger.kernel.org>; Wed, 30 Mar 2022 12:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ep/B5jCmKQky3+DkX38CJKthsuL7hQk7n7nL5T7ds3A=;
        b=MNnqTgCE4+njj9ItvBSzTCABDTg8EUPDyg9myUqLZNN7eDSEx8aKWDsvAdBpzjqc2z
         ZpRS7w5/rMGDVo/aUH0OdoXxQehPMAWNXt0HUackEshc/v+jvw/o3tZ3HQWPe/rYyrx7
         44Zm0AOxFoSFsXcISlqkSkNZghRYVPvmTQbXzOvKSawxdmj76RZMxeWqHYQ2anQoQq/J
         RAoDBqgdsVQ3BlbCtBctC+dzZ0SDXZPYboOIAnxZIYfv9TZFKstdC+/AXALsp+IjN0Zj
         2SmMZO9n7wcNp7T9xZmD7ukS86Y7l5LQ6wetxEaVD7V4T4wHeBPRP6DUD3gtbo5SmGz9
         hFng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ep/B5jCmKQky3+DkX38CJKthsuL7hQk7n7nL5T7ds3A=;
        b=T58Pf3WzoYqdktHwvhTSPA4D5Xo7j67CGYZ4cf0zskmO3vpja31YqtYbE0+p320y6F
         24CRB0HvOQiodINu+12lrL+maGZxdayPh9phize4Ccc2pPA0MRgFAeKZHZ3ZdNr3rzZ9
         B7K1Sk3D35vMO1n1UuHOz0aOZjdhHXvb9zFHqyFM5c9TLSzdC8uCuLYCnpB5KM3OrvXf
         FlExrKjas7AfyD8gsaQP4Wvp8nMtOSURtLz2XewaHFWahrgRZD6svaFIyRNig5QFjc6W
         cib3oGdoSupPmoLAb7VOlcPbuuUoH4tgeRLN2VpwZWYxCzbcru9K1p3KInVRUldvbM7g
         c/4w==
X-Gm-Message-State: AOAM532bboG3+zcOov3/ceZkcS4QKE2bVIdkhw3kus8w9bSR59dsY/JH
        yo8GaEOZqRyYwR6FIU3A5ZwetoGkxOaSPsu7VDWCqspl
X-Google-Smtp-Source: ABdhPJyQh8L1nC9ml6sresfDTs1bckIvTzjxMaMWyycTMl1YHmMRNgC/H6nYeshdXgBLNqpaqbCJjsmpMRnb6gPD1is=
X-Received: by 2002:a05:6871:81e:b0:dd:9f3e:c94a with SMTP id
 q30-20020a056871081e00b000dd9f3ec94amr630477oap.156.1648667178412; Wed, 30
 Mar 2022 12:06:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220314182400.121510-1-jwcart2@gmail.com> <CAJ2a_Dd-c=xTsnz9q95dhQkwTD+iFcVuRyMCUAG2TopASY739Q@mail.gmail.com>
In-Reply-To: <CAJ2a_Dd-c=xTsnz9q95dhQkwTD+iFcVuRyMCUAG2TopASY739Q@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 30 Mar 2022 15:06:07 -0400
Message-ID: <CAP+JOzRsMCuTeY_ee9+SrOE=6DvridAo-F8W=8sN6hefztRa1Q@mail.gmail.com>
Subject: Re: [PATCH] libsepol: Use calloc when initializing bool_val_to_struct array
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Mar 29, 2022 at 3:43 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> On Mon, 14 Mar 2022 at 19:24, James Carter <jwcart2@gmail.com> wrote:
> >
> > Use calloc() instead of mallocarray() so that everything is
> > initialized to zero to prevent the use of unitialized memory when
> > validating malformed binary policies.
> >
> > Found by oss-fuzz (#45493)
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
> > ---
> >  libsepol/src/conditional.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/libsepol/src/conditional.c b/libsepol/src/conditional.c
> > index f78b38a2..a620451d 100644
> > --- a/libsepol/src/conditional.c
> > +++ b/libsepol/src/conditional.c
> > @@ -522,7 +522,7 @@ int cond_init_bool_indexes(policydb_t * p)
> >         if (p->bool_val_to_struct)
> >                 free(p->bool_val_to_struct);
> >         p->bool_val_to_struct =3D (cond_bool_datum_t **)
> > -           mallocarray(p->p_bools.nprim, sizeof(cond_bool_datum_t *));
> > +           calloc(p->p_bools.nprim, sizeof(cond_bool_datum_t *));
> >         if (!p->bool_val_to_struct)
> >                 return -1;
> >         return 0;
> > --
> > 2.34.1
> >
>
> Can this be merged? I think it might hurt the fuzzer, e.g. cause the
> flakiness in issue #45327.
>

This has been merged.
Jim

> On a technical note:
> In src/policydb.c::policydb_index_others() the return value of
> cond_init_bool_indexes() is not checked.
>
> diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
> index fc71463e..e29cbd51 100644
> --- a/libsepol/src/policydb.c
> +++ b/libsepol/src/policydb.c
> @@ -1252,7 +1252,8 @@ int policydb_index_others(sepol_handle_t * handle,
>        if (!p->type_val_to_struct)
>                return -1;
>
> -       cond_init_bool_indexes(p);
> +       if (cond_init_bool_indexes(p) =3D=3D -1)
> +               return -1;
>
>        for (i =3D SYM_ROLES; i < SYM_NUM; i++) {
>                free(p->sym_val_to_name[i]);
