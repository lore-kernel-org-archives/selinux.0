Return-Path: <SRS0=qOBY=OI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD086C04EB9
	for <selinux@archiver.kernel.org>; Thu, 29 Nov 2018 22:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F6922086B
	for <selinux@archiver.kernel.org>; Thu, 29 Nov 2018 22:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="lBGh1LbU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F6922086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbeK3Jai (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 30 Nov 2018 04:30:38 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36122 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbeK3Jai (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 30 Nov 2018 04:30:38 -0500
Received: by mail-lj1-f194.google.com with SMTP id g11-v6so3213903ljk.3
        for <selinux@vger.kernel.org>; Thu, 29 Nov 2018 14:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IFFFODJAUcQ7EGKBOCEI+xnM97dWa4zBAdH/PBU4lSA=;
        b=lBGh1LbUWYmZkAh0djZEdEId9vuR4wLSQkWWylcqVoccF2KJXxGvkZOeqSwilY8OA9
         apwOz2CdJ3KTtj/Zd2T85NufCNZ7nAhdlkJJHcgzM1pbaYBNLa8cORmNgl03W0rH1ay6
         w14rFlrvo/zFNJhSVBdk9BchEFzLfFdXDkrCcDeHOzZrEPd4S6IXSzfbZYRtat8rPRQ/
         uYxEKi9SI/6uw+tBHr6H8iaGpuSDI2mu4RA2SiFlTuwsaQx0g7aw3+CSjuNF7f5LBr/T
         /RUQB3m2y/CP3DiFsr0QVAK5nbZdK2sSL9Gai3h39fVgitZZRLbT4U4ix66C1NU7W+ie
         Du5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IFFFODJAUcQ7EGKBOCEI+xnM97dWa4zBAdH/PBU4lSA=;
        b=tGXwLtllrDiSEW+36Db8m5RA3hyuxZYclK3dKnkWJniLp3tj7uq9RBs01f+NrfAdrq
         /ccgwmuulG1IZEjdRbwvMXpeo9OPVfPK7rEq/hAfWhinnPF57J206iR00bYZ1ou1PrSX
         Di4gfz8EZVB5zot/8QLGg/MbtvLhBFez5Fo7BaQeVf2WmgmRasJgHuIOZo4OOoCCte7w
         c8vAEUwh+AJH5c7Vq6HbF5ryQnBLFMzkRvGNP5V7uWwH0yuDix2czcyXDiG4v6BvV/CF
         dLe0HPs8v2yDWyDWLr/UBpuxghVZ23wG4udbuf0KypeXXxCiiPn9h1w49nlDnxzEkR0Y
         NuIg==
X-Gm-Message-State: AA+aEWZqr9EyM8+UGW2b2ksVn5egwPMMLGb+S5XKGrSqZ4U/eBQxoKIx
        feMHwmxDmKRwpjHEZQRpL3E318b6v80Vfggo/Oyh
X-Google-Smtp-Source: AFSGD/Wb5cU+CCLVPlEEp6kppYwCbwh19lyhn81ke+XjEdF0gYICbmS3DMkD7Rkwp5WZ6NJ/gELQEESDvHiuRG426xw=
X-Received: by 2002:a2e:8ec8:: with SMTP id e8-v6mr2244444ljl.162.1543530215730;
 Thu, 29 Nov 2018 14:23:35 -0800 (PST)
MIME-Version: 1.0
References: <20181127115246.00967523@canb.auug.org.au> <CAFqZXNs6XTOx2-EQ5P9bK3vPsPby7rzryHPqzqsVD9XsbsG20w@mail.gmail.com>
 <20181127225013.133adc7d@canb.auug.org.au> <CAHC9VhSFSxBc+-O=GQMkiyiQz3S+_ZreicLhsoAuvR-oq2mi6g@mail.gmail.com>
 <CAFqZXNuZCof=7CtyMq8JDyAgRmONYRZhhqr6bFVy9-F70-Uwrw@mail.gmail.com>
In-Reply-To: <CAFqZXNuZCof=7CtyMq8JDyAgRmONYRZhhqr6bFVy9-F70-Uwrw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 29 Nov 2018 17:23:24 -0500
Message-ID: <CAHC9VhRthWKfgYenGq6Az+jVQ+76wCeBhBcMyo9zZwv+nBhy3A@mail.gmail.com>
Subject: Re: linux-next: manual merge of the selinux tree with the vfs tree
To:     omosnace@redhat.com
Cc:     sfr@canb.auug.org.au, viro@zeniv.linux.org.uk,
        linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
        dhowells@redhat.com, selinux@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Nov 29, 2018 at 5:07 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Wed, Nov 28, 2018 at 10:52 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Tue, Nov 27, 2018 at 6:50 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > > Hi Ondrej,
> > >
> > > On Tue, 27 Nov 2018 09:53:32 +0100 Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > >
> > > > Hm... seems that there was some massive overhaul in the VFS code right
> > > > at the wrong moment... There are new hooks for mounting now and the
> > >
> > > The mount changes have been in linux-next since before the last
> > > release ...
> > >
> > > > code that our commit changes is now here:
> > > >
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git/tree/security/selinux/hooks.c?h=for-next#n3131
> > > >
> > > > It seems that the logic is still the same, just now our patch (or the
> > > > VFS one) needs to be updated to change the above line as such
> > > > (untested pseudo-patch):
> > > >
> > > > - if (fc->purpose == FS_CONTEXT_FOR_KERNEL_MOUNT)
> > > > + if (fc->purpose == (FS_CONTEXT_FOR_KERNEL_MOUNT|FS_CONTEXT_FOR_SUBMOUNT))
> > >
> > > OK, so from tomorrow I will use that merge resolution.  Someone needs
> > > to remember to tell Linus about this when the latter of the vfs and
> > > selinux trees reach him.
> >
> > I will, or at least I'll do my best to remember; since we only have a
> > few more week until the merge window I like my odds.  FWIW, I
> > typically do a test merge on top of Linus' tree before sending the
> > SELinux PR just to verify that everything is relatively clean and
> > there are no surprises.
> >
> > Ondrej, please work with David Howells to ensure that submounts are
> > handled correctly in his mount rework.
>
> OK, I will verify that the SELinux submount fix rebased on top of
> vfs/work.mount in the way I suggested above passes the same testing
> (seliinux-testsuite + NFS crossmnt reproducer). I am now building two
> kernels (vfs/work.mount with and without the fix) to test. Let me know
> if there is anything more to do.

Thanks.

The big thing is just making sure that we don't regress on the fix in
selinux/next if/when David's mount rework hits Linus' tree.

-- 
paul moore
www.paul-moore.com
