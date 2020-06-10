Return-Path: <SRS0=NQFP=7X=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DFACC433E0
	for <selinux@archiver.kernel.org>; Wed, 10 Jun 2020 14:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E63DD206F7
	for <selinux@archiver.kernel.org>; Wed, 10 Jun 2020 14:11:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mqSG4S+C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgFJOLS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 10 Jun 2020 10:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbgFJOLS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 10 Jun 2020 10:11:18 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203E6C03E96B
        for <selinux@vger.kernel.org>; Wed, 10 Jun 2020 07:11:18 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id x202so2139220oix.11
        for <selinux@vger.kernel.org>; Wed, 10 Jun 2020 07:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3460rZ8PGQCnJoQu4miHXCmkB9GrU12N64Y+tB69o54=;
        b=mqSG4S+C8XaM1sQLS9qdBWY85c7isBeRalJhe/WDtuzSbX/yJ+d/TM9jlt+NV84iVY
         qlqP2MgH00rjqbWAi3B7McRj4CO3rGurR3LV/8CC8VOBGvLk7rDzpUv6xm9R5wNDi2jD
         P7GyR/d2BLYC+fuz5QpQAc36PosVki21Rt3Fd7+OFdNF+Rn/hcivGglzxegekGjuosdI
         MKdi+NLKL5YZs1pRDTnS/kd+YPaAr+emqT2bQeScINjJRZu+Nk7xo/fkb3i/i444lBVs
         Yew2PkYr/iQGvpSZeDDSdQlqp7gcIx7b98Q8hY0keYF1WcLMMIHL0WqxRNs7aZ8AgPHj
         zElg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3460rZ8PGQCnJoQu4miHXCmkB9GrU12N64Y+tB69o54=;
        b=QyJNY8NjIK99dIB7FopebobijCVkF5EoSWmYlCGMaZit5V/tbOIA5xgRbK2CfgT/RR
         NFT1qRR7o4tHtWNdu31j6A0k4JHPktmjVqafNZkvO/qg7AoOXPFlg55YR91DSylT3aFP
         7Oc1IoUFpTMkXiGwEBU8jmsivjP0Ci0Q67I18C9wRKItJ8twoAUR61U+KF4eClUz3uUd
         7REfYyebaFUdPGMXcTaoLLE2NRCY9Evj5CRIwVcb4KiVLlyZISKsuLkFPygJRW873OaP
         XGrOD0f3gVRkdjAJAApgqD8M5vAi1GfbGSQdUg9DultdQ5gHttnNydH8PTdanFGi3klk
         3Tzg==
X-Gm-Message-State: AOAM530suNZPTa9HNDCg8mbbNoza4TcO41sIfTUICOERCX3fHFC5aL4W
        PRC7k0N32pCXxtZW+u7a1CGs/4TdEz4kkOHQGaM=
X-Google-Smtp-Source: ABdhPJyIPeIuY2vXtGknopB5u1pZE29IkLLTW0JyhydW7seBldrfyN1JoCWYY4ky/5UX1NeluSHkbVVx/qDquJo5sVE=
X-Received: by 2002:aca:55c1:: with SMTP id j184mr2482123oib.160.1591798277260;
 Wed, 10 Jun 2020 07:11:17 -0700 (PDT)
MIME-Version: 1.0
References: <159110207843.57260.5661475689740939480.stgit@chester>
 <CAHC9VhQacYKE4sJRbqmpudXfMyzCT8VM0SFUCi=o-MNsn4c_MA@mail.gmail.com>
 <CAEjxPJ5oGWygz87dQw1HbP2wZovc+Q7ESKSF0zBMF_cSwxRdww@mail.gmail.com>
 <CAHC9VhSsY+MtSrj17g+p3FMeaKQ-Mjjy=iXS+1TbhCKGAn_yxA@mail.gmail.com>
 <CAEjxPJ6nLAOjLvhswyLNCUO8bUuwm_h7emFp7dZXDzRjMuG2HA@mail.gmail.com> <CAEjxPJ47H1_PQ1HnJhqV4yWz_u1vvWR=Q6T999Xm92z04OimqQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ47H1_PQ1HnJhqV4yWz_u1vvWR=Q6T999Xm92z04OimqQ@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 10 Jun 2020 10:11:06 -0400
