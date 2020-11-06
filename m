Return-Path: <SRS0=8IdP=EM=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03FB9C2D0A3
	for <selinux@archiver.kernel.org>; Fri,  6 Nov 2020 04:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92883206F7
	for <selinux@archiver.kernel.org>; Fri,  6 Nov 2020 04:13:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="qYd+pyRg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725925AbgKFENK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 5 Nov 2020 23:13:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgKFENK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 5 Nov 2020 23:13:10 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C112DC0613CF
        for <selinux@vger.kernel.org>; Thu,  5 Nov 2020 20:13:09 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id w13so11754eju.13
        for <selinux@vger.kernel.org>; Thu, 05 Nov 2020 20:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H6+Mj5/s0x+9jvur9pI/fslwnvDF8FHVTNb+rCQYGGc=;
        b=qYd+pyRgWjeeoUCLfOggoxpppYDmQ4tTL3lZ+fq0qkh9buakTDpzeUMwkuYUZciVjC
         gH7hVqxFJH1c/d7Yek40XbRBfY9tw2VOeU6IqU/VFKQLUT+BrjSkRgyLJLLIlebSQyiF
         KLT8DvStVVrZj8miksEKEY3gOcdX6ji6IzwMRpGbXo8Smp8yvKQcNi8xC4TbtR1/BF/e
         kmamG56cK+8DLKpomqKfhP5nrDAAgER2cB2/TU7FVOUKN9/5cUXYly5q4+z2Uxe3xkLN
         GswxA6Yv4XSc71pBNUca2YgtAGH4d9NMDKEGdtNgXnvq4lrAXydw3U3iUVRz3nqTNTqc
         uVUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H6+Mj5/s0x+9jvur9pI/fslwnvDF8FHVTNb+rCQYGGc=;
        b=uOcShOw0DHDbSZ0IeALf+Ab3tBXApU6M5cYR9fjSTkzFC73TXKrGpdp4SiLUn1ck2d
         9g47YJx5vFTgdrTcvgljmidpR5rAZZw5glSstwE8sdCORI+ombur5GF0KMyCwMM6nZ4/
         OJHdW+GSdvU4BNSC59X4YvGRmeWy4yXQ3NbpZClGvvfHxEQ7K3I3X3uDPxFCA2ObYeNQ
         DNmtAbBsUKCa2U0jHhLfWWorWNMmft3Yte2w+wvewDQnifGiDMZ7Tjuk8KniCL8x2pZ8
         1JWQMgrh+cMNGR3nkrv5FdKuVMD2lRK10E3WBAwPEP2FJUY8SDvko18KtGc161Ca3Tmq
         zJ5g==
X-Gm-Message-State: AOAM530M25IZtugJaNH0fVuiTbZdGu+bwRBgTPpDEOmIKvAABXcoctbX
        ylzIRRVFaaKhgBQQDJ1MnUcnUorDMUrj5DE7qP5/n3CwNA==
X-Google-Smtp-Source: ABdhPJwsHJXT2rDk+AZspAvUH9kDsCd7scjc/X+7KAf9CP4i5niPHEwFqI4yq+4uEA3uEFO+iZEW37jcyCjY7sKhsRY=
X-Received: by 2002:a17:906:cb0f:: with SMTP id lk15mr135043ejb.431.1604635988347;
 Thu, 05 Nov 2020 20:13:08 -0800 (PST)
MIME-Version: 1.0
References: <CAFqZXNvT=G4HPiugi6vnnJMGLgv5MsumURQij0cnFjLrnXZ93Q@mail.gmail.com>
 <CAEjxPJ7cwBpLGoTmzGOUJFq5QuFCHG+xydiGYAtk2hV0d8ww3g@mail.gmail.com>
 <CAHC9VhQZGM2XW5=durZRb-gapsu+bUu_45JegmsOxcGEgThL6g@mail.gmail.com>
 <CAFqZXNvgQ5s50JS0_s1wEUONo2nzc2=_rufKxmWqQ=hhz8_T-A@mail.gmail.com> <CAEjxPJ6d4VN7TfJXMT-RGtZ=_rje_=27T5XhXrt9iRdvQuVCdw@mail.gmail.com>
In-Reply-To: <CAEjxPJ6d4VN7TfJXMT-RGtZ=_rje_=27T5XhXrt9iRdvQuVCdw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 5 Nov 2020 23:12:56 -0500
Message-ID: <CAHC9VhTwA8MS5_smPux07bbr0vNj1iWrm0Ywm=7M8TEU3k9j3A@mail.gmail.com>
Subject: Re: Possibly unwanted rootcontext= behavior?
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Nov 5, 2020 at 12:28 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Thu, Nov 5, 2020 at 12:22 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
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

I'd be curious to see what sort of breakage, if any, we might see if
we blocked the relabel when rootcontext is in use.  Ondrej, any chance
you can finish that patch enough to do some basic testing?

-- 
paul moore
www.paul-moore.com
