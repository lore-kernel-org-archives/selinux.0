Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC85C433EF
	for <selinux@archiver.kernel.org>; Sun, 29 May 2022 18:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbiE2SWk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 29 May 2022 14:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbiE2SWk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 29 May 2022 14:22:40 -0400
Received: from mx1.polytechnique.org (mx1.polytechnique.org [129.104.30.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81EA9286D0
        for <selinux@vger.kernel.org>; Sun, 29 May 2022 11:22:37 -0700 (PDT)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 36BA056479D
        for <selinux@vger.kernel.org>; Sun, 29 May 2022 20:22:35 +0200 (CEST)
Received: by mail-pf1-f173.google.com with SMTP id b135so8704779pfb.12
        for <selinux@vger.kernel.org>; Sun, 29 May 2022 11:22:35 -0700 (PDT)
X-Gm-Message-State: AOAM532zcYJIvz834Vh6CJTvsREClMFh4X1qjF+OZK0B0kcOE6BNzFmo
        h1kXUumHLmExYvdDUB3YKn24l9xg5MXT0DguuiQ=
X-Google-Smtp-Source: ABdhPJxnwnIzwdxY0wUN8/CRAAS+lOiz2E4cdcLH9490YopD15n93QZ31yri6RqTiU7WgRnHMu1QTGV5179zKAelsP8=
X-Received: by 2002:a05:6a00:134c:b0:518:7a03:168a with SMTP id
 k12-20020a056a00134c00b005187a03168amr43695057pfu.50.1653848553866; Sun, 29
 May 2022 11:22:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220127130741.31940-1-jsegitz@suse.de>
In-Reply-To: <20220127130741.31940-1-jsegitz@suse.de>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sun, 29 May 2022 20:22:22 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=mg7ayNLhcxwWX=NoG98MiCB4stgtmtkkJ8=MNn9zZZgA@mail.gmail.com>
Message-ID: <CAJfZ7=mg7ayNLhcxwWX=NoG98MiCB4stgtmtkkJ8=MNn9zZZgA@mail.gmail.com>
Subject: Re: [PATCH] libselinux: Prevent cached context giving wrong results
To:     Johannes Segitz <jsegitz@suse.de>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun May 29 20:22:35 2022 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello,

Sorry for not answering sooner. I was busy in the past few months, and
it seems the other libselinux maintainers too.

I had some difficulty understanding what your patch was about, as I
missed its context (from
https://lore.kernel.org/selinux/20220121084012.GS7643@suse.com/ ) and
the commit message did not explain what the issue actually was. While
trying to reverse-engineer it, I found (again) the bug which is fixed.
Instead of adding "pid == 0" to some functions, I decided to
rework/simplify libselinux/src/procattr.c to fix this bug. The result
of this work was sent on the mailing list:
https://patchwork.kernel.org/project/selinux/patch/20220529180111.408899-1-nicolas.iooss@m4x.org/
. I personally prefer this simplification, but if anyone thinks this
makes it more difficult to maintain libselinux (for example), I am
open to discussion.

Best regards,
Nicolas

On Thu, Jan 27, 2022 at 2:07 PM Johannes Segitz <jsegitz@suse.de> wrote:
>
> The procattr cache doesn't work properly in all cases. This fixes the issue at
> the cost of not using the cache as soon as a pid is specified.
>
> In most use cases this will never occur, but it's still a small security issue,
> since this incorrect information might lead to incorrect access decisions.
>
> Signed-off-by: Johannes Segitz <jsegitz@suse.de>
> ---
>  libselinux/src/procattr.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/libselinux/src/procattr.c b/libselinux/src/procattr.c
> index 142fbf3a..4ca8337a 100644
> --- a/libselinux/src/procattr.c
> +++ b/libselinux/src/procattr.c
> @@ -148,7 +148,7 @@ static int getprocattrcon_raw(char ** context,
>                         return -1;
>         }
>
> -       if (prev_context && prev_context != UNSET) {
> +       if (pid == 0 && prev_context && prev_context != UNSET) {
>                 *context = strdup(prev_context);
>                 if (!(*context)) {
>                         return -1;
> @@ -242,9 +242,9 @@ static int setprocattrcon_raw(const char * context,
>                         return -1;
>         }
>
> -       if (!context && !*prev_context)
> +       if (pid == 0 && !context && !*prev_context)
>                 return 0;
> -       if (context && *prev_context && *prev_context != UNSET
> +       if (pid == 0 && context && *prev_context && *prev_context != UNSET
>             && !strcmp(context, *prev_context))
>                 return 0;
>
> @@ -272,9 +272,11 @@ out:
>                 free(context2);
>                 return -1;
>         } else {
> -               if (*prev_context != UNSET)
> -                       free(*prev_context);
> -               *prev_context = context2;
> +               if (pid == 0) {
> +                       if (*prev_context != UNSET)
> +                               free(*prev_context);
> +                       *prev_context = context2;
> +               }
>                 return 0;
>         }
>  }
> --
> 2.31.1
>

