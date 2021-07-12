Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9808C07E99
	for <selinux@archiver.kernel.org>; Mon, 12 Jul 2021 14:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 995EA61106
	for <selinux@archiver.kernel.org>; Mon, 12 Jul 2021 14:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234914AbhGLOjV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 12 Jul 2021 10:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234869AbhGLOjV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 12 Jul 2021 10:39:21 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15F2C0613DD
        for <selinux@vger.kernel.org>; Mon, 12 Jul 2021 07:36:31 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id w127so24662274oig.12
        for <selinux@vger.kernel.org>; Mon, 12 Jul 2021 07:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zdb6ci63l31ofYtUCTMHkxz9ZCFD/0IPl/QkYgNUtgE=;
        b=rOe6eG+8tXEY5yCdDQG9Bfsa2pelosD/Gwa9zfoyf6W93C11PA7IpOERKb/VTEhycQ
         VdYrgVg/xzDbzuXuelHdVsNG00uk48PJwFyIpMiNvSo8t/uwCdkGpQVGnmY8OPnw/W6d
         kQarC3h6D11gjRTA0PXknqj4ZNDvE+lKj9r3e4ncn3Q5w6XANV3+DoR66MQ9ypnrHSR7
         q1lCUwaGr/avdC7fcXNXG80a6VtH2w4Y3aIZCTKwgiaI58D6QHcrBU4h0VRR9a6yVV3u
         jWikjx5dlBrVomFF9BQapZTh3Ne7jY0OZgK+BZBjq9OYNNB+ME3slIIQYRoAq28UneMY
         eQ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zdb6ci63l31ofYtUCTMHkxz9ZCFD/0IPl/QkYgNUtgE=;
        b=jgcXiM0/cEh0pU/EFu8VQfLST8qlAtHckO5i7Mz2Sf80ja3WkdMtH8tNiU8M4Q5+LZ
         9xPBjP9Tq5ojyyNfEDbyopLzr2hvvHLebO80aldppfKorubBuI+k07NDV1AiiK1qPdsX
         NVejnc3bcZBE84CbliSsokYtzMaZa9xAS0BiSnEx4iXunLIbcpkd4dfo0iGO+SvgoCss
         3LtvxtcZjmf8nl7RkjIHDGFnHo81A1P7GofqtGyKmdfYYg2HvJqhxB3jZzAtzKUNzwwC
         IrwXPALG+OdT6GZ3l4WESs5jDsnw9sqcKKlvfjIKFkg2YeJpmbepE0YU8OHvjLjbwLcJ
         byJw==
X-Gm-Message-State: AOAM530+0NJzbKYPyOsrFEhPTO9wNVhy/Au/xjjJw0vtdo+5UCFv98Mb
        fpzZSGCJ1JCg9oIIfJrS9aK9ODwCKOztp9aOwo8=
X-Google-Smtp-Source: ABdhPJzgRksGbth3cxVBu0Tsg/ze+YCKbbiROQZ98QuFfxbCMUXtuSGWFCn06Gasx4xluVcsQgRgxHamEY7TpSAG7Lc=
X-Received: by 2002:aca:a887:: with SMTP id r129mr4508051oie.128.1626100591432;
 Mon, 12 Jul 2021 07:36:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210712084428.73440-1-nicolas.iooss@m4x.org>
In-Reply-To: <20210712084428.73440-1-nicolas.iooss@m4x.org>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 12 Jul 2021 10:36:20 -0400
Message-ID: <CAP+JOzR-xRuU9x4qm5Ndp-wbjgxHj2UDxwdcvkGSxTg912=snw@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: do not allow \0 in quoted strings
To:     Nicolas Iooss <nicolas.iooss@m4x.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jul 12, 2021 at 4:54 AM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> Using the '\0' character in strings in a CIL policy is not expected to
> happen, and makes the flex tokenizer very slow. For example when
> generating a file with:
>
>     python -c 'print("\"" + "\0"*100000 + "\"")' > policy.cil
>
> secilc fails after 26 seconds, on my desktop computer. Increasing the
> numbers of \0 makes this time increase significantly. But replacing \0
> with another character makes secilc fail in only few milliseconds.
>
> Fix this "possible denial of service" issue by forbidding \0 in strings
> in CIL policies.
>
> Fixes: https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=36016
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/cil/src/cil_lexer.l | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libsepol/cil/src/cil_lexer.l b/libsepol/cil/src/cil_lexer.l
> index e28c33ecb9f1..8bf2b6e7765a 100644
> --- a/libsepol/cil/src/cil_lexer.l
> +++ b/libsepol/cil/src/cil_lexer.l
> @@ -49,7 +49,7 @@ spec_char     [\[\]\.\@\=\/\*\-\_\$\%\+\-\!\|\&\^\:\~\`\#\{\}\'\<\>\?\,]
>  symbol         ({digit}|{alpha}|{spec_char})+
>  white          [ \t]
>  newline                [\n\r]
> -qstring                \"[^"\n]*\"
> +qstring                \"[^"\n\0]*\"
>  hll_lm          ^;;\*
>  comment                ;
>
> --
> 2.32.0
>
