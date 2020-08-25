Return-Path: <SRS0=Kf9N=CD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D359BC433DF
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 17:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B74BC20706
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 17:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iorw+Q2E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgHYRVR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Aug 2020 13:21:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44117 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726119AbgHYRVK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Aug 2020 13:21:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598376068;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KxD7IxUp1X3Xkrm/hgADWFiOoNeg3viNvay8AmcqOCE=;
        b=iorw+Q2EEqZZqa4bjT5k0/iUdoLmRUo/3sPiDgYho8O3QInuBulnpjkSAQtDvG+P+rOAXD
        4oTA3cLp87CDfaIqknSdqjIq9yZDJ4KU9PGt+Y3oCOf1NX5yyvR5lzyBt30HqxJ88El1HZ
        m0mEhKt2tnRAQCLgXn+Jj9ZOrujOi84=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-o43qUd9ZMBCuZdQ-7tRiRg-1; Tue, 25 Aug 2020 13:21:06 -0400
X-MC-Unique: o43qUd9ZMBCuZdQ-7tRiRg-1
Received: by mail-lf1-f72.google.com with SMTP id p12so1716527lfk.21
        for <selinux@vger.kernel.org>; Tue, 25 Aug 2020 10:21:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KxD7IxUp1X3Xkrm/hgADWFiOoNeg3viNvay8AmcqOCE=;
        b=mvH617dwB8V7Bjwo3smfmFNJpwFAnVEy06CJ5g1EX3aBjnhDV9SrWnyk1cjkkkIEPJ
         NcGXw5aUYdQZ15s94/rQRkyEOqhK0ZHTE2x2B0d0IudFvY2SoSS+fveHOPKcxr9qIegh
         W/w3O+vtPKnuH1zeT783+nXa6IZk0GxoZQ7/edjmMb+bpz+IZLh4QzTk0Y1RIrjYPNSK
         M0JJxeCQfs8p+T742Hph6pCDh5/be9u62Rd45QfHPfcj43CD7TFPGKN/Vk+xsPtXiO3R
         2njx7cG0MEtANHU5jeVbveF/tTloFVi5bWbcnhVvrLHIZL4h1LO80ZUEye+z67IP85HA
         rRgg==
X-Gm-Message-State: AOAM5301dOXBdDO0OIPNwV7CBDmAWgXQwkcEoXstIXh4A9OCqBHXT3Xz
        c1HaUOGYZGvoLSJCVeIh8O4avcXC+5GYdp7Y4mJ3HvpdhWmNbqe71G5zGOFpzc1LzC9dXg3B3po
        0m4qeTixXGTnFQsJQik3DYU1YzuSI4flExw==
X-Received: by 2002:a05:651c:217:: with SMTP id y23mr5092978ljn.123.1598376064729;
        Tue, 25 Aug 2020 10:21:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzWbndphIDnuCUBz7OoPBUXMnneOsMof6eVfG09lVKfMhU0U1FDx7L52k+O+mOnyYRYkGdaUME/ZTziDS2UoK0=
X-Received: by 2002:a05:651c:217:: with SMTP id y23mr5092968ljn.123.1598376064496;
 Tue, 25 Aug 2020 10:21:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200825152045.1719298-1-omosnace@redhat.com> <20200825152045.1719298-3-omosnace@redhat.com>
 <CAEjxPJ4UYV5OqtumoN9tK5wAQbOjuP0tUKW6dTPgftWxbY+R-w@mail.gmail.com>
In-Reply-To: <CAEjxPJ4UYV5OqtumoN9tK5wAQbOjuP0tUKW6dTPgftWxbY+R-w@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 25 Aug 2020 19:20:53 +0200
Message-ID: <CAFqZXNtLn_Tw_t1bnzYJ+cH_Kw8CUjs7kBdHKbMTp5WYBw7Fmw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] selinux: remove the 'initialized' flag from selinux_state
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        rcu@vger.kernel.org, "Paul E . McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Aug 25, 2020 at 6:07 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Tue, Aug 25, 2020 at 11:20 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > After the RCU conversion, it is possible to simply check the policy
> > pointer against NULL instead.
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
>
> > diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> > index ec4570d6c38f7..d863b23f2a670 100644
> > --- a/security/selinux/ss/services.c
> > +++ b/security/selinux/ss/services.c
> > @@ -2221,20 +2218,19 @@ void selinux_policy_commit(struct selinux_state *state,
> >         /* Load the policycaps from the new policy */
> >         security_load_policycaps(state, newpolicy);
> >
> > -       if (!selinux_initialized(state)) {
> > +       if (!oldpolicy) {
> >                 /*
> >                  * After first policy load, the security server is
> >                  * marked as initialized and ready to handle requests and
> >                  * any objects created prior to policy load are then labeled.
> >                  */
> > -               selinux_mark_initialized(state);
> >                 selinux_complete_init();
>
> This isn't quite equivalent. The difference is whether
> security_load_policycaps() has completed.  Not sure of the
> implications but could yield different behavior.

Good point... And you just reminded me of my plan to eliminate the
selinux_state::policycap[] array and replace it with calls to
security_policycap_supported(). That should have no more race
conditions than the current code at least... I'll try to splice such a
patch below this one for the next revision. Or is there some
compelling reason to keep the array?

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

