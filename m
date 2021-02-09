Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D17C433DB
	for <selinux@archiver.kernel.org>; Tue,  9 Feb 2021 02:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79F2F64E16
	for <selinux@archiver.kernel.org>; Tue,  9 Feb 2021 02:21:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhBICVK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 8 Feb 2021 21:21:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbhBICVJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 8 Feb 2021 21:21:09 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4AFC061786
        for <selinux@vger.kernel.org>; Mon,  8 Feb 2021 18:20:29 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id hs11so28974355ejc.1
        for <selinux@vger.kernel.org>; Mon, 08 Feb 2021 18:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BkmIqzugwJm9bxagdLRHe71u5jowh8EW9waE+8tSD20=;
        b=y08Uu6uvhCJ3UoU+5/5S5+K/SZq31G606TvR9z7i/ZlbAz2ua7kcW7OmljK+EVe9rA
         5DhHuhc7ajUQ9OssJbMobxuVTIwnMtdRy4ughXHk+vIvKOzTT/EJzFnUaK+JyBojaiOD
         B3C06jXapDA5f+vStAY4XXB3ga2I3rlsK/bC02DJAGTd3mQF0hggb6aOBmq0iT3RAJVZ
         ARGgkWjqYaInX761tZb1cGxye4lF5vCGTeI+uYNNSlBhjrAndAFTZtc0qbV62xLtpAuT
         awLlpkdCTqqPTNSk/oyaJ+5G8r5y8uMKIfVM+SP948GS2ZVsE0mnX+3ZnYcIscVfy0Oo
         gPDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BkmIqzugwJm9bxagdLRHe71u5jowh8EW9waE+8tSD20=;
        b=rpobOLU9Dhqv7ThAJs64kuRdGf74x/Oj4lUP1EFA9Km2SO/Wc7dHTFjtQb9eyaTRbP
         z6fQvoU5sG8CGdYxyZXTMqEPS0jZwwPglR+8NN4n10YEp6nS5nBi63bCOcOxTzrYL8oP
         CaSNvUuRSGe/IKoP+f13lyirGoFkaR7Scj8XhDm7omEO1EfdmUerHpydpLz4UjTrWpPJ
         k3SDdtKlQN+Iosl9qHRDxaeobnpO2atoS4XxIoKhh77+DvY8Z+kyWmeVV42EBk8GQJJA
         Lj92aRdpUZVD9fQ3vr9uk2qkCNT27GSvdxzWmS9VtPCdBONioZYj+yAGHHjOeMsGKeH8
         XQ0A==
X-Gm-Message-State: AOAM531X+im204GWlQrJZPerD2EhYV9tjMfQvUkZLU2X7mDVE0hSJ6no
        X0yZiezsZOoKjb/yUCySfDPhKNufzf3J0/dOLlCsYZc+eKc1
X-Google-Smtp-Source: ABdhPJwO2bhaopDJ3fYIODmyUQvVqnKlMmjygksMk1Dw91BIsh1sI41tA3Ew1P+uTPDtJVqeOUh3MziLjZOh3HgYI5I=
X-Received: by 2002:a17:906:8519:: with SMTP id i25mr20581541ejx.106.1612837227848;
 Mon, 08 Feb 2021 18:20:27 -0800 (PST)
MIME-Version: 1.0
References: <20210208112736.247195-1-omosnace@redhat.com>
In-Reply-To: <20210208112736.247195-1-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 8 Feb 2021 21:20:16 -0500
Message-ID: <CAHC9VhTN+2kTxXvu2JtDGM1mATVT6PoBWojE=-xDMz1Mer85Lg@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix variable scope issue in live sidtab conversion
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Feb 8, 2021 at 6:27 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> Commit 02a52c5c8c3b ("selinux: move policy commit after updating
> selinuxfs") moved the selinux_policy_commit() call out of
> security_load_policy() into sel_write_load(), which caused a subtle yet
> rather serious bug.
>
> The problem is that security_load_policy() passes a reference to the
> convert_params local variable to sidtab_convert(), which stores it in
> the sidtab, where it may be accessed until the policy is swapped over
> and RCU synchronized. Before 02a52c5c8c3b, selinux_policy_commit() was
> called directly from security_load_policy(), so the convert_params
> pointer remained valid all the way until the old sidtab was destroyed,
> but now that's no longer the case and calls to sidtab_context_to_sid()
> on the old sidtab after security_load_policy() returns may cause invalid
> memory accesses.
>
> This can be easily triggered using the stress test from commit
> ee1a84fdfeed ("selinux: overhaul sidtab to fix bug and improve
> performance"):
> ```
> function rand_cat() {
>         echo $(( $RANDOM % 1024 ))
> }
>
> function do_work() {
>         while true; do
>                 echo -n "system_u:system_r:kernel_t:s0:c$(rand_cat),c$(rand_cat)" \
>                         >/sys/fs/selinux/context 2>/dev/null || true
>         done
> }
>
> do_work >/dev/null &
> do_work >/dev/null &
> do_work >/dev/null &
>
> while load_policy; do echo -n .; sleep 0.1; done
>
> kill %1
> kill %2
> kill %3
> ```
>
> There are several ways to fix this:
> 1. Move the sidtab convert parameters to struct selinux_policy.
>    Pros:
>      * simple change
>    Cons:
>      * added fields not used during most of the object's lifetime
> 2. Move the sidtab convert params to sel_write_load().
>    Pros:
>      * (nothing specific)
>    Cons:
>      * layering violation, a lot of types would have to be exposed to
>        selinuxfs.c
> 3. Merge policy load functions back into one and call
>    sel_make_policy_nodes() as a callback.
>    Pros:
>      * results in simpler code
>    Cons:
>      * introduces an indirect call (not in hot path, so should be okay)
>
> I chose to implement option (3.), because IMHO it results in the least
> ugly code and has the least bad drawback.
>
> Note that this commit also fixes the minor issue of logging a
> MAC_POLICY_LOAD audit record in case sel_make_policy_nodes() fails (in
> which case the new policy isn't actually loaded).
>
> Fixes: 02a52c5c8c3b ("selinux: move policy commit after updating selinuxfs")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  security/selinux/include/security.h |  10 +-
>  security/selinux/selinuxfs.c        |  18 +---
>  security/selinux/ss/services.c      | 159 ++++++++++++----------------
>  3 files changed, 78 insertions(+), 109 deletions(-)

My concern is that this is something that should be backported to
-stable and I wonder if there is an easier way.  Since the core issue
appears to be the scope/lifetime of the stdtab->convert field, and
since the ->convert field is a struct with only three pointers, why
not either embed a copy of the sidtab_convert_params struct in the
sidtab struct (net increase in two pointers), or do a memdup() (or
similar) into the sidtab->convert in sidtab_convert().  There would
need to be some minor additional work in the latter case, but I
imagine adding a kfree() to sidtab_cancel_convert() and calling
sidtab_cancel_convert() in selinux_policy_commit() should be the bulk
of the changes.

Am I missing something, is there a good reason why it isn't that easy?

-- 
paul moore
www.paul-moore.com
