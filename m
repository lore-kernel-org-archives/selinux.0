Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CEB9C43334
	for <selinux@archiver.kernel.org>; Wed, 15 Jun 2022 13:47:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353179AbiFONrX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 15 Jun 2022 09:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345430AbiFONrQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 15 Jun 2022 09:47:16 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5210638BFE
        for <selinux@vger.kernel.org>; Wed, 15 Jun 2022 06:47:05 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-100eb6f7782so16577643fac.2
        for <selinux@vger.kernel.org>; Wed, 15 Jun 2022 06:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6zP2Y1Se85dDRkVBInEnosmJWg45SGOH7/31RKpha68=;
        b=KtYmFX7tBDUXllCfce3olUeMl79zVKGWiqwrOkwd0OssnlCQ/ZbsRcOr7jMiM+zIvs
         iiOSpgwbnsVQxh1hv47kOMoKTzd9YtwUrbkb/tlCLjwdVZYRTuWFI4T0C5v354c9p7z0
         uAKZVNjU6gcwAy++NZYMqUCm2m8IghNylWOhv56tom9Pgx0gcNHEDNI5vBFZpNfJ20e0
         StmM+jrGlqG6gzrdIltRV7OiN7n+PrQTzneVIkgB/WrrlmmuH/criW8PNwMc+5JFgmZl
         kUrQeTAy0cJXaJFAR5q5vNCWRHgaujrj4ymG3froSpiC4iwRUBUBtBLI9GcCQFw/rfbb
         H4Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6zP2Y1Se85dDRkVBInEnosmJWg45SGOH7/31RKpha68=;
        b=8KOzyoOU0tmN83dRWOdFseyA790qUFsN7YBMIcb9OBq5N7M5qUi5u6TXiC106a/yEN
         0Ft2e/Wuggywg56KFs1v4jiPQnaEIf1IgtqZnQCStCs7+gRVWuvVv/Mmwy3dkMz4O1cm
         L0Qd4ZlBdFLEG2r8YWx9LutVckrg7XIXvzZNRAxj+B6QTvindyCTSHuzYqjsj6SeExM8
         rYxOi6R6jD3EIoc70brT+CTja6EkH4h+/iBWVTquWU+b8C5DxcWua/g8j/YkWQTPG/Sn
         0e8KXTZv3nau8wlRDH+bmQoE56h3kjf8k6Eqa2780NlEP+kUKVJ1ZCgitASAqQutZiz0
         9jxw==
X-Gm-Message-State: AJIora8QfTl/PC801pbfT8umbX0Lpv/wqvhvpIaxZBPYma18fTxZm9D4
        9Ehj8OwV7jlK+cTx1qMGSI7AoDDx7+9kfKAaIzXxH+ME
X-Google-Smtp-Source: AGRyM1uSD4k+Uk+twhEuR1DavsOhCfuftooLk0JmEAaGScvngjsxzQeBrLIYur63ZA8vQzp2LgmJnzvSOAWXzVL0RVI=
X-Received: by 2002:a05:6870:4604:b0:f2:5b64:fad9 with SMTP id
 z4-20020a056870460400b000f25b64fad9mr5664308oao.182.1655300824391; Wed, 15
 Jun 2022 06:47:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220607115557.492447-1-plautrba@redhat.com> <CAP+JOzTkrBTKijb2Ojes7s3JKNgNS4DhAdveSKsCez=GtOoPJg@mail.gmail.com>
In-Reply-To: <CAP+JOzTkrBTKijb2Ojes7s3JKNgNS4DhAdveSKsCez=GtOoPJg@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 15 Jun 2022 09:46:53 -0400
Message-ID: <CAP+JOzSeh-1hookq7VJWkXXu2L7Axjkh=9kjwOaUHFa8U0x9WA@mail.gmail.com>
Subject: Re: [PATCH] libsepol: Drop unused assignment
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jun 8, 2022 at 2:28 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Tue, Jun 7, 2022 at 8:55 AM Petr Lautrbach <plautrba@redhat.com> wrote:
> >
> > Fixes:
> > cil/src/cil_build_ast.c:4622:4: warning[deadcode.DeadStores]: Value stored to 'rc' is never read
> >
> > Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>
Merged.
Thanks,
Jim

> > ---
> >  libsepol/cil/src/cil_build_ast.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
> > index 26fa79069b96..4177c9f6778c 100644
> > --- a/libsepol/cil/src/cil_build_ast.c
> > +++ b/libsepol/cil/src/cil_build_ast.c
> > @@ -4619,7 +4619,6 @@ int cil_gen_genfscon(struct cil_db *db, struct cil_tree_node *parse_current, str
> >                         } else {
> >                                 cil_log(CIL_ERR, "Invalid file type \"%s\"\n", file_type);
> >                         }
> > -                       rc = SEPOL_ERR;
> >                         goto exit;
> >                 }
> >                 context_node = parse_current->next->next->next->next;
> > --
> > 2.36.1
> >
