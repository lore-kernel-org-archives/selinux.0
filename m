Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7DF8C433F5
	for <selinux@archiver.kernel.org>; Mon,  4 Oct 2021 13:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99F4961184
	for <selinux@archiver.kernel.org>; Mon,  4 Oct 2021 13:52:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235717AbhJDNyc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 4 Oct 2021 09:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233411AbhJDNy3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 4 Oct 2021 09:54:29 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05F9C0C0034
        for <selinux@vger.kernel.org>; Mon,  4 Oct 2021 06:36:11 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id g62-20020a9d2dc4000000b0054752cfbc59so21531641otb.1
        for <selinux@vger.kernel.org>; Mon, 04 Oct 2021 06:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NziyS/phsbh0+PYs19wLOoVcO7VfpJwZbIa6j4llFx8=;
        b=UTkQ85WIgFkD8Y4AW6eIBSg3q+4pyS7NxO10HHYL9R9prUrfOCoETkIRf4P54pn+j4
         AOaVxPboOclQM3RjhYE8bbfFPawDovMzxvxN/+liGoCJTP5vpq0ViEifCq9KkUbAvEcI
         9qJimKEJBs/+bg617HaLfElH8zBN9DgYBzF6MACMpuYGqIEjvzFxsxFCt5XG6covdQs3
         LpGZfjLAP1km1ZbRp653zTr+mP2LLthotMMPXNu0SYXgzT5RkRhZT6Q+fQwOrHNnghDX
         40fR58K9dj7Ji76joa+PbnV5fo1hloFloeKaWHn4QDpTAo8MiajV+VMXQG3BNXRJOzxF
         qHng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NziyS/phsbh0+PYs19wLOoVcO7VfpJwZbIa6j4llFx8=;
        b=T3ToGdCybPncfhvXt7xvC4xBWEUjV8up8r/cmelYN5LvYaCJogiaKAnXQVW/46tu1b
         eDLSgb4bYYWvYl+xT+ojy0AzmrJ7y2XYlpBq0f3vOWWULRx7UL+mXtUFzauSx7v/Lzgh
         uYUzDqO0UNl+NKLv8t5eorSGMKy5tE0hpMUR0sFjilhLK0L4oDxbHYwCZ1tw8lXmLsnu
         TnHdkD0WlgwZv4SwZfK0KD1syEU4/lBcBMcmRqa4BLJQRWLbNs5VbMB6YnSob2e1bbyq
         aAXhB7g7UzIIcq3e4CbVi+85TnwDT5Kb2XvT3XlvN0WloA8np7t9Tu/AfFyqGMNVHSd9
         3ydg==
X-Gm-Message-State: AOAM53232piMlBNTgpg0ctKyjY4igdDBaYYGZ+8CozIFcl+uEwTdRhE/
        ogIhHH7jkSgHYiTL3rM1wuOuc1iKuH2Vw3funJPbd6iR
X-Google-Smtp-Source: ABdhPJwWGlBr/aff/Whi3S2YvQJG60iHEJQ1cYCRJaEnx3coHzE3d5KudJIlKei3buwa6D78LLemEYm3DDsA17oDddw=
X-Received: by 2002:a9d:6399:: with SMTP id w25mr9544472otk.53.1633354571336;
 Mon, 04 Oct 2021 06:36:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210928154620.11181-1-cgzones@googlemail.com> <CAP+JOzSgGga6pG6QG1t-20vhm3B3yp9g=SrXLnXYGD36oyee4A@mail.gmail.com>
