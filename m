Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 587C3C433F5
	for <selinux@archiver.kernel.org>; Thu, 18 Nov 2021 21:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37C4061A70
	for <selinux@archiver.kernel.org>; Thu, 18 Nov 2021 21:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbhKRVVn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Nov 2021 16:21:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbhKRVVm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Nov 2021 16:21:42 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D3EC061574
        for <selinux@vger.kernel.org>; Thu, 18 Nov 2021 13:18:42 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id h16-20020a9d7990000000b0055c7ae44dd2so13266941otm.10
        for <selinux@vger.kernel.org>; Thu, 18 Nov 2021 13:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=euu56CNLPsCp5ry8gPQcm3RRzHYqfX1W/BLe3tyS4/8=;
        b=RPQ8Kg1PX/1+HSauL7pX3P2j2+QEaxRGbBEhYS5AKLtu0bDy1osEh0vL7VtXn1qilp
         sBPoDpfLXiICIzR5JdsRb8G0nAvGTEjhR3ikNDQTKAlDTBBACzQGPLzbjP/JKtcUIRWJ
         CRKqQoR9DW2poX/R2mcdtsSm2PvznLt6C/mtKJ6BHch1NJVz6nFPezTyBmBdZVqCxyWw
         5UYP7IwXb/jk3RK4ZXNhEwuYa2KgtzGInm8YOXOrSzceqUONuVags7fK6eS0rtAAj1uG
         Ih5vZrb1/3/FODKEM8LlU7qd/pj4eVD38bGajViTec5b3u01buZ19UiY+3QlqF4qsju8
         EleQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=euu56CNLPsCp5ry8gPQcm3RRzHYqfX1W/BLe3tyS4/8=;
        b=eDDE5YsMGA25kiEseHNFlrRmwgc5YJBcHkhdU2c1tUdVL7v6KheTTss0R8+XS0eqHo
         22y4ptQ5TOxKz0cphOhWdaab+rVGnURK7DJ5QzPunMvSJHu/EQgokbXpaOkPxjtFAKSS
         MKddySllVG6Af7xjd3+zqlu8UJPRBLGF9Atgi+kqWRWQrIXvioNriJToN84btZc9LCI0
         gclJw7zok4QfHl27Hi4b+OKr7YMG3jAOda8AkFq0WQvNLEfoBNDVxkZueOc/vh/0HnA0
         P3N4zqDAuVUIMD6rcAEj3oYktw6wbIeWtuH5xoaTWWcsBGXumZCiuZBS+rT+SeqHIU76
         2img==
X-Gm-Message-State: AOAM530mpAfqpXxcLYhuwLIrsFIRwvfi+cd7TFHHA+9SzYoDFIDEGqDh
        8d4jomB64o5UAdQ+vr7UcnKaZiSwvoD8y5emGAw=
X-Google-Smtp-Source: ABdhPJzYUnMTXQxYJxJ9oM9cHrKMuFbD632KQ3KtJ/Fo39xmJ5IzuITgPleWqF0+Rx1hK2A7qJvQfovR+SR7ruW8AUc=
X-Received: by 2002:a9d:6451:: with SMTP id m17mr250034otl.53.1637270321647;
 Thu, 18 Nov 2021 13:18:41 -0800 (PST)
MIME-Version: 1.0
References: <20211116151122.172831-1-plautrba@redhat.com>
In-Reply-To: <20211116151122.172831-1-plautrba@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 18 Nov 2021 16:18:30 -0500
Message-ID: <CAP+JOzSPTEwjeFbgd+pNEQS5XUbOA3uMLxs2axWL40fRV2xd2w@mail.gmail.com>
Subject: Re: [PATCH] semodule: Fix lang_ext column index
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Nov 16, 2021 at 10:12 AM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> lang_ext is 3. column - index number 2.
>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  policycoreutils/semodule/semodule.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/policycoreutils/semodule/semodule.c b/policycoreutils/semodule/semodule.c
> index ddbf10455abf..57f005ce2c62 100644
> --- a/policycoreutils/semodule/semodule.c
> +++ b/policycoreutils/semodule/semodule.c
> @@ -684,7 +684,7 @@ cleanup_extract:
>                                                 if (result != 0) goto cleanup_list;
>
>                                                 size = strlen(tmp);
> -                                               if (size > column[3]) column[3] = size;
> +                                               if (size > column[2]) column[2] = size;
>                                         }
>
>                                         /* print out each module */
> --
> 2.33.1
>
