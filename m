Return-Path: <SRS0=iCYl=CS=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B412CC433E2
	for <selinux@archiver.kernel.org>; Wed,  9 Sep 2020 20:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B5052080C
	for <selinux@archiver.kernel.org>; Wed,  9 Sep 2020 20:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WMSVkLEZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgIIUCP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Sep 2020 16:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbgIIUCO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Sep 2020 16:02:14 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC59C061573;
        Wed,  9 Sep 2020 13:02:13 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id 60so3401580otw.3;
        Wed, 09 Sep 2020 13:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uyw71uc/UrDKRonmuOmxdKfI21OPcapU/xkp1sKYzJc=;
        b=WMSVkLEZQBZ1aZLPOFZ1T0+V1vZd0E0msVq9Ln6MvIJPIywS9tG7dmAbXmYQ5fVdO6
         HnuRwLBcNpFCoouQv1TmIIeYQ4oJMiYD6fh+vdtNiCOuBDL2jP89dMvm049St1h+99SF
         nx1FNimGkQ4A47UK1aZ0hlUZe7LXoC/H28B0LosIzL/a+Xeu7N6WpLhVRmnz3pUY4Qj6
         iJP1Y7mPMko8dYT3JAwTVYhmeHEr/+pOoa2LoKGDGYVqV5SQvTzPb8PaIHs6PSPv0wMY
         UyiIVFmQsUbTn3kyCs9/ninKB7WwWo0R8YRhIVQAW5OtnltLY+nv3L5T6Dsx8mj6E5gF
         L1dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uyw71uc/UrDKRonmuOmxdKfI21OPcapU/xkp1sKYzJc=;
        b=Hx6r9aEUhVmmwa8svvIdANj6gKc++Hnt7DkwQDEQhZXGCPOQbUztBRrys5Av6VSPep
         v68E+9XzztnVUlSqEbbp7FCpurlXDvCvgffjPZ3QrcnyEpKYoodDNvDa0pYK/+fgtbC8
         TMqxh7QjwgiuKZPflLgl+aU7O8/OTnF08Oa42aqHHBOfN9WVoZ9yolfoqbF16PeAV3j1
         /sp0Oyyujs10acE0LWwV3zp9tHKbKLe1Kxd1xT7Nvkcumx6IZsxiHn8V6/giDImH2gvd
         SQKIgU5hMZqM2oQLKksY7+kcD1dCBtIMknZF7Wq9hBVTS0dZnia7/Ji6aqtB6lOWPH5+
         g0Zg==
X-Gm-Message-State: AOAM531It7KSgyYYoAWiGK4s0UczC8dINJpIVXGu4OTCH6f5BkUezVhH
        WFFFgbZgKTQccD6D9ZRdoDt7pcf2CaR5pX80/eo=
X-Google-Smtp-Source: ABdhPJy+9ffxclh7eAoQYtaeVADJdorlrA7ZSLNtNX/tNQNH2W2mJ7jGLZyTXNjxcpSsKISptydTYL4GK64s1RdIN0s=
X-Received: by 2002:a9d:185:: with SMTP id e5mr1837153ote.135.1599681732535;
 Wed, 09 Sep 2020 13:02:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200909182351.10740-1-nramas@linux.microsoft.com>
In-Reply-To: <20200909182351.10740-1-nramas@linux.microsoft.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 9 Sep 2020 16:02:01 -0400
Message-ID: <CAEjxPJ4ndTZ7A5RKV3-2fXNYkP7KG44ot8hxmgW6qBAbhfwqmA@mail.gmail.com>
Subject: Re: [PATCH] selinux: Add helper functions to get and set checkreqprot
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     Paul Moore <paul@paul-moore.com>, Sasha Levin <sashal@kernel.org>,
        James Morris <jmorris@namei.org>,
        SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Sep 9, 2020 at 2:23 PM Lakshmi Ramasubramanian
<nramas@linux.microsoft.com> wrote:
>
> checkreqprot data member in selinux_state struct is accessed directly by
> SELinux functions to get and set. This could cause unexpected read or
> write access to this data member due to compiler optimizations and\or

and/or

> compiler's reordering of access to this field.
>
> Add helper functions to get and set checkreqprot data member in
> selinux_state struct. These helper functions use READ_ONCE and
> WRITE_ONCE macros to ensure explicit read or write of memory for
> this data member.

s/explicit/atomic/

> This patch is based on commit 66ccd2560aff
> ("selinux: simplify away security_policydb_len()") in "next" branch
> in https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git

Don't include this kind of information in a commit message, if needed
it can go after the --- or in brackets in the subject line ala [-next]
 but it isn't necessary when sending against the next branch because
that's the default expectation for submitted patches for selinux.  No
need to cc lsm list on selinux-only patches.

> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> Suggested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---

> diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
> index cbdd3c7aff8b..b19d919f01e7 100644
> --- a/security/selinux/include/security.h
> +++ b/security/selinux/include/security.h
> @@ -209,6 +209,16 @@ static inline bool selinux_policycap_genfs_seclabel_symlinks(void)
>         return state->policycap[POLICYDB_CAPABILITY_GENFS_SECLABEL_SYMLINKS];
>  }
>
> +static inline bool selinux_checkreqprot(const struct selinux_state *state)
> +{
> +       return READ_ONCE(state->checkreqprot);
> +}
> +static inline void selinux_checkreqprot_set(struct selinux_state *state,
> +                                           bool value)
> +{
> +       WRITE_ONCE(state->checkreqprot, value);
> +}

Move these up with the enforcing accessor functions in this header and
use a consistent naming, e.g. checkreqprot_enabled(),
checkreqprot_set().
