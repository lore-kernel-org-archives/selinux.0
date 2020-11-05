Return-Path: <SRS0=HUo+=EL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C88DC4741F
	for <selinux@archiver.kernel.org>; Thu,  5 Nov 2020 17:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E586F206CA
	for <selinux@archiver.kernel.org>; Thu,  5 Nov 2020 17:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oVpaDT5j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgKERhc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 5 Nov 2020 12:37:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgKERhc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 5 Nov 2020 12:37:32 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10800C0613CF
        for <selinux@vger.kernel.org>; Thu,  5 Nov 2020 09:37:32 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id m17so2514270oie.4
        for <selinux@vger.kernel.org>; Thu, 05 Nov 2020 09:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8k0oFykdv1vO74HUCrxYzpFcNZgQeMmNmibgDdutAOA=;
        b=oVpaDT5jL8RXR91dF8QmpD+kQAsKFGahvy9ZLvzLGqhgWN4TzJY766djF9ycINY730
         psUfkAxIrgSLrwKf31jn/m84WXCw/H1x8B5odmP5rQE+LqT2UjH3jBXlP3Z49+Y3PbTD
         iHBlYahTJqO6k+rXLeN48ZgWT8dHfeMe+GlDPe3NZJz9TjkrxCiym7FQK/zJE01ONvsZ
         YrB16/8HO7Ux4Qh0Of0rVdOixS3tHDsKqCyorVLoo92RQYNbcze2Cv7fbOTCHb8GgxVS
         3E+fbUOjtCrwQSwvRW0aBZ4c6519HSk8hFLIzvHANa/GcucYpWXoChlduOMTyg3FbjTE
         1GHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8k0oFykdv1vO74HUCrxYzpFcNZgQeMmNmibgDdutAOA=;
        b=asgDdf3dL4/S2Nt5syCZCQMxY+hqu40MlupO/1vc5iPT28JtxfR/2bVC8W5PGi5m6g
         2xOZW+/3/xZjTH/5q8dDmKn5P5EzF4LhoqpUswk5S+v+MmUq562V7W+4xXVxoggGNa6f
         ouwQ2mn9EmcZ4EBifEropolPg4eMnFum94DsHC18GGK9oxIhK1pwXGNYbOV76O9dw6/L
         rL/UZ3NhAbZ5hIeLnJ+gMx0kY0XoNG8CYU5NN4nHDs9mGMkzN8NueaanrXo8Ex6jMIG1
         dsBRR86RNCV9xMYSpX08gwMij9YCCspMkMvat8JOYYYajFHZzdXFsc3HPG30Q5HGXoV/
         rkPw==
X-Gm-Message-State: AOAM530XhPBHNvG1iAyT0xUJA/FjJk529optQo/z3zP9xqczQa0dj+X+
        HPLDQ8HfynzlkXltd9hNfd95VdUjISKGhu8qszQ=
X-Google-Smtp-Source: ABdhPJzAohvumXyfmQeIY0EVAhEDuNTPdpXHj+7aXAxOj3FjJm2VQN8qM+xVu20AnwJ7P6QVZqKMlLyE0jAto+pKtl0=
X-Received: by 2002:aca:5095:: with SMTP id e143mr330248oib.138.1604597851177;
 Thu, 05 Nov 2020 09:37:31 -0800 (PST)
MIME-Version: 1.0
References: <CAFqZXNvT=G4HPiugi6vnnJMGLgv5MsumURQij0cnFjLrnXZ93Q@mail.gmail.com>
 <CAEjxPJ7cwBpLGoTmzGOUJFq5QuFCHG+xydiGYAtk2hV0d8ww3g@mail.gmail.com>
 <CAHC9VhQZGM2XW5=durZRb-gapsu+bUu_45JegmsOxcGEgThL6g@mail.gmail.com>
 <CAFqZXNvgQ5s50JS0_s1wEUONo2nzc2=_rufKxmWqQ=hhz8_T-A@mail.gmail.com> <CAEjxPJ6d4VN7TfJXMT-RGtZ=_rje_=27T5XhXrt9iRdvQuVCdw@mail.gmail.com>
