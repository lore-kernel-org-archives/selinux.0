Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C86C433EF
	for <selinux@archiver.kernel.org>; Mon,  6 Dec 2021 03:12:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236121AbhLFDQA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 5 Dec 2021 22:16:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236053AbhLFDPy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 5 Dec 2021 22:15:54 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C1AC061354
        for <selinux@vger.kernel.org>; Sun,  5 Dec 2021 19:12:26 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id t5so37070214edd.0
        for <selinux@vger.kernel.org>; Sun, 05 Dec 2021 19:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2IyolONNkDbR7sT7twDhZs7xy7XX9+UpOdA7FHMqNRI=;
        b=iNdrtK2U9atJVlQKeX5jhr+4CBLjOdm83gqc9Ehrf2a89bTiCPn/+MeMauOGbg+Coz
         RqJTe/cjMpiLh0YGhaT3DXqlwnM39G1N2UhzvVZpTf+y3PqkYq/go/OJtxegp/0PPRmt
         zc3p9vMMk7rNA9HRgYmu/jJqbkYbMU4WzSLR7Cym59Lq9iT9Qdvg9krojubnZFzexiN4
         s8oTFKWvsjge04uU1koEl5YRsx/BUoaIUdu/TFmW0iBlEpfx0RPmYnW93EOUCq5Xy7CK
         yW/Po9oXQ1hfQu11Wjhl3hZQbYGe4nuvgg4h2d2XGXpXhGGvt37JAiRFwyfXhloC2Pb9
         e2zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2IyolONNkDbR7sT7twDhZs7xy7XX9+UpOdA7FHMqNRI=;
        b=oBVX8qGSVKMuVouD2U4gUUFonamu+J2OUumHh9+WjlFsUnlbF/NqENX+gCwNd/1Ekh
         LZ0dRORPEf9wv7atjB9H0q0KnX37DgR6hgUoTXBxoWZnsEsvkbC/81c6SbuTlvxck1D7
         2LtwhD1yR6XpdS462bSjJa0aYRoOV1gg2GZ1EIRJfV9PBuJINCsnfmLZjMQNYrRhdPCz
         9q1se+0Ynm8QwcVbxZslQ3/t1hh7NEndyNzDv9V0gaykQ0j/YkqN1WDVIQy+x2drkVsq
         cCBlycvWcUsXI7kuV6XGbIZfSGsokeI7slO3x0CPCgPEDM4uCo1dpoUJTQ7gNQLmdQA7
         Y2nA==
X-Gm-Message-State: AOAM533OTD3HV8pBDArpiPjMC/3FrSJa1Z58PCL+U+HbQd2Wf5gerlUd
        KAymj3S3tpXwtXH4T7zUVbGu2g063XPM8lyazbjI
X-Google-Smtp-Source: ABdhPJxJ7VmkTg3OwBCylZyCwHv8hxCmvxe7XYg6d5Z3vHUbOdKFsPP3tUPleTN7ObhwrjZIFbLhUfkc4kjckpV5i0w=
X-Received: by 2002:a17:907:9196:: with SMTP id bp22mr40420784ejb.69.1638760344800;
 Sun, 05 Dec 2021 19:12:24 -0800 (PST)
MIME-Version: 1.0
References: <20211202033447.253596-1-bernard@vivo.com>
In-Reply-To: <20211202033447.253596-1-bernard@vivo.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 5 Dec 2021 22:12:14 -0500
Message-ID: <CAHC9VhR0bu-D2yjGkACMNxg34qA4Y75MjVbJpr8FQc=rfLu=pg@mail.gmail.com>
Subject: Re: [PATCH] security/selinux: fix potential memleak
To:     Bernard Zhao <bernard@vivo.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Dec 1, 2021 at 10:35 PM Bernard Zhao <bernard@vivo.com> wrote:
>
> This patch try to fix potential memleak in function
> selinux_fs_context_dup`s error branch.
>
> Signed-off-by: Bernard Zhao <bernard@vivo.com>
> ---
>  security/selinux/hooks.c | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 62d30c0a30c2..36d7fc373839 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2856,24 +2856,38 @@ static int selinux_fs_context_dup(struct fs_context *fc,
>         if (src->fscontext) {
>                 opts->fscontext = kstrdup(src->fscontext, GFP_KERNEL);
>                 if (!opts->fscontext)
> -                       return -ENOMEM;
> +                       goto err_fscontext;
>         }
>         if (src->context) {
>                 opts->context = kstrdup(src->context, GFP_KERNEL);
>                 if (!opts->context)
> -                       return -ENOMEM;
> +                       goto err_context;
>         }
>         if (src->rootcontext) {
>                 opts->rootcontext = kstrdup(src->rootcontext, GFP_KERNEL);
>                 if (!opts->rootcontext)
> -                       return -ENOMEM;
> +                       goto err_rootcontext;
>         }
>         if (src->defcontext) {
>                 opts->defcontext = kstrdup(src->defcontext, GFP_KERNEL);
>                 if (!opts->defcontext)
> -                       return -ENOMEM;
> +                       goto err_defcontext;
>         }
>         return 0;
> +
> +err_defcontext:
> +       if (src->rootcontext)
> +               kfree(opts->rootcontext);
> +err_rootcontext:
> +       if (src->context)
> +               kfree(opts->context);
> +err_context:
> +       if (src->fscontext)
> +               kfree(opts->fscontext);
> +err_fscontext:
> +       kfree(fc->security);
> +
> +       return -ENOMEM;
>  }

Thanks for catching this a providing a patch, however I think the
memory cleanup can be made simpler, see the pseudo code below:

static int selinux_fs_context_dup(...)
{

  fc->security = kzalloc(...);
  if (!fc->security)
    return -ENOMEM;

  opts = fc->security;

  if (src->fscontext) {
    opts->fscontext = kstrdup(...);
    if (!opts->fscontext)
      goto err;
  }

  /* ... */

  return 0;

  err:
    kfree(opts->fscontext);
    kfree(opts->context);
    kfree(opts->rootcontext);
    kfree(opts->defcontext);
    kfree(opts);
    fc->security = NULL;
    return -ENOMEM;
}

--
paul moore
www.paul-moore.com
