Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E516C433EF
	for <selinux@archiver.kernel.org>; Fri, 19 Nov 2021 23:00:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234551AbhKSXDq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 19 Nov 2021 18:03:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234188AbhKSXDp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 19 Nov 2021 18:03:45 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60031C06174A
        for <selinux@vger.kernel.org>; Fri, 19 Nov 2021 15:00:43 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id y12so48728184eda.12
        for <selinux@vger.kernel.org>; Fri, 19 Nov 2021 15:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=It4uFIPm/TcoK+jPH5YkeMMq3zsyxm4gO2u58vGukR0=;
        b=3pJoQe2hjfrg/7hSbzLxsod9OrFWCoaug9P7fvkrEFg0rv9ffCcPK1UzNYydItGFTZ
         8Gsmt/c334dnG4toozreaXjNphhZPsZYp2nlHPw3e/IL09S/41opYVanB2nzNO6/romw
         i1rKm54xMk9+J65ZcFGOcZQ1SLjAb01WfAXpC5IjfPdVnhpO70u2p2JsMNKHDcQdADrz
         aY47nKih2yF8knoiTAME51sXes1K6AV8Z51vQZXQFjkOEDpmKlNrruLgqJUvnP5ZmTFO
         EX6tdfLRUPCJosqeGFNBGk62gvwF20K+oZOxePAEXnDwZsit9k4eDkfGa6isnfm5eM4B
         QSvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=It4uFIPm/TcoK+jPH5YkeMMq3zsyxm4gO2u58vGukR0=;
        b=eOVWpmfKDeRR4jnjVuG6Hgfz9omFoSJodrqIxUWQT/3ROxEDpmqwXP3fDuAmLZMKMT
         0Zc2HGe37e8F+9CyPw9VAWxvjxON5+8pRrGHYQiCHQEOBeocvE51LvtMHG6nUaXLDeBG
         PBEVUhlvxJE6tg1GMYmquyp3x2P6S8Yi9JratP2QLC6ZzKHQKwPigdw0HR1SDkBxRXq1
         dmu55mBsvykcEM0Ctju1xhHM/4YS3R6p5orc+pZ/TdnqA+gRSJqVlfNumrugo8MgxDV5
         DKPLL9DIuOC9Lx6KdlwqD1PikyA855Qa+X9ChlmHH+Xls3IpWm9vGgbKU/QTGLAp1ixE
         rasQ==
X-Gm-Message-State: AOAM531nChWcuCT8WglRJEVY9SnCz74W/UAyhQ9F2Rhu0c0F7OoHHX27
        Kt86y4wnaEDIc63Gei59xZQBhHdOyFslGJzB+kZm
X-Google-Smtp-Source: ABdhPJwj8srWh1Z1Q4zO93E9LesvzJGVPu0HuTT8W9Stihxm6dQnTTI+EpjPhsnLo9c1VlkWaxAuFRFcd+EwUhAciqo=
X-Received: by 2002:a17:907:629b:: with SMTP id nd27mr12593174ejc.24.1637362841746;
 Fri, 19 Nov 2021 15:00:41 -0800 (PST)
MIME-Version: 1.0
References: <20211112180720.2858135-1-tkjos@google.com>
In-Reply-To: <20211112180720.2858135-1-tkjos@google.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 19 Nov 2021 18:00:31 -0500
Message-ID: <CAHC9VhQaHzrjdnr_DvZdPfWGiehC17yJVAJdVJMn8tOC1_Y+gA@mail.gmail.com>
Subject: Re: [PATCH] binder: fix test regression due to sender_euid change
To:     Todd Kjos <tkjos@google.com>
Cc:     gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com, christian@brauner.io, jmorris@namei.org,
        serge@hallyn.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, keescook@chromium.org, jannh@google.com,
        jeffv@google.com, zohar@linux.ibm.com,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org, kernel-team@android.com,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Nov 12, 2021 at 1:07 PM Todd Kjos <tkjos@google.com> wrote:
>
> This is a partial revert of commit
> 29bc22ac5e5b ("binder: use euid from cred instead of using task").
> Setting sender_euid using proc->cred caused some Android system test
> regressions that need further investigation. It is a partial
> reversion because subsequent patches rely on proc->cred.
>
> Cc: stable@vger.kernel.org # 4.4+
> Fixes: 29bc22ac5e5b ("binder: use euid from cred instead of using task")
> Signed-off-by: Todd Kjos <tkjos@google.com>
> Change-Id: I9b1769a3510fed250bb21859ef8beebabe034c66
> ---
> - the issue was introduced in 5.16-rc1, so please apply to 5.16
> - this should apply cleanly to all stable branches back to 4.4
>   that contain "binder: use euid from cred instead of using task"
>
>
>  drivers/android/binder.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This looks okay to me.  I assume this is going in via GregKH's tree?

Acked-by: Paul Moore <paul@paul-moore.com>

> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 49fb74196d02..cffbe57a8e08 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -2710,7 +2710,7 @@ static void binder_transaction(struct binder_proc *proc,
>                 t->from = thread;
>         else
>                 t->from = NULL;
> -       t->sender_euid = proc->cred->euid;
> +       t->sender_euid = task_euid(proc->tsk);
>         t->to_proc = target_proc;
>         t->to_thread = target_thread;
>         t->code = tr->code;
> --
> 2.34.0.rc1.387.gb447b232ab-goog

-- 
paul moore
www.paul-moore.com
