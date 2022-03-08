Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E36CC433EF
	for <selinux@archiver.kernel.org>; Tue,  8 Mar 2022 22:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345323AbiCHWOS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 8 Mar 2022 17:14:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350594AbiCHWOR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 8 Mar 2022 17:14:17 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A585D33A0E
        for <selinux@vger.kernel.org>; Tue,  8 Mar 2022 14:13:19 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id s10so600779edd.0
        for <selinux@vger.kernel.org>; Tue, 08 Mar 2022 14:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=Xcu3YWlNG5WIlHrP/UGZRboaPN6V/9ELg0SKhO4P0HU=;
        b=3NeJK5xW/3hUa0eO5TMOJXTDZA1+KF1wN1v5LbiE3E6N7cY4o9sLvR12askujmvg/3
         1SGi4/7nxCYstfbXt74cQFPmwXWKN74XEEzFK+HSEIhh4dJvHRrZHXrEHAJKQuf54lJL
         fw0skg7OTEzribIpft//0NVlNjvQ2YNxnp7W7vnS5KPsSQx0WNLFertbtNdBIrs09aBW
         JVHeNThxT5Rs8BaTh7wET+ZTpVBGiN2UVvr/jXbCfw0i1KREmUZyhOp4maGp6ekrzlco
         ViyV2dvn1TBaOdk0CA1CJicM49Grj7842L46O47a0MW1mESCL/p4D2QnAntd4RMBcg0F
         5BSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Xcu3YWlNG5WIlHrP/UGZRboaPN6V/9ELg0SKhO4P0HU=;
        b=51oLNjfpkQ23F2x+EKni2DhxDNhsK81BJJeEK3seYOKMqHqsJ8Or2tI+BcyduZIkAF
         BVbBwh4MRO6N22FzhdSmt2N5MJ1mHKrVrLZAEdaT9CiACkRaJnyRQyovshR8g8FI018K
         nUWlKXuLJGa8ziWQz4rUSOPmALDx1zKiMiI4WscaHytfr+DK6TsOcqNPJqLvXcYKOVav
         ASLA6knrsZmacxQ4A/1Y6ylRJ8/myPBN5nvjx0DMFKxHV9Nr1WX4PAyqDxUiwgran6Z7
         Oj8aDtGcq1unUfXgLW/vsNYAWN5/+pHT0wwhfnt/8b/5fz9IQ0kY0fnrUvmEGDGfbJ7z
         VW7g==
X-Gm-Message-State: AOAM532SwktLHUkxNOJCPgp6Uam1JYnw2ym/VNaJPv/3SkwPAAumDW44
        X/jQ3ExUh2ePbt9owhXbRTcC51IQVx+h0Vfn3ytDkAlGSg==
X-Google-Smtp-Source: ABdhPJynGBsR0hyR/qaOP3QFCSLcMNAYQOo06sgAYRRA1UJj6LqAzJHhrA48+lwi0cdZ8DafyAirCp4Y9eY2iLi8aKg=
X-Received: by 2002:a05:6402:42d4:b0:412:c26b:789 with SMTP id
 i20-20020a05640242d400b00412c26b0789mr18135346edc.232.1646777597781; Tue, 08
 Mar 2022 14:13:17 -0800 (PST)
MIME-Version: 1.0
References: <164677751730.170741.6493351205403681020.stgit@olly>
In-Reply-To: <164677751730.170741.6493351205403681020.stgit@olly>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 8 Mar 2022 17:13:06 -0500
Message-ID: <CAHC9VhQ49GhkZZne4YNz3gCuQfzQtfvoUO+wA1dCJOgBe3a-gA@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: checkreqprot is deprecated, add some
 ssleep() discomfort
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Mar 8, 2022 at 5:11 PM Paul Moore <paul@paul-moore.com> wrote:
>
> The checkreqprot functionality was disabled by default back in
> Linux v4.4 (2015) with commit 2a35d196c160e3 ("selinux: change
> CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE default") and it was
> officially marked as deprecated in Linux v5.7.  It was always a
> bit of a hack to workaround very old userspace and to the best of
> our knowledge, the checkreqprot functionality has been disabled by
> Linux distributions for quite some time.
>
> This patch moves the deprecation messages from KERN_WARNING to
> KERN_ERR and adds a five second sleep to anyone using it to help
> draw their attention to the deprecation and provide a URL which
> helps explain things in more detail.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/selinux/hooks.c            |    4 +++-
>  security/selinux/include/security.h |    6 ++++++
>  security/selinux/selinuxfs.c        |    4 ++--
>  3 files changed, 11 insertions(+), 3 deletions(-)

As with the runtime disable RFC, comments on the wiki text are welcome as well.

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index b12e14b2797b..cff129f96e97 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -146,7 +146,7 @@ static int __init checkreqprot_setup(char *str)
>         if (!kstrtoul(str, 0, &checkreqprot)) {
>                 selinux_checkreqprot_boot = checkreqprot ? 1 : 0;
>                 if (checkreqprot)
> -                       pr_warn("SELinux: checkreqprot set to 1 via kernel parameter.  This is deprecated and will be rejected in a future kernel release.\n");
> +                       pr_err("SELinux: checkreqprot set to 1 via kernel parameter.  This is deprecated and will be rejected in a future kernel release.\n");
>         }
>         return 1;
>  }
> @@ -7295,6 +7295,8 @@ static __init int selinux_init(void)
>
>         memset(&selinux_state, 0, sizeof(selinux_state));
>         enforcing_set(&selinux_state, selinux_enforcing_boot);
> +       if (CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE)
> +               pr_err("SELinux: CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE is non-zero.  This is deprecated and will be rejected in a future kernel release.\n");
>         checkreqprot_set(&selinux_state, selinux_checkreqprot_boot);
>         selinux_avc_init(&selinux_state.avc);
>         mutex_init(&selinux_state.status_lock);
> diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
> index ace4bd13e808..f7e6be63adfb 100644
> --- a/security/selinux/include/security.h
> +++ b/security/selinux/include/security.h
> @@ -16,6 +16,8 @@
>  #include <linux/rcupdate.h>
>  #include <linux/refcount.h>
>  #include <linux/workqueue.h>
> +#include <linux/delay.h>
> +#include <linux/printk.h>
>  #include "flask.h"
>  #include "policycap.h"
>
> @@ -150,6 +152,10 @@ static inline bool checkreqprot_get(const struct selinux_state *state)
>
>  static inline void checkreqprot_set(struct selinux_state *state, bool value)
>  {
> +       if (value) {
> +               pr_err("SELinux: https://github.com/SELinuxProject/selinux-kernel/wiki/DEPRECATE-checkreqprot\n");
> +               ssleep(5);
> +       }
>         WRITE_ONCE(state->checkreqprot, value);
>  }
>
> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index 6568bc48cd3e..6c8b6a0ddecf 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -757,8 +757,8 @@ static ssize_t sel_write_checkreqprot(struct file *file, const char __user *buf,
>                 char comm[sizeof(current->comm)];
>
>                 memcpy(comm, current->comm, sizeof(comm));
> -               pr_warn_once("SELinux: %s (%d) set checkreqprot to 1. This is deprecated and will be rejected in a future kernel release.\n",
> -                            comm, current->pid);
> +               pr_err("SELinux: %s (%d) set checkreqprot to 1. This is deprecated and will be rejected in a future kernel release.\n",
> +                      comm, current->pid);
>         }
>
>         checkreqprot_set(fsi->state, (new_value ? 1 : 0));
>


-- 
paul-moore.com
