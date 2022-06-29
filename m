Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B68C433EF
	for <selinux@archiver.kernel.org>; Wed, 29 Jun 2022 20:07:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiF2UHB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 29 Jun 2022 16:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiF2UHA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 29 Jun 2022 16:07:00 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4D23ED20
        for <selinux@vger.kernel.org>; Wed, 29 Jun 2022 13:06:59 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1013ecaf7e0so22874737fac.13
        for <selinux@vger.kernel.org>; Wed, 29 Jun 2022 13:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ofvPVr98LMoGzo+30L8Ilaua8uhQCArZB8JgkekGEGM=;
        b=ay9p5g2habAeEqfPROK6dTTi2f4ZrsMsVWsW85myyiAkakPcxcY2fxibf6nk1PHvLM
         aqjSGWURrYkg3pAYo4GzmDnTQkIaYk/EgZsNipJzdmSiN7Py4+TEsd3DKdsbybeZw78K
         HaMO9CdvQtHT6j4yw7DGNj2dZByIMBc4usIGyhRLVfQRCysE8HT7ZVtBtUe0pyNYvif0
         ncrmfDsALoJiaHVg01vkrLxhKLB2OYEmlWjRSDrDEyE+ZD8G0Z3n9jqw44rwF05mo89I
         +8+hG6LB/Sw7/izYSGYXiidnWhY/CD+UnRmbc2dnAC8KOMdi2slDQdpl4D0xUpjKIYEv
         2Pew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ofvPVr98LMoGzo+30L8Ilaua8uhQCArZB8JgkekGEGM=;
        b=6ppQ2QHRfUXgHE0HLx48qg/36ydVIW5Ypb1Y9aKrWKQ1w8NYZOwg9+cPQKfR/Ej2++
         QuANQdKuNXs7oA9O0i7Eb5ZMFSiUClD57HoIDw18hW5woMMvuPeGdaQ9mtN5FW/FB9g3
         lesCZBO6/62hTW0RM4tFpwEQ+kHca0Lw/xru3Kwgen9xFTYWmnmjEWefk1fl801g3rBd
         A5YYQbMgFGvTIyiNu6eUbRdB5hXaobXzMAiHqygjSEzekFhz9yWD7CTJZCXUQ+A4FNge
         2SN2m7VfpCW0j3y9EEceduaRPJtgq5bfO2LO4bbi94dsLQcQRBHxdMO/tauPTDw+/RR2
         Jfig==
X-Gm-Message-State: AJIora9F5x5XLsMFtS0nV2KWeOplBKiiEYWSCk5iVmjlZjCXyW2jEo2W
        ja0kR+j7oXqpxh8ELblks+Bgf/XcEJswFDD4Beio0oJ1j3o=
X-Google-Smtp-Source: AGRyM1s9NqyFKzlkxRXrNjnZrtpkE4TdQRt9+YfDmBuEblHIz/Mr7/QFTZwDtR0vesKveJOtJC8kiKuQBZukDQt8J+M=
X-Received: by 2002:a05:6870:d68e:b0:e2:861:8b15 with SMTP id
 z14-20020a056870d68e00b000e208618b15mr4336599oap.156.1656533219015; Wed, 29
 Jun 2022 13:06:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220629072055.2653695-1-nicolas.iooss@m4x.org>
In-Reply-To: <20220629072055.2653695-1-nicolas.iooss@m4x.org>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 29 Jun 2022 16:06:48 -0400
Message-ID: <CAP+JOzRXjoneNg4sQ3W9sMSneQETHqCw1yGUP1hdmXqbXXMwsQ@mail.gmail.com>
Subject: Re: [PATCH userspace 1/1] libsepol: initialize s in constraint_expr_eval_reason
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jun 29, 2022 at 3:37 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> clang's static analyzer reports that s[0] can be uninitialized when used
> in:
>
>     sprintf(tmp_buf, "%s %s\n",
>                     xcontext ? "Validatetrans" : "Constraint",
>                     s[0] ? "GRANTED" : "DENIED");
>
> Silence this false-positive issue by making s always initialized.
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/src/services.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libsepol/src/services.c b/libsepol/src/services.c
> index d7510e9dae51..db769cdcfaf9 100644
> --- a/libsepol/src/services.c
> +++ b/libsepol/src/services.c
> @@ -394,7 +394,7 @@ static int constraint_expr_eval_reason(context_struct_t *scontext,
>         role_datum_t *r1, *r2;
>         mls_level_t *l1, *l2;
>         constraint_expr_t *e;
> -       int s[CEXPR_MAXDEPTH];
> +       int s[CEXPR_MAXDEPTH] = {};
>         int sp = -1;
>         char tmp_buf[128];
>
> --
> 2.36.1
>
