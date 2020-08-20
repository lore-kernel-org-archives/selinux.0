Return-Path: <SRS0=r9sn=B6=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 853BAC433E1
	for <selinux@archiver.kernel.org>; Thu, 20 Aug 2020 14:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AD7920738
	for <selinux@archiver.kernel.org>; Thu, 20 Aug 2020 14:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gbnY3zh9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbgHTO1p (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 20 Aug 2020 10:27:45 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60981 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728146AbgHTO1l (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 20 Aug 2020 10:27:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597933659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bN0gIaNi3+HwB/3FFrhvqONscGbrWTXNALBK/nUecb0=;
        b=gbnY3zh9YxRxJNS3TJU89K4TY4uJimc1qukiWNu+AVDY0Kah9MHZCup2sZ4gDSRMe4vVWD
        uX8QuR+AvL4xr74fwHNx4fCFOsOpE27puvbNnvpxSGNDQ3uDuqVMyI2uljRWKsULbi1m9R
        DTT3NTY2a3qNMARdfYDZGfKypufnFaY=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-u32Bdr2EMEOIDGxNcgbKeQ-1; Thu, 20 Aug 2020 10:27:38 -0400
X-MC-Unique: u32Bdr2EMEOIDGxNcgbKeQ-1
Received: by mail-lj1-f197.google.com with SMTP id g5so408453ljn.8
        for <selinux@vger.kernel.org>; Thu, 20 Aug 2020 07:27:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bN0gIaNi3+HwB/3FFrhvqONscGbrWTXNALBK/nUecb0=;
        b=ejvbMlg/wK7eSRAseO0fqx1BSSsrL7DxpPWisIDOAggPj9u7nQECxn02HDwI1Y4Oxn
         yeY/LoweJC9LMfKrVQLJ2ZF0QV4Q/oLGQ8SLEVUC0faMprba/gIklf4AjbJivUc/nMyT
         q34knI0OPreT4Vvjdsp8oQP9jbw+SKADNz53XOsUEu8KdCv+I/rXguKkLOwQwdG5s9wW
         oMqmgVmOicvzBmmI+U/IGL82qIRuNRIChs8+lO+VdKIz0hYxOagwYr4YqYdSqQG4fZad
         XVpAGVcY04puKxnJBtcXqn20E10qGlmEk67WAWNwt3/Y4Lc1F2qSOQ+mRuCyx+ib+Rmb
         Nbhw==
X-Gm-Message-State: AOAM531/6L344DdRYpF+KX0zDLf0hTFG6H/t5B7jjDnP1tCxY1rlEkcm
        nPRgBd+oJObJn+b25zxxW2HsaKPPlhHmR0OyABG4CA/F8IBCWiwpENqNS4zDj4ETf9fd/z+J5lG
        +a6ru8Gn/b1HD/h407UISasQb/bIbmmAN6g==
X-Received: by 2002:a05:651c:217:: with SMTP id y23mr1684995ljn.123.1597933656320;
        Thu, 20 Aug 2020 07:27:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyWy+532KHbrEIpPhzv3b43FzWfhwiG1qELtCnyi+qvdPtN6Kx7Dh1kqjwLAmRxkoedKjIrOtKlxBgwn5EPFhI=
X-Received: by 2002:a05:651c:217:: with SMTP id y23mr1684988ljn.123.1597933656021;
 Thu, 20 Aug 2020 07:27:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200819194516.50746-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20200819194516.50746-1-stephen.smalley.work@gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 20 Aug 2020 16:27:25 +0200
Message-ID: <CAFqZXNs0xG+FgGW3DamHWw+smzHpz_9g86VvhTwa9rM5W=C49w@mail.gmail.com>
Subject: Re: [RFC PATCH v4] selinux: convert policy read-write lock to RCU
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        SElinux list <selinux@vger.kernel.org>,
        peter enderborg <peter.enderborg@sony.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Aug 19, 2020 at 9:45 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> Convert the policy read-write lock to RCU.  This is significantly
> simplified by the earlier work to encapsulate the policy data
> structures and refactor the policy load and boolean setting logic.
> Move the latest_granting sequence number into the selinux_policy
> structure so that it can be updated atomically with the policy.
> Since removing the policy rwlock and moving latest_granting reduces
> the selinux_ss structure to nothing more than a wrapper around the
> selinux_policy pointer, get rid of the extra layer of indirection.
>
> At present this change merely passes a hardcoded 1 to
> rcu_dereference_check() in the cases where we know we do not need to
> take rcu_read_lock(), with the preceding comment explaining why.
> Alternatively we could pass fsi->mutex down from selinuxfs and
> apply a lockdep check on it instead.
>
> Based in part on earlier attempts to convert the policy rwlock
> to RCU by Kaigai Kohei [1] and by Peter Enderborg [2].
>
> [1] https://lore.kernel.org/selinux/6e2f9128-e191-ebb3-0e87-74bfccb0767f@tycho.nsa.gov/
> [2] https://lore.kernel.org/selinux/20180530141104.28569-1-peter.enderborg@sony.com/
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---

(from v3 comment section:)
> Remaining open questions include whether I should change selinuxfs
> to pass down fsi->mutex so that we can use it in a lockdep check
> for rcu_dereference_check() and whether the sidtab live convert is
> safe after this change.

FTR, I spent some time pondering on whether there is any bad
interaction with the sidtab live convert and I couldn't find anything.
The tricky part was splitting the policy load into load/commit/cancel
and that seems to have been done correctly.

As for rcu_dereference_check(), I'd prefer to pass the fsi->mutex in
there for better clarity. For example, if someone were to call one of
the functions containing it, they may not realize that some mutual
exclusion is expected around them. If the functions take the mutex as
an argument, they at least have to stop and think what to pass in,
which should eventually lead them down the right path.

> v4 fixes the __rcu annotation so that sparse doesn't complain about
> services.c and removes a few extraneous empty lines.
>
>  security/selinux/hooks.c            |   1 -
>  security/selinux/include/security.h |   5 +-
>  security/selinux/ss/services.c      | 487 ++++++++++++++++------------
>  security/selinux/ss/services.h      |   5 -
>  4 files changed, 280 insertions(+), 218 deletions(-)
>
[...]
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index a48fc1b337ba..838161462756 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
[...]
> @@ -2174,14 +2208,18 @@ void selinux_policy_commit(struct selinux_state *state,
>                         pr_info("SELinux: Enabling MLS support...\n");
>         }
>
> +       /* Set latest granting seqno for new policy. */
> +       if (oldpolicy)
> +               newpolicy->latest_granting = oldpolicy->latest_granting + 1;
> +       else
> +               newpolicy->latest_granting = 1;
> +       seqno = newpolicy->latest_granting;

This could be written as:

    seqno = newpolicy->latest_granting = oldpolicy ?
oldpolicy->latest_granting + 1 : 1;

...which is a bit easier to read to me, but others may differ.

> +
>         /* Install the new policy. */
> -       write_lock_irq(&state->ss->policy_rwlock);
> -       state->ss->policy = newpolicy;
> -       seqno = ++state->ss->latest_granting;
> -       write_unlock_irq(&state->ss->policy_rwlock);
> +       rcu_assign_pointer(state->policy, newpolicy);
>
>         /* Load the policycaps from the new policy */
> -       security_load_policycaps(state);
> +       security_load_policycaps(state, newpolicy);
>
>         if (!selinux_initialized(state)) {
>                 /*
[...]
> @@ -2997,20 +3049,20 @@ int security_set_bools(struct selinux_state *state, u32 len, int *values)
>         /* Re-evaluate the conditional rules in the copy */
>         evaluate_cond_nodes(&newpolicy->policydb);
>
> +       /* Set latest granting seqno for new policy */
> +       newpolicy->latest_granting = oldpolicy->latest_granting + 1;
> +       seqno = newpolicy->latest_granting;

These could also be merged into one line.

> +
>         /* Install the new policy */
> -       write_lock_irq(&state->ss->policy_rwlock);
> -       state->ss->policy = newpolicy;
> -       seqno = ++state->ss->latest_granting;
> -       write_unlock_irq(&state->ss->policy_rwlock);
> +       rcu_assign_pointer(state->policy, newpolicy);
>
[...]

Other than the minor things above, I didn't find any logical issue in
this patch.

Since the mutex passing is going to be discussed in a separate patch
and the only other comments I had are minor nits (and which may not
align with your and/or Paul's preference), here you go:

Reviewed-by: Ondrej Mosnacek <omosnace@redhat.com>

--
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

