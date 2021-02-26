Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A59FC433E0
	for <selinux@archiver.kernel.org>; Fri, 26 Feb 2021 14:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F370D64EDB
	for <selinux@archiver.kernel.org>; Fri, 26 Feb 2021 14:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbhBZOsz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 26 Feb 2021 09:48:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20877 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230141AbhBZOsv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 26 Feb 2021 09:48:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614350845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m5KKnqfIBK34P3drEk5Y4AAXctfKgO9dLx+u/5dDFy0=;
        b=Eh6P4aSRtLhXi+DSGnSuPUgSfW/8W+mrWU8MmA/hEUUJtqQE5b5A1+EEt/Ic2YGxPtX6ri
        RXG+SPeF8PMHBASwc/dFBwlsid3HHbx98sWC8t0U/nngIP0FSYoJYhRR+V41A/E9j4Pr7X
        3r6tBbSD/pXgcbR3/Or6yUNtgL16GDA=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-_nAmO6tXM9mUCWFw3I8aXQ-1; Fri, 26 Feb 2021 09:47:23 -0500
X-MC-Unique: _nAmO6tXM9mUCWFw3I8aXQ-1
Received: by mail-yb1-f197.google.com with SMTP id g17so10225458ybh.4
        for <selinux@vger.kernel.org>; Fri, 26 Feb 2021 06:47:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m5KKnqfIBK34P3drEk5Y4AAXctfKgO9dLx+u/5dDFy0=;
        b=LT/G8AeISgTjuHiEUVdsTqDIxgAeLsYcG+T12sUX/iCkAF5P9R3LBXe3gi1av857OU
         NF4aMMKSZ3PLRxDAiMtQYbVic3Krt6nlF30QT+D8pKCY7KWyP/OM943OFU5u4YMrmiHP
         DxxbS/4WPJF933sa4yql9FYN6xOJzsd+0gDnupm9o4Ub5MOgA9tqGHIqLbFCu29Q9OxB
         Buif21EqzYE1WrHfqrCi24Jy5kj7cZlNb9e/MvaRr6h61yWVpfKK+jZ/N/TSvwkjgGLY
         3bKbpUn/2UFOcowYz0XAuRvmN8nY+Q2pjm0Btaf4thtwTKGZ+7zdI4FVrGrEZkpzMTAZ
         C08w==
X-Gm-Message-State: AOAM530xNjfSfqHaIp1JUSUjDf3arko0SlOB1t1B+DvGTMCW3AVMvgx/
        rjlYoqVEGmw3CoGT02HxY0gk427Q+a8vidDbBKS8b87PSAtTtFafsWSRlDAaXfyz/3nOBbEznJ/
        tyuf0MPEnIVUKrbez0DC4WfvXhSMOmqEclQ==
X-Received: by 2002:a25:83cc:: with SMTP id v12mr4770965ybm.293.1614350842605;
        Fri, 26 Feb 2021 06:47:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzqlWtIdrAElZbl4I9Od4nZ2dRcsAQ6m2D4+2L80mXOcoiTrdVr8cdVpGjWzXQpkDJwLp2Hg1VxoJtxYbD5iac=
X-Received: by 2002:a25:83cc:: with SMTP id v12mr4770940ybm.293.1614350842404;
 Fri, 26 Feb 2021 06:47:22 -0800 (PST)
MIME-Version: 1.0
References: <20210212185930.130477-1-omosnace@redhat.com> <20210212185930.130477-3-omosnace@redhat.com>
 <CAHC9VhTfEekRYo=_-RMNHqKenkVdjBr9bA1bgm3EMXojgandZw@mail.gmail.com>
In-Reply-To: <CAHC9VhTfEekRYo=_-RMNHqKenkVdjBr9bA1bgm3EMXojgandZw@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 26 Feb 2021 15:47:11 +0100
Message-ID: <CAFqZXNtOMTOC-4=vbL5dw9YjQLb7+kFkbDxxp+bjg4mhq4vb2Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] selinux: fix variable scope issue in live sidtab conversion
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Feb 25, 2021 at 8:20 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Fri, Feb 12, 2021 at 1:59 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > Commit 02a52c5c8c3b ("selinux: move policy commit after updating
> > selinuxfs") moved the selinux_policy_commit() call out of
> > security_load_policy() into sel_write_load(), which caused a subtle yet
> > rather serious bug.
> >
> > The problem is that security_load_policy() passes a reference to the
> > convert_params local variable to sidtab_convert(), which stores it in
> > the sidtab, where it may be accessed until the policy is swapped over
> > and RCU synchronized. Before 02a52c5c8c3b, selinux_policy_commit() was
> > called directly from security_load_policy(), so the convert_params
> > pointer remained valid all the way until the old sidtab was destroyed,
> > but now that's no longer the case and calls to sidtab_context_to_sid()
> > on the old sidtab after security_load_policy() returns may cause invalid
> > memory accesses.
> >
> > This can be easily triggered using the stress test from commit
> > ee1a84fdfeed ("selinux: overhaul sidtab to fix bug and improve
> > performance"):
> > ```
> > function rand_cat() {
> >         echo $(( $RANDOM % 1024 ))
> > }
> >
> > function do_work() {
> >         while true; do
> >                 echo -n "system_u:system_r:kernel_t:s0:c$(rand_cat),c$(rand_cat)" \
> >                         >/sys/fs/selinux/context 2>/dev/null || true
> >         done
> > }
> >
> > do_work >/dev/null &
> > do_work >/dev/null &
> > do_work >/dev/null &
> >
> > while load_policy; do echo -n .; sleep 0.1; done
> >
> > kill %1
> > kill %2
> > kill %3
> > ```
> >
> > Fix this by allocating the temporary sidtab convert structures
> > dynamically and passing them among the
> > selinux_policy_{load,cancel,commit} functions.
> >
> > Note that this commit also fixes the minor issue of logging a
> > MAC_POLICY_LOAD audit record in case sel_make_policy_nodes() fails (in
> > which case the new policy isn't actually loaded).
>
> I think you forgot to remove the paragraph above :)

Oh, good point :)

>
> Other than that, and a small nit (below), this looks good to me.
>
> > Fixes: 02a52c5c8c3b ("selinux: move policy commit after updating selinuxfs")
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >  security/selinux/include/security.h | 15 ++++++---
> >  security/selinux/selinuxfs.c        | 10 +++---
> >  security/selinux/ss/services.c      | 51 +++++++++++++++++++----------
> >  3 files changed, 49 insertions(+), 27 deletions(-)
>
> ...
>
> > diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> > index 5e08ce2c5994..fada4ebc7ef8 100644
> > --- a/security/selinux/ss/services.c
> > +++ b/security/selinux/ss/services.c
> > @@ -2157,8 +2157,13 @@ static void selinux_policy_cond_free(struct selinux_policy *policy)
> >         kfree(policy);
> >  }
> >
> > +struct selinux_policy_convert_data {
> > +       struct convert_context_args args;
> > +       struct sidtab_convert_params sidtab_params;
> > +};
>
> I generally prefer structs up at the top of the source file, before
> the forward declarations please.

Ok, I'll move it to the top.

-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

