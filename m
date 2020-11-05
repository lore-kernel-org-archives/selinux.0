Return-Path: <SRS0=HUo+=EL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41FE7C4741F
	for <selinux@archiver.kernel.org>; Thu,  5 Nov 2020 17:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3CDE206B6
	for <selinux@archiver.kernel.org>; Thu,  5 Nov 2020 17:29:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/7Y6KZW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgKER3B (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 5 Nov 2020 12:29:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgKER3B (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 5 Nov 2020 12:29:01 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7CB8C0613CF
        for <selinux@vger.kernel.org>; Thu,  5 Nov 2020 09:28:59 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id u127so2464529oib.6
        for <selinux@vger.kernel.org>; Thu, 05 Nov 2020 09:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hfzgt9fHPq/e7vum7rDHUb2ETbiufXa9hk9ifMRHE9w=;
        b=V/7Y6KZWoDxVrlOK3S2u0pqduOSccPo1usDL3rK2Xc2b05R20D2dEAXYq0BY0Jmvjq
         jIRfuDuasVeiuwVSwyMrhXuu2RS25m3YpWfZT3wVGdA1ITEcBhF3slJLcpKysusoXM14
         SNYVRBKTYQHvzzlFwSt3WrDQn5DSAGKGmZH7aiy8RKGLe++cMh/nfG5RpZZr4tZNeApc
         2tVAI+SmQw+4J+MGjJqhfcDu8NyWmi+FtWUAMp2SSP9A9eNTBTYT0/BZMOMl+O0wOk/n
         7zkG3TX9ucUOIAtzpOv44CdNKK5l8xqmDWlrkCcSrCmKazsKNjpDxl9wK6fF8XOtseGw
         58SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hfzgt9fHPq/e7vum7rDHUb2ETbiufXa9hk9ifMRHE9w=;
        b=hSnyvg6zk3QDvnkIMQ/CWBbh+xeGHxvIvhwDBPgqO5rKunzb1eP0vE8TWs0st2rDiH
         9PSy6b1fyuYi66Uycagd7CcAuQPyiUDPy53rHFAAofpxmnd2FhoyZ1ipBrmKkvOsbLjs
         7G+ZqRATCC4usw4MlHh8/i/yIeZIjn4QJ1IluoYJl11HdNyssdWjKsv4D7Mo3n2CvPWo
         KV4JHgwbG8w+Uu3yffHL1qLRV1kLE4Ci55MIozKJZmkQ1saTctqls5MQ00daoc7ukIMT
         D1FYz9CRYmBt60v7xgjXJo2C181JoGP778tSSu6YIxyP7BqGOkqWHu4dsjxBMFYiMWz7
         Pg0g==
X-Gm-Message-State: AOAM533j6WNq1twdrKBb+SS0YdQzSqBiBQV6v35zIn5W17dXnpGDt1Bm
        RM1B0A2VtRBXNDn30svANJFrGtmWQoPUE7gsjlrcCTIQ
X-Google-Smtp-Source: ABdhPJxoFqdyZM87FQXFojX7lspnla6eJZV2ixCsNA5JWQP4JdAcEa4go+O3b8bU0pE1C6tDclrDBhyA8kY8X7GmsW8=
X-Received: by 2002:aca:5885:: with SMTP id m127mr317387oib.5.1604597339111;
 Thu, 05 Nov 2020 09:28:59 -0800 (PST)
MIME-Version: 1.0
References: <CAFqZXNvT=G4HPiugi6vnnJMGLgv5MsumURQij0cnFjLrnXZ93Q@mail.gmail.com>
 <CAEjxPJ7cwBpLGoTmzGOUJFq5QuFCHG+xydiGYAtk2hV0d8ww3g@mail.gmail.com>
 <CAHC9VhQZGM2XW5=durZRb-gapsu+bUu_45JegmsOxcGEgThL6g@mail.gmail.com> <CAFqZXNvgQ5s50JS0_s1wEUONo2nzc2=_rufKxmWqQ=hhz8_T-A@mail.gmail.com>
In-Reply-To: <CAFqZXNvgQ5s50JS0_s1wEUONo2nzc2=_rufKxmWqQ=hhz8_T-A@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 5 Nov 2020 12:28:06 -0500
Message-ID: <CAEjxPJ6d4VN7TfJXMT-RGtZ=_rje_=27T5XhXrt9iRdvQuVCdw@mail.gmail.com>
Subject: Re: Possibly unwanted rootcontext= behavior?
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Nov 5, 2020 at 12:22 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Thu, Nov 5, 2020 at 4:31 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Thu, Nov 5, 2020 at 8:51 AM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > > On Thu, Nov 5, 2020 at 7:44 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > >
> > > > Hello everyone,
> > > >
> > > > while trying to fix the NFS rootcontext= issue, I realized that this
> > > > funny thing is possible:
> > > >
> > > > # mount -o rootcontext=system_u:object_r:lib_t:s0 -t tmpfs tmpfs /mnt
> > > > # ls -lZd /mnt
> > > > drwxrwxrwt. 2 root root system_u:object_r:lib_t:s0 40 nov  5 07:30 /mnt
> > > > # mount
> > > > [...]
> > > > tmpfs on /mnt type tmpfs
> > > > (rw,relatime,rootcontext=system_u:object_r:lib_t:s0,seclabel)
> > > > # chcon -t bin_t /mnt
> > > > # ls -lZd /mnt
> > > > drwxrwxrwt. 2 root root system_u:object_r:bin_t:s0 40 nov  5 07:30 /mnt
> > > > # mount
> > > > [...]
> > > > tmpfs on /mnt type tmpfs
> > > > (rw,relatime,rootcontext=system_u:object_r:bin_t:s0,seclabel)
> > > >
> > > > I.e. if you mount a tree with rootcontext=<oldctx> and then relabel
> > > > the root node to <newctx>, the displayed mount options will report
> > > > rootcontext=<newctx> instead of rootcontext=<oldctx>. A side effect is
> > > > that if you try to mount the same superblock again, it will only
> > > > permit you to mount with rootcontext=<newctx>, not with
> > > > rootcontext=<oldctx>.
> > > >
> > > > Is that intended, bad, or "weird, but doesn't matter" behavior?
> > >
> > > I'd say it is bad.
> > >
> > > > I have a halfway written patch to disallow altering the root node's
> > > > context when mounted with rootcontext=, but I'm not sure if that's the
> > > > right thing to do or not.
> > >
> > > Probably the better fix would be to save the original rootcontext SID
> > > as a new field of the
> > > superblock security struct and use that both when displaying the mount
> > > options and when
> > > comparing old and new mount options instead of what happens to be
> > > assigned to the root
> > > inode at the time.
> >
> > I worry that would be confusing, allowing the root inode to be
> > relabeled yet still showing the old label in the mount options.  It
> > would seem that simply blocking a root inode relabel when a
> > rootcontext is specified would be the cleanest choice, assuming
> > existing systems do not rely on this behavior.
> >
> > Ondrej, Stephen, any idea how common this is on normal systems?  My
> > gut feeling says "not very common", but that is just a guess.
>
> I don't even know what use case it's supposed to solve :) I suppose if
> you freshly format some storage drive and you want the root dir to be
> labeled immediately after mounting, rootcontext= could be useful. For
> such a use case Stephen's approach would make sense (you might still
> want to eventually relabel the root dir to something else), but there
> are some gotchas... For example, the label is initially set only in
> the inode security struct, but not written to the xattrs (I only
> looked at the code briefly, I could be wrong here), so you would still
> need to manually set the label on the root directory after mounting
> for the label to persist. And if you remount the superblock after
> changing the label, the internal label will be reset to the old one
> (which you are forced to specify in the mount options), but again not
> persistently. That's all very unintuitive.
>
> So, IMHO, good ways to fix it are either disallowing changing the
> label altogether, or making sure the label is propagated to the xattrs
> (if supported) and allowing to remount with a different rootcontext=
> option (or with no rootcontext). But that's only if I guessed the use
> case correctly.

I think the original use case was primarily tmpfs mounts, so that e.g.
one could mount a tmpfs on /dev that is immediately labeled with
device_t.

Not fundamentally opposed to preventing relabeling afterward but
always possible that could break existing userspace somewhere.
