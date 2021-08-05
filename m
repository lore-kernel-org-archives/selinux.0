Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9576EC4338F
	for <selinux@archiver.kernel.org>; Thu,  5 Aug 2021 20:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A8C9610FF
	for <selinux@archiver.kernel.org>; Thu,  5 Aug 2021 20:48:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbhHEUtE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 5 Aug 2021 16:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbhHEUtD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 5 Aug 2021 16:49:03 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11EDCC061765
        for <selinux@vger.kernel.org>; Thu,  5 Aug 2021 13:48:48 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id qk33so11647702ejc.12
        for <selinux@vger.kernel.org>; Thu, 05 Aug 2021 13:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/vG2y3pQr2mGpthXdmqTFF0XGUdaGGCWCADJ95snNYQ=;
        b=q66U6kw2e4AOq/fw84oFjvyzV1zNQ56b8kIoaikslTBveCNDcLBxKIczdfu4FIdoFA
         xCgK5JisaoR3nXj8fCkomsesiZ9yl9b6WSLp7q7GqhdSKq9dTkfF4rBEk8s7M9uPZD0Y
         vCW9JKA/mN29FashUABEspFhEYKG1IQnRnlKN0i9WjPgbLQvfoO/S66qwIAwUDrDI11Y
         HvUBuMG79dQDpXIa0WrVYvCDKUvL0HvWbFh0khuWiMA/RFLY3nts3MTQwAymr2PLwQpj
         IlHhI3g2Cm++T3nAqrPM06WvsoIUsEPrakoTbCHdI66z1YBi/uw27ovWUTsG6rGs4n2K
         Eh2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/vG2y3pQr2mGpthXdmqTFF0XGUdaGGCWCADJ95snNYQ=;
        b=BA2Lq+rPsucR1BlXmxJDnaAJ8IRXCvpFGeImTdyQDi0q3ZzDK+7lm3jih72cC8cabH
         Di/fEI95YA0499nkloLFOfHqW111HKal4iTnkLTFN0KtTqoZnGW2DJ5xtKXTsRVkijyh
         PDraPlTO7sMp/OCTbJyi7qZwxAQ35Bh/lZjgvZWPcFOBg1+BSfq0HCPmK8HZeAtEM2nP
         RMzuCZPt6bBKI4siCPNNJuPVtfWUB6AU/gON7nLky11Moo2cdWw6emhqaQWRdret/V/C
         KbnIRoEW7GSt4+6wIf14TRQJGdV9mrwLq/2MncBjxYZ+wJN429WG9Z183TfiwO3ZMmjG
         vaKg==
X-Gm-Message-State: AOAM5319bjyh8yF9x/RJnjlIokpeTfMXyXKKUEf7bPAHIHNaGw9Za/rA
        5V/NQs0citkjDGvk0s31t56GE+CwvXxNUOWmd9T+
X-Google-Smtp-Source: ABdhPJyDeSYes/bgfYa6CIzNl+GpqZJSaL7iQWC+Mo+NeCt7Cs0adz4podcTWjUO5a9cSi/QLU14LM9H0kQ43ZRonCs=
X-Received: by 2002:a17:906:46da:: with SMTP id k26mr6496142ejs.398.1628196526516;
 Thu, 05 Aug 2021 13:48:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210728140313.68096-1-omosnace@redhat.com>
In-Reply-To: <20210728140313.68096-1-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 5 Aug 2021 16:48:35 -0400
Message-ID: <CAHC9VhTDagTt1CKDRPkVrcvHwWPbSzzPp3HSS3ZzsbLapTBAxw@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix race condition when computing ocontext SIDs
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, Sujithra Periasamy <sujithra@google.com>,
        Xinjie Zheng <xinjie@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jul 28, 2021 at 10:03 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> Current code contains a lot of racy patterns when converting an
