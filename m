Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C3DC25B08
	for <selinux@archiver.kernel.org>; Mon,  8 Aug 2022 15:20:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243655AbiHHPUr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 8 Aug 2022 11:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243668AbiHHPUj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 8 Aug 2022 11:20:39 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE03DF80
        for <selinux@vger.kernel.org>; Mon,  8 Aug 2022 08:20:32 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1168e046c85so1060524fac.13
        for <selinux@vger.kernel.org>; Mon, 08 Aug 2022 08:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=OmcTxkdiJKe+p8i+cxgWWF0AlVb+jvNJ8DcFvyE/BZ4=;
        b=qrnnWsOKtUySqjCcBuOw0clfJLUsYxNbGFj30KEC0XOKDIrvQNDA8mHQgJm76bvuGI
         pYPYe9IH0OyHhe6kAIrfTt3yt5kPORp5iPK+18t5958yb9Uc9S7kQimVdJupc8s06zgF
         cwTLhsLGvvg5H0WfATw5jXT7o4Z1/X5/u/5ZSZT23aC+AiofHaURUpRqJNXcBnxR/9Kg
         gijEmTCi0FT8Uil/x3/TWKfBiLHrW+xNmJ/eNXIx3BERvEZSmkAYNVsxXTqk1EKwMBc1
         zEQZm/iO3xOvpfl38zrT+sWQAu6CVsxodhHaZeH3yjen8OE8I91dmvC9xdPkyAgwGge+
         y+Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=OmcTxkdiJKe+p8i+cxgWWF0AlVb+jvNJ8DcFvyE/BZ4=;
        b=uy9hGj5wT6AU0XcuHVl9QTar0rRWNKRJM89rhVCjxSQpDd6AYVPk6NXIbH5PTNqyfh
         Lxb3JOSuLdYPC2+zhdxw8V4Ka+0RH8LqmfZbdSNDxN7GzxBd6HAu35G792fqu/JYhxms
         FM8nhmNCkkWL0gUh21kOBFIwWpJdUlW7hBWgMPhL2m2U4i/nRUYsOFGnlWUKXaeiMsD3
         CL0lKt5c0NKkcE6rZmSbJva8WWCu1URlzR7C+0TbTA5m+XGEJ1hgihZ6270vDNjlW1lw
         IIf3v30f/BHeT+y9BMvH4HF5Q5y5GdnBXH5MqS7gPMrNl5h5gHeJ22iCahOjVBOodx9D
         AiCQ==
X-Gm-Message-State: ACgBeo1JD/qqNRnIx2mGHHCAk4Qwnfvn1LVeLHjKogtbVBW0bk9bZULM
        XpziN3vYDE/divPx5+2f9epjCZl/95Ui7g/cxwxvlbv1uXw=
X-Google-Smtp-Source: AA6agR7bicmpifAx5civcJTr7FoA6bL0oZin3NitHmUEFKQ3RHun2MCgbh8qNwFVCPgvzJglpaz/qJIiEAsDp3rN7YM=
X-Received: by 2002:a05:6870:b017:b0:10c:ce5a:ac4 with SMTP id
 y23-20020a056870b01700b0010cce5a0ac4mr8600459oae.182.1659972031562; Mon, 08
 Aug 2022 08:20:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220721150515.19843-1-cgzones@googlemail.com> <20220721150515.19843-7-cgzones@googlemail.com>
In-Reply-To: <20220721150515.19843-7-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 8 Aug 2022 11:20:20 -0400
Message-ID: <CAP+JOzTp6Nao8PR7dZa98g01eYAMQM1m7RJQgi_Ok==AEfAFRQ@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] secilc: run tests against development version of libsepol
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jul 21, 2022 at 11:11 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Since secilc is dynamically linked against libsepol do not run tests
> against the system version of libsepol to support new features currently
> in development.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  secilc/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/secilc/Makefile b/secilc/Makefile
> index 94be0481..543df43b 100644
> --- a/secilc/Makefile
> +++ b/secilc/Makefile
> @@ -34,8 +34,8 @@ $(SECILC): $(SECILC_OBJS)
>         $(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LDLIBS)
>
>  test: $(SECILC)
> -       ./$(SECILC) test/policy.cil
> -       ./$(SECILC) -c $(POL_VERS) -O -M 1 -f /dev/null -o opt-actual.bin=
 test/opt-input.cil
> +       env LD_LIBRARY_PATH=3D"$(DESTDIR)/lib:$(DESTDIR)/usr/lib" ./$(SEC=
ILC) test/policy.cil
> +       env LD_LIBRARY_PATH=3D"$(DESTDIR)/lib:$(DESTDIR)/usr/lib" ./$(SEC=
ILC) -c $(POL_VERS) -O -M 1 -f /dev/null -o opt-actual.bin test/opt-input.c=
il
>         $(CHECKPOLICY) -b -C -M -o opt-actual.cil opt-actual.bin >/dev/nu=
ll
>         $(DIFF) test/opt-expected.cil opt-actual.cil
>

This assumes that LIBDIR and SHLIBDIR were not used.

The README.md file says to use the following for tests:

DESTDIR=3D~/obj ./scripts/env_use_destdir make test

and that works for secilc as well.

Jim


> --
> 2.36.1
>
