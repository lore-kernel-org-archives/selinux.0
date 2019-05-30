Return-Path: <SRS0=hg1M=T6=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1012BC28CC3
	for <selinux@archiver.kernel.org>; Thu, 30 May 2019 08:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE5FF24F53
	for <selinux@archiver.kernel.org>; Thu, 30 May 2019 08:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbfE3I2y (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 30 May 2019 04:28:54 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45640 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbfE3I2y (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 30 May 2019 04:28:54 -0400
Received: by mail-oi1-f194.google.com with SMTP id b20so721649oie.12
        for <selinux@vger.kernel.org>; Thu, 30 May 2019 01:28:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a4/V6C9EK4vY7/JLXibmWc3UiOpGTZPM0ljUbojs3aI=;
        b=hWU2NE95h0jUfjMjNDuoKbg+WeJoh3Ju0QRkj0wOkqWPpnKV6BOwqUvT7mzRKAIUXo
         Ba8jAvU9SOpUxuTk9lb11qG6wx+7DlX76bsixMUYS8qMkLEr16NDbkgGjdmH4QFJTx7D
         I6aHJMwf8LYh8J4nyS8xqnVeOQV3S7d22rm6daQkrRpyVvreAdlFW14mV2UL4bbvOsR1
         LU9L/pHtn24sUlWL5D7lqe9NYKOCQwbtj9/lxJtiH5pFYQdrdYbhnLdUF5qwhR+V/wFv
         hTF2aih+dLxJXkH3Yyibabw5bAxZiE5vj3AcICJEirll3S0VZ3+hRIWjWd1STwbmNjBj
         mBQQ==
X-Gm-Message-State: APjAAAWPgBDvyPkd2hFYCH2VxGBMLoeo3Wd5GWHgSR93Th4evJJugAjG
        fpaxAIn/OycxGB4+FLEhTztS8OLYYrr4CwAyU6LEXA==
X-Google-Smtp-Source: APXvYqz8Iw8/yjTeW0ZPob8U9xgh/OrWA3XSOSxGUsJCtkPzLy3bnytgOFnAYpOTDJoJ1VvfTiEd8WIOqAIMIBngZT4=
X-Received: by 2002:aca:e146:: with SMTP id y67mr1244852oig.127.1559204933231;
 Thu, 30 May 2019 01:28:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190530035310.GA9127@zhanggen-UX430UQ>
In-Reply-To: <20190530035310.GA9127@zhanggen-UX430UQ>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 30 May 2019 10:28:46 +0200
Message-ID: <CAFqZXNv-54DJhd8gyUhwDo6RvmjFGSHo=+s-BVsL87S+u0cQxQ@mail.gmail.com>
Subject: Re: [PATCH] hooks: fix a missing-check bug in selinux_sb_eat_lsm_opts()
To:     Gen Zhang <blackgod016574@gmail.com>
Cc:     Paul Moore <paul@paul-moore.com>, tony.luck@intel.com,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, May 30, 2019 at 5:53 AM Gen Zhang <blackgod016574@gmail.com> wrote:
> In selinux_sb_eat_lsm_opts(), 'arg' is allocated by kmemdup_nul(). It
> returns NULL when fails. So 'arg' should be checked.
>
> Signed-off-by: Gen Zhang <blackgod016574@gmail.com>

Since it looks like you are going to respin this patch, please add:

Fixes: 99dbbb593fe6 ("selinux: rewrite selinux_sb_eat_lsm_opts()")

to the commit message so that there is a record of which commit
introduced the issue (then it can be picked up automatically for
backport into the relevant stable kernels).

Thanks for spotting the issue and sending the patch(es)!

> ---
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 3ec702c..5a9e959 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2635,6 +2635,8 @@ static int selinux_sb_eat_lsm_opts(char *options, void **mnt_opts)
>                                                 *q++ = c;
>                                 }
>                                 arg = kmemdup_nul(arg, q - arg, GFP_KERNEL);
> +                               if (!arg)
> +                                       return 0;
>                         }
>                         rc = selinux_add_opt(token, arg, mnt_opts);
>                         if (unlikely(rc)) {

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.
