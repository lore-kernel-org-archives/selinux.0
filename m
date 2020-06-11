Return-Path: <SRS0=nmhN=7Y=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3AEFC433E0
	for <selinux@archiver.kernel.org>; Thu, 11 Jun 2020 13:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 948F2207ED
	for <selinux@archiver.kernel.org>; Thu, 11 Jun 2020 13:29:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gh7apdvg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbgFKN3p (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 11 Jun 2020 09:29:45 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23461 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726249AbgFKN3o (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 11 Jun 2020 09:29:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591882182;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MXzJP+97iuWVSo3gUSmAQl1JcacTLpsKb5Qpq77SsEY=;
        b=Gh7apdvgnhusAq/cG+IzZvcL1+tEv1QiI0JfxAhq1zPIHI6KwTwhPVUYNFc7w4aUzPCzWu
        fS7nb53sMpoXN3k4/6n7TugVJp/aTTYcOPskTBfpVGEnh0FMZpXPjVv9G6BLAsmoOXnuPO
        V/f2LOQERRpb6u/sSzr5ytDRF7KN9p8=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-NqUyoN3uOyS_8J-LRpdt2g-1; Thu, 11 Jun 2020 09:29:40 -0400
X-MC-Unique: NqUyoN3uOyS_8J-LRpdt2g-1
Received: by mail-lj1-f199.google.com with SMTP id g24so1002156ljn.19
        for <selinux@vger.kernel.org>; Thu, 11 Jun 2020 06:29:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MXzJP+97iuWVSo3gUSmAQl1JcacTLpsKb5Qpq77SsEY=;
        b=J6d4SUQdxTnc9CU908+HewZFfEUvX80s7Pf7j5caqjO6OtgASrK/AUN+fYX8vkI8tG
         p229OubxS/uMyu3ZTpHGGpABqXXH1fVJV67/FGPaZ5mpwybm+EkN3qyjyyG/5u0hDRzG
         m7l//8GjmYbFekSiuGCtSSa7HYcPX8yHdrwH2wHhgQoc6AWxnv51sa1HKKCHLQK2QCde
         hxaImbakP8wRnOA4DdpXPsn7t9X281RaFVBLq+Dx5nyJM2seRjqk9Qxa6QcT4F98VqE2
         9/O0h2QlyuWFwMQid7NdE8CT5tgUmVOxSN0G2VqXZZkhm+2XoWePl3BTWZ1jRu1wwZlX
         wEnQ==
X-Gm-Message-State: AOAM530MpKFr9LaAV0+HYq8aFQ6Y8taz1dK2gfT1veTd3us0N0zaWthv
        Zrstnw8PURBPOAYecP/VKT3pOOzaBtW1QKkS9d62EozO7lb4W4ynj0VfYdSzBIYCQTyUCvofW/0
        CVb6EWV5117x3pzCXseR+ZCQvY8UNZfs5cg==
X-Received: by 2002:a2e:81c5:: with SMTP id s5mr4194358ljg.372.1591882178534;
        Thu, 11 Jun 2020 06:29:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJysnLHaaYr0JChUUDcJA9gr489o9/tb4QEeZbcQ0ZfnXDmD+NJNO6RuQ+YEg2CWgol2ZhgkZolfxmm/BkpGrmw=
X-Received: by 2002:a2e:81c5:: with SMTP id s5mr4194342ljg.372.1591882178176;
 Thu, 11 Jun 2020 06:29:38 -0700 (PDT)
MIME-Version: 1.0
References: <159110207843.57260.5661475689740939480.stgit@chester>
 <CAHC9VhQacYKE4sJRbqmpudXfMyzCT8VM0SFUCi=o-MNsn4c_MA@mail.gmail.com>
 <CAEjxPJ5oGWygz87dQw1HbP2wZovc+Q7ESKSF0zBMF_cSwxRdww@mail.gmail.com>
 <CAHC9VhSsY+MtSrj17g+p3FMeaKQ-Mjjy=iXS+1TbhCKGAn_yxA@mail.gmail.com>
 <CAEjxPJ6nLAOjLvhswyLNCUO8bUuwm_h7emFp7dZXDzRjMuG2HA@mail.gmail.com>
 <CAEjxPJ47H1_PQ1HnJhqV4yWz_u1vvWR=Q6T999Xm92z04OimqQ@mail.gmail.com> <CAEjxPJ6KQAc5YmrZNHU=Wr9xZ5+v6o3BYiV4+1NRzpfMhw7BJA@mail.gmail.com>
In-Reply-To: <CAEjxPJ6KQAc5YmrZNHU=Wr9xZ5+v6o3BYiV4+1NRzpfMhw7BJA@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 11 Jun 2020 15:29:27 +0200
Message-ID: <CAFqZXNuWNw+e23_Lz0WN-=HODHmbSAmMQcAX87tVRGp3ZSiccA@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: runtime disable is deprecated, add some
 ssleep() discomfort
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

(Sorry for the late reply.)

On Wed, Jun 10, 2020 at 4:11 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Wed, Jun 10, 2020 at 10:03 AM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Mon, Jun 8, 2020 at 6:13 PM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > >
> > > On Mon, Jun 8, 2020 at 5:35 PM Paul Moore <paul@paul-moore.com> wrote:
> > > >
> > > > On Thu, Jun 4, 2020 at 10:49 AM Stephen Smalley
> > > > <stephen.smalley.work@gmail.com> wrote:
> > > > > On Tue, Jun 2, 2020 at 8:52 AM Paul Moore <paul@paul-moore.com> wrote:
> > > > > > On Tue, Jun 2, 2020 at 8:47 AM Paul Moore <paul@paul-moore.com> wrote:
> > > > > > >
> > > > > > > We deprecated the SELinux runtime disable functionality in Linux
> > > > > > > v5.6, add a five second sleep to anyone using it to help draw their
> > > > > > > attention to the deprecation.
> > > > > > >
> > > > > > > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > > > > > > ---
> > > > > > >  security/selinux/selinuxfs.c |    2 ++
> > > > > > >  1 file changed, 2 insertions(+)
> > > > > >
> > > > > > Warning: while trivial, I've done no testing beyond a quick compile
> > > > > > yet.  I'm posting this now to see what everyone thinks about starting
> > > > > > to make it a bit more painful to use the runtime disable
> > > > > > functionality.
> > > > >
> > > > > I'm concerned about how users will experience and respond to this
> > > > > change (and Linus too).  Currently SELinux runtime disable is the
> > > > > method used by distro installers (at least Fedora/RHEL and
> > > > > derivatives) when SELinux-disabled is selected at install time and it
> > > > > is the approach documented in distro documentation for how to disable
> > > > > SELinux.  Hence, we'd be inflicting pain on the end users for what is
> > > > > essentially a distro choice.

Good point about the installer. I have already started working on
preparing Fedora for the runtime disable removal, but so far I'm only
at the beginning. Updating anaconda to add selinux=0 to the kernel
params instead of using /etc/selinux/config will be one of the main
steps.

> > > > I delayed my response in hopes the Fedora folks would also comment,
> > > > but I'm not seeing anything.
> > > >
> > > > All this patch does is start executing on the deprecation path we laid
> > > > out when we marked the functionality as deprecated.  When we decided
> > > > to do this we had buy-in from the Fedora folks (the only ones who
> > > > still use this option);  if this is a problem for them then I would
> > > > like to understand what changed, and why.  If it is a matter of this
> > > > coming too quickly, that's okay, we can push this out another release
> > > > or two.  We can even drop the sleep down to a second or two.  Both the
> > > > timing of introducing the delay, and the length of the delay itself,
> > > > aren't important to me; it's the fact that we are adding a delay and
> > > > moving forward on the deprecation (just as we said we would).
> > > >
> > > > What were you envisioning when we marked this as deprecated Stephen?
> > > > If not this, what were you thinking we would do?
> > >
> > > I feel like we've already communicated the fact that it is being
> > > deprecated to those who need to know (Fedora maintainers), and we
> > > already have it displaying an error message for those who look at
> > > kernel logs.  So I was fine with just waiting some number of kernel
> > > release cycles (not sure what is typical for these kinds of things)
> > > and then just changing selinux_write_disable() to just return 0
> > > without doing anything and dropping the selinux_disable() code and the
> > > config option.  I think we'll want it to return 0 rather than an error
> > > so that systemd will still unmount selinuxfs and act as if SELinux has
> > > been disabled (which in turn will case everything else to act as if
> > > SELinux has been disabled).  The kernel will be in permissive mode
> > > with no policy loaded in that situation, so except for some corner
> > > cases everything should just work.  That seems the least disruptive
> > > path for end users.  Distro maintainers will hopefully get around to
> > > using selinux=0 instead but that may lag.

I also prefer to rather go somewhere in this direction rather than
introducing the delay. I was kinda OK with the delay at first, but as
Stephen points out, it would punish users rather than distros, even
though users are (normally) not the ones that make a conscious
decision to use the runtime disable.

> > I just tested with building a kernel with
> > CONFIG_SECURITY_SELINUX_DISABLE=n and setting SELINUX=disabled in
> > /etc/selinux/config, and the system came up with selinuxfs unmounted,
> > sestatus and friends think SELinux is disabled, but it is enabled just
> > permissive with no policy.  I double checked the logic in systemd and
> > libselinux (selinux_init_load_policy()) and it does handle an error
> > return from writing to /sys/fs/selinux/disable gracefully.  So I guess
> > we can have it return an error without breaking userspace.

Yes, I was under the impression that some changes in libselinux are
needed before this works transparently, but apparently it already does
the right thing now. In that case I'd say that it may be better to
skip adding sleeps etc. and just remove the feature at some point. But
please let's wait with that for a while longer so we can prepare
Fedora for it first. It's hard to tell at this point how long that
will take, but it could be several months.

Then again, the sleep might be helpful to wake up potential non-Fedora
users (if any) and in Fedora we can always apply a revert as a
downstream patch until things are sorted. So if you guys really want
it, I think we can deal with it.

> Ondrej might want to check that it doesn't break RHEL either but I
> wouldn't really expect this to get back-ported to RHEL anyway unless
> they want the additional hardening gain from being able to make the
> LSM hooks read-only after initialization.

We definitely don't plan on backporting it to existing major RHEL
releases. However, I'd like to prepare Fedora for a life without the
runtime disable (and to disable the kernel config option as the final
step) before the next major release is branched off of Fedora, so any
future major releases will hopefully already ship with SELINUX_DISABLE
turned off/removed.

--
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