> ocontext's context structure to an SID. This is being done in a "lazy"
> fashion, such that the SID is looked up in the SID table only when it's
> first needed and then cached in the "sid" field of the ocontext
> structure. However, this is done without any locking or memory barriers
> and is thus unsafe.
>
> Between commits 24ed7fdae669 ("selinux: use separate table for initial
> SID lookup") and 66f8e2f03c02 ("selinux: sidtab reverse lookup hash
> table"), this race condition lead to an actual observable bug, because a
> pointer to the shared sid field was passed directly to
> sidtab_context_to_sid(), which was using this location to also store an
> intermediate value, which could have been read by other threads and
> interpreted as an SID. In practice this caused e.g. new mounts to get a
> wrong (seemingly random) filesystem context, leading to strange denials.
> This bug has been spotted in the wild at least twice, see [1] and [2].
>
> Fix the race condition by making all the racy functions use a common
> helper that ensures the ocontext::sid accesses are made safely using the
> appropriate SMP constructs.
>
> Note that security_netif_sid() was populating the sid field of both
> contexts stored in the ocontext, but only the first one was actually
> used. The SELinux wiki's documentation on the "netifcon" policy
> statement [3] suggests that using only the first context is intentional.
> I kept only the handling of the first context here, as there is really
> no point in doing the SID lookup for the unused one.

The security_netif_sid() change looks fine to me.  I *think* that the
second netif label goes back to some of the original SELinux network
labeling, I believe the original intent may even predate my
involvement in the project but that is far enough back I can't say for
certain without doing some heavy mailing list searches :)

> I wasn't able to reproduce the bug mentioned above on any kernel that
> includes commit 66f8e2f03c02, even though it has been reported that the
> issue occurs with that commit, too, just less frequently. Thus, I wasn't
> able to verify that this patch fixes the issue, but it makes sense to
> avoid the race condition regardless.
>
> [1] https://github.com/containers/container-selinux/issues/89
> [2] https://lists.fedoraproject.org/archives/list/selinux@lists.fedoraproject.org/thread/6DMTAMHIOAOEMUAVTULJD45JZU7IBAFM/
> [3] https://selinuxproject.org/page/NetworkStatements#netifcon
>
> Reported-by: Sujithra Periasamy <sujithra@google.com>
> Cc: Xinjie Zheng <xinjie@google.com>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  security/selinux/ss/services.c | 162 ++++++++++++++++-----------------
>  1 file changed, 77 insertions(+), 85 deletions(-)
>
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index 0a5ce001609b..c8db8a3432e4 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -2369,6 +2369,43 @@ err_policy:
>         return rc;
>  }
>
> +/**
> + * ocontext_to_sid - Helper to safely get sid for an ocontext
> + * @sidtab: SID table
> + * @c: ocontext structure
> + * @index: index of the context entry (0 or 1)
> + * @out_sid: pointer to the resulting SID value
> + *
> + * For all ocontexts except OCON_ISID the SID fields are populated
> + * on-demand when needed. Since updating the SID value is an SMP-sensitive
> + * operation, this helper must be used to do that safely.
> + *
> + * WARNING: This function may return -ESTALE, indicating that the caller
> + * must retry the operation after re-acquiring the policy pointer!
> + */
> +static int ocontext_to_sid(struct sidtab *sidtab, struct ocontext *c,
> +                          size_t index, u32 *out_sid)
> +{
> +       int rc;
> +       u32 sid;
> +
> +       /* Ensure the associated sidtab entry is visible to this thread. */
> +       sid = smp_load_acquire(&c->sid[index]);

Is there a reason why you decided to use smp_{load,store} to guard
ocontext.sid[] as opposed to RCU/spinlock?  RCU would allow us to
avoid the memory barrier in smp_load_acquire() on every call to
ocontext_to_sid() and it looks like all of the non-exclusive callers
are already in a RCU protected section so the additional impact on an
already cached value should be next to nothing.  The spinlock would
make things slightly more complicated (take the lock, recheck
ocontext.sid, set/bail, unlock, etc.) but we are already in the slow
path at that point.

> +       if (!sid) {
> +               rc = sidtab_context_to_sid(sidtab, &c->context[index], &sid);
> +               if (rc)
> +                       return rc;
> +
> +               /*
> +                * Ensure the new sidtab entry is visible to other threads
> +                * when they see the SID.
> +                */
> +               smp_store_release(&c->sid[index], sid);
> +       }
> +       *out_sid = sid;
> +       return 0;
> +}

-- 
paul moore
www.paul-moore.com
