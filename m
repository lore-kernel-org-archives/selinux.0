Return-Path: <SRS0=Milt=CT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44AB2C43461
	for <selinux@archiver.kernel.org>; Thu, 10 Sep 2020 21:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 032C5208E4
	for <selinux@archiver.kernel.org>; Thu, 10 Sep 2020 21:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hs8veInH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725803AbgIJVij (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 10 Sep 2020 17:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730643AbgIJNbO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 10 Sep 2020 09:31:14 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED11C061573
        for <selinux@vger.kernel.org>; Thu, 10 Sep 2020 06:31:12 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id o6so5360296ota.2
        for <selinux@vger.kernel.org>; Thu, 10 Sep 2020 06:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mLNfd/U3e2McBmCQ5NrmupixXVnLzAvtnufCJQdxuQo=;
        b=hs8veInH42EJ7NaiHgKB94xXuLiQg8J/JAjtatpCppTVXO+58lH+PKws49aF7SFr9Y
         pa3IypywC39Qaw2vS5NlZWN3JtZmRyHqD0bPSmwHe9/mmt6OVNDHBTzzxJIWqqtpgowK
         LKbGRjj0Pc6YfBpELfxHOUdMIS22tGiUeSe+Nu8vNfQ4LCWLKGhzpEABuMvoj59tVrVQ
         nLtV0xHcPwF8/R57eC1KrqAY+dEzM6lw/zGR4MOYCE30hyNra971ANlUqk0W0yJaDU+c
         B0w6WahICpoQETPvMNnsO+g4nLrVaoQqDId4Mp8Hzi7Ox3Gk5kZd5MSPgK0/DHLThKij
         hPOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mLNfd/U3e2McBmCQ5NrmupixXVnLzAvtnufCJQdxuQo=;
        b=JNA7zwNep02/eS3kcLqs7mPmh6W4LapG0VMxcFUE+IggEQgG0tJVbzXK9aTywotEgN
         XZI3Z8ooYLz/ACfjKVqAoftcWVMRGvIExwhxE40oUUIIjFLwKT7gVSA8c1nvBKJ4z4ny
         U2LLyJO2BoYvq2CHEIf2GC2eKo++ft4JEKB2BLiDz59t1GJqaSS6E9U5T+9X6PB1kjkM
         hRl8guEH+hCJhq2yp+PC+cP3D/l/tyOoCAuAWF0ynU8i30nxv8pOjMsQHefB9A1x6oco
         r7av8mWr+CYL7FjfvymSQUVZVrXHX3OQXeaXqQlrTYIraOvFKq6NZ6gMOxaGvj8z50n1
         u02A==
X-Gm-Message-State: AOAM5307+7X15OHU1ipGWtrjxeLgKS/Dpwo3m6jo6aaN/TBIjk9RuVXj
        8AnCdEeqM1A27Dvqzhn4694GmAG4Ge2BWisbAD8=
X-Google-Smtp-Source: ABdhPJwt03ZlT2Kc3BbIc8thbZq0zDWAE0mMUAFWETg7Ui9KNvWmzYPhN6A2Bag4H6ITgrSEdRdrepgegCkuinLcD/Y=
X-Received: by 2002:a9d:185:: with SMTP id e5mr4057736ote.135.1599744671443;
 Thu, 10 Sep 2020 06:31:11 -0700 (PDT)
MIME-Version: 1.0
References: <159110207843.57260.5661475689740939480.stgit@chester>
 <CAHC9VhQacYKE4sJRbqmpudXfMyzCT8VM0SFUCi=o-MNsn4c_MA@mail.gmail.com>
 <CAEjxPJ5oGWygz87dQw1HbP2wZovc+Q7ESKSF0zBMF_cSwxRdww@mail.gmail.com>
 <CAHC9VhSsY+MtSrj17g+p3FMeaKQ-Mjjy=iXS+1TbhCKGAn_yxA@mail.gmail.com>
 <CAEjxPJ6nLAOjLvhswyLNCUO8bUuwm_h7emFp7dZXDzRjMuG2HA@mail.gmail.com>
 <CAEjxPJ47H1_PQ1HnJhqV4yWz_u1vvWR=Q6T999Xm92z04OimqQ@mail.gmail.com>
 <CAEjxPJ6KQAc5YmrZNHU=Wr9xZ5+v6o3BYiV4+1NRzpfMhw7BJA@mail.gmail.com>
 <CAFqZXNuWNw+e23_Lz0WN-=HODHmbSAmMQcAX87tVRGp3ZSiccA@mail.gmail.com>
 <CAHC9VhQ25U5PLYMAA1onNssWrOMYrUXhfJ_SRpzM1qNXeavfuw@mail.gmail.com>
 <20200819171459.GA57975@localhost.localdomain> <CAEjxPJ54j6PD6oBMWj7wOVskJuUY=BLpMCkdmmqwrP1DGJ0VqA@mail.gmail.com>
 <CAFqZXNuPCwvf2BNYrxxL-DqcwLQBCS9b78iQBfKDsWXOy8pvyg@mail.gmail.com>
In-Reply-To: <CAFqZXNuPCwvf2BNYrxxL-DqcwLQBCS9b78iQBfKDsWXOy8pvyg@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 10 Sep 2020 09:31:00 -0400
Message-ID: <CAEjxPJ4HMyabC+WwNwjO33SaFn9vKd1zZUR8n-wjrzN6bkHgMw@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: runtime disable is deprecated, add some
 ssleep() discomfort
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Petr Lautrbach <plautrba@redhat.com>,
        SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Sep 10, 2020 at 7:39 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Wed, Aug 19, 2020 at 9:07 PM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > On Wed, Aug 19, 2020 at 1:15 PM Petr Lautrbach <plautrba@redhat.com> wrote:
> <snip>
> > > So I've started to compose Fedora Change proposal
> > >
> > > https://fedoraproject.org/wiki/SELinux/Changes/Disable_CONFIG_SECURITY_SELINUX_DISABLE
> > >
> > > It's not complete yet, but I believe it contains basic information. I'd
> > > appreciate if you can help me with text, phrases and references so that it would
> > > be easy to sell it as security feature to Fedora community :)
> >
> > I'd simplify the Summary to be something like "Remove support for
> > SELinux runtime disable so that the LSM hooks can be hardened via
> > read-only-after-initialization protections.  Migrate users to using
> > selinux=0 if they want to disable SELinux."
>
> FYI, the change proposal has now been announced to the Fedora devel community:
> https://lists.fedoraproject.org/archives/list/devel@lists.fedoraproject.org/thread/YQIYMWKFQEWCILU7UZWXO3YFNS2PLDG4/

