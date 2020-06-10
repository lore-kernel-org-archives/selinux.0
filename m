Return-Path: <SRS0=NQFP=7X=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16753C433DF
	for <selinux@archiver.kernel.org>; Wed, 10 Jun 2020 14:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3A152078C
	for <selinux@archiver.kernel.org>; Wed, 10 Jun 2020 14:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NXEi1n3r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgFJODk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 10 Jun 2020 10:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgFJODj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 10 Jun 2020 10:03:39 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A32C03E96B
        for <selinux@vger.kernel.org>; Wed, 10 Jun 2020 07:03:40 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id n70so1779496ota.5
        for <selinux@vger.kernel.org>; Wed, 10 Jun 2020 07:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8ZYHjB9JDdP7ww1t68j+iEjFIUMUgLx1qLDW/jVb264=;
        b=NXEi1n3raRJxhdu1euFY+LIAcdjPYlTB6Lau3mcrDoFe3HcJ1FppEPjwql8MHpnoid
         AyFoz67RW+Fsl5DlFwulnfhwNZPn1XG2ZQQJUwMkb35pSdKM34GsX7L6pf+S3YGcqduU
         hX3x8+0Msx+a2x3mm98tk3MenIDiF0c/WZQsIHr4yFyL9NOcNC0ZvqY8WaAHGi7c8zMk
         wZzd8zAvnXcaagv2IockDXdLENg9adOvtsTXV6wTnpPNvJtP7PyDr6r+CT4lLi37eoQ7
         r10CNpxRfr+aML6tc9R8W+zb8BfTDfrJoZ0i/8SRkwZjIo5nKPKvxVAaI2zTXD9MqaFT
         m7KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8ZYHjB9JDdP7ww1t68j+iEjFIUMUgLx1qLDW/jVb264=;
        b=OXLELjLfiuj9ujEhxNYXzcbOn6zW4wndZu/VUoa3U1tRuzCafSbKsnWibhNDa3+iTa
         O7KwSSmY5fbcLwe5JgSQ8JieRohI4dS4z3aTFklav3oRT/QJVbb15kBxWJEUBsJcAT/h
         7WS+DskCQm4vxZAjiVL2XwYdTUBM3oGZzMDRkUynhc5/iDg8dmFhN+yWwth1efnUjSZg
         5u/FedSdDhfa8+mhJT04hCM/wWFLU/ER5lr2kc3mm02Who7nwBbEpfuULbcV0yLQCQp6
         wzfwKNh+SfwWWa0/2EcK6YtuTVAt5C8krbnx43hPlQV9xsVB4H9wrt5mOyVrXP2PpGf/
         1DQA==
X-Gm-Message-State: AOAM530/hVr7lYFHkJ3yb/rLlX2KGyX9GlLmcYG4PyiXdQmd4+XgKB6Q
        xUufJrEOud9gYGcMKZEpb/JJP7HRDsRukr3pvSk=
X-Google-Smtp-Source: ABdhPJxSUNwVwCQkh/T2OTxM3yVi9rZLJ1kSBB4rEBaON7q1gFoN7uEKlsYqKkwDeABqkgPxyKi3QRUQwDrcPir1edg=
X-Received: by 2002:a05:6830:1d8c:: with SMTP id y12mr2807108oti.162.1591797819345;
 Wed, 10 Jun 2020 07:03:39 -0700 (PDT)
MIME-Version: 1.0
References: <159110207843.57260.5661475689740939480.stgit@chester>
 <CAHC9VhQacYKE4sJRbqmpudXfMyzCT8VM0SFUCi=o-MNsn4c_MA@mail.gmail.com>
 <CAEjxPJ5oGWygz87dQw1HbP2wZovc+Q7ESKSF0zBMF_cSwxRdww@mail.gmail.com>
 <CAHC9VhSsY+MtSrj17g+p3FMeaKQ-Mjjy=iXS+1TbhCKGAn_yxA@mail.gmail.com> <CAEjxPJ6nLAOjLvhswyLNCUO8bUuwm_h7emFp7dZXDzRjMuG2HA@mail.gmail.com>
In-Reply-To: <CAEjxPJ6nLAOjLvhswyLNCUO8bUuwm_h7emFp7dZXDzRjMuG2HA@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 10 Jun 2020 10:03:28 -0400
Message-ID: <CAEjxPJ47H1_PQ1HnJhqV4yWz_u1vvWR=Q6T999Xm92z04OimqQ@mail.gmail.com>
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

On Mon, Jun 8, 2020 at 6:13 PM Stephen Smalley
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

I just tested with building a kernel with
CONFIG_SECURITY_SELINUX_DISABLE=n and setting SELINUX=disabled in
/etc/selinux/config, and the system came up with selinuxfs unmounted,
sestatus and friends think SELinux is disabled, but it is enabled just
permissive with no policy.  I double checked the logic in systemd and
libselinux (selinux_init_load_policy()) and it does handle an error
return from writing to /sys/fs/selinux/disable gracefully.  So I guess
we can have it return an error without breaking userspace.
