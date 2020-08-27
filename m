Return-Path: <SRS0=ySGb=CF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 853F8C433E3
	for <selinux@archiver.kernel.org>; Thu, 27 Aug 2020 14:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CE572054F
	for <selinux@archiver.kernel.org>; Thu, 27 Aug 2020 14:50:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="gHp9D4t6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbgH0Oto (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 27 Aug 2020 10:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727924AbgH0N5S (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 27 Aug 2020 09:57:18 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F0AC06123D
        for <selinux@vger.kernel.org>; Thu, 27 Aug 2020 06:56:51 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id c8so4997176edn.8
        for <selinux@vger.kernel.org>; Thu, 27 Aug 2020 06:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RKsZojbbyOfxkDp1UPneiBMH0M5ZxO9l2JOGUdoyREk=;
        b=gHp9D4t6rfFAnedxJG6Q0FF2Fwpv9zjxc60+rltarjPAOhEsCrtUAh8f8/mwocBGkf
         6z0Vt2UOXiJAGGZGesBFzhYTrya8ufn/esXON6ka4oRw/JNaeOIvkpxPIKt+KxNCtA2u
         7IOUFam3oIyXAaa9MhceT5WQK4P14RRNK0o+dUrfK9Y8bnMJ/rqbO6y+/FnptLpCexei
         KXbLiSN3vQSahExdiUw4H2uRGAoAn0ArrVrkEjHjGTfeHakZso3mqLjpK+1G90vFMvw+
         I4fAU/AQ+X0/P/FEIg5oBNTK5vuNEA0ibwS9SeimmLDnB94fGjG7xYWSmfqk148p8a9m
         sDwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RKsZojbbyOfxkDp1UPneiBMH0M5ZxO9l2JOGUdoyREk=;
        b=Xa3Fow/vTAb/6DhLrcCy1As1J9UdI3yvODdAsIchgmLuWS96Bv4TI2hln+m2aqbs/j
         P/1dC8JMXMDj3LMUc9Fxu6D9+brgq2dWRhwefAcHNHQo947QgBKdmilUcalNEv6/1xy0
         V5NUZmKVf/HoToKq+lm1lpv0u1RI5oFhnNQWIe63YLcQS7eRv3PCnNbrUbiVhah6I+uu
         lUTty1lzt5pLpOSNYC98tSL4TC7462rbDxRF2cgzGMcyXFy8YaMJG0KoEu/0gMExMl7l
         PGsWNPQmlSHUx1S0M7C/9VqtjEUgB56qyL9u5II1778bmYuWcze6K3XZDDQQyKeW2Okt
         F0NQ==
X-Gm-Message-State: AOAM533DOG1jdv7LUjbIfDH+dnQ09kKfREMSUEuvcMGTyP4dvg2CKrfJ
        e5h0Z1dIwJQaFizEHCE2npaY3xBaqExtgImDLgko
X-Google-Smtp-Source: ABdhPJxvIst3uW+7bP4YtOHQff4e0LokVWGDkqTd5XSV0XF50JTNGNlV2a6sbs0Uji6xWZ4WljwhIrx0nuY6eqa4bcE=
X-Received: by 2002:aa7:ca46:: with SMTP id j6mr17773546edt.128.1598536610236;
 Thu, 27 Aug 2020 06:56:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200826135906.1912186-1-omosnace@redhat.com> <20200826135906.1912186-2-omosnace@redhat.com>
 <CAEjxPJ4LL022dtKyqs+YB-gKVuJqRNQu0dafjgzZLqStqn-zSA@mail.gmail.com>
In-Reply-To: <CAEjxPJ4LL022dtKyqs+YB-gKVuJqRNQu0dafjgzZLqStqn-zSA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 27 Aug 2020 09:56:38 -0400
Message-ID: <CAHC9VhTOTuscseVrLEj17y2ULG9rWjLrxT+PorakT8EGk4dhTA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] selinux: simplify away security_policydb_len()
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Aug 26, 2020 at 10:05 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, Aug 26, 2020 at 9:59 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > Remove the security_policydb_len() calls from sel_open_policy() and
> > instead update the inode size from the size returned from
> > security_read_policy().
> >
> > Since after this change security_policydb_len() is only called from
> > security_load_policy(), remove it entirely and just open-code it there.
> >
> > Also, since security_load_policy() is always called with fsi->mutex
> > held, make it dereference the policy pointer directly and drop the
> > unnecessary RCU locking.
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
>
> One comment below but nonetheless:
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> > diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> > index 8381614627569..7cc2f7486c18f 100644
> > --- a/security/selinux/ss/services.c
> > +++ b/security/selinux/ss/services.c
> > @@ -3912,11 +3896,17 @@ int security_read_policy(struct selinux_state *state,
> >         int rc;
> >         struct policy_file fp;
> >
> > -       if (!selinux_initialized(state))
> > +       /*
> > +        * NOTE: We do not need to take the rcu read lock
> > +        * around the code below because other policy-modifying
> > +        * operations are already excluded by selinuxfs via
> > +        * fsi->mutex.
> > +        */
> > +       policy = rcu_dereference_check(state->policy, 1);
> > +       if (!policy)
> >                 return -EINVAL;
>
> If/when my patch to move the mutex to selinux_state and use it in
> rcu_dereference_protected() lands, we'll want to change this one over
> too.

FWIW, I felt the mutex move was more significant than this patchset so
I merged it first.  Ondrej, would you mind rebasing this patch and
making the changes above?

Thanks.

-- 
paul moore
www.paul-moore.com
