Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153DFC433F5
	for <selinux@archiver.kernel.org>; Tue,  1 Feb 2022 20:10:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbiBAUKG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 1 Feb 2022 15:10:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237714AbiBAUKG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 1 Feb 2022 15:10:06 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B7BC06173D
        for <selinux@vger.kernel.org>; Tue,  1 Feb 2022 12:10:06 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id w25so35924942edt.7
        for <selinux@vger.kernel.org>; Tue, 01 Feb 2022 12:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sFUSweAG1xqhzQLZf+qgHtmVMyG+ZwNZxELpOo7tJ7Y=;
        b=CuUvvIsTnO5K5mWWbYYmYYXege1CBgtanGtwEfBdyx7IDiadCxdZRbJ3kkvt3/w1rp
         09/Lr0wBt1eqUr45j9XsfBW6SAH1YALzgAQISJ62txmRPEnV3YLmNreJF9SaQ3+clrVe
         gF0T+NyP7E7+QMauL9Y/2EyITmo5IpWj3msatcJzANo+tvM+mMSDHmyAVtZKxAOjaL6B
         I66CbZWYpZ/kcP9nxbL4oFAC2NLgzpuDHNwhPQKdAlJiBCSWofLDzP13MSRpJPYHjtmt
         uuM2WV36BoMaiTBLe6JvuqqI45nhtQtDyUk9qBLYz/M7dTyJ+guR1MgzJ2mMxlyeitsG
         z6rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sFUSweAG1xqhzQLZf+qgHtmVMyG+ZwNZxELpOo7tJ7Y=;
        b=mH+gPWzHB9/plWMhczqGQoTkg9MORzniUnTB/OyegTvuejZFBdwGj+90nU+q42WEsD
         07Ua/NtUoUmJFLUHPZIcwjhg60K2P9awu2+IC4DMEtUM/eEpO/IroNrOc/dcNq8lD3i1
         SQWFGQDVWiyS8dDChqSwgcxMBugkRPEM/hSB+7MrC7FIp2ZFiQa9Fmnu5DufB8zrWBN9
         NmZoVuiHs752z2/KeUYkBTyskoZr1n3IB/C44Am48gFTRLfVp8JZCJ63mqJIW/D+B7jQ
         n1xHUJnXc/lumF82F6kiU7gQUwrKfkudPPq2JzpmX7N8pdksMOw9g12PPYCuHEa6sVRZ
         RAjA==
X-Gm-Message-State: AOAM531hImS84UkANqfjXVEFUnjgxz/rBKB6Bw+//Joti5E/wkhtT4oU
        BfAEqRRMXTcQFyWrThZ5ArO/UUwW/DTWqWSktiz7
X-Google-Smtp-Source: ABdhPJwMt3ROWjFbgsVgFHnPMASy0Jm2iEtG5+43QwWyA2Em39TLV2pHLZdwaOmcYahMWv2KUec141fZPR7IaSvFlko=
X-Received: by 2002:a05:6402:345:: with SMTP id r5mr27432331edw.269.1643746204648;
 Tue, 01 Feb 2022 12:10:04 -0800 (PST)
MIME-Version: 1.0
References: <20220128202858.96935-1-vbendel@redhat.com> <20220128202858.96935-4-vbendel@redhat.com>
In-Reply-To: <20220128202858.96935-4-vbendel@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 1 Feb 2022 15:09:53 -0500
Message-ID: <CAHC9VhRXFf22+2wjxT6KAbVC2R6FVZ6m1i7EFGTbm1icWdr_vw@mail.gmail.com>
Subject: Re: [PATCH 3/3] selinux: remove duplicate cond_list clean up calls
To:     vbendel@redhat.com
Cc:     stephen.smalley.work@gmail.com, eparis@parisplace.org,
        omosnace@redhat.com, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jan 28, 2022 at 3:29 PM <vbendel@redhat.com> wrote:
> From: Vratislav Bendel <vbendel@redhat.com>
>
> On error path from cond_read_list() and duplicate_policydb_cond_list()
> the *_destroy() functions get called a second time in caller functions.
> Remove the first calls and let the callers clean it.
>
> Suggested-by: Ondrej Mosnacek <omosnace@redhat.com>
> Signed-off-by: Vratislav Bendel <vbendel@redhat.com>
> ---
>  security/selinux/ss/conditional.c | 20 ++++++--------------
>  1 file changed, 6 insertions(+), 14 deletions(-)
>
> diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
> index 8bc16ad3af9e..c333daaeceab 100644
> --- a/security/selinux/ss/conditional.c
> +++ b/security/selinux/ss/conditional.c
> @@ -432,19 +432,16 @@ int cond_read_list(struct policydb *p, void *fp)
>
>         rc = avtab_alloc(&(p->te_cond_avtab), p->te_avtab.nel);
>         if (rc)
> -               goto err;
> +               return rc;
>
>         p->cond_list_len = len;
>
>         for (i = 0; i < len; i++) {
>                 rc = cond_read_node(p, &p->cond_list[i], fp);
>                 if (rc)
> -                       goto err;
> +                       return rc;
>         }
>         return 0;
> -err:
> -       cond_list_destroy(p);
> -       return rc;
>  }

I tend to prefer functions that cleanup their own allocations on
error.  It makes it easier and quicker to reason about a function's
error handling.  I recognize in this case it may mean multiple calls
to cond_list_destroy(), but that should be safe (considering the
previous patches in this series), and we are on the error path anyway
so I'm not as worried about a few extra instructions.

-- 
paul-moore.com
