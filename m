Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88CDDC433E0
	for <selinux@archiver.kernel.org>; Thu, 18 Mar 2021 11:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FFCF64E61
	for <selinux@archiver.kernel.org>; Thu, 18 Mar 2021 11:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbhCRLWl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Mar 2021 07:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbhCRLWP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Mar 2021 07:22:15 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B7AC06174A
        for <selinux@vger.kernel.org>; Thu, 18 Mar 2021 04:22:14 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id a1so7028738ljp.2
        for <selinux@vger.kernel.org>; Thu, 18 Mar 2021 04:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n1cpzjU1ewy6u7lai4EGA3u73yz/6y3eVtVky8aaeiw=;
        b=UvwTeWAvX80ma862sq4muceuNzYa5zmpUjLue+ZYLnRf8yi20zA5VVBLtZ2n+aaJ8/
         yrT12wOmz8srsVAceeZWDw6O51CrLS39oVBgpd2nuDgC9aYpXdxVQW8b3R1fvGCGuXDh
         iXgD3GQj8mclEtRc2E1NhQRVUq51AuYnVFEv149L6BC+KOqFZM1mj9hA/1RYaBCEgbQT
         J2tjVA5hqK07Q6lFqqKDxtak7mFp75N72XYh9bxvzQUHCakyFpFwABYnCF9rxU55ZopL
         3MTZRofoiRGOdOcBATfKS7wSP0TI5Cu7yXU5qVjulE4dAq7adD34SfA9yrQkiIrZPvwl
         q+rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n1cpzjU1ewy6u7lai4EGA3u73yz/6y3eVtVky8aaeiw=;
        b=rz8wnJKM31DorGh61nLC+mETd0/9WCN7xOkUdIgJXfzX1MOghltL7heVyWkzTQ/ihT
         kemMfta/VLOwLcW2E0kVVdIFfXKHN9HD5f5H1NwDvrPdCDVdP3tapunmny5gNaQy+/qt
         OgOymMLW2B3BYrHOLl5QBk0V+7L6xnocFuoJuKWZi4ElsE9WY47LGH/fnlvZx96dL16O
         9HTffpo8/SHMtMjWLcJpwAcerZZUdfwkazx3J3APuHZHeS9UjQvlLkTzc4zxYePKlDFp
         7V8g5ABVk6vamsOVymDOePgmWLFnhQ7q2Qc9Yi8DCbbenGTue4E3IheI7i1T4l+e25yX
         Yn5g==
X-Gm-Message-State: AOAM530KJKFLmgP75yPCplatADhaFh1syTEntKdCvAmqCF8XtK2FWhnl
        pYljMG6Ptsdvl8J/i3bmTYzjhLh8JVEBw8kG5efF0l1OSOc=
X-Google-Smtp-Source: ABdhPJxI+Miawfu/8s4aiI25Q3QnKSNBYW8BbA5vmu8e5Bsb8Uz6vZDJnesgO7TbTX9+8I5v/gtivW/QfstBto67iuY=
X-Received: by 2002:a2e:8596:: with SMTP id b22mr5034328lji.482.1616066533294;
 Thu, 18 Mar 2021 04:22:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210212185930.130477-1-omosnace@redhat.com> <20210212185930.130477-3-omosnace@redhat.com>
 <20210303025730.GI6000@sequoia> <CAFqZXNtTV0PS26MYXO3urLvNYiaV9mG2kNqU9+syAnJCPhZ2jA@mail.gmail.com>
In-Reply-To: <CAFqZXNtTV0PS26MYXO3urLvNYiaV9mG2kNqU9+syAnJCPhZ2jA@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 18 Mar 2021 07:22:01 -0400
Message-ID: <CAEjxPJ43MY28wXbQrXNZSaAQ-OaLa6q4VRje61WSUXjWfmOimQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] selinux: fix variable scope issue in live sidtab conversion
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Tyler Hicks <tyhicks@linux.microsoft.com>,
        SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Mar 3, 2021 at 4:01 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Wed, Mar 3, 2021 at 3:57 AM Tyler Hicks <tyhicks@linux.microsoft.com> wrote:
> > On 2021-02-12 19:59:30, Ondrej Mosnacek wrote:
> > > Commit 02a52c5c8c3b ("selinux: move policy commit after updating
> > > selinuxfs") moved the selinux_policy_commit() call out of
> > > security_load_policy() into sel_write_load(), which caused a subtle yet
> > > rather serious bug.
> > >
> > > The problem is that security_load_policy() passes a reference to the
> > > convert_params local variable to sidtab_convert(), which stores it in
> > > the sidtab, where it may be accessed until the policy is swapped over
> > > and RCU synchronized. Before 02a52c5c8c3b, selinux_policy_commit() was
> > > called directly from security_load_policy(), so the convert_params
> > > pointer remained valid all the way until the old sidtab was destroyed,
> > > but now that's no longer the case and calls to sidtab_context_to_sid()
> > > on the old sidtab after security_load_policy() returns may cause invalid
> > > memory accesses.
> > >
> > > This can be easily triggered using the stress test from commit
> > > ee1a84fdfeed ("selinux: overhaul sidtab to fix bug and improve
> > > performance"):
> > > ```
> > > function rand_cat() {
> > >       echo $(( $RANDOM % 1024 ))
> > > }
> > >
> > > function do_work() {
> > >       while true; do
> > >               echo -n "system_u:system_r:kernel_t:s0:c$(rand_cat),c$(rand_cat)" \
> > >                       >/sys/fs/selinux/context 2>/dev/null || true
> > >       done
> > > }
> > >
> > > do_work >/dev/null &
> > > do_work >/dev/null &
> > > do_work >/dev/null &
> > >
> > > while load_policy; do echo -n .; sleep 0.1; done
> > >
> > > kill %1
> > > kill %2
> > > kill %3
> > > ```
> > >
> > > Fix this by allocating the temporary sidtab convert structures
> > > dynamically and passing them among the
> > > selinux_policy_{load,cancel,commit} functions.
> > >
> > > Note that this commit also fixes the minor issue of logging a
> > > MAC_POLICY_LOAD audit record in case sel_make_policy_nodes() fails (in
> > > which case the new policy isn't actually loaded).
> > >
> > > Fixes: 02a52c5c8c3b ("selinux: move policy commit after updating selinuxfs")
> > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> >
> > Tested-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> > Reviewed-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> >
> > Feel free to leave those tags on your v3 submission after making the two
> > small changes requested by Paul.
>
> Thanks!

I haven't seen a final version of these patches yet.  Did I miss it?