In-Reply-To: <CAEjxPJ6d4VN7TfJXMT-RGtZ=_rje_=27T5XhXrt9iRdvQuVCdw@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 5 Nov 2020 12:36:38 -0500
Message-ID: <CAEjxPJ7L88gxjs+A0RS-zRPrx_QDR=0ioYL5Dk0BXWiyL0dmOg@mail.gmail.com>
Subject: Re: Possibly unwanted rootcontext= behavior?
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Nov 5, 2020 at 12:28 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Nov 5, 2020 at 12:22 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > On Thu, Nov 5, 2020 at 4:31 PM Paul Moore <paul@paul-moore.com> wrote:
> > > On Thu, Nov 5, 2020 at 8:51 AM Stephen Smalley
> > > <stephen.smalley.work@gmail.com> wrote:
> > > > On Thu, Nov 5, 2020 at 7:44 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > > >
> > > > > Hello everyone,
> > > > >
> > > > > while trying to fix the NFS rootcontext= issue, I realized that this
> > > > > funny thing is possible:
> > > > >
> > > > > # mount -o rootcontext=system_u:object_r:lib_t:s0 -t tmpfs tmpfs /mnt
> > > > > # ls -lZd /mnt
> > > > > drwxrwxrwt. 2 root root system_u:object_r:lib_t:s0 40 nov  5 07:30 /mnt
> > > > > # mount
> > > > > [...]
> > > > > tmpfs on /mnt type tmpfs
> > > > > (rw,relatime,rootcontext=system_u:object_r:lib_t:s0,seclabel)
> > > > > # chcon -t bin_t /mnt
> > > > > # ls -lZd /mnt
> > > > > drwxrwxrwt. 2 root root system_u:object_r:bin_t:s0 40 nov  5 07:30 /mnt
> > > > > # mount
> > > > > [...]
> > > > > tmpfs on /mnt type tmpfs
> > > > > (rw,relatime,rootcontext=system_u:object_r:bin_t:s0,seclabel)
> > > > >
> > > > > I.e. if you mount a tree with rootcontext=<oldctx> and then relabel
> > > > > the root node to <newctx>, the displayed mount options will report
> > > > > rootcontext=<newctx> instead of rootcontext=<oldctx>. A side effect is
> > > > > that if you try to mount the same superblock again, it will only
> > > > > permit you to mount with rootcontext=<newctx>, not with
> > > > > rootcontext=<oldctx>.
> > > > >
> > > > > Is that intended, bad, or "weird, but doesn't matter" behavior?
> > > >
> > > > I'd say it is bad.
> > > >
> > > > > I have a halfway written patch to disallow altering the root node's
> > > > > context when mounted with rootcontext=, but I'm not sure if that's the
> > > > > right thing to do or not.
> > > >
> > > > Probably the better fix would be to save the original rootcontext SID
> > > > as a new field of the
> > > > superblock security struct and use that both when displaying the mount
> > > > options and when
> > > > comparing old and new mount options instead of what happens to be
> > > > assigned to the root
> > > > inode at the time.
> > >
> > > I worry that would be confusing, allowing the root inode to be
> > > relabeled yet still showing the old label in the mount options.  It
> > > would seem that simply blocking a root inode relabel when a
> > > rootcontext is specified would be the cleanest choice, assuming
> > > existing systems do not rely on this behavior.
> > >
> > > Ondrej, Stephen, any idea how common this is on normal systems?  My
> > > gut feeling says "not very common", but that is just a guess.
> >
> > I don't even know what use case it's supposed to solve :) I suppose if
> > you freshly format some storage drive and you want the root dir to be
> > labeled immediately after mounting, rootcontext= could be useful. For
> > such a use case Stephen's approach would make sense (you might still
> > want to eventually relabel the root dir to something else), but there
> > are some gotchas... For example, the label is initially set only in
> > the inode security struct, but not written to the xattrs (I only
> > looked at the code briefly, I could be wrong here), so you would still
> > need to manually set the label on the root directory after mounting
> > for the label to persist. And if you remount the superblock after
> > changing the label, the internal label will be reset to the old one
> > (which you are forced to specify in the mount options), but again not
> > persistently. That's all very unintuitive.
> >
> > So, IMHO, good ways to fix it are either disallowing changing the
> > label altogether, or making sure the label is propagated to the xattrs
> > (if supported) and allowing to remount with a different rootcontext=
> > option (or with no rootcontext). But that's only if I guessed the use
> > case correctly.
>
> I think the original use case was primarily tmpfs mounts, so that e.g.
> one could mount a tmpfs on /dev that is immediately labeled with
> device_t.
>
> Not fundamentally opposed to preventing relabeling afterward but
> always possible that could break existing userspace somewhere.

commit 0808925ea5684a0ce25483b30e94d4f398804978
Author: Eric Paris <eparis@parisplace.org>
Date:   Mon Jul 10 04:43:55 2006 -0700

    [PATCH] SELinux: add rootcontext= option to label root inode when mounting

    Introduce a new rootcontext= option to FS mounting.  This option will allow
    you to explicitly label the root inode of an FS being mounted before that
    FS or inode because visible to userspace.  This was found to be useful for
    things like stateless linux, see
    https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=190001

    Signed-off-by: Eric Paris <eparis@parisplace.org>
    Acked-by: Stephen Smalley <sds@tycho.nsa.gov>
    Signed-off-by: James Morris <jmorris@namei.org>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Linus Torvalds <torvalds@osdl.org>
