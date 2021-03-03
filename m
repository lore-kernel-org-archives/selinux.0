Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEEE8C43603
	for <selinux@archiver.kernel.org>; Thu,  4 Mar 2021 00:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CAAC64EC0
	for <selinux@archiver.kernel.org>; Thu,  4 Mar 2021 00:24:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348688AbhCDAYX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:24:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20557 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233845AbhCCMJY (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 3 Mar 2021 07:09:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614773221;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eyIW06nT3yilJ526fdZOU9nZRboHXJufS7daPvz3Jfw=;
        b=gl95vtqOp/WsCk7MTdun5rr5LirVnaItmP8AA7iIY8eWLEwtbrDSg1nhutmPJG1XC6tUsk
        KaveyBjI9N8WcA+a/S5Eh5AeAdJx+nIFxBjIejePWNVai6F05tzgAVHchYXUo1DfeRXv5I
        RS6kD73b1aX0QlfQ4bb4z8L6Xv2cXEU=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-UzXgZ51ZPMiD--HqioW_tQ-1; Wed, 03 Mar 2021 04:01:16 -0500
X-MC-Unique: UzXgZ51ZPMiD--HqioW_tQ-1
Received: by mail-yb1-f197.google.com with SMTP id 127so25841881ybc.19
        for <selinux@vger.kernel.org>; Wed, 03 Mar 2021 01:01:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eyIW06nT3yilJ526fdZOU9nZRboHXJufS7daPvz3Jfw=;
        b=g150e2nqmwaNjMx2ZNWTuEcd1c8QBfjlIwauBLbjHKHykJW4HEKHZ/Kndr8GGgxDqd
         MeE47BeC440HLw20EgwkC1LHt/rl4S+/rs6k/uSbx09Z2HpYSTvPSFXAum2qFbs7mG9p
         LxUmcKnbDFnjGbTJa4Qy7e8RxmugDHpHIVaOUXh7BfbdmhNgSXm0YcQArTwSnpf74RE2
         F8GmAKQZ2JRhF6zYIn6M/3MBdNZ9Kel4OOMRVHsV3USPlCiLcuHQj7/QZh9om9nT3Vuo
         /3DO6i5yM7zB37vuEIgfBUnjdD/ySLPKpUyXzAzdjd3QpGR9Rv/UpvUdFtzwAa0TyEGr
         AqUw==
X-Gm-Message-State: AOAM532Ue2gi3S6u04R3Re6hTvu/93tYvbUHvbuo0wtItYrRdH33wDfV
        AFQw10i1tgvCrFUjBwcJmisqdSWxE8G9BAzy3V1aKeugWPughyyKTY+QDXxqzcKf0Ft8Fyoflpy
        XRnyVWyJ3ohLj7N7fI+uZWP0h+Ftjw9I/xg==
X-Received: by 2002:a5b:4a:: with SMTP id e10mr38444893ybp.436.1614762075624;
        Wed, 03 Mar 2021 01:01:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxuuFAGLAUtfw7Thad/LbKLM9ZKxxE5CtoR6ZquE4kowzhZknOV3WHQOOS2XEFfhGoTYR0gXEOE/Sf3LQo+XWk=
X-Received: by 2002:a5b:4a:: with SMTP id e10mr38444871ybp.436.1614762075454;
 Wed, 03 Mar 2021 01:01:15 -0800 (PST)
MIME-Version: 1.0
References: <20210212185930.130477-1-omosnace@redhat.com> <20210212185930.130477-3-omosnace@redhat.com>
 <20210303025730.GI6000@sequoia>
In-Reply-To: <20210303025730.GI6000@sequoia>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 3 Mar 2021 10:01:03 +0100
Message-ID: <CAFqZXNtTV0PS26MYXO3urLvNYiaV9mG2kNqU9+syAnJCPhZ2jA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] selinux: fix variable scope issue in live sidtab conversion
To:     Tyler Hicks <tyhicks@linux.microsoft.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Mar 3, 2021 at 3:57 AM Tyler Hicks <tyhicks@linux.microsoft.com> wrote:
> On 2021-02-12 19:59:30, Ondrej Mosnacek wrote:
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
> >       echo $(( $RANDOM % 1024 ))
> > }
> >
> > function do_work() {
> >       while true; do
> >               echo -n "system_u:system_r:kernel_t:s0:c$(rand_cat),c$(rand_cat)" \
> >                       >/sys/fs/selinux/context 2>/dev/null || true
> >       done
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
> >
> > Fixes: 02a52c5c8c3b ("selinux: move policy commit after updating selinuxfs")
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
>
> Tested-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> Reviewed-by: Tyler Hicks <tyhicks@linux.microsoft.com>
>
> Feel free to leave those tags on your v3 submission after making the two
> small changes requested by Paul.

Thanks!

-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

