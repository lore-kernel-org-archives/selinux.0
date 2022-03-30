Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF17FC433FE
	for <selinux@archiver.kernel.org>; Wed, 30 Mar 2022 19:06:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345876AbiC3TIc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 30 Mar 2022 15:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344730AbiC3TIc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 30 Mar 2022 15:08:32 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855DB13B
        for <selinux@vger.kernel.org>; Wed, 30 Mar 2022 12:06:46 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-de3eda6b5dso23060833fac.0
        for <selinux@vger.kernel.org>; Wed, 30 Mar 2022 12:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=ESEmyX+T5xuiJScPWDsEyGBRIbcaozjU4xz2b86iZh4=;
        b=Ilf2jkFlYxNyEATV4AxkiFI48Dsf6q6M0hf0aC8tjUyk5mwhkU9rZ6Zvr+n3db298i
         ftHViKdCG/yAAJ+fft2wgGb7LSlVJKywcT4gFKSl7dwpZJuCRXcCcLwqd6KUIIs0LD/5
         ocGC9RfyR/GnsUIqPeG7gg4sCL+obkwgNveYiOSLlW/3NCxpzehjc2NrkG/4WJkRAjpX
         2mR4qZmnAt8CYFRKhacdBmcE8WUKHvRkV9DAUoUNygGhA2cFjdeC47uEnBzK27ubnTOg
         Ku6kegZAKJjxMiP4sR5ocbEorbmnYwEJfb1np8rIXdyPj22EdUMRwpW7y4t1/DoROPFc
         E3YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=ESEmyX+T5xuiJScPWDsEyGBRIbcaozjU4xz2b86iZh4=;
        b=PXiNhwNX1klP36M0w0/2ELPeemBU4MaPn2thXLXIDZrIYlpL1YDz8PEO7KISVdkRC1
         1/5LYzU1cU0tLHS7zoXt5WK7yXxZjBq+PQBAsO/YWotSr82tlEdcQNCUewFsmpyc+Cqo
         lVbkZQFBMaFE2A6BAbQkEyhIhJgOFSi+D56cbEJ34QfheukH4FjeRlgexVIxlaFl6Ab6
         sdHb50gKx2gHGYkMXNhnvhDq+4hT9IH/DbD+ytF236oNeJOnPeAVR9jqA0NVaLzf/mXz
         +CSSIkX2RSEKR5jrKYVhbvNIS0lz+lPs8Cvs/nHuCqtrdCIunfIB03CDBe0VIbtRQxNj
         +vTw==
X-Gm-Message-State: AOAM53337MOWWHY4R2jZLF0Ccb/ujS8drmEp5hMrWNVz/dUQYoTjA/F4
        NXvVUrPgO0bfL5L0833w8ijE9Rm7vIaPdaJ/uFJJno2q
X-Google-Smtp-Source: ABdhPJy1RYSwk3jnNBihzqRfLh77bWZmNWw12Hb2+nDb6THSAU/bTDze5yPodkjzRA2AeOLPbN75OLstHCb2JTgZQXA=
X-Received: by 2002:a05:6870:5a4:b0:da:b3f:3206 with SMTP id
 m36-20020a05687005a400b000da0b3f3206mr641028oap.182.1648667205798; Wed, 30
 Mar 2022 12:06:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220316205346.260080-1-jwcart2@gmail.com>
In-Reply-To: <20220316205346.260080-1-jwcart2@gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 30 Mar 2022 15:06:35 -0400
Message-ID: <CAP+JOzTDRrv+CuuSopryjN7yTg2JhER8ePAGtgbYZWepSGjYyg@mail.gmail.com>
Subject: Re: [PATCH] libsepol: Validate conditional expressions
To:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Mar 16, 2022 at 4:53 PM James Carter <jwcart2@gmail.com> wrote:
>
> When validating a policydb, validate the conditional expressions
> including the values of the booleans within them.
>
> Found by oss-fuzz (#45523)
>
> Signed-off-by: James Carter <jwcart2@gmail.com>

Merged.
Jim

> ---
>  libsepol/src/policydb_validate.c | 43 ++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
>
> diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
> index a2dcebe4..13d9480d 100644
> --- a/libsepol/src/policydb_validate.c
> +++ b/libsepol/src/policydb_validate.c
> @@ -881,9 +881,52 @@ bad:
>         return -1;
>  }
>
> +static int validate_cond_expr(sepol_handle_t *handle, struct cond_expr *expr, validate_t *bool)
> +{
> +       int depth = -1;
> +
> +       for (; expr; expr = expr->next) {
> +               switch(expr->expr_type) {
> +               case COND_BOOL:
> +                       if (validate_value(expr->bool, bool))
> +                               goto bad;
> +                       if (depth == (COND_EXPR_MAXDEPTH - 1))
> +                               goto bad;
> +                       depth++;
> +                       break;
> +               case COND_NOT:
> +                       if (depth < 0)
> +                               goto bad;
> +                       break;
> +               case COND_OR:
> +               case COND_AND:
> +               case COND_XOR:
> +               case COND_EQ:
> +               case COND_NEQ:
> +                       if (depth < 1)
> +                               goto bad;
> +                       depth--;
> +                       break;
> +               default:
> +                       goto bad;
> +               }
> +       }
> +
> +       if (depth != 0)
> +               goto bad;
> +
> +       return 0;
> +
> +bad:
> +       ERR(handle, "Invalid cond expression");
> +       return -1;
> +}
> +
>  static int validate_cond_list(sepol_handle_t *handle, cond_list_t *cond, validate_t flavors[])
>  {
>         for (; cond; cond = cond->next) {
> +               if (validate_cond_expr(handle, cond->expr, &flavors[SYM_BOOLS]))
> +                       goto bad;
>                 if (validate_cond_av_list(handle, cond->true_list, flavors))
>                         goto bad;
>                 if (validate_cond_av_list(handle, cond->false_list, flavors))
> --
> 2.34.1
>
