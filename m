Return-Path: <SRS0=HUo+=EL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E00C55179
	for <selinux@archiver.kernel.org>; Thu,  5 Nov 2020 15:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7CA3206B2
	for <selinux@archiver.kernel.org>; Thu,  5 Nov 2020 15:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="s9lXyb0u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731204AbgKEPbh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 5 Nov 2020 10:31:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731339AbgKEPbg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 5 Nov 2020 10:31:36 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4EDC0613CF
        for <selinux@vger.kernel.org>; Thu,  5 Nov 2020 07:31:36 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id i19so3199522ejx.9
        for <selinux@vger.kernel.org>; Thu, 05 Nov 2020 07:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YM/XgjTQ8wobK+HLaTsVkorcsV/rxa0Gp3JsvZnLt0Q=;
        b=s9lXyb0u8whlCVtZNVXhzybxkCUiRjYqUMDAwaeO8oa+TcPlwKVy7wT27pwQyvDtey
         YuH6UskHoTb10dGVC5w7ziWpb2ppUcPc061urZHbfKEI7iHH2XXud9U06TX3UhD/+m+i
         sNek6C+jcE62VXaALNCVORCONHFQhJNwNagdlM6eqbfvT6mIGqikeddGcfd8RRyJkXcY
         B8Py9VzGVTQT1iCA+U0vTXLNzSEILee2n3V2+EC1oyMeyntQqw7g1Zt1Eoeneuug2a1d
         BS8Na+ZYh1eS/L31ZnIVq3e4YiCsFoqn1TzM9PY8SQbgouBZDyIFILJaRu/AZxsF9YnK
         FskA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YM/XgjTQ8wobK+HLaTsVkorcsV/rxa0Gp3JsvZnLt0Q=;
        b=LCm2V3WpEbuENsGJjdqyswTXg0I80VZ7NqEDp89TfbDgmn8ch34HnPfelFp02Yv5v6
         32SqZUXnhsk3M+nvkFupkuhMJeEzQsJpMo1MlVl5SQQDUVO13Uo3R+5JuTOhHP0MWEfs
         o9CPi/9mgOQfynaNKphiA+Lejd6tlI1WVzW/JWl/H2Qxc80T/g7+mCatdpK5echFpocv
         GtRwiWZ7P7mZJsS7GnKOPnOgfn7MoluVuXLd2J8UF24M2mZf+G2KPBas+JnPQdL5/KnV
         PzUGEkuI2xatZSPWynO2N8Ic+FM5O2ovREd2f3LSYadID0psPaG2e834TATkaD5rBKzF
         9CRA==
X-Gm-Message-State: AOAM532EmWmyjIfVGwWmkdaTnLPO+YIL4pPUWxP545RSo+IUDGhI+maq
        ER3jNIFj6L9/GxGNprbBwfxCwbAYo/3lcDHyuHsbJw1kYw==
X-Google-Smtp-Source: ABdhPJwNRw/BOSSv1acMK1GOKRBuKEKmuy2njowUvFbjCN8eVaIJOpXaw4nfqLw/w4FtyNxu132uVi0agfbkdtbfOIM=
X-Received: by 2002:a17:906:3b81:: with SMTP id u1mr2793195ejf.542.1604590294835;
 Thu, 05 Nov 2020 07:31:34 -0800 (PST)
MIME-Version: 1.0
References: <CAFqZXNvT=G4HPiugi6vnnJMGLgv5MsumURQij0cnFjLrnXZ93Q@mail.gmail.com>
 <CAEjxPJ7cwBpLGoTmzGOUJFq5QuFCHG+xydiGYAtk2hV0d8ww3g@mail.gmail.com>
In-Reply-To: <CAEjxPJ7cwBpLGoTmzGOUJFq5QuFCHG+xydiGYAtk2hV0d8ww3g@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 5 Nov 2020 10:31:23 -0500
Message-ID: <CAHC9VhQZGM2XW5=durZRb-gapsu+bUu_45JegmsOxcGEgThL6g@mail.gmail.com>
Subject: Re: Possibly unwanted rootcontext= behavior?
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Nov 5, 2020 at 8:51 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Thu, Nov 5, 2020 at 7:44 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > Hello everyone,
> >
> > while trying to fix the NFS rootcontext= issue, I realized that this
> > funny thing is possible:
> >
> > # mount -o rootcontext=system_u:object_r:lib_t:s0 -t tmpfs tmpfs /mnt
> > # ls -lZd /mnt
> > drwxrwxrwt. 2 root root system_u:object_r:lib_t:s0 40 nov  5 07:30 /mnt
> > # mount
> > [...]
> > tmpfs on /mnt type tmpfs
> > (rw,relatime,rootcontext=system_u:object_r:lib_t:s0,seclabel)
> > # chcon -t bin_t /mnt
> > # ls -lZd /mnt
> > drwxrwxrwt. 2 root root system_u:object_r:bin_t:s0 40 nov  5 07:30 /mnt
> > # mount
> > [...]
> > tmpfs on /mnt type tmpfs
> > (rw,relatime,rootcontext=system_u:object_r:bin_t:s0,seclabel)
> >
> > I.e. if you mount a tree with rootcontext=<oldctx> and then relabel
> > the root node to <newctx>, the displayed mount options will report
> > rootcontext=<newctx> instead of rootcontext=<oldctx>. A side effect is
> > that if you try to mount the same superblock again, it will only
> > permit you to mount with rootcontext=<newctx>, not with
> > rootcontext=<oldctx>.
> >
> > Is that intended, bad, or "weird, but doesn't matter" behavior?
>
> I'd say it is bad.
>
> > I have a halfway written patch to disallow altering the root node's
> > context when mounted with rootcontext=, but I'm not sure if that's the
> > right thing to do or not.
>
> Probably the better fix would be to save the original rootcontext SID
> as a new field of the
> superblock security struct and use that both when displaying the mount
> options and when
> comparing old and new mount options instead of what happens to be
> assigned to the root
> inode at the time.

I worry that would be confusing, allowing the root inode to be
relabeled yet still showing the old label in the mount options.  It
would seem that simply blocking a root inode relabel when a
rootcontext is specified would be the cleanest choice, assuming
existing systems do not rely on this behavior.

Ondrej, Stephen, any idea how common this is on normal systems?  My
gut feeling says "not very common", but that is just a guess.

-- 
paul moore
www.paul-moore.com
