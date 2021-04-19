Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12CDAC433B4
	for <selinux@archiver.kernel.org>; Mon, 19 Apr 2021 15:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF50E61157
	for <selinux@archiver.kernel.org>; Mon, 19 Apr 2021 15:31:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233733AbhDSPbl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 19 Apr 2021 11:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239962AbhDSPbl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 19 Apr 2021 11:31:41 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682CDC06174A
        for <selinux@vger.kernel.org>; Mon, 19 Apr 2021 08:31:10 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 92-20020a9d02e50000b029028fcc3d2c9eso10445957otl.0
        for <selinux@vger.kernel.org>; Mon, 19 Apr 2021 08:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uIHvdJPRFiu3q/C+LBVQWU4ulf5jZi0WG/YYWHjZ15Y=;
        b=ENxRazb45161v6Qoj9uGN2tPirOfBuKWqcC8QTi89WYi4FibcbT2jEDVJXLWU+meY/
         d9s+usSlcDKd2GfaMTFzGNnWm334d3VcGN4kvcomPha9NA6sFlMzfQ1z7gvahHsrl/BQ
         nlIIIkH3njh4q/XAt36M+pfRLUYC5GcxARTavbrjcLoA1WUNnQdqCXpo/tccL1hY5Zsk
         mwBkQ9dsrZnipzoFTEATvYOqHxY+hGTifo/vZCUlxNNes8iJR1HNCPDvOvtzZWJsvAqS
         6l/2AbUGOQOMzUA8J0jetTxIBe5cZkLN6/vOZXM5B3PaArAYm53DLyshg/P/c2g133Dy
         wnCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uIHvdJPRFiu3q/C+LBVQWU4ulf5jZi0WG/YYWHjZ15Y=;
        b=kB3rgDt56RK22VDBpRJf9Kb9wFISE5M1QDswWHx5r6y911J6XdCc9y6L9HOOw8E87a
         y0kTd+JKtPa+acVW2g4Xi0KvsmkaKE554Hrrcx6n/tur32R+bKxlaSAVQDHWBgu+zlDm
         Og0mWxtl1TmUygq4WQK+f275VIWqmUJIMWqQNJNxC67uU/qZLQnUKh+H9LOFRNCBmMYz
         nNFfqrm7fzfvLkf21SI1Cd6VhiV7xV8N04ljbfrND0S07qrxuiaL4hD//X/TGN2Y4u8K
         g0r2fBEM11g0uwxb3L+M03LRo5fO72AAb3BU7JGeBTHAS24bO02j0rYxjgKK7V+YEjtX
         06sw==
X-Gm-Message-State: AOAM5311oYIrFD6C1jIYtswv4us2Tp51Qg6HB9OW0R6cVlXiKxk4GyVi
        x6jHln8GHNKhH9hydSY1SfssMQNpzAnjloZK5A4fRBwPgfE=
X-Google-Smtp-Source: ABdhPJzFXolftkYjPofFcxNBDWFCCQzp2K6g/iv19mhlSEjkXz16K7AvXUntYdLBqSnYVU7vqeUC+OBqAJkH9SsFKAU=
X-Received: by 2002:a9d:aa4:: with SMTP id 33mr15361958otq.295.1618846269805;
 Mon, 19 Apr 2021 08:31:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210330174003.281613-1-jwcart2@gmail.com> <20210330174003.281613-3-jwcart2@gmail.com>
 <87fszq9ypw.fsf@redhat.com>
