Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F602C433DB
	for <selinux@archiver.kernel.org>; Thu, 18 Mar 2021 11:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 265C264F2A
	for <selinux@archiver.kernel.org>; Thu, 18 Mar 2021 11:46:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbhCRLpu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Mar 2021 07:45:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21120 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229939AbhCRLpa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Mar 2021 07:45:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616067929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UBfCysrQt/O1SesDVY/v9J9KrWqx5M8GujDRavRokHo=;
        b=i9flgDQJQ6MFZ6Dqw/FLTlnsKHUPSA34wYK+p0dmDclGlG1by6IrBsW45FbSQzlCdRXAfx
        TZk7m0BY1mJt3aUBUlrbv8nH1gbLhj623TMht3TV+o6vHkdnu5vXr6T1DMbHowZgu8m6h5
        SMTOJUD9B0uLHn0SEbCCphwt8RN9G94=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-hmsBIApFN6uxS2MFe6kT5Q-1; Thu, 18 Mar 2021 07:45:28 -0400
X-MC-Unique: hmsBIApFN6uxS2MFe6kT5Q-1
Received: by mail-yb1-f198.google.com with SMTP id b127so48105517ybc.13
        for <selinux@vger.kernel.org>; Thu, 18 Mar 2021 04:45:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UBfCysrQt/O1SesDVY/v9J9KrWqx5M8GujDRavRokHo=;
        b=hBd5w4a9Jyg6jQ4CoPtuRi3D/TjB0VwgS5iwWfvc8AWsk/7hAwBJ3XuWE+5CAeHYaO
         hPxWKntwyE6iJ/pRI3vpSO3x6Nc/T3X8NSCl0YDEflSm3oaODGE5T2lpF2QPEUkd1bjr
         nK07tuwmLXYKlnbnAow/SnmnTqtmQL9GcxwyxUIwiEZfbj+M468AOTE1B2npTzYDFZ5z
         YkpaGHdYhrZLCnccb3ObDpBks+SBemPqzS0dPcWvsSjAL5C5F3gdse3uIXFPIeNARp+F
         pk7G69GNue5F2/yYK9Nq15pCFZu9wViXFXHxI/tHWoMBmc4Av/r5l2p0JhNlCZtefYoD
         BBXw==
X-Gm-Message-State: AOAM530vPUILfCPHDrHGEoSH8GJ+vo4x953TEelnCN5JTwRnp/iACkYI
        yR3Azgbe2F3PjAvFuXHsv+NcssEyUhLdrNd27f1fJIxNy9LpVG9TC34FKWINiWXbpINOjrDCEcp
        GH7TE0oGGoDUUEGIxN8swOPhsyLq/iAm07Q==
X-Received: by 2002:a5b:d43:: with SMTP id f3mr3831121ybr.81.1616067927381;
        Thu, 18 Mar 2021 04:45:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwWWhC0Fu1b6XIV1b/nsazMAas4hy+U0JsLHW97FAiivi/vwCUG4ly63YWZ5M21/v7dcd5XsbGpP3ttsIISYQY=
X-Received: by 2002:a5b:d43:: with SMTP id f3mr3831096ybr.81.1616067927096;
 Thu, 18 Mar 2021 04:45:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210212185930.130477-1-omosnace@redhat.com> <20210212185930.130477-3-omosnace@redhat.com>
 <20210303025730.GI6000@sequoia> <CAFqZXNtTV0PS26MYXO3urLvNYiaV9mG2kNqU9+syAnJCPhZ2jA@mail.gmail.com>
 <CAEjxPJ43MY28wXbQrXNZSaAQ-OaLa6q4VRje61WSUXjWfmOimQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ43MY28wXbQrXNZSaAQ-OaLa6q4VRje61WSUXjWfmOimQ@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 18 Mar 2021 12:45:14 +0100
Message-ID: <CAFqZXNs9U30ydS76Gw7A2m9v6F6XdPgc2F8HmOyHfOhFt+w1JA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] selinux: fix variable scope issue in live sidtab conversion
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Tyler Hicks <tyhicks@linux.microsoft.com>,
        SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Mar 18, 2021 at 12:22 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Wed, Mar 3, 2021 at 4:01 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > On Wed, Mar 3, 2021 at 3:57 AM Tyler Hicks <tyhicks@linux.microsoft.com> wrote:
> > > On 2021-02-12 19:59:30, Ondrej Mosnacek wrote:
> > > > Commit 02a52c5c8c3b ("selinux: move policy commit after updating
> > > > selinuxfs") moved the selinux_policy_commit() call out of
> > > > security_load_policy() into sel_write_load(), which caused a subtle yet
> > > > rather serious bug.
> > > >
> > > > The problem is that security_load_policy() passes a reference to the
> > > > convert_params local variable to sidtab_convert(), which stores it in
> > > > the sidtab, where it may be accessed until the policy is swapped over
> > > > and RCU synchronized. Before 02a52c5c8c3b, selinux_policy_commit() was
> > > > called directly from security_load_policy(), so the convert_params
> > > > pointer remained valid all the way until the old sidtab was destroyed,
> > > > but now that's no longer the case and calls to sidtab_context_to_sid()
> > > > on the old sidtab after security_load_policy() returns may cause invalid
> > > > memory accesses.
> > > >
> > > > This can be easily triggered using the stress test from commit
> > > > ee1a84fdfeed ("selinux: overhaul sidtab to fix bug and improve
> > > > performance"):
> > > > ```
> > > > function rand_cat() {
> > > >       echo $(( $RANDOM % 1024 ))
> > > > }
> > > >
> > > > function do_work() {
> > > >       while true; do
> > > >               echo -n "system_u:system_r:kernel_t:s0:c$(rand_cat),c$(rand_cat)" \
> > > >                       >/sys/fs/selinux/context 2>/dev/null || true
> > > >       done
> > > > }
> > > >
> > > > do_work >/dev/null &
> > > > do_work >/dev/null &
> > > > do_work >/dev/null &
> > > >
> > > > while load_policy; do echo -n .; sleep 0.1; done
> > > >
> > > > kill %1
> > > > kill %2
> > > > kill %3
> > > > ```
> > > >
> > > > Fix this by allocating the temporary sidtab convert structures
> > > > dynamically and passing them among the
> > > > selinux_policy_{load,cancel,commit} functions.
> > > >
> > > > Note that this commit also fixes the minor issue of logging a
> > > > MAC_POLICY_LOAD audit record in case sel_make_policy_nodes() fails (in
> > > > which case the new policy isn't actually loaded).
> > > >
> > > > Fixes: 02a52c5c8c3b ("selinux: move policy commit after updating selinuxfs")
> > > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > >
> > > Tested-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> > > Reviewed-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> > >
> > > Feel free to leave those tags on your v3 submission after making the two
> > > small changes requested by Paul.
> >
> > Thanks!
>
> I haven't seen a final version of these patches yet.  Did I miss it?

No, I've been waiting for a reply regarding pr_warn() vs. pr_err(),
etc. on patch 1/2 (and then it slipped off my mind, so I didn't follow
up...)

--
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

