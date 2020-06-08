Return-Path: <SRS0=NH41=7V=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA13C433DF
	for <selinux@archiver.kernel.org>; Mon,  8 Jun 2020 22:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E35C206D5
	for <selinux@archiver.kernel.org>; Mon,  8 Jun 2020 22:57:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MnHCdNRs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbgFHW5D (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 8 Jun 2020 18:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbgFHW5D (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 8 Jun 2020 18:57:03 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A9CC08C5C2
        for <selinux@vger.kernel.org>; Mon,  8 Jun 2020 15:57:02 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id d5so20663715ios.9
        for <selinux@vger.kernel.org>; Mon, 08 Jun 2020 15:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=98WSZBoJHTVnh4zGW8dda2uifATm5VSzz4wD7bZZ9xk=;
        b=MnHCdNRsBWNfNxt07cPHsXyGUQv7Tj62a7aSFGEV8koh/7Qlip+0kg14supZBxVlLb
         I2ORP7Z44yYUZQBbIlOlrAINDNlvINwSW2vUL1I23BK5+kPMHdQVkABMPwR+HWaNO/zE
         8jS1B6ySE7nE82ZZOGLPDAxrKyG6l8+v86TNOPsKYutzP52ZmnC8LlKEbsEP2A9LfJ6W
         kRXHJNbEFI+XAucBWFJE5GiB1DIuCm4Fd5SDq5/WWEmDQfOEQj+Q3LyNTOobnayNdfXZ
         eqmnjCnXwThMTAxl6DoRJmJaIyniVzqD3NPZ2fX/NdPQRQXZvYhsqrruCROob4CXS47o
         mBFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=98WSZBoJHTVnh4zGW8dda2uifATm5VSzz4wD7bZZ9xk=;
        b=Y8nIeqyuwxOZ6sHnuL6879tDfJyWXZgthvYnn4+L37OGCLZc43qr0XQDV9gqahlMkj
         d9cO6leE/MVL8vBTeLULt7fMFgTYYbeN+BxbYBVxd57qAVJ0hFZID7TB7NFwV4m1n2KJ
         6q96jd7SqBVyxtfOwN430pMJKj1hwPASBgabIjJYufuOUw9sG64Szn6SIJi/6FWMKY66
         PP/aSq8VUCrYNMUzGl8Bdb4ccHHt7Wn0my25oUwDRpXbOkUlXsqp0lAd7nnEuzKfAJPa
         7uiBvqf4ckFnjx+r3ri1mrUvmPP2NmueMhulhenUSTgnTu0N/nL0gVUuI0NTeo6RxCPh
         rgeA==
X-Gm-Message-State: AOAM533Klb44LoO9De0FHZI8mXUlcnIZqBKUHfD2npJzw5RhVTtDlKve
        s4A5aZRpMzJ7ALMshHDrnRWmOR0MrCx68SK+Leg=
X-Google-Smtp-Source: ABdhPJxhImsXrKH0GyBqFJrhaV9Kw1vOMGE7fBmWgLA6UdAInuVPu/GR0YVM96sdalWW5AgZTuzJ1+6GXpIl9JtBb7Q=
X-Received: by 2002:a6b:e60e:: with SMTP id g14mr24131266ioh.141.1591657022196;
 Mon, 08 Jun 2020 15:57:02 -0700 (PDT)
MIME-Version: 1.0
References: <159110207843.57260.5661475689740939480.stgit@chester>
 <CAHC9VhQacYKE4sJRbqmpudXfMyzCT8VM0SFUCi=o-MNsn4c_MA@mail.gmail.com>
 <CAEjxPJ5oGWygz87dQw1HbP2wZovc+Q7ESKSF0zBMF_cSwxRdww@mail.gmail.com>
 <CAHC9VhSsY+MtSrj17g+p3FMeaKQ-Mjjy=iXS+1TbhCKGAn_yxA@mail.gmail.com> <CAEjxPJ6nLAOjLvhswyLNCUO8bUuwm_h7emFp7dZXDzRjMuG2HA@mail.gmail.com>
In-Reply-To: <CAEjxPJ6nLAOjLvhswyLNCUO8bUuwm_h7emFp7dZXDzRjMuG2HA@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Mon, 8 Jun 2020 17:56:51 -0500
Message-ID: <CAFftDdo0ctEVW7j7UR9TJ7Bio5Zm6NiLHy=m=LeVx2+N1BGwZQ@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: runtime disable is deprecated, add some
 ssleep() discomfort
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jun 8, 2020 at 5:16 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Jun 8, 2020 at 5:35 PM Paul Moore <paul@paul-moore.com> wrote:
> >
> > On Thu, Jun 4, 2020 at 10:49 AM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > > On Tue, Jun 2, 2020 at 8:52 AM Paul Moore <paul@paul-moore.com> wrote:
> > > > On Tue, Jun 2, 2020 at 8:47 AM Paul Moore <paul@paul-moore.com> wrote:
> > > > >
> > > > > We deprecated the SELinux runtime disable functionality in Linux
> > > > > v5.6, add a five second sleep to anyone using it to help draw their
> > > > > attention to the deprecation.
> > > > >
> > > > > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > > > > ---
> > > > >  security/selinux/selinuxfs.c |    2 ++
> > > > >  1 file changed, 2 insertions(+)
> > > >
> > > > Warning: while trivial, I've done no testing beyond a quick compile
> > > > yet.  I'm posting this now to see what everyone thinks about starting
> > > > to make it a bit more painful to use the runtime disable
> > > > functionality.
> > >
> > > I'm concerned about how users will experience and respond to this
> > > change (and Linus too).  Currently SELinux runtime disable is the
> > > method used by distro installers (at least Fedora/RHEL and
> > > derivatives) when SELinux-disabled is selected at install time and it
> > > is the approach documented in distro documentation for how to disable
> > > SELinux.  Hence, we'd be inflicting pain on the end users for what is
> > > essentially a distro choice.
> >
> > I delayed my response in hopes the Fedora folks would also comment,
> > but I'm not seeing anything.
> >
> > All this patch does is start executing on the deprecation path we laid
> > out when we marked the functionality as deprecated.  When we decided
> > to do this we had buy-in from the Fedora folks (the only ones who
> > still use this option);  if this is a problem for them then I would
> > like to understand what changed, and why.  If it is a matter of this
> > coming too quickly, that's okay, we can push this out another release
> > or two.  We can even drop the sleep down to a second or two.  Both the
> > timing of introducing the delay, and the length of the delay itself,
> > aren't important to me; it's the fact that we are adding a delay and
> > moving forward on the deprecation (just as we said we would).
> >
> > What were you envisioning when we marked this as deprecated Stephen?
> > If not this, what were you thinking we would do?
>
> I feel like we've already communicated the fact that it is being
> deprecated to those who need to know (Fedora maintainers), and we
> already have it displaying an error message for those who look at
> kernel logs.  So I was fine with just waiting some number of kernel
> release cycles (not sure what is typical for these kinds of things)
> and then just changing selinux_write_disable() to just return 0
> without doing anything and dropping the selinux_disable() code and the
> config option.  I think we'll want it to return 0 rather than an error
> so that systemd will still unmount selinuxfs and act as if SELinux has
> been disabled (which in turn will case everything else to act as if
> SELinux has been disabled).  The kernel will be in permissive mode
> with no policy loaded in that situation, so except for some corner
> cases everything should just work.  That seems the least disruptive
> path for end users.  Distro maintainers will hopefully get around to
> using selinux=0 instead but that may lag.

+1. I've been following this and was going to reply with what Stephen
is saying, just less eloquently.
