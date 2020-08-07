Return-Path: <SRS0=J0Ra=BR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D94C433E0
	for <selinux@archiver.kernel.org>; Fri,  7 Aug 2020 03:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 328292086A
	for <selinux@archiver.kernel.org>; Fri,  7 Aug 2020 03:41:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="XaKNcpZx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbgHGDlc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 6 Aug 2020 23:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgHGDlc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 6 Aug 2020 23:41:32 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9292C061574
        for <selinux@vger.kernel.org>; Thu,  6 Aug 2020 20:41:31 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id l23so247442edv.11
        for <selinux@vger.kernel.org>; Thu, 06 Aug 2020 20:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ySVSFq+3n2OYR9wYE3HFhKONbQJu/K8guVDLgnzSdDs=;
        b=XaKNcpZx6KocF+VEOXwl0nMD8LHGxTjzpz4x6c2u0MX8cxiFMrMg45rrZJaBEDuun4
         BPkoin58B7VYTi0kN/4MNcHnEILsmQQSogww2vko/ZVGupaB27QywO7ZILA70OP1gBQs
         gdOfxtF8RdR42WwZn7F9TjMnCunHIkSnFlEhZevSPOvWd/F6ZonZhtNcviYfzpti/Ito
         xR2RIRQqJ4ME8NvMbPDDLNv1sBxD3UYx7q43e39a6yw8fNm3Q9ROR0G92Gz1Gih9Qla1
         TB8jludi8mT3zZ1jnwNH07IbFGpPfUegohIpM+FimY5E/MU50Glx9gjB2fD/mJsoBnO2
         o8VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ySVSFq+3n2OYR9wYE3HFhKONbQJu/K8guVDLgnzSdDs=;
        b=bapupmyNa0A5Wxs4zNG85li/F7c235xa9jBE1pyVqvrsjicL0+vi9u/5c+G+ihCBij
         OxDFRoUXSUuyTdRZ0DN+5Hlqi1ey8Oiy8hZokOl0Ns+0paItcTpiyUkup3nNk2ZjmN/v
         TwixP7pUQrkkC5liuMNf3I9UBe1WIF4ztGCvgJ6bO4Q30t4q4MLtbrEIXnScfuZ+Yuf2
         mGgc0hjV7sbOLNcY/Gu1RrfHh+C5XlOvh80oDIPhaZ1c3ZisiFP8yse171MQzMAcaFB0
         qrVe9XSRSQqb5x/l6V98Fq8UwCkPu6FWQ9vaC1R+gLkz+WPljGKRkGNg9/fisbHmOnSf
         vqkQ==
X-Gm-Message-State: AOAM5324Q9UyrfOUNf6BrAcSBqzaSPpm4fSkoGl7HMU5ETBWjeKa6cx+
        3Y9BAwd16PQZWM8yoFifKayU6Jv0XefoAv+rV55T
X-Google-Smtp-Source: ABdhPJyH4y/UHcnhA9HcG32f+5eYOtMQzCKT94anHI6lyUzZyF9AZBBkSmc41qOsTycCirJJWxdv766bb0wv9bwL1FE=
X-Received: by 2002:a50:93c5:: with SMTP id o63mr6888500eda.31.1596771690189;
 Thu, 06 Aug 2020 20:41:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200805155240.26473-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20200805155240.26473-1-stephen.smalley.work@gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 6 Aug 2020 23:41:19 -0400
Message-ID: <CAHC9VhTmXnHMGd8sD7343ANYkZD3RR_Tz=D2a2V8H9coOpvDNg@mail.gmail.com>
Subject: Re: [RFC PATCH v4 1/2] selinux: encapsulate policy state, refactor
 policy load
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
        dburgener@linux.microsoft.com
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Aug 5, 2020 at 11:52 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> Encapsulate the policy state in its own structure (struct
> selinux_policy) that is separately allocated but referenced from the
> selinux_ss structure.  The policy state includes the SID table
> (particularly the context structures), the policy database, and the
> mapping between the kernel classes/permissions and the policy values.
> Refactor the security server portion of the policy load logic to
> cleanly separate loading of the new structures from committing the new
> policy.  Unify the initial policy load and reload code paths as much
> as possible, avoiding duplicated code.  Make sure we are taking the
> policy read-lock prior to any dereferencing of the policy.  Move the
> copying of the policy capability booleans into the state structure
> outside of the policy write-lock because they are separate from the
> policy and are read outside of any policy lock; possibly they should
> be using at least READ_ONCE/WRITE_ONCE or smp_load_acquire/store_release.
> Restore the load mutex that was previously removed by
> commit 89abd0acf033 ("SELinux: drop load_mutex in security_load_policy")
> to make explicit the exclusion even though it is currently redundant
> with the fsi->mutex held by selinuxfs; this makes clear that we do
> not need to take the policy read-lock across sidtab_convert() and will
> be useful in the future for lockdep checking.
>
> These changes simplify the policy loading logic, reduce the size of
> the critical section while holding the policy write-lock, and should
> facilitate future changes to e.g. refactor the entire policy reload
> logic including the selinuxfs code to make the updating of the policy
> and the selinuxfs directory tree atomic and/or to convert the policy
> read-write lock to RCU.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
> v4 does not take the policy read-lock across sidtab_convert() and
> therefore does not require changing allocations by it to be atomic
> or dropping the cond_resched() call.  To make obvious that taking
> the policy read-lock is not necessary in security_load_policy(), restore
> the load mutex to security_load_policy() that was removed back in
> commit 89abd0acf033 ("SELinux: drop load_mutex in security_load_policy").
> However, since we have refactored security_load_policy() in this change
> to split out selinux_policy_commit(), we need to take the mutex in
> security_load_policy() and release it in selinux_policy_commit().

