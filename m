Return-Path: <SRS0=Kf9N=CD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 940E2C433E1
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 16:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F6D120782
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 16:04:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SUyNE8yq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgHYQEA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Aug 2020 12:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbgHYQDy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Aug 2020 12:03:54 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9FAFC061756;
        Tue, 25 Aug 2020 09:03:53 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id n23so1036582otq.11;
        Tue, 25 Aug 2020 09:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NrY5BOuEwv9i/y8I9V7tOuPskohUHoY8aphMXsMirGg=;
        b=SUyNE8yqNHVDU6hmseYbFHMbdJh28npASqQH8+lsX2+q8J43/la3WuU4nTWHozAyNC
         Ef3AkdJnXy6bIzyafNRhgNN5CnRQgjpzlBIKe/BxV3qovna6b8tF85TXZIlORoW5AX0t
         xbwn2L0iOCsAW3LG8P85E8ZW6G4ebfMvzRUjbLLFD7UyzYclK4mmeqWEo3xo52BDvjil
         lMKN9qzJNGjelYec9j38yxaXf/nnhwuVy95JJXvVxUtAhh28avDjYrBRmZIzqfKBAx27
         FO7pgKLOB5LZU5jgHGfZRrfs73Ym37auz/f0Bw7Osi9pnshdlQv10VwMC6MnqrFZ5nyJ
         43ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NrY5BOuEwv9i/y8I9V7tOuPskohUHoY8aphMXsMirGg=;
        b=SDxrE47eIx1+ncjDYhZc6L+9NJXWPzKygLOwxSXxZXr4dH3PGJ8tbI6kM6Zby41awM
         NRRGR7sla4gNxSHV3bS6L1dc1dUf60eDTz+uABSa1aYDfVy82g1lvernJo1o62K42oCI
         U1XiK/n+xWHz2uq87I+sewBNdNZdvf2wbGjXa9FWL0ss2MQXVwxs2VYWQyaK1CfOIURk
         FiY2dudSNFmchAvsX9bsdE0kYk7ZBCn5R2/SBHciCOGOkKVRzzKW/ypb3vMXutoUFVN9
         qS/dz/vMjKTdbKRkAtdGFEO38Rojmu+ljOQrGdpDJfyCmWPXZOHIr8RneL+I0sHd34+g
         bw0Q==
X-Gm-Message-State: AOAM532loyzI/CoIbY0fJK+0tawOJL/uz5d2OOfFoyLYCmK8GCEc/jt3
        ieK86k2IHXMZTn71dTbqJ0NZEHJ/0W0sX/m/gtdDcG4uAh4=
X-Google-Smtp-Source: ABdhPJwWdmRmDKE4N6Btm3wLta95ynS2EhPrCo70ZTrdpipMICVOnawkuwLRCWblppUQ5BBmGvXUJ0tYOFW804h5m+M=
X-Received: by 2002:a05:6830:16d8:: with SMTP id l24mr6897361otr.89.1598371433072;
 Tue, 25 Aug 2020 09:03:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200825152045.1719298-1-omosnace@redhat.com> <20200825152045.1719298-2-omosnace@redhat.com>
In-Reply-To: <20200825152045.1719298-2-omosnace@redhat.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 25 Aug 2020 12:02:26 -0400
Message-ID: <CAEjxPJ5vPX1bp6kq_H4pU1bg2=NERt1_irdzMpdJ7R_Jfb3Q4g@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] selinux: simplify away security_policydb_len()
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        rcu@vger.kernel.org, "Paul E . McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Aug 25, 2020 at 11:20 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> Remove the security_policydb_len() calls from sel_open_policy() and
> instead update the inode size from the size returned from
> security_read_policy().
>
> Since after this change security_policydb_len() is only called from
> security_load_policy(), remove it entirely and just open-code it there.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---

> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index 8381614627569..ec4570d6c38f7 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -3915,7 +3899,10 @@ int security_read_policy(struct selinux_state *state,
>         if (!selinux_initialized(state))
>                 return -EINVAL;
>
> -       *len = security_policydb_len(state);
> +       rcu_read_lock();
> +       policy = rcu_dereference(state->policy);
> +       *len = policy->policydb.len;
> +       rcu_read_unlock();
>
>         *data = vmalloc_user(*len);
>         if (!*data)

We don't actually need to take rcu_read_lock() here at all, and can
use rcu_dereference_check(..., 1) or rcu_deference_protected() because
the fsi->mutex is held.  We should also fix the code immediately below
this diff context to not double dereference the policy pointer and
just reuse the already dereferenced pointer (also not requiring
rcu_read_lock).
