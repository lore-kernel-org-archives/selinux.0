Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A61C9C433EF
	for <selinux@archiver.kernel.org>; Thu, 27 Jan 2022 17:49:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbiA0RtE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 27 Jan 2022 12:49:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiA0RtD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 27 Jan 2022 12:49:03 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712E4C061714
        for <selinux@vger.kernel.org>; Thu, 27 Jan 2022 09:49:03 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id w14so4667710edd.10
        for <selinux@vger.kernel.org>; Thu, 27 Jan 2022 09:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=V/ELOnrC6YJQRucUSK+A6H1ABUO4PSmzCbZE8RuZrtg=;
        b=ulnGfYlHFWy8Dr2k0Bs3OSOqKPT4JaVosf56SodQFhcgQSAxiZhYSUrvxViwdVLFpI
         32CWWr7LWo8k3swRYw/9Q9nATCZr4yUssCUy5RUPd8ggFof/ehmIOjmbGAAROVqnkXZl
         aPbcQP9m/uj/CvJ/5vHP9k1pFdLuwKvnFPnvyBxSQ3u65KILV5TWz8nHK7Z43Lc7Wq9o
         MZEWCKbFthlfSQ9zoD5OK6cm+/OTnlljiOBnrSG+FQJ55DcwZgeSKOkkziigipeG/I1C
         g5VINQ5yQoBEnpQ9pjrlVZNowuHE/5eJKdzfOT1NFwmT8b+AUiXzyIczlYQ3BhfZj/ev
         XOOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=V/ELOnrC6YJQRucUSK+A6H1ABUO4PSmzCbZE8RuZrtg=;
        b=6+MVDQzcE8/5bNtOgwwNtRoDJLUlpmYCCX9rswg5cZ5N3Vu6jue/RvCnOhDIran6pC
         Am2MRyx5eiTf73AWhb0ANqDUWAqF7v4rkmg7j8lQhLi0sNxYxOcvFTjpol9B+nPg71oT
         IkWmScPapJTIIfD/EAmlGA67/Wk79BofYceyvl7lwzhd/nm90p/TmTPrzPRJ7OR5MRU3
         Voqcul7dQAc5ftThVmIAKsvZv2GI3TK/lGW/Hfl2w/HjF/JxiDIgtLhVm2bdFOoF979l
         iBUy/Z5O2yjP/BqSgYFTLhwj7gqnXw0f9eY354SjZBg6WU5B59TmbEg5BtXGO/cF/JJM
         1bYg==
X-Gm-Message-State: AOAM531Zjt5t7jglsRg+LOLokrdcsT4/038URn7GfIvcv/4LZE/VFxhB
        HQxvUSAR7Vz7r7HrtWZcR0k17m2QoxLBP+3vV/cGGbg6uQ==
X-Google-Smtp-Source: ABdhPJzMuaLC63NACXyxn6mx6o16hd8GECCujb1p3+WYPUhCgT27RM0v6keDDY+2SRfSX/whtaP7fPz+TiNv+FYgAV8=
X-Received: by 2002:a05:6402:1290:: with SMTP id w16mr4584114edv.331.1643305741542;
 Thu, 27 Jan 2022 09:49:01 -0800 (PST)
MIME-Version: 1.0
References: <164330287653.95708.5024040003451330147.stgit@olly>
In-Reply-To: <164330287653.95708.5024040003451330147.stgit@olly>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 27 Jan 2022 12:48:51 -0500
Message-ID: <CAHC9VhQ_5HfABO2sASOpdf=RaQtrQrWBQMGkvPgukCU8WHQjZQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: various sparse fixes
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jan 27, 2022 at 12:01 PM Paul Moore <paul@paul-moore.com> wrote:
>
> When running the SELinux code through sparse, there are a handful of
> warnings.  This patch resolves some of these warnings by casting away
> the "__rcu" attribute in a few core kernel function calls.
>
>  % make W=1 C=1 security/selinux/
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/selinux/hooks.c |    7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Self NACK as this is likely also a good candidate for the unrcu macro
treatment that Ondrej suggested.

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index c057896e7dcd..da04f3435268 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -2534,7 +2534,7 @@ static void selinux_bprm_committed_creds(struct linux_binprm *bprm)
>         if (rc) {
>                 clear_itimer();
>
> -               spin_lock_irq(&current->sighand->siglock);
> +               spin_lock_irq((__force spinlock_t *)&current->sighand->siglock);
>                 if (!fatal_signal_pending(current)) {
>                         flush_sigqueue(&current->pending);
>                         flush_sigqueue(&current->signal->shared_pending);
> @@ -2542,13 +2542,14 @@ static void selinux_bprm_committed_creds(struct linux_binprm *bprm)
>                         sigemptyset(&current->blocked);
>                         recalc_sigpending();
>                 }
> -               spin_unlock_irq(&current->sighand->siglock);
> +               spin_unlock_irq((__force spinlock_t *)&current->sighand->siglock);
>         }
>
>         /* Wake up the parent if it is waiting so that it can recheck
>          * wait permission to the new task SID. */
>         read_lock(&tasklist_lock);
> -       __wake_up_parent(current, current->real_parent);
> +       __wake_up_parent(current,
> +                        (__force struct task_struct *)current->real_parent);
>         read_unlock(&tasklist_lock);
>  }

-- 
paul-moore.com
