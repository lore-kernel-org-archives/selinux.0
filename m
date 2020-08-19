Return-Path: <SRS0=v2nJ=B5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E98C433E1
	for <selinux@archiver.kernel.org>; Wed, 19 Aug 2020 08:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8813E20639
	for <selinux@archiver.kernel.org>; Wed, 19 Aug 2020 08:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W0JzhAYZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgHSIk5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Aug 2020 04:40:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55155 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725903AbgHSIkw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Aug 2020 04:40:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597826449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rA1u2hchuPnlMnnlgsLUeIZaqdzKKKb5RecCBYS1TAw=;
        b=W0JzhAYZv0jMo760K2Rc+CPtJAUYvLBOmqDXsQvAxX8hpySnksOIBAgWlHdqS8qHt7Ft5I
        NdCcUZWa38ODRMHGLSMrBZgxj6mojxXBtmUFbah6f6uZxcszNYtlH0pMymKUBiKn3jU/0b
        BCTEoB9CE/qOZELANQE0I5ZkkqRQrYc=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-lQ9C6b_KOmSOoDXnJ731gQ-1; Wed, 19 Aug 2020 04:40:47 -0400
X-MC-Unique: lQ9C6b_KOmSOoDXnJ731gQ-1
Received: by mail-lj1-f197.google.com with SMTP id i18so3785735ljj.4
        for <selinux@vger.kernel.org>; Wed, 19 Aug 2020 01:40:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rA1u2hchuPnlMnnlgsLUeIZaqdzKKKb5RecCBYS1TAw=;
        b=c233gSY4MxTriKCCUCfCAwwYi9B/nkiBIPKFPol84DpixLfeKCBVDkMaalTsqx6JQr
         dmoDsJ28r2EB4vxqt75fhOPFhQhcx02fMGyYa5B+3pxI6Q6r1Nh+Vp+K06lL43fbOMn8
         FEAN3zcRbU4OCX3FGw+ilOpRvi6UxuMWoc7PWjWrdfK++c74fgdK6IkHn0FYG7yP2oAm
         D64ny0iY8EGW5wFcV/1dTLwVs934hMCo7p+x1dKVhVWEpwkWfczOA4m5xjHDHLNvLIWz
         bc9qh4IKJUmwb0yOo5m3n+g9Vv5mgKAB8av6PD8wfZQ8E/2TdD3AZhsmFZ+vwPSugGPI
         Jmig==
X-Gm-Message-State: AOAM532zPGW8BxW7tcXFMP+eeyPKwbZ1A4A8wffRxYOLVj5oPdM3iXZ+
        GgL9aYGgBjmpVWWCDWfqfRDR0XDXLjLRWSyquDQ2aiQFT1ZrVMMDfTwO6rwcM2fxuRUL5qr81wv
        Dxn+55RTSgnZ9nKYU8NsHwyM/YTsL2+M4+A==
X-Received: by 2002:a2e:86da:: with SMTP id n26mr12106321ljj.311.1597826445334;
        Wed, 19 Aug 2020 01:40:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyqdNHVcUGoltOM8U7mb7dTU3acG2gQfoOirbl+wSJP/TVmhE/iu2kcoUxMGIqVFNSa8jOGBy2pS9BYLYQpLS8=
X-Received: by 2002:a2e:86da:: with SMTP id n26mr12106302ljj.311.1597826444996;
 Wed, 19 Aug 2020 01:40:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200818221718.35655-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20200818221718.35655-1-stephen.smalley.work@gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 19 Aug 2020 10:40:34 +0200
Message-ID: <CAFqZXNtAXmOF30FGn-uD_ORUAWMaDdr6x2NC_scbYjhAbYD5Aw@mail.gmail.com>
Subject: Re: [RFC PATCH v2] selinux: convert policy read-write lock to RCU
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        SElinux list <selinux@vger.kernel.org>,
        peter.enderborg@sony.com
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

A few comments inline after a quick glance...