In-Reply-To: <CAP+JOzSgGga6pG6QG1t-20vhm3B3yp9g=SrXLnXYGD36oyee4A@mail.gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 4 Oct 2021 09:36:00 -0400
Message-ID: <CAP+JOzRGtDZmHQPE=WftWuJHwyzZ6dRr-XFVN0=bS1z7FHw-jw@mail.gmail.com>
Subject: Re: [PATCH 1/9] libsepol: ebitmap: mark nodes of const ebitmaps const
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Sep 30, 2021 at 3:40 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Tue, Sep 28, 2021 at 11:47 AM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> > Mark pointers to nodes of const ebitmaps also const. C does not enforce
> > a transitive const-ness, but it clarifies the intent and improves
> > maintainability.
> >
> > Follow-up of 390ec54d278a
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> For all 9 patches:
> Acked-by: James Carter <jwcart2@gmail.com>
>

All nine patches have been merged.
Thanks,
Jim

> > ---
> >  libsepol/src/ebitmap.c | 16 +++++++++-------
> >  1 file changed, 9 insertions(+), 7 deletions(-)
> >
> > diff --git a/libsepol/src/ebitmap.c b/libsepol/src/ebitmap.c
> > index 4e9acdf8..1de3816a 100644
> > --- a/libsepol/src/ebitmap.c
> > +++ b/libsepol/src/ebitmap.c
> > @@ -17,7 +17,8 @@
> >
> >  int ebitmap_or(ebitmap_t * dst, const ebitmap_t * e1, const ebitmap_t =
* e2)
> >  {
> > -       ebitmap_node_t *n1, *n2, *new, *prev;
> > +       const ebitmap_node_t *n1, *n2;
> > +       ebitmap_node_t *new, *prev;
> >
> >         ebitmap_init(dst);
> >
> > @@ -154,7 +155,7 @@ int ebitmap_hamming_distance(const ebitmap_t * e1, =
const ebitmap_t * e2)
> >
> >  int ebitmap_cmp(const ebitmap_t * e1, const ebitmap_t * e2)
> >  {
> > -       ebitmap_node_t *n1, *n2;
> > +       const ebitmap_node_t *n1, *n2;
> >
> >         if (e1->highbit !=3D e2->highbit)
> >                 return 0;
> > @@ -175,7 +176,8 @@ int ebitmap_cmp(const ebitmap_t * e1, const ebitmap=
_t * e2)
> >
> >  int ebitmap_cpy(ebitmap_t * dst, const ebitmap_t * src)
> >  {
> > -       ebitmap_node_t *n, *new, *prev;
> > +       const ebitmap_node_t *n;
> > +       ebitmap_node_t *new, *prev;
> >
> >         ebitmap_init(dst);
> >         n =3D src->node;
> > @@ -204,7 +206,7 @@ int ebitmap_cpy(ebitmap_t * dst, const ebitmap_t * =
src)
> >
> >  int ebitmap_contains(const ebitmap_t * e1, const ebitmap_t * e2)
> >  {
> > -       ebitmap_node_t *n1, *n2;
> > +       const ebitmap_node_t *n1, *n2;
> >
> >         if (e1->highbit < e2->highbit)
> >                 return 0;
> > @@ -231,8 +233,8 @@ int ebitmap_contains(const ebitmap_t * e1, const eb=
itmap_t * e2)
> >
> >  int ebitmap_match_any(const ebitmap_t *e1, const ebitmap_t *e2)
> >  {
> > -       ebitmap_node_t *n1 =3D e1->node;
> > -       ebitmap_node_t *n2 =3D e2->node;
> > +       const ebitmap_node_t *n1 =3D e1->node;
> > +       const ebitmap_node_t *n2 =3D e2->node;
> >
> >         while (n1 && n2) {
> >                 if (n1->startbit < n2->startbit) {
> > @@ -253,7 +255,7 @@ int ebitmap_match_any(const ebitmap_t *e1, const eb=
itmap_t *e2)
> >
> >  int ebitmap_get_bit(const ebitmap_t * e, unsigned int bit)
> >  {
> > -       ebitmap_node_t *n;
> > +       const ebitmap_node_t *n;
> >
> >         if (e->highbit < bit)
> >                 return 0;
> > --
> > 2.33.0
> >
