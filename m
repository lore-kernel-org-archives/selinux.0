Return-Path: <SRS0=rjXy=CC=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0215CC433DF
	for <selinux@archiver.kernel.org>; Mon, 24 Aug 2020 12:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCD7D20706
	for <selinux@archiver.kernel.org>; Mon, 24 Aug 2020 12:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WUGQ+yVo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgHXMrU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 24 Aug 2020 08:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgHXMrU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 24 Aug 2020 08:47:20 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22510C061573
        for <selinux@vger.kernel.org>; Mon, 24 Aug 2020 05:47:18 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id i11so126966otr.5
        for <selinux@vger.kernel.org>; Mon, 24 Aug 2020 05:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2AKcJIRPJAk2LUoy6fYxWc8ZYwJvJ6k81XCxfGPddQs=;
        b=WUGQ+yVoMzVL6Htz7FrxFMFjOTvKpGoLLZ6Ntfta7bNJAFc9gXaUIZ0ww6JGUkGyDu
         3e4mZAgT7jhS6NV77c8grieT0la840WPwc7P39qVZqEPj1b2p0bkmNzEj+p0BQ7KzLkz
         M0VcUYmq3KcwwxbKlM+mYI7Im5OXBooTUEm9rZyfVuOxGA7UTQ5QJKwfXqfvDlQRlbDP
         ZbdynlA6FHEWnLnOUnwMZDAVmOIbiYfrqE65lwKmQsmGavJ40DqRR+RyA3imf8HWuAt6
         lb8mVDVS8yXu3lWvXzoQpHdnWJyj0USnHjXJE9g4TsyNdAeryQu5eZXYkEZrdXdQG8iZ
         aWZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2AKcJIRPJAk2LUoy6fYxWc8ZYwJvJ6k81XCxfGPddQs=;
        b=CouszvS3d6gSjTBZ826BtQB8vpeZsED4LaXMFEZBEKWD8UEaI42eczQlW6L+Mw8ne2
         G8YwVs9Vt6D0wnKU3rXcXv6zu67aFxROEJQ6ZnkyRVCpMmEv64gjCKZ3AsopEhU09khx
         O1Tru3beQFS8287bIlg88BY+fA4Ii49wJER+cMlD9OLrv5ou9+8/8VZ9exYcxL4vrVw0
         bAb0Pkbu6OG1EkQLGFs5uL8+ad4wwM4BDWQScTmn9wne27rgnb0+SMsbZMi6giEnuuBG
         0kZCGrkxp3Gh6cG2i7gf2AtFaGmA7U1tVKdJhQk2IBhua8gzwCitB8j6MraI1ZOuKf/3
         N62g==
X-Gm-Message-State: AOAM530wU0W4/a/B3qgZx0hRIVrcWlRHVjYbMekmO9m/SWRghKghizkU
        uBrf40FJwzwtEpMiNH4gYlmKDmvb9jqaE6XxMTWzhptSU5c=
X-Google-Smtp-Source: ABdhPJzFgQVqj0mqecQ5mvp586kCWXIPsbgP1HMeQMV0MOgjZ/kpo//Oef8QXzY+OXAZ+u8ZWXyJwTN8P2Qsbo6aftc=
X-Received: by 2002:a9d:25:: with SMTP id 34mr1179321ota.135.1598273237189;
 Mon, 24 Aug 2020 05:47:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200824113015.1375857-1-omosnace@redhat.com> <20200824113015.1375857-2-omosnace@redhat.com>
In-Reply-To: <20200824113015.1375857-2-omosnace@redhat.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 24 Aug 2020 08:47:06 -0400
Message-ID: <CAEjxPJ6sTB+SCKQFg=4uMHMih1gAnCTYdcPUJ=FGMpYZwYYo5Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] selinux: fix a race condition in security_read_policy()
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Aug 24, 2020 at 7:30 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> In security_read_policy(), the policy length is computed using
> security_policydb_len(), which does a separate transaction, and then
> another transaction is done to write the policydb into a buffer of this
> length.
>
> The bug is that the policy might be re-loaded in between the two
> transactions and so the length can be wrong. In case the new length is
> lower than the old length, the length is corrected at the end of the
> function. In case the new length is higher than the old one, an error is
> returned.
>
> Since we can't call vmalloc_user() under read_lock(), fix it by checking
> if the allocated buffer is sufficiently large after doing the allocation
> and taking the read lock and if not, retry the whole operation with the
> new size.
>
> Fixes: cee74f47a6ba ("SELinux: allow userspace to read policy back out of the kernel")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  security/selinux/ss/services.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index a48fc1b337ba9..2c9072f095985 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -3849,14 +3849,22 @@ int security_read_policy(struct selinux_state *state,
>
>         *len = security_policydb_len(state);
>
> +again:
>         *data = vmalloc_user(*len);
>         if (!*data)
>                 return -ENOMEM;
>
> +       read_lock(&state->ss->policy_rwlock);
> +       if (*len < state->ss->policy->policydb.len) {
> +               *len = state->ss->policy->policydb.len;
> +               read_unlock(&state->ss->policy_rwlock);
> +               vfree(*data);
> +               goto again;
> +       }
> +
>         fp.data = *data;
>         fp.len = *len;
>
> -       read_lock(&state->ss->policy_rwlock);
>         rc = policydb_write(&state->ss->policy->policydb, &fp);
>         read_unlock(&state->ss->policy_rwlock);
>

security_read_policy() is called with fsi->mutex held by selinuxfs, so
policy reload cannot occur in between the length computation and the
writing of the policydb.  Right?  It's another case where we could
pass down the mutex as in my rcu patches for a lockdep assertion.
