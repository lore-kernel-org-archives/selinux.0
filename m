Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E41BAC43334
	for <selinux@archiver.kernel.org>; Wed, 29 Jun 2022 16:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbiF2Qzw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 29 Jun 2022 12:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiF2Qzv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 29 Jun 2022 12:55:51 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3D3258
        for <selinux@vger.kernel.org>; Wed, 29 Jun 2022 09:55:50 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id s13-20020a0568301e0d00b00616ad12fee7so11708709otr.10
        for <selinux@vger.kernel.org>; Wed, 29 Jun 2022 09:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3FeSFOQkR8i4iLodTYu6DBOP6nkzQc75O2CJ80ivjrE=;
        b=DBUyCCtshlsrtGBPz9R6Xgc55wZ0ADElXEUmeNIXe+cMVG2LNJrO5bbOau8cljI0Lr
         h63lB5G4g3wCN38e4eAYHCr3xO+tDKZYrde9+QwioSRpMmwgkvPD/pa4o90/NF6JioYZ
         4m8I4w+/ePPyJEH4I4Ca/x5YzUuVuA+wrmjTByxQjAK25noMLOKlEqosUfG0yG4YqDq3
         3GDBe/JqwfW/ea75O/8pYYsjEKkO6WNKX+o5/Jp62R0mDgFDn/ITR5FIVIWhN9fo2CU4
         iQxl7s9z0ZcxoMo7obwqKo5HR3nprx0Q7SlVeuhiQASgnD0tqi6wVAgNalVH6sj0fITC
         wlJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3FeSFOQkR8i4iLodTYu6DBOP6nkzQc75O2CJ80ivjrE=;
        b=BGR/Sn3x+LEYGAVIovIg99t+JpQ7cQPiHltD+Gjhnndyrw6y5tdRTATla0RdDm/EgN
         zR+M+Mk7ItWi0DEOd8Vd3G0zOzLXD340G5BSiCcjdRrksQbuusctsNcR+DHdANi3E1nY
         4iGgLn8JjjuatV41APJDIAh+Sfh0ne14Y/73UVS2oonhR5xMcC0Xz/tZZ6Ad7qIIZbko
         WIX8+bCs1m81YeuQOHzuLYhAM/VuXnS0YdSPsHIav99RHYydXI/TPimdKLHtvoxLVQ/3
         l4gKT0ozdYgIRNDMNzTbey5ok6bmhmDc7BL9EZyavwFSiwBMUWRy/V8s12N1zlva/d9H
         rGGw==
X-Gm-Message-State: AJIora9u2DdMpf8thPLSKg6Y1H0qwz69XK0Us6WRTVT2C2dpXheR6ide
        B5Jpg85QNB5AobkIrtQsyQ4uiEyZF1yuxzjyV0En0p7t
X-Google-Smtp-Source: AGRyM1uDuRaYoiD8p5OL6HgbakaWr5ENp1h5EDNjJXck8NCdKjtujSzMjKAv6+/y1XTfRkNYl+j3apDF323XW+TJjdA=
X-Received: by 2002:a05:6830:91d:b0:616:e98c:2581 with SMTP id
 v29-20020a056830091d00b00616e98c2581mr1960131ott.53.1656521750109; Wed, 29
 Jun 2022 09:55:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220608170954.114668-1-omosnace@redhat.com> <20220608170954.114668-2-omosnace@redhat.com>
 <CAJfZ7==gbwH8-SaNxEVRU0CCnP-HaDemC7GqhK9CmkYG+p05vA@mail.gmail.com>
In-Reply-To: <CAJfZ7==gbwH8-SaNxEVRU0CCnP-HaDemC7GqhK9CmkYG+p05vA@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 29 Jun 2022 12:55:39 -0400
Message-ID: <CAP+JOzR0oxga_drqVhDi3yCgSkeSzXmuMcgWwh3=snVb8FgCTw@mail.gmail.com>
Subject: Re: [PATCH userspace 1/2] libsemanage: always write kernel policy
 when check_ext_changes is specified
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jun 28, 2022 at 5:08 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Wed, Jun 8, 2022 at 7:23 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > For the use case of rebuilding the policy afte package updates, we need
> > the check_ext_changes operation to always do at least the do_write_kernel
> > step, because the various semanage dbs may have also changed content
> > relative to the current binary policy. As this step is itself relatively
> > fast, we can do it unconditionally.
> >
> > Fixes: 286a679fadc4 ("libsemanage: optionally rebuild policy when modules are changed externally")
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
>
> Hello,
> This patch and the next one ("semodule: rename
> --rebuild-if-modules-changed to --refresh") look good to me. Has
> anyone also taken a look at them?
>
> If nobody objects, I will merge it tomorrow, with a small misspelling
> fix in the commit message (afte -> after).
>

These look good to me as well.
Thanks,
Jim


> Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>
> Thanks,
> Nicolas
>
> > ---
> >  libsemanage/include/semanage/handle.h | 2 +-
> >  libsemanage/src/direct_api.c          | 8 +++++---
> >  2 files changed, 6 insertions(+), 4 deletions(-)
> >
> > diff --git a/libsemanage/include/semanage/handle.h b/libsemanage/include/semanage/handle.h
> > index 0157be4f..4cf30815 100644
> > --- a/libsemanage/include/semanage/handle.h
> > +++ b/libsemanage/include/semanage/handle.h
> > @@ -67,7 +67,7 @@ extern void semanage_set_reload(semanage_handle_t * handle, int do_reload);
> >  extern void semanage_set_rebuild(semanage_handle_t * handle, int do_rebuild);
> >
> >  /* set whether to rebuild the policy on commit when potential changes
> > - * to module files since last rebuild are detected,
> > + * to store files since last rebuild are detected,
> >   * 1 for yes (default), 0 for no */
> >  extern void semanage_set_check_ext_changes(semanage_handle_t * handle, int do_check);
> >
> > diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
> > index 7206483a..7aa081ab 100644
> > --- a/libsemanage/src/direct_api.c
> > +++ b/libsemanage/src/direct_api.c
> > @@ -1437,13 +1437,15 @@ static int semanage_direct_commit(semanage_handle_t * sh)
> >          * Determine what else needs to be done.
> >          * We need to write the kernel policy if we are rebuilding
> >          * or if any other policy component that lives in the kernel
> > -        * policy has been modified.
> > +        * policy has been modified. We also want to force it when
> > +        * check_ext_changes was specified as the various dbases may have
> > +        * changes as well.
> >          * We need to install the policy files if any of the managed files
> >          * that live under /etc/selinux (kernel policy, seusers, file contexts)
> >          * will be modified.
> >          */
> > -       do_write_kernel = do_rebuild | ports_modified | ibpkeys_modified |
> > -               ibendports_modified |
> > +       do_write_kernel = do_rebuild | sh->check_ext_changes |
> > +               ports_modified | ibpkeys_modified | ibendports_modified |
> >                 bools->dtable->is_modified(bools->dbase) |
> >                 ifaces->dtable->is_modified(ifaces->dbase) |
> >                 nodes->dtable->is_modified(nodes->dbase) |
> > --
> > 2.36.1
> >
>