With regard to concerns raised in that thread:

1) For (soft?) real-time users, one option (if the latency introduced
by SELinux without a policy loaded is truly enough to affect their
workloads) would be to insert a if
(!selinux_initialized(&selinux_state)) return 0; at the beginning of
most hooks. However, we can't do that everywhere (e.g. we still need
to allocate/initialize security structures and maintain lists of
superblocks and inodes allocated before policy load so that we can
later fix up their labels during selinux_complete_init), and adding
such checks would make selinux_state.initialized an even more
attractive target for kernel exploits since it becomes another way to
"disable" SELinux entirely.  You can of course already target it to
disable policy checking but doing so tends to break certain things
like security_sid_to_context/context_to_sid on SIDs other than the
initial ones so it is not quite as attractive as enforcing currently.
This assumes that these real-time workloads are not so sensitive that
even the overhead of the indirect function call for the LSM hook
pushes them over their tolerance.

2) For cases where an error is returned by SELinux that is not already
governed by a selinux_initialized() or enforcing_enabled() check, we
just need to ensure that all such cases are gated by such a check. We
fixed that recently for the removexattr security.selinux case and
there were some earlier cases fixed with respect to setting labels
before policy load.  The specific concern raised in the thread
appeared to be due to denials silenced via dontaudit rules, which
won't happen if there is no policy loaded so I don't think that's
relevant.  There are other cases where SELinux might return an error
if a new case is introduced in another kernel subsystem without
updating SELinux to handle it, e.g. a new type for
selinux_perf_event_open(), a new obj_type in selinux_path_notify().
It would be better if we could introduce build-time guards to catch
these as we have done for e.g. new capabilities, new socket address
families, new netlink message types, in order to ensure that they are
always in sync.
