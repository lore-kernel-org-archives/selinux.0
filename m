Return-Path: <SRS0=8ULP=VT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD0AC76188
	for <selinux@archiver.kernel.org>; Mon, 22 Jul 2019 14:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F91121911
	for <selinux@archiver.kernel.org>; Mon, 22 Jul 2019 14:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gW9vyQD8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbfGVORz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 22 Jul 2019 10:17:55 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:39475 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728228AbfGVORz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 22 Jul 2019 10:17:55 -0400
Received: by mail-io1-f66.google.com with SMTP id f4so74252015ioh.6
        for <selinux@vger.kernel.org>; Mon, 22 Jul 2019 07:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8BgcIiKgU3cVL5c3uWuI7qgsPo43Ofan69gI+GtB8pA=;
        b=gW9vyQD8wpUE67AmtdmO61lNcDOm8C5bBDjVDcn6BwyHFIH8yaSi732bkz4H2nu2+K
         0EQKB1Eqsi2bMtqtxkY6Uqvm9FbC3KHdjMr8YWU2Q0dO14s4YHbTce11onLwHo4AkMfY
         yl+IIgyxsY6GRdnWrYZCAWCuTn9eqfkm+fD2CxNNGY7VToOg0UAD+IT95RBQ3H+H4PRq
         AYlaAXHtxknXs98faJuayVZB7UpcKc1FZ6sfp2Vz7vFXDf72PzX1oucRO0/NM4yrPteD
         mACizNGtGqbpG8m6dvzm4d6MjETaOL0ZyGQyV8xUaDMtMLLMbru0xbYgT4Eyb7xT32DO
         AWqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8BgcIiKgU3cVL5c3uWuI7qgsPo43Ofan69gI+GtB8pA=;
        b=SaiCNc7rxVBu4PIqMQZdFJGokwYw8/t845fBmk4LlzuEUpEb3CH6Llusm57ycDqx27
         u2O9mATtUnSBojBt1P6oFvVIwJgISz6tkyKzDDc+Iqp9GrVdEyZTK/BDmbm6OHspPXhj
         cFc+28D/cvwvgKvDbs7oB7sn392zAAY1VTBQcL+R2+MZkDCpQJ2pDclbf6GPga3iOs64
         1xqS+FixuZXsN0i3tvMDqfsp++KmBwDjsnBr8zSBgE+nN+oe/t1+OIswLGBe3oMt9xj/
         I+Z/sgH3FlwMg7aQ4IWW4EtbJ+V9A0aZup2+RzyezGTQpT13EokVIV0gq2l8NJbyzOnI
         PLzQ==
X-Gm-Message-State: APjAAAU8Mc5HPzlpvJSI8Kb2WbM5DAnOxx8/0lQJTzl+wthaBEAI84VG
        rmV17qATUSpZxHSiCQhFmihIEHiyjIM/fEpMIU/APIPw
X-Google-Smtp-Source: APXvYqxSU8r5SW12WAZvYzgqmo77sEVY1AxWrM0uLeeeouxYv0Rw9/ilnZOqdOmpbDCS0VjqHL/70dpc95EAtETUm4U=
X-Received: by 2002:a6b:d008:: with SMTP id x8mr62293510ioa.129.1563805074311;
 Mon, 22 Jul 2019 07:17:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190722132111.25743-1-omosnace@redhat.com>
In-Reply-To: <20190722132111.25743-1-omosnace@redhat.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Mon, 22 Jul 2019 09:17:42 -0500
Message-ID: <CAFftDdqROGAUDD3wXRC-PSjnrm29B6bfsBDn8AMPKkzJ8yJ=Hg@mail.gmail.com>
Subject: Re: [PATCH] selinux: check sidtab limit before adding a new entry
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
        NitinGote <nitin.r.gote@intel.com>,
        kernel-hardening@lists.openwall.com,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jul 22, 2019 at 8:34 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> We need to error out when trying to add an entry above SIDTAB_MAX in
> sidtab_reverse_lookup() to avoid overflow on the odd chance that this
> happens.
>
> Fixes: ee1a84fdfeed ("selinux: overhaul sidtab to fix bug and improve performance")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  security/selinux/ss/sidtab.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
> index e63a90ff2728..54c1ba1e79ab 100644
> --- a/security/selinux/ss/sidtab.c
> +++ b/security/selinux/ss/sidtab.c
> @@ -286,6 +286,11 @@ static int sidtab_reverse_lookup(struct sidtab *s, struct context *context,
>                 ++count;
>         }
>
> +       /* bail out if we already reached max entries */
> +       rc = -ENOMEM;

Wouldn't -EOVERFLOW be better?

> +       if (count == SIDTAB_MAX)
> +               goto out_unlock;
> +
>         /* insert context into new entry */
>         rc = -ENOMEM;
>         dst = sidtab_do_lookup(s, count, 1);
> --
> 2.21.0
>
