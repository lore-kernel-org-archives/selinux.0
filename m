Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DAD5C433F5
	for <selinux@archiver.kernel.org>; Mon, 11 Oct 2021 18:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 393B360E90
	for <selinux@archiver.kernel.org>; Mon, 11 Oct 2021 18:21:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbhJKSXG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 11 Oct 2021 14:23:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49831 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229565AbhJKSXG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 11 Oct 2021 14:23:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633976465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ohyIViGl1QdCfoc0LpU/AMXi6YFfnwDVF+4zmqvqVyg=;
        b=T0vfigrLyLJLfIi65TSqS/GvUJxNIktuo+xjT5PdjHmTg3hDs6Dk4HqRB2p2SxC/94L2x0
        tQKVk5bC06wm5ZoBqHEfSM8vc7SK5xUm96uPzDge0HohsyU1e5lrTftnAJYIJ064uXcncJ
        vEX2OoNU+WufrkYjPnqCcFUAf0SVX78=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-532-_9Yv4eNPN5OGO4_CXKhyVA-1; Mon, 11 Oct 2021 14:21:04 -0400
X-MC-Unique: _9Yv4eNPN5OGO4_CXKhyVA-1
Received: by mail-yb1-f200.google.com with SMTP id p8-20020a056902114800b005bad2571fbeso12770863ybu.23
        for <selinux@vger.kernel.org>; Mon, 11 Oct 2021 11:21:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ohyIViGl1QdCfoc0LpU/AMXi6YFfnwDVF+4zmqvqVyg=;
        b=3pv+JadrR8UnCZCMSdye+k0zZ3C9/o238BGwzNXaOjLR/kHzIEFE3Sk4YWxKPiK77M
         I0p3DlZzkwyE8ux8e5m/gG56nSeAMhVrOUrs/5uHRLJDQAG+/jUIj8mRbWHfcstF0vg/
         v7HAYPJsT1rhGwBsYjIMPJoPC0ZiZL20nqjhHs+5bhGU2PZttB8r1tFZ3RwHbr3I7KSo
         m2rH/ypsqdfPfbzxmdXWqKhEofyhEPqiERnJJTb1NHlgHi50NWv54VHj0lV5cDjXgrwZ
         mOFQo5RWRIOKGvdPiFmS3M5QcZtrHQ59mLF2Oks1z8cToUPE0KJyUTXff0vXBTcvTk16
         amcQ==
X-Gm-Message-State: AOAM532NsFMPUHiE8P8zQqVvSYGxGKnkJM/+AyVZV8TfNoGhFxScdMXy
        5034hasOF1LWPUg4qMLILNuPJOnTaTyEOkKiiWcnba7Gnl2wv5KJjPp9ezgO1n0+u3QP+Ukdbjs
        WJ3c9/xAzkScEosmNTYZkxUVBunM04+XLmQ==
X-Received: by 2002:a25:2e01:: with SMTP id u1mr15371696ybu.363.1633976464002;
        Mon, 11 Oct 2021 11:21:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwMqltzBWSwS35cooO86q7dmgQ4fXEyQmCNC8yxgopUWT43s9eRMelqFxm40Ko0isnyBLw3opotjhPpJyi6x+M=
X-Received: by 2002:a25:2e01:: with SMTP id u1mr15371670ybu.363.1633976463738;
 Mon, 11 Oct 2021 11:21:03 -0700 (PDT)
MIME-Version: 1.0
References: <20211011142416.26798-1-fw@strlen.de> <CAHC9VhRBYMMSucVbqUkcWTtyeuJ7SSuzDED=Cg=svWiaByo3Qw@mail.gmail.com>
In-Reply-To: <CAHC9VhRBYMMSucVbqUkcWTtyeuJ7SSuzDED=Cg=svWiaByo3Qw@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 11 Oct 2021 20:20:51 +0200
Message-ID: <CAFqZXNvHitBVyDga2CO2WAdxFwhY44xXoLkvmvVsPNGwqSe5zw@mail.gmail.com>
Subject: Re: [PATCH v2 selinux] selinux: remove unneeded ipv6 hook wrappers
To:     Paul Moore <paul@paul-moore.com>
Cc:     Florian Westphal <fw@strlen.de>,
        SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Oct 11, 2021 at 7:10 PM Paul Moore <paul@paul-moore.com> wrote:
> On Mon, Oct 11, 2021 at 10:25 AM Florian Westphal <fw@strlen.de> wrote:
> >
> > Netfilter places the protocol number the hook function is getting called
> > from in state->pf, so we can use that instead of an extra wrapper.
> >
> > Signed-off-by: Florian Westphal <fw@strlen.de>
> > ---
> >  v2: add back '#endif /* CONFIG_NETFILTER */' erronously axed in v1.
> >  Applies to 'next' branch of
> >  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git/
> >
> >  security/selinux/hooks.c | 52 ++++++++++------------------------------
> >  1 file changed, 12 insertions(+), 40 deletions(-)
>
> ...
>
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index e7ebd45ca345..831b857d5dd7 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -7470,38 +7442,38 @@ DEFINE_LSM(selinux) = {
> >
> >  static const struct nf_hook_ops selinux_nf_ops[] = {
> >         {
> > -               .hook =         selinux_ipv4_postroute,
> > +               .hook =         selinux_hook_postroute,
> >                 .pf =           NFPROTO_IPV4,
> >                 .hooknum =      NF_INET_POST_ROUTING,
> >                 .priority =     NF_IP_PRI_SELINUX_LAST,
> >         },
>
> Thanks for the patch Florian, although the name "selinux_hook_*" seems
> a bit ambiguous to me, after all we have a little more than 200
> "hooks" in the SELinux LSM implementation.  Would you be okay with
> calling the netfilter hook functions "selinux_nf_*" or something
> similar?  If you don't have time I can do the rename during the merge
> assuming we can all agree on a name.

Since selinux_ip_forward() and selinux_ip_postroute() are used only in
the hook functions, how about changing their signature and using them
as hooks directly? That would solve the naming and also remove a few
extra lines of boilerplate.

-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