I'm not in love with the idea of splitting the lock/unlock across
different functions, more below in the relevant code section.

>  security/selinux/ss/services.c | 403 +++++++++++++++++----------------
>  security/selinux/ss/services.h |  11 +-
>  2 files changed, 220 insertions(+), 194 deletions(-)

...


> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index 9e76a80db6e1..6dea93fac9e2 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -2115,11 +2126,73 @@ static void security_load_policycaps(struct selinux_state *state)
>                         pr_info("SELinux:  unknown policy capability %u\n",
>                                 i);
>         }
> +
> +       read_unlock(&state->ss->policy_rwlock);
>  }
>
>  static int security_preserve_bools(struct selinux_state *state,
>                                    struct policydb *newpolicydb);
>
> +static void selinux_policy_free(struct selinux_policy *policy)
> +{
> +       if (!policy)
> +               return;
> +
> +       policydb_destroy(&policy->policydb);
> +       sidtab_destroy(&policy->sidtab);
> +       kfree(policy->map.mapping);
> +       kfree(policy);
> +}
> +
> +static void selinux_policy_commit(struct selinux_state *state,
> +                               struct selinux_policy *newpolicy)
> +{
> +       struct selinux_policy *oldpolicy;
> +       u32 seqno;
> +
> +       lockdep_assert_held(&state->ss->load_mutex);
> +
> +       /* If switching between different policy types, log MLS status */
> +       oldpolicy = state->ss->policy;
> +       if (oldpolicy) {
> +               if (oldpolicy->policydb.mls_enabled && !newpolicy->policydb.mls_enabled)
> +                       pr_info("SELinux: Disabling MLS support...\n");
> +               else if (!oldpolicy->policydb.mls_enabled && newpolicy->policydb.mls_enabled)
> +                       pr_info("SELinux: Enabling MLS support...\n");
> +       }
> +
> +       /* Install the new policy. */
> +       write_lock_irq(&state->ss->policy_rwlock);
> +       state->ss->policy = newpolicy;
> +       seqno = ++state->ss->latest_granting;
> +       write_unlock_irq(&state->ss->policy_rwlock);
> +
> +       /* Load the policycaps from the new policy */
> +       security_load_policycaps(state);
> +
> +       if (!selinux_initialized(state)) {
> +               /*
> +                * After first policy load, the security server is
> +                * marked as initialized and ready to handle requests and
> +                * any objects created prior to policy load are then labeled.
> +                */
> +               selinux_mark_initialized(state);
> +               mutex_unlock(&state->ss->load_mutex);
> +               selinux_complete_init();
> +       } else
> +               mutex_unlock(&state->ss->load_mutex);
> +
> +       /* Free the old policy */
> +       selinux_policy_free(oldpolicy);
> +
> +       /* Flush external caches and notify userspace of policy load */
> +       avc_ss_reset(state->avc, seqno);
> +       selnl_notify_policyload(seqno);
> +       selinux_status_update_policyload(state, seqno);
> +       selinux_netlbl_cache_invalidate();
> +       selinux_xfrm_notify_policyload();
> +}

I can somewhat understand if you don't want to have all the old policy
cleanup, reset, and notify code in security_load_policy(), but I
really dislike that the mutex lock/unlock is split across the two
functions.

What if selinux_policy_commit() returned oldpolicy on success and we
created a new function, selinux_policy_retire() (name?), that would be
called from security_load_policy and could handle the cleanup, reset,
and notify code.  The mutex unlock could happen between the calls to
selinux_policy_commit() and selinux_policy_retire()?

I'm open to other ideas as well.

-- 
paul moore
www.paul-moore.com
