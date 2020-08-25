Return-Path: <SRS0=Kf9N=CD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BAD4C433DF
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 16:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27A16207F7
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 16:48:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YSWZjf71"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgHYQsp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Aug 2020 12:48:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48523 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726090AbgHYQso (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Aug 2020 12:48:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598374123;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dSmmLdkc7RSVC8EfmtZm/2Ty1INyRIvxtQ55lfyUZGw=;
        b=YSWZjf71FCSg19fajUwzjWnhh8Z9lNvhb8OK7yQ/3ZYCjYUSJUr9NB4SLvk84mFSgpY2W4
        0y/TpIPfQqq+Mv0XaWZM8cgaE67f2p9Oj1ify9+INliA85BJOFF8pv14wWDVGdafdrG8Wb
        +y1/KgBSr0evJAc4SkvIjEIbZ6CJVoI=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-5EAJakPPNci0P1lEuzigBQ-1; Tue, 25 Aug 2020 12:48:41 -0400
X-MC-Unique: 5EAJakPPNci0P1lEuzigBQ-1
Received: by mail-lj1-f197.google.com with SMTP id n11so230933ljc.16
        for <selinux@vger.kernel.org>; Tue, 25 Aug 2020 09:48:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dSmmLdkc7RSVC8EfmtZm/2Ty1INyRIvxtQ55lfyUZGw=;
        b=UMGij1GhE7AZFx1rvHRph2qvT64aCMekVLUVi9xevdZO+jG7Z5TvTHGP83cK0gw1EM
         DyoPRBMVV9Y2m8C9GWfMCzONHB4WWJ0jFM39B6Ho/XWoIPFumwSl4iWe4x+Sbt4WWPkH
         a2MeKLTup4HQdy08xbbFL2EWcEDMBXi8E6wgDe5YL4u0gxz232qfZkt//GcLsdZ3og2V
         KSN296MtUkoB7Ikf5yjl1b6e0l7PNmCmWvfShBjnWbPTzSw/lEDe1DI32v7U2WQlBhYq
         3wCg1UZSBxZOMGFQe2kQJitxJ+guVW2v7Iw0c+5MeCp0m+nGNrcRpiax1BDuTqa9Hn1v
         uqnQ==
X-Gm-Message-State: AOAM530wPUz+wJKcKPmAwAbX6hMoKhj1LOonpN/sJtYgvh38txddbgep
        mZYf6icgCh6EnjX9PAS9xwBMNJu3XKaXNd7lIQJF4fH6ZRsO2xju2zF/wthKSWZnmkNhp+PMkhp
        ZRcdiNPoWvmA1IfIqguK9fnueoEvU15IDBA==
X-Received: by 2002:a2e:8798:: with SMTP id n24mr4759267lji.217.1598374119641;
        Tue, 25 Aug 2020 09:48:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyMsrVlgwrlencGw12QSrptvlcPe/P14ZKF5kt9y0nhGDvkfTqXv7bs70IR+paKpdK/SGRrAV22j+fEJU6X5AE=
X-Received: by 2002:a2e:8798:: with SMTP id n24mr4759256lji.217.1598374119424;
 Tue, 25 Aug 2020 09:48:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200825152045.1719298-1-omosnace@redhat.com> <20200825152045.1719298-2-omosnace@redhat.com>
 <CAEjxPJ5vPX1bp6kq_H4pU1bg2=NERt1_irdzMpdJ7R_Jfb3Q4g@mail.gmail.com>
In-Reply-To: <CAEjxPJ5vPX1bp6kq_H4pU1bg2=NERt1_irdzMpdJ7R_Jfb3Q4g@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 25 Aug 2020 18:48:28 +0200
Message-ID: <CAFqZXNvfpT6th=0bgCvhFFaxX-ss3=A1gPPjaBzXeYHs=ahdLg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] selinux: simplify away security_policydb_len()
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

On Tue, Aug 25, 2020 at 6:03 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, Aug 25, 2020 at 11:20 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > Remove the security_policydb_len() calls from sel_open_policy() and
> > instead update the inode size from the size returned from
> > security_read_policy().
> >
> > Since after this change security_policydb_len() is only called from
> > security_load_policy(), remove it entirely and just open-code it there.
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
>
> > diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> > index 8381614627569..ec4570d6c38f7 100644
> > --- a/security/selinux/ss/services.c
> > +++ b/security/selinux/ss/services.c
> > @@ -3915,7 +3899,10 @@ int security_read_policy(struct selinux_state *state,
> >         if (!selinux_initialized(state))
> >                 return -EINVAL;
> >
> > -       *len = security_policydb_len(state);
> > +       rcu_read_lock();
> > +       policy = rcu_dereference(state->policy);
> > +       *len = policy->policydb.len;
> > +       rcu_read_unlock();
> >
> >         *data = vmalloc_user(*len);
> >         if (!*data)
>
> We don't actually need to take rcu_read_lock() here at all, and can
> use rcu_dereference_check(..., 1) or rcu_deference_protected() because
> the fsi->mutex is held.  We should also fix the code immediately below
> this diff context to not double dereference the policy pointer and
> just reuse the already dereferenced pointer (also not requiring
> rcu_read_lock).

OK, I'll fix this up to just fetch the pointer as you suggest (and
adapt the corresponding hunks in the other patches).

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