On Wed, Aug 19, 2020 at 12:17 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> Convert the policy read-write lock to RCU.  This is significantly
> simplified by the earlier work to encapsulate the policy data
> structures and refactor the policy load and boolean setting logic.
> Move the latest_granting sequence number into the selinux_policy
> structure so that it can be updated atomically with the policy.
> Since the removal of the policy rwlock and this move of
> latest_granting reduces the selinux_ss structure to nothing more than
> a wrapper around the selinux_policy pointer, get rid of the extra
> layer of indirection.
>
> At present this change merely passes a hardcoded 1 to
> rcu_dereference_check() in the cases where we know we do not need to
> take rcu_read_lock(), with the preceding comment explaining why.
> Alternatively we could pass fsi->mutex down from selinuxfs and
> apply a lockdep check on it instead.
>
> This change does not specifically do anything special with respect
> to the sidtab live convert; I am unclear as to whether it is safe
> as a result.  Comments welcome.
>
> Based in part on earlier attempts to convert the policy rwlock
> to RCU by Kaigai Kohei [1] and by Peter Enderborg [2].
>
> [1] https://lore.kernel.org/selinux/6e2f9128-e191-ebb3-0e87-74bfccb0767f@tycho.nsa.gov/
> [2] https://lore.kernel.org/selinux/20180530141104.28569-1-peter.enderborg@sony.com/
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> v2 switches to synchronize_rcu() and moves latest_granting into selinux_policy,
> removing the need for a separate selinux_ss struct altogether.  Open questions
> remain about what to pass to rcu_dereference_check() and whether sidtab live
> convert is safe after this change.
>
>  security/selinux/hooks.c            |   1 -
>  security/selinux/include/security.h |   5 +-
>  security/selinux/ss/services.c      | 436 ++++++++++++++++------------
>  security/selinux/ss/services.h      |   5 -
>  4 files changed, 256 insertions(+), 191 deletions(-)
>
[...]
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index f6f78c65f53f..ba9347517e5b 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
[...]
> @@ -239,13 +231,15 @@ static void map_decision(struct selinux_map *map,
>  int security_mls_enabled(struct selinux_state *state)
>  {
>         int mls_enabled;
> +       struct selinux_policy *policy;
>
>         if (!selinux_initialized(state))
>                 return 0;
>
> -       read_lock(&state->ss->policy_rwlock);
> -       mls_enabled = state->ss->policy->policydb.mls_enabled;
> -       read_unlock(&state->ss->policy_rwlock);
> +       rcu_read_lock();
> +       policy = rcu_dereference(state->policy);
> +       mls_enabled = policy->policydb.mls_enabled;
> +       rcu_read_unlock();
>         return mls_enabled;
>  }
>
> @@ -722,8 +716,9 @@ static int security_validtrans_handle_fail(struct selinux_state *state,
>                                            struct sidtab_entry *tentry,
>                                            u16 tclass)
>  {
> -       struct policydb *p = &state->ss->policy->policydb;
> -       struct sidtab *sidtab = state->ss->policy->sidtab;
> +       struct selinux_policy *policy = rcu_dereference(state->policy);

This looks dangerous - you might get a newer policy pointer here than
the one you dereferenced in security_compute_validatetrans(), which
wouldn't be good. Instead of double-dereferencing you should always
pass the struct selinux_policy pointer as an argument to functions
like this. Please double-check if there are other cases like this, I
didn't go over the patch in detail yet.

> +       struct policydb *p = &policy->policydb;
> +       struct sidtab *sidtab = policy->sidtab;
>         char *o = NULL, *n = NULL, *t = NULL;
>         u32 olen, nlen, tlen;
>
> @@ -751,6 +746,7 @@ static int security_compute_validatetrans(struct selinux_state *state,
>                                           u32 oldsid, u32 newsid, u32 tasksid,
>                                           u16 orig_tclass, bool user)
>  {
> +       struct selinux_policy *policy;
>         struct policydb *policydb;
>         struct sidtab *sidtab;
>         struct sidtab_entry *oentry;
> @@ -765,13 +761,14 @@ static int security_compute_validatetrans(struct selinux_state *state,
>         if (!selinux_initialized(state))
>                 return 0;
>
> -       read_lock(&state->ss->policy_rwlock);
> +       rcu_read_lock();
>
> -       policydb = &state->ss->policy->policydb;
> -       sidtab = state->ss->policy->sidtab;
> +       policy = rcu_dereference(state->policy);
> +       policydb = &policy->policydb;
> +       sidtab = policy->sidtab;
>
>         if (!user)
> -               tclass = unmap_class(&state->ss->policy->map, orig_tclass);
> +               tclass = unmap_class(&policy->map, orig_tclass);
>         else
>                 tclass = orig_tclass;
>
> @@ -824,7 +821,7 @@ static int security_compute_validatetrans(struct selinux_state *state,
>         }
>
>  out:
> -       read_unlock(&state->ss->policy_rwlock);
> +       rcu_read_unlock();
>         return rc;
>  }
>
[...]
> @@ -2174,11 +2206,16 @@ void selinux_policy_commit(struct selinux_state *state,
>                         pr_info("SELinux: Enabling MLS support...\n");
>         }
>
> +
> +       /* Set latest granting seqno for new policy. */
> +       if (oldpolicy)
> +               newpolicy->latest_granting = oldpolicy->latest_granting + 1;
> +       else
> +               newpolicy->latest_granting = 1;
> +       seqno = newpolicy->latest_granting;
> +
>         /* Install the new policy. */
> -       write_lock_irq(&state->ss->policy_rwlock);
> -       state->ss->policy = newpolicy;
> -       seqno = ++state->ss->latest_granting;
> -       write_unlock_irq(&state->ss->policy_rwlock);
> +       rcu_assign_pointer(state->policy, newpolicy);

This is probably a pre-existing thing, but I noticed that there is a
small window of inconsistency between policy (re)load / bool change
and AV cache. Between the rcu_assign_pointer() (or the write lock
section before) and avc_ss_reset(), there might be AVC lookups, which
in case of cache hit would decide based on the old policy, but in case
of a miss, they would decide based on the new one. I think it might be
fixed by moving avc_ss_reset() before rcu_assign_pointer() (but no
earlier than when it is guaranteed that the policy reload will
complete successfully).

Anyway, since we need to flush the AVC at each policy reload, it might
be more logical now to move the AVC under struct selinux_policy as
well, and avoid the seqno logic altogether. After the RCU conversion,
accessing a consistent struct selinux_policy becomes really cheap, so
integrating the AVC should allow for code simplification for (almost)
zero performance impact. A similar thing could be probably done also
with the netlabel/xfrm cache (not really familiar with those). Also
the duplicit policycap array in struct selinux_state could be replaced
with queries to struct selinux_policy instead (but I have a hunch
there are some pre-existing logical race conditions around the
handling of policycaps...).

>
>         /* Load the policycaps from the new policy */
>         security_load_policycaps(state);
> @@ -2194,6 +2231,7 @@ void selinux_policy_commit(struct selinux_state *state,
>         }
>
>         /* Free the old policy */
> +       synchronize_rcu();
>         selinux_policy_free(oldpolicy);
>
>         /* Notify others of the policy change */
[...]


--
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

