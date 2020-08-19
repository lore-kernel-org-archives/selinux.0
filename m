Return-Path: <SRS0=v2nJ=B5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB1CC433E1
	for <selinux@archiver.kernel.org>; Wed, 19 Aug 2020 08:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D5642072D
	for <selinux@archiver.kernel.org>; Wed, 19 Aug 2020 08:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E+1baoah"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbgHSI45 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 19 Aug 2020 04:56:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59948 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727068AbgHSIzF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 19 Aug 2020 04:55:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597827301;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0wrHZFLj97oMmbcx2fgdGJVQT5wDX33567A2Zi5jAWw=;
        b=E+1baoahIw6s3knXmZFO325ohMqmDdB+nrEIHk56SzDExmIGj+4lM3mMmffska7zbFIX2w
        5XquLMHNocskuqixifnxRhBK7BEzTS+sapLKuC3Y6y6Snwo7S//yjJDEjR3okqiCgoBYd4
        l7K+XN0pkLynKWjMRtWHLRwGP4ZIp7E=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-P1llq0WPNFSHMMmq79-dhA-1; Wed, 19 Aug 2020 04:54:59 -0400
X-MC-Unique: P1llq0WPNFSHMMmq79-dhA-1
Received: by mail-lj1-f200.google.com with SMTP id a20so3766125lji.17
        for <selinux@vger.kernel.org>; Wed, 19 Aug 2020 01:54:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0wrHZFLj97oMmbcx2fgdGJVQT5wDX33567A2Zi5jAWw=;
        b=kEm1QluR9ZRWLZQAKQDxQbCw9Yc7kJFYhsAMObrUaWZRbVHfdWWa6V16wBhHnf0IrN
         rN2FUsVuhJ/iCiuKowvPdoRR3R7kmwd+nf96Etd1NJ/ACqhCy9SdzyfRH+EckUna2rqN
         cAw+qtFL6DOsgAp8CBRz5Fk+hwlFdLa5QfFmwyMDXByIutboaWpEPy6V2BM6USDeAAQm
         F/CvMjPMIaqQaxRnv+Y9DmOJPCUn1Me38du/qHBYeItFvMrlQcnpbJZS2NXVV/BGyaKm
         wLKY722oLogjrPSKc/78LukecRYC07n/81QeWJ/sNuGC2Vh3yjhQ2Bjm7E/FbLkpEGW3
         7sIQ==
X-Gm-Message-State: AOAM532exrA3E9zZZuFPg2FkvbW/nA90pJOPlfiDGlZiYQVMkVxuTVkO
        FiBqWKSth9Z8MfHAWU+zi1zn8I7ibEVVCRid7CjgevlX3hJpxV1ZGlC4hIBz19E7tYZIdY17aro
        tIEolUv07MOCPsRUHciOCsZ2RZY7N9t3P3w==
X-Received: by 2002:a19:be53:: with SMTP id o80mr11689250lff.33.1597827297488;
        Wed, 19 Aug 2020 01:54:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzibElK+hNQC8Qm0zfYV6MSkbyn8LWRFUodwa+Qbg13aUubn73mZ53y/mZGWC1g5roV70D45PsFQormCjH07yY=
X-Received: by 2002:a19:be53:: with SMTP id o80mr11689242lff.33.1597827297166;
 Wed, 19 Aug 2020 01:54:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200818221718.35655-1-stephen.smalley.work@gmail.com> <e9c1967d-170f-86f0-2762-7ca36ea08e40@sony.com>
In-Reply-To: <e9c1967d-170f-86f0-2762-7ca36ea08e40@sony.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 19 Aug 2020 10:54:46 +0200
Message-ID: <CAFqZXNsJKDfGy0VAXX6fyKuM5R6ivrfuYmmdQBHySHOFrYT1TA@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: Use call_rcu for policydb and booleans
To:     peter enderborg <peter.enderborg@sony.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Aug 19, 2020 at 10:32 AM peter enderborg
<peter.enderborg@sony.com> wrote:
> From 8184ea3648b18718fdb460a30dfc7f848b7bc6a2 Mon Sep 17 00:00:00 2001
> From: Peter Enderborg <peter.enderborg@sony.com>
> Date: Wed, 19 Aug 2020 10:20:28 +0200
> Subject: [RFC PATCH] selinux: Use call_rcu for policydb and booleans
>
> This patch adds call_rcu that moves sycronize out
> out call path. In the callback we can no call
> cond_resched so they have to be remvoed.

Did you notice Stephen's comment about vfree() in the v1 patch [1]?
That probably also needs addressing, and after that you'll likely end
up with something very similar to the v1 patch anyway.

[1] https://lore.kernel.org/selinux/20200818194311.30018-1-stephen.smalley.work@gmail.com/

>
> Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
> ---
>  security/selinux/ss/policydb.c |  6 -----
>  security/selinux/ss/services.c | 43 ++++++++++++++++++++++++++++++----
>  2 files changed, 39 insertions(+), 10 deletions(-)
>
[...]
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index ba9347517e5b..11eff3a98ef8 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -2184,11 +2184,29 @@ static void selinux_notify_policy_change(struct selinux_state *state,
>         selinux_xfrm_notify_policyload();
>  }
>
> +struct deprecated_policy {
> +       struct selinux_policy *policy;
> +       int partial;
> +       struct rcu_head rcu;

Why not just add these fields to struct selinux_policy directly? Then
you can avoid the speculative allocation of struct deprecated_policy.

> +};
> +
> +void policy_reclaim(struct rcu_head *rp)
> +{
> +       struct deprecated_policy *dep = container_of(rp, struct dep_policy, rcu);
> +
> +       if (dep->partial)
> +               selinux_policy_cond_free(dep->policy);
> +       else
> +               selinux_policy_free(dep->policy);
> +       kfree(dep);
> +}
> +
>  void selinux_policy_commit(struct selinux_state *state,
>                         struct selinux_policy *newpolicy)
>  {
>         struct selinux_policy *oldpolicy;
>         u32 seqno;
> +       struct deprecated_policy *dep;
>
>         /*
>          * NOTE: We do not need to take the rcu read lock
> @@ -2231,8 +2249,16 @@ void selinux_policy_commit(struct selinux_state *state,
>         }
>
>         /* Free the old policy */
> -       synchronize_rcu();
> -       selinux_policy_free(oldpolicy);
> +       /* if cant alloc we need to it the slow way */
> +       dep  = kzalloc(sizeof(struct deprecated_policy), GFP_KERNEL);
> +       if (dep) {
> +               dep->policy = oldpolicy;
> +               dep->partial = 0;
> +               call_rcu(&dep->rcu, policy_reclaim);
> +       } else {
> +               synchronize_rcu();
> +               selinux_policy_free(oldpolicy);
> +       }
>
>         /* Notify others of the policy change */
>         selinux_notify_policy_change(state, seqno);
[...]


--
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