In-Reply-To: <87fszq9ypw.fsf@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 19 Apr 2021 11:30:58 -0400
Message-ID: <CAP+JOzRkk0GGdOM5Q=GJ8kM=cXnoYx2ys0UHT9cp9iTmstMUNg@mail.gmail.com>
Subject: Re: [PATCH 12/12] secilc/docs: Update the CIL documentation for
 various blocks
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Apr 16, 2021 at 8:54 AM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> James Carter <jwcart2@gmail.com> writes:
>
> > Update the documentation for macros, booleans, booleanifs, tunables,
> > tunableifs, blocks, blockabstracts, blockinherits, and optionals to
> > tell where these statements can be used and, for those that have
> > blocks, what statements are not allowed in them.
> >
> > Signed-off-by: James Carter <jwcart2@gmail.com>
> > ---
> >  secilc/docs/cil_call_macro_statements.md  |  2 ++
> >  secilc/docs/cil_conditional_statements.md |  6 +++++
> >  secilc/docs/cil_container_statements.md   | 28 +++++++++++++++--------
> >  3 files changed, 26 insertions(+), 10 deletions(-)
> >
> > diff --git a/secilc/docs/cil_call_macro_statements.md b/secilc/docs/cil=
_call_macro_statements.md
> > index 332eb28f..352a9fb0 100644
> > --- a/secilc/docs/cil_call_macro_statements.md
> > +++ b/secilc/docs/cil_call_macro_statements.md
> > @@ -58,6 +58,8 @@ When resolving macros the following places are checke=
d in this order:
> >
> >  -   Items defined in the global namespace
> >
> > +[`tunable`](cil_conditional_statements.md#tunable), [`in`](cil_contain=
er_statements.md#in), [`block`](cil_container_statements.md#block), [`block=
inherit`](cil_container_statements.md#blockinherit), [`blockabstract`](cil_=
container_statements.md#blockabstract), and other [`macro`](cil_call_macro_=
statements.md#macro) statements are not allowed in [`macro`](cil_call_macro=
_statements.md#macro) blocks.
> > +
> >  **Statement definition:**
> >
> >  ```secil
> > diff --git a/secilc/docs/cil_conditional_statements.md b/secilc/docs/ci=
l_conditional_statements.md
> > index a55a9b6c..d0c8e2ce 100644
> > --- a/secilc/docs/cil_conditional_statements.md
> > +++ b/secilc/docs/cil_conditional_statements.md
> > @@ -6,6 +6,8 @@ boolean
> >
> >  Declares a run time boolean as true or false in the current namespace.=
 The [`booleanif`](cil_conditional_statements.md#booleanif) statement conta=
ins the CIL code that will be in the binary policy file.
> >
> > +[`boolean`](cil_conditional_statements.md#boolean) are not allowed in =
[`booleanif`](cil_conditional_statements.md#booleanif) blocks.
> > +
> >  **Statement definition:**
> >
> >  ```secil
> > @@ -126,6 +128,8 @@ Tunables are similar to booleans, however they are =
used to manage areas of CIL s
> >
> >  Note that tunables can be treated as booleans by the CIL compiler comm=
and line parameter `-P` or `--preserve-tunables` flags.
> >
> > +Since [`tunableif`](cil_conditional_statements.md#tunableif) statement=
s are resolved first, [`tunable`](cil_conditional_statements.md#tunable) st=
atements are not allowed in [`in`](cil_container_statements.md#in), [`macro=
`](cil_call_macro_statements.md#macro), [`optional`](cil_container_statemen=
ts.md#optional), and [`booleanif`](cil_conditional_statements.md#booleanif)=
 blocks. To simplify processing, they are also not allowed in [`tunableif`]=
(cil_conditional_statements.md#tunableif) blocks.
> > +
> >  **Statement definition:**
> >
> >  ```secil
> > @@ -164,6 +168,8 @@ tunableif
> >
> >  Compile time conditional statement that may or may not add CIL stateme=
nts to be compiled.
> >
> > +If tunables are being treated as booleans (by using the CIL compiler c=
ommand line parameter `-P` or `--preserve-tunables` flag), then only the st=
atements allowed in a [`booleanif`](cil_conditional_statements.md#booleanif=
) block are allowed in a [`tunableif`](cil_conditional_statements.md#tunabl=
eif) block. Otherwise, [`tunable`](cil_conditional_statements.md#tunable) s=
tatements are not allowed in a [`tunableif`](cil_conditional_statements.md#=
tunableif) block.
> > +
> >  **Statement definition:**
> >
> >  ```secil
> > diff --git a/secilc/docs/cil_container_statements.md b/secilc/docs/cil_=
container_statements.md
> > index 76e9da51..c75c2d7c 100644
> > --- a/secilc/docs/cil_container_statements.md
> > +++ b/secilc/docs/cil_container_statements.md
> > @@ -4,7 +4,11 @@ Container Statements
> >  block
> >  -----
> >
> > -Start a new namespace where any CIL statement is valid.
> > +Start a new namespace.
> > +
> > +Not allowed in [`macro`](cil_call_macro_statements.md#macro) and [`opt=
ional`](cil_container_statements.md#optional) blocks.
> >
>
> FYI:
>
> Applying: secilc/docs: Update the CIL documentation for various blocks
> .../devel/github/SELinuxProject/selinux/master/.git/worktrees/patchwork/r=
ebase-apply/patch:62: trailing whitespace.
> Not allowed in [`macro`](cil_call_macro_statements.md#macro) and [`option=
al`](cil_container_statements.md#optional) blocks.
> warning: 1 line adds whitespace errors.
>
>
>

I'll fix this when I apply the patches.
Thanks,
Jim