Message-ID: <CAEjxPJ6KQAc5YmrZNHU=Wr9xZ5+v6o3BYiV4+1NRzpfMhw7BJA@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: runtime disable is deprecated, add some
 ssleep() discomfort
To:     Paul Moore <paul@paul-moore.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jun 10, 2020 at 10:03 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Mon, Jun 8, 2020 at 6:13 PM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Mon, Jun 8, 2020 at 5:35 PM Paul Moore <paul@paul-moore.com> wrote:
> > >
> > > On Thu, Jun 4, 2020 at 10:49 AM Stephen Smalley
> > > <stephen.smalley.work@gmail.com> wrote:
> > > > On Tue, Jun 2, 2020 at 8:52 AM Paul Moore <paul@paul-moore.com> wrote:
> > > > > On Tue, Jun 2, 2020 at 8:47 AM Paul Moore <paul@paul-moore.com> wrote:
> > > > > >
> > > > > > We deprecated the SELinux runtime disable functionality in Linux
> > > > > > v5.6, add a five second sleep to anyone using it to help draw their
> > > > > > attention to the deprecation.
> > > > > >
> > > > > > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > > > > > ---
> > > > > >  security/selinux/selinuxfs.c |    2 ++
> > > > > >  1 file changed, 2 insertions(+)
> > > > >
> > > > > Warning: while trivial, I've done no testing beyond a quick compile
> > > > > yet.  I'm posting this now to see what everyone thinks about starting
> > > > > to make it a bit more painful to use the runtime disable
> > > > > functionality.
> > > >
> > > > I'm concerned about how users will experience and respond to this
> > > > change (and Linus too).  Currently SELinux runtime disable is the
> > > > method used by distro installers (at least Fedora/RHEL and
> > > > derivatives) when SELinux-disabled is selected at install time and it
> > > > is the approach documented in distro documentation for how to disable
> > > > SELinux.  Hence, we'd be inflicting pain on the end users for what is
> > > > essentially a distro choice.
> > >
> > > I delayed my response in hopes the Fedora folks would also comment,
> > > but I'm not seeing anything.
> > >
> > > All this patch does is start executing on the deprecation path we laid
> > > out when we marked the functionality as deprecated.  When we decided
> > > to do this we had buy-in from the Fedora folks (the only ones who
> > > still use this option);  if this is a problem for them then I would
> > > like to understand what changed, and why.  If it is a matter of this
> > > coming too quickly, that's okay, we can push this out another release
> > > or two.  We can even drop the sleep down to a second or two.  Both the
> > > timing of introducing the delay, and the length of the delay itself,
> > > aren't important to me; it's the fact that we are adding a delay and
> > > moving forward on the deprecation (just as we said we would).
> > >
> > > What were you envisioning when we marked this as deprecated Stephen?
> > > If not this, what were you thinking we would do?
> >
> > I feel like we've already communicated the fact that it is being
> > deprecated to those who need to know (Fedora maintainers), and we
> > already have it displaying an error message for those who look at
> > kernel logs.  So I was fine with just waiting some number of kernel
> > release cycles (not sure what is typical for these kinds of things)
> > and then just changing selinux_write_disable() to just return 0
> > without doing anything and dropping the selinux_disable() code and the
> > config option.  I think we'll want it to return 0 rather than an error
> > so that systemd will still unmount selinuxfs and act as if SELinux has
> > been disabled (which in turn will case everything else to act as if
> > SELinux has been disabled).  The kernel will be in permissive mode
> > with no policy loaded in that situation, so except for some corner
> > cases everything should just work.  That seems the least disruptive
> > path for end users.  Distro maintainers will hopefully get around to
> > using selinux=0 instead but that may lag.
>
> I just tested with building a kernel with
> CONFIG_SECURITY_SELINUX_DISABLE=n and setting SELINUX=disabled in
> /etc/selinux/config, and the system came up with selinuxfs unmounted,
> sestatus and friends think SELinux is disabled, but it is enabled just
> permissive with no policy.  I double checked the logic in systemd and
> libselinux (selinux_init_load_policy()) and it does handle an error
> return from writing to /sys/fs/selinux/disable gracefully.  So I guess
> we can have it return an error without breaking userspace.

Ondrej might want to check that it doesn't break RHEL either but I
wouldn't really expect this to get back-ported to RHEL anyway unless
they want the additional hardening gain from being able to make the
LSM hooks read-only after initialization.
