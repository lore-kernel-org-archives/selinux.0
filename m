Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38FEFC433EF
	for <selinux@archiver.kernel.org>; Thu, 30 Jun 2022 19:42:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236884AbiF3Tmb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 30 Jun 2022 15:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236881AbiF3Tmb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 30 Jun 2022 15:42:31 -0400
Received: from mx1.polytechnique.org (mx1.polytechnique.org [129.104.30.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8749243AD4
        for <selinux@vger.kernel.org>; Thu, 30 Jun 2022 12:42:29 -0700 (PDT)
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 321E6564E41
        for <selinux@vger.kernel.org>; Thu, 30 Jun 2022 21:34:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=m4x.org; s=svoboda;
        t=1656617699; bh=qK+rf1OY2UWCV4fcxxiA3gnPjDj/oorkaRRguUtcgDg=;
        h=References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc;
        b=gJmxnNwqYdpTt0SdwR9MXsASs9/5jGp8c/QkNPgAAjKf0zvG+GeoZYwAEmcoknFBE
         198MIp4rPxbuJFe4wqx9ygWwaOMycf2Drgv9GYpbtPiups+iHtNsD0Cw15nRlThjCb
         1NDva4f43n4Xiey7f+oEQUb7Mr8MZN78pFTZLb0w=
Received: by mail-io1-f42.google.com with SMTP id s17so174124iob.7
        for <selinux@vger.kernel.org>; Thu, 30 Jun 2022 12:34:59 -0700 (PDT)
X-Gm-Message-State: AJIora8Gi7I4TcTlfEQyC8pmigcS3TiwKObNXw0QPqQUGpZveNGseHtv
        jlI4Id1Y2mvZf0tat4bKty3KHcyRiki/sxm0F6s=
X-Google-Smtp-Source: AGRyM1vZTnXzIiehfR/cMrWphy4JBxwVNG6sYwjlPU3oK62kaE/qQ04TXaFlOaN5/W1HnAi3ANNaPGpM9ivbMkurBiw=
X-Received: by 2002:a05:6638:2494:b0:33c:cfb8:1e3c with SMTP id
 x20-20020a056638249400b0033ccfb81e3cmr5873664jat.139.1656617698228; Thu, 30
 Jun 2022 12:34:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220608170954.114668-1-omosnace@redhat.com> <20220608170954.114668-2-omosnace@redhat.com>
 <CAJfZ7==gbwH8-SaNxEVRU0CCnP-HaDemC7GqhK9CmkYG+p05vA@mail.gmail.com> <CAP+JOzR0oxga_drqVhDi3yCgSkeSzXmuMcgWwh3=snVb8FgCTw@mail.gmail.com>
In-Reply-To: <CAP+JOzR0oxga_drqVhDi3yCgSkeSzXmuMcgWwh3=snVb8FgCTw@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Thu, 30 Jun 2022 21:34:47 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=mPmw-z-Qi-8T4aMZHTuxgnDCx=9e3UfDLQkBWw=zEOwg@mail.gmail.com>
Message-ID: <CAJfZ7=mPmw-z-Qi-8T4aMZHTuxgnDCx=9e3UfDLQkBWw=zEOwg@mail.gmail.com>
Subject: Re: [PATCH userspace 1/2] libsemanage: always write kernel policy
 when check_ext_changes is specified
To:     James Carter <jwcart2@gmail.com>,
        SElinux list <selinux@vger.kernel.org>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Thu Jun 30 21:34:59 2022 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jun 29, 2022 at 6:55 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Tue, Jun 28, 2022 at 5:08 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> >
> > On Wed, Jun 8, 2022 at 7:23 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > >
> > > For the use case of rebuilding the policy afte package updates, we need
> > > the check_ext_changes operation to always do at least the do_write_kernel
> > > step, because the various semanage dbs may have also changed content
> > > relative to the current binary policy. As this step is itself relatively
> > > fast, we can do it unconditionally.
> > >
> > > Fixes: 286a679fadc4 ("libsemanage: optionally rebuild policy when modules are changed externally")
> > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> >
> > Hello,
> > This patch and the next one ("semodule: rename
> > --rebuild-if-modules-changed to --refresh") look good to me. Has
> > anyone also taken a look at them?
> >
> > If nobody objects, I will merge it tomorrow, with a small misspelling
> > fix in the commit message (afte -> after).
> >
>
> These look good to me as well.
> Thanks,
> Jim

Thanks. I merged both patches.
Nicolas

> > Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> >
> > Thanks,
> > Nicolas
> >
> > > ---
> > >  libsemanage/include/semanage/handle.h | 2 +-
> > >  libsemanage/src/direct_api.c          | 8 +++++---
> > >  2 files changed, 6 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/libsemanage/include/semanage/handle.h b/libsemanage/include/semanage/handle.h
> > > index 0157be4f..4cf30815 100644
> > > --- a/libsemanage/include/semanage/handle.h
> > > +++ b/libsemanage/include/semanage/handle.h
> > > @@ -67,7 +67,7 @@ extern void semanage_set_reload(semanage_handle_t * handle, int do_reload);
> > >  extern void semanage_set_rebuild(semanage_handle_t * handle, int do_rebuild);
> > >
> > >  /* set whether to rebuild the policy on commit when potential changes
> > > - * to module files since last rebuild are detected,
> > > + * to store files since last rebuild are detected,
> > >   * 1 for yes (default), 0 for no */
> > >  extern void semanage_set_check_ext_changes(semanage_handle_t * handle, int do_check);
> > >
> > > diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
> > > index 7206483a..7aa081ab 100644
> > > --- a/libsemanage/src/direct_api.c
> > > +++ b/libsemanage/src/direct_api.c
> > > @@ -1437,13 +1437,15 @@ static int semanage_direct_commit(semanage_handle_t * sh)
> > >          * Determine what else needs to be done.
> > >          * We need to write the kernel policy if we are rebuilding
> > >          * or if any other policy component that lives in the kernel
> > > -        * policy has been modified.
> > > +        * policy has been modified. We also want to force it when
> > > +        * check_ext_changes was specified as the various dbases may have
> > > +        * changes as well.
> > >          * We need to install the policy files if any of the managed files
> > >          * that live under /etc/selinux (kernel policy, seusers, file contexts)
> > >          * will be modified.
> > >          */
> > > -       do_write_kernel = do_rebuild | ports_modified | ibpkeys_modified |
> > > -               ibendports_modified |
> > > +       do_write_kernel = do_rebuild | sh->check_ext_changes |
> > > +               ports_modified | ibpkeys_modified | ibendports_modified |
> > >                 bools->dtable->is_modified(bools->dbase) |
> > >                 ifaces->dtable->is_modified(ifaces->dbase) |
> > >                 nodes->dtable->is_modified(nodes->dbase) |
> > > --
> > > 2.36.1
> > >
> >

