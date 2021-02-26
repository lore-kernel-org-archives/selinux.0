Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB51C433DB
	for <selinux@archiver.kernel.org>; Fri, 26 Feb 2021 14:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E03B64E20
	for <selinux@archiver.kernel.org>; Fri, 26 Feb 2021 14:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbhBZOrs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 26 Feb 2021 09:47:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53395 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229554AbhBZOrs (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 26 Feb 2021 09:47:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614350781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X2s711Vnia0MJxDnuGcc03MEmMLLST5GdwAOKqb2c9E=;
        b=hjHuyc/YzwWmqX8xsRXYGCkP/v6lt0G+HqYvr39ix1fJPMWwLse0stKCwoPF+sKQW6RaAP
        dCe+1c9Clps5drpQSAuhaH1F/R31Xt8ybhkatM9AFyuXdsJB9k8lC55Ks6msZDKh8wHx3v
        5hDFkC0DfRHhWw+F610rOhAy7VdqSW4=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-wHFdlazdN6qWXuQRGYn0ig-1; Fri, 26 Feb 2021 09:46:18 -0500
X-MC-Unique: wHFdlazdN6qWXuQRGYn0ig-1
Received: by mail-yb1-f197.google.com with SMTP id p136so10217901ybc.21
        for <selinux@vger.kernel.org>; Fri, 26 Feb 2021 06:46:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X2s711Vnia0MJxDnuGcc03MEmMLLST5GdwAOKqb2c9E=;
        b=KEgyTSEpyEkkvBRvcrsVIkArPTzwae+6uYhrjTFD4BUxNewlXZyM22t61llhJS339H
         /bGR51evkGKjCk3+Lm1mtsIn6zyL/nOcASF6ZfbKDYTdInPfDS2gpr3w6ViNmPp1glv8
         qe0CtJk6hY27b809VvDlubXZ9e9PVEFCJiEAtgF3tJmKJsoJ0JwBISreRq7sIqP9SV4X
         XxLWrYMFGt/gSvpY8nQJUD71hhlE/JX6mfTGd0SH2SmxP4yg1PvFHnFkLtBkrHcjdU+r
         mzzcjDUpmsO3gm6evGPj4JlLeNmChrwThVkix72yHaIp8uhf8SNkYtMrpWjmY5yGcOIY
         OwPQ==
X-Gm-Message-State: AOAM532GxAnb1lzlXCg3dMO55Pc5HQhuriULOfSTIm9Llh21CGaO2s72
        jQGVQXLyLkKbB1ajJaMVHYrgM8kD+33zqQ/utp/+ZIfLjTZcVTDSQD1SV39Etat5hdymxMpDCGe
        QwCr/yXO6n06gXoRhimpt+Uq/kCnlqHkEOg==
X-Received: by 2002:a25:d4d0:: with SMTP id m199mr4992234ybf.26.1614350777280;
        Fri, 26 Feb 2021 06:46:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxSD2Q7nE3eRWVNZ4cnLBx92ZR/4kuk58draSvPeDHxYNOUdz5lkuJjaRVG3hkGCkkmuHEbuI5NwBRe9qrZHgA=
X-Received: by 2002:a25:d4d0:: with SMTP id m199mr4992204ybf.26.1614350777025;
 Fri, 26 Feb 2021 06:46:17 -0800 (PST)
MIME-Version: 1.0
References: <20210212185930.130477-1-omosnace@redhat.com> <20210212185930.130477-2-omosnace@redhat.com>
 <CAHC9VhQLJKjY0KSC+=f4b=8d8n-m29j_9J5r_VQ_1BpSY8WD2w@mail.gmail.com>
In-Reply-To: <CAHC9VhQLJKjY0KSC+=f4b=8d8n-m29j_9J5r_VQ_1BpSY8WD2w@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 26 Feb 2021 15:46:06 +0100
Message-ID: <CAFqZXNuBYwAT2-vLaTM8_Zng=vh+XsY_EvnzPYM4Z=PoCydZ+A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] selinux: don't log MAC_POLICY_LOAD record on
 failed policy load
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Feb 25, 2021 at 7:15 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Fri, Feb 12, 2021 at 1:59 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > If sel_make_policy_nodes() fails, we should jump to 'out', not 'out1',
> > as the latter would incorrectly log an MAC_POLICY_LOAD audit record,
> > even though the policy hasn't actually been reloaded. The 'out1' jump
> > label now becomes unused and can be removed.
> >
> > Fixes: 02a52c5c8c3b ("selinux: move policy commit after updating selinuxfs")
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >  security/selinux/selinuxfs.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> > index 01a7d50ed39b..340711e3dc9a 100644
> > --- a/security/selinux/selinuxfs.c
> > +++ b/security/selinux/selinuxfs.c
> > @@ -651,14 +651,13 @@ static ssize_t sel_write_load(struct file *file, const char __user *buf,
> >         length = sel_make_policy_nodes(fsi, newpolicy);
> >         if (length) {
> >                 selinux_policy_cancel(fsi->state, newpolicy);
> > -               goto out1;
> > +               goto out;
>
> This looks good, especially with AUDIT_MAC_POLICY_LOAD recording
> "res=1".  However, now that I'm looking at the error path here, we
> don't display anything if sel_make_policy_nodes() fails, do we?  If
> security_load_policy fails we at least do a printk(), but if this
> fails it silently kills the policy load; at the very least I think we
> want a `pr_warn_ratelimited("SELinux: failed to load policy due to
> selinuxfs failures")` or something similar.

There are error messages in some error paths in
sel_make_policy_nodes(), but not all. Those are pr_err()s, while in
sel_write_load() there is a pr_warn_ratelimited(). Could we just unify
the sel_make_policy_nodes() failure to a single message? (I don't
think the information on which part has failed is very useful as the
most likely cause here is a memory allocation failure, not bad
policy.) If so, should it be a pr_warn() or pr_err()? Ratelimited or
not?

>
> >         }
> >
> >         selinux_policy_commit(fsi->state, newpolicy);
> >
> >         length = count;
> >
> > -out1:
> >         audit_log(audit_context(), GFP_KERNEL, AUDIT_MAC_POLICY_LOAD,
> >                 "auid=%u ses=%u lsm=selinux res=1",
> >                 from_kuid(&init_user_ns, audit_get_loginuid(current)),
> > --
> > 2.29.2
>
> --
> paul moore
> www.paul-moore.com
>

-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

