Return-Path: <SRS0=rjXy=CC=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1523C433DF
	for <selinux@archiver.kernel.org>; Mon, 24 Aug 2020 14:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB58F20738
	for <selinux@archiver.kernel.org>; Mon, 24 Aug 2020 14:50:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hsDfT4vP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725973AbgHXOuk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 24 Aug 2020 10:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgHXOuj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 24 Aug 2020 10:50:39 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0089C061573
        for <selinux@vger.kernel.org>; Mon, 24 Aug 2020 07:50:39 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id x24so7508647otp.3
        for <selinux@vger.kernel.org>; Mon, 24 Aug 2020 07:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NWgYlMcyzTfzPYhcrOALlS1ts4UnyS9Ej4Gmp9TO3wQ=;
        b=hsDfT4vPUj0Lmz40URWSoS8m0GyU7I+VUNABr1U90c2BHTFCtjYRF+a9UtWpVQn7bc
         hIUVv+JSL4SWqLuAJdmbVGCOiv7VnhbVAvIxGksxMWhgPtNP4Cq7X8+dXs9husoQqbxn
         WJkC62fzmeVB9eGBwdWoDBCnXEvgRYwb56FcDvm3ujG2dkKGvxRQpXOPqXpw2+cM1lkQ
         UI7T9zA694DAraAKwIC2mHQ/Dbl6uAxgUDeI1HdLphTNjR+0fruxF1FBPA4b2+WVMgEL
         9nszNFlkOOWWTxmWvNfl76Y7RHtywpvZ9RnpgC0Uhfab8S7G6s3ffCQTGUsr5cKR/koN
         DovA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NWgYlMcyzTfzPYhcrOALlS1ts4UnyS9Ej4Gmp9TO3wQ=;
        b=V4nDsjquhR1KCaOVkNv5Hcz0pX7ImD46+mapAFkj5KOuPuMsbytt5vAevr+wat0BC6
         sEkjDvkh1DlmJHeYA5DVQ5dK4ezNkHGf+5MeJ9Mx4/R30alGiEO0zK49iDub6UFQofSV
         Ae9cOfDwXkPhfaoe5GqUnmi183wqZQ1WXrzB/2M2ePRNboeCl9y69za4R4kDtQVCiWQx
         0UBohKqj2z6EmgRChHUfqtFgJcXVkW4aLFxZ20vms9HolTLXWEVZ9s0HngjoIQJ3W9nX
         TJbaKuhGWxwr/nhC/4vAwWWs6FHqMVwsFHBOrjL2yyrdtZ3QkJZpu2oeNvZtoO5XAWLn
         qJxg==
X-Gm-Message-State: AOAM53375dT1jzIDlRyJwW1EechIeaxa9ZHN/VO6uQ3bWr5ht6NGGdCX
        bHSGcLoDk7FVswL3OHWtd26vnAmymObpqsogMTM=
X-Google-Smtp-Source: ABdhPJza8Uv5SqjqUFgFnvvcCxk8AZqC+KxgRWNukSBEZqpkrEnqtNXh87MAGLf2c+Gb6QDU0LeA0S64Kvmx5pePBDA=
X-Received: by 2002:a9d:25:: with SMTP id 34mr1553008ota.135.1598280639006;
 Mon, 24 Aug 2020 07:50:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200824131841.55687-1-cgzones@googlemail.com>
In-Reply-To: <20200824131841.55687-1-cgzones@googlemail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 24 Aug 2020 10:50:28 -0400
Message-ID: <CAEjxPJ6BMLeieB6cFcLm0r1TSbp9Dbu214jyCHsnGfiJuTiNyg@mail.gmail.com>
Subject: Re: [PATCH 1/3] libselinux: refactor wrapper in sestatus.c for safe
 shared memory access
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Mike Palmiotto <mike.palmiotto@crunchydata.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Aug 24, 2020 at 9:19 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  libselinux/src/sestatus.c | 35 +++++++++++------------------------
>  1 file changed, 11 insertions(+), 24 deletions(-)
>
> diff --git a/libselinux/src/sestatus.c b/libselinux/src/sestatus.c
> index 814e86ee..925e6079 100644
> --- a/libselinux/src/sestatus.c
> +++ b/libselinux/src/sestatus.c
> @@ -80,6 +80,14 @@ static inline uint32_t read_sequence(struct selinux_st=
atus_t *status)
>         return seqno;
>  }
>
> +/* sequence must not be changed during references */
> +#define sestatus_save_access(name, result)                          \
> +       uint32_t _seqno;                                            \
> +       do {                                                        \
> +               _seqno =3D read_sequence(selinux_status);             \
> +               (result) =3D selinux_status->name;                    \
> +       } while (_seqno !=3D read_sequence(selinux_status))           \

I'm not sure how much we gain from this macro versus losing in
readability of the calling code.
It should be clear at the call site that we are setting result to the
value of selinux_status->name, either by
having the macro "return" the value to the caller or passing the
address of result.
If we are going to use a macro with a local variable declaration, then
it needs to be wrapped with do { ... } while (0)
to ensure that the variable has its own scope/block.
I'm also not clear on the naming - why "save_access" - is that
supposed to be "safe_access"?
It would be nice if the trailing backslashes were aligned.
To be clear, this code is not currently thread-safe; the "safety" has
to do with getting a consistent view of the SELinux kernel status
page.

> @@ -157,13 +164,7 @@ int selinux_status_getenforce(void)
>                 return fallback_enforcing;
>         }
>
> -       /* sequence must not be changed during references */
> -       do {
> -               seqno =3D read_sequence(selinux_status);
> -
> -               enforcing =3D selinux_status->enforcing;
> -
> -       } while (seqno !=3D read_sequence(selinux_status));
> +       sestatus_save_access(enforcing, enforcing);

Someone reading the above code snippet has no idea that we just set
enforcing to selinux_status->enforcing.
