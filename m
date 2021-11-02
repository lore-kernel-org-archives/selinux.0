Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74504C433EF
	for <selinux@archiver.kernel.org>; Tue,  2 Nov 2021 15:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5832760F90
	for <selinux@archiver.kernel.org>; Tue,  2 Nov 2021 15:38:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234625AbhKBPky (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 2 Nov 2021 11:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234598AbhKBPkw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 2 Nov 2021 11:40:52 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B22C0613B9
        for <selinux@vger.kernel.org>; Tue,  2 Nov 2021 08:38:17 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id u9so38683804uac.8
        for <selinux@vger.kernel.org>; Tue, 02 Nov 2021 08:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hvn6IK84CbRQLtjc7l/5dJ9gRPuu8dy76RLolQ2t/AM=;
        b=qeOes2SFm05r0+Umjia2PAG8jdD4k4XAmhZPdxsEBv9der0W90mE02ru69zop8Nrqa
         hVO/svx+EkayJnWXzRND3cJG6t3JfdWfGyThkj1RnWXoPj2dbSb+sneRNvceNByd3NDP
         kSusTZQN6PPsTKrF2jcjaZ9uvDqtArXDiE9UU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hvn6IK84CbRQLtjc7l/5dJ9gRPuu8dy76RLolQ2t/AM=;
        b=faubQqRbPUVyp8jEwhwXt9Tk6SxT4phq/uXblksrZox9L00kb+4vhlDbX0G94XA3G8
         LmPcU+rkKX7liq2R515/1MOTHsaYUYMe1aV1BU2A2bbe87cvPfMYPIN2RKUePHvQ+izg
         XT5LvdqbeQ+N4jhZiaNbClgE56iiy44rfeAGITU/U4Ae6soZzY7m1DoCqbLMtbmUE4QZ
         mFr9qK2rv5esNghwIotFu7NRp0izw0Jl69IFn1ZZQTrAaD2DWydP9uUE/wScdfZ1hYDz
         XgxqsDFJ07Y0rk59FBESKckIywuK9ZytuAnFXhKuIGpa+X0rvN8Bq2cB0vSFIi+/iyjt
         +tfg==
X-Gm-Message-State: AOAM530yyMstvao7CMi04sltEzA3ZmkC0aoMb5v8aa/KFkGRH114OYsS
        amLOQTjwUytqXbiyDad40qPQ+O1QYHPoPWrhdeoAUA==
X-Google-Smtp-Source: ABdhPJwM/sOX+XAdvh0VyZxUiRR1OPTmhW0nDkSkNWKVTVw3TJBX/WlGnO99RdqCf3FE2JYyOVFneg09Vrz/bI4rMWg=
X-Received: by 2002:ab0:3d07:: with SMTP id f7mr17766292uax.11.1635867496900;
 Tue, 02 Nov 2021 08:38:16 -0700 (PDT)
MIME-Version: 1.0
References: <20211012180624.447474-1-vgoyal@redhat.com> <20211012180624.447474-3-vgoyal@redhat.com>
 <CAJfpegs-EHBjjnsVQdPWfH=idVENj9Aw0e-L4tjcgx3v38NJtg@mail.gmail.com> <YYFZl3egeX88G3FQ@redhat.com>
In-Reply-To: <YYFZl3egeX88G3FQ@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 2 Nov 2021 16:38:06 +0100
Message-ID: <CAJfpeguMLE1rgpuP7gWWNcip6R+cgp-BdDfdQGtV=TouOVEn4A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] fuse: Send security context of inode on file creation
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org,
        SElinux list <selinux@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>,
        virtio-fs-list <virtio-fs@redhat.com>,
        Chirantan Ekbote <chirantan@chromium.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Ondrej Mosnacek <omosnace@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, 2 Nov 2021 at 16:30, Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Tue, Nov 02, 2021 at 03:00:30PM +0100, Miklos Szeredi wrote:
> > On Tue, 12 Oct 2021 at 20:06, Vivek Goyal <vgoyal@redhat.com> wrote:

> > > @@ -633,7 +713,29 @@ static int create_new_entry(struct fuse_mount *fm, struct fuse_args *args,
> > >         args->out_numargs = 1;
> > >         args->out_args[0].size = sizeof(outarg);
> > >         args->out_args[0].value = &outarg;
> > > +
> > > +       if (init_security) {
> >
>
> Hi Miklos,
>
> > Instead of a new arg to create_new_entry(), this could check
> > args.opcode != FUSE_LINK.
>
> Will do.
>
> >
> > > +               unsigned short idx = args->in_numargs;
> > > +
> > > +               if ((size_t)idx >= ARRAY_SIZE(args->in_args)) {
> > > +                       err = -ENOMEM;
> > > +                       goto out_put_forget_req;
> > > +               }
> > > +
> > > +               err = get_security_context(entry, mode, &security_ctx,
> > > +                                          &security_ctxlen);
> > > +               if (err)
> > > +                       goto out_put_forget_req;
> > > +
> > > +               if (security_ctxlen > 0) {
> >
> > This doesn't seem right.  How would the server know if this is arg is missing?
> >
> > I think if FUSE_SECURITY_CTX was negotiated, then the secctx header
> > will always need to be added to the MK* requests.
>
> Even for the case of FUSE_LINK request? I think I put this check because
> FUSE_LINK is not sending secctx header. Other requests are appending
> this header even if a security module is not loaded/enabled.

No, FUSE_LINK wouldn't even get this far.

> I guess it makes more sense to add secctx header even for FUSE_LINK
> request. Just that header will mention 0 security contexts are
> following. This will interface more uniform. I will make this change.

Why? FUSE_LINK is not an inode creation op, it just shares the
instantiation part with creation.

Thanks,
Miklos
