Return-Path: <SRS0=Kl1g=UC=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5441C04AB6
	for <selinux@archiver.kernel.org>; Mon,  3 Jun 2019 07:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85E3027C94
	for <selinux@archiver.kernel.org>; Mon,  3 Jun 2019 07:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbfFCHXo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 Jun 2019 03:23:44 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41532 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbfFCHXn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 Jun 2019 03:23:43 -0400
Received: by mail-oi1-f196.google.com with SMTP id b21so8128818oic.8
        for <selinux@vger.kernel.org>; Mon, 03 Jun 2019 00:23:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iTUu3d7b9FzAYYjmvVuBAKOXOUdvkARIBZFMJ5+g9jg=;
        b=KKcWKCY6u14GE0vwmfIWG2r+oiQVnKtJwhtMVA6Tz13mqmpfn9BUppHEDpjW3NY/43
         KIYzVPbMIllZ9ug0KzsRHJ5PPX8yQqORuOGpHtfDDVFh35jcwE2BgoAm3t5mwMa4oGb6
         enSXU8oXJy/gRMdt7dN/WzlVfkyUtMYXXvHJpOxXTxWD8W0qtFWpVaVpgLfinGILHprm
         vXUW6AqUvKLKuUrH/f8fHIre2crohRQCipmexCl2c12LIIHfoWfrWvlVoD7GVSMKAncO
         l9nmigGARhxgtlQltVlEpxD16/jjyvX0AZqqTbWuoDyH+0hziRm+aIxl1IYrJgHc+Mwa
         a4Cg==
X-Gm-Message-State: APjAAAXj7a9ma3VI+5SrbYdU68CVsqm4kME0t3Rbhuv/zgj/dhThYQMK
        KKCYkV+K5upt7Zi/l8e8xA1nSrl0X8AL8eNSfBHQig==
X-Google-Smtp-Source: APXvYqx0VgOQnKSu2Xug35l6BWUdLvg06ZkeE2AA30kAXedGN2FJpCJud/tT+mFlsFIbw6BQNQLjACXkglcx7v8H0DQ=
X-Received: by 2002:aca:e887:: with SMTP id f129mr115563oih.156.1559546622977;
 Mon, 03 Jun 2019 00:23:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190601021526.GA8264@zhanggen-UX430UQ>
In-Reply-To: <20190601021526.GA8264@zhanggen-UX430UQ>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 3 Jun 2019 09:23:32 +0200
Message-ID: <CAFqZXNvBpmxNYjZx6YcH5Q-u4Tkwhfyzu_8VmEe8O7r9CCsvNg@mail.gmail.com>
Subject: Re: [PATCH v3] selinux: lsm: fix a missing-check bug in selinux_sb_eat_lsm_opts()
To:     Gen Zhang <blackgod016574@gmail.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, Jun 1, 2019 at 4:15 AM Gen Zhang <blackgod016574@gmail.com> wrote:
> In selinux_sb_eat_lsm_opts(), 'arg' is allocated by kmemdup_nul(). It
> returns NULL when fails. So 'arg' should be checked. And 'mnt_opts'
> should be freed when error.
>
> Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
> Reviewed-by: Ondrej Mosnacek <omosnace@redhat.com>

It looks like you're new to the kernel development community, so let
me give you a bit of friendly advice for the future :)

You don't need to repost the patch when people give you
Acked-by/Reviewed-by/Tested-by (unless there is a different reason to
respin/repost the patches). The maintainer goes over the replies when
applying the final patch and adds Acked-by/Reviewed-by/... on his/her
own.

If you *do* need to respin a path for which you have received A/R/T,
then you need to distinguish between two cases:
1. Only trivial changes to the patch (only fixed typos, edited commit
message, removed empty line, etc. - for example, v1 -> v2 of this
patch falls into this category) - in this case you can collect the
A/R/T yourself and add them to the new version. This saves the
maintainer and the reviewers from redundant work, since the patch is
still semantically the same and the A/R/T from the last version still
apply.
2. Non-trivial changes to the patch (as is the case for this patch) -
in this case your patch needs to be reviewed again and you should
disregard all A/R/T from the previous version. You can easily piss
someone off if you add their Reviewed-by to a patch they haven't
actually reviewed, so be careful ;-)

(Someone please correct me if I got it wrong - this is what I gathered
so far from my experience.)

Good luck in your future work!

> Fixes: 99dbbb593fe6 ("selinux: rewrite selinux_sb_eat_lsm_opts()")
> ---
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 3ec702c..f329fc0 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2616,6 +2616,7 @@ static int selinux_sb_eat_lsm_opts(char *options, void **mnt_opts)
>         char *from = options;
>         char *to = options;
>         bool first = true;
> +       int ret;
>
>         while (1) {
>                 int len = opt_len(from);
> @@ -2635,15 +2636,16 @@ static int selinux_sb_eat_lsm_opts(char *options, void **mnt_opts)
>                                                 *q++ = c;
>                                 }
>                                 arg = kmemdup_nul(arg, q - arg, GFP_KERNEL);
> +                               if (!arg) {
> +                                       ret = -ENOMEM;
> +                                       goto free_opt;
> +                               }
>                         }
>                         rc = selinux_add_opt(token, arg, mnt_opts);
>                         if (unlikely(rc)) {
> +                               ret = rc;
>                                 kfree(arg);
> -                               if (*mnt_opts) {
> -                                       selinux_free_mnt_opts(*mnt_opts);
> -                                       *mnt_opts = NULL;
> -                               }
> -                               return rc;
> +                               goto free_opt;
>                         }
>                 } else {
>                         if (!first) {   // copy with preceding comma
> @@ -2661,6 +2663,12 @@ static int selinux_sb_eat_lsm_opts(char *options, void **mnt_opts)
>         }
>         *to = '\0';
>         return 0;
> +free_opt:
> +       if (*mnt_opts) {
> +               selinux_free_mnt_opts(*mnt_opts);
> +               *mnt_opts = NULL;
> +       }
> +       return ret;
>  }
>
>  static int selinux_sb_remount(struct super_block *sb, void *mnt_opts)

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.
