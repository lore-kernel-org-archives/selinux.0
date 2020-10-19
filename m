Return-Path: <SRS0=fPvm=D2=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URI_HEX autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF51C433E7
	for <selinux@archiver.kernel.org>; Mon, 19 Oct 2020 21:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 231FC2236F
	for <selinux@archiver.kernel.org>; Mon, 19 Oct 2020 21:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733260AbgJSViB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 19 Oct 2020 17:38:01 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:39211 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733259AbgJSViB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 19 Oct 2020 17:38:01 -0400
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id BD91C564C53
        for <selinux@vger.kernel.org>; Mon, 19 Oct 2020 23:29:37 +0200 (CEST)
Received: by mail-oo1-f50.google.com with SMTP id j6so317323oot.3
        for <selinux@vger.kernel.org>; Mon, 19 Oct 2020 14:29:37 -0700 (PDT)
X-Gm-Message-State: AOAM533toqAFfCEeLKiHks2nthdZFTqKSdlqYRlkIOrA3RjynfGaoqPk
        87mJIBScrsumA+2yBTd9EBfn2+qWTbSewB4SVDI=
X-Google-Smtp-Source: ABdhPJwzzwzDBb187vqD3JX+qAkB1VmVz+wW2g1Z2pRa3yPLqY8aK7afF8JsKSzaMXbX5HNKRK3eSw3xZ2hRkrXybZE=
X-Received: by 2002:a4a:b34a:: with SMTP id n10mr1411521ooo.46.1603142976862;
 Mon, 19 Oct 2020 14:29:36 -0700 (PDT)
MIME-Version: 1.0
References: <20201003193957.1876526-1-nicolas.iooss@m4x.org>
 <20201003193957.1876526-2-nicolas.iooss@m4x.org> <CAP+JOzTfHeF7DTEsubhC3Lhyvrj2S_TX-3rOUD7dtHa=zsoQdQ@mail.gmail.com>
In-Reply-To: <CAP+JOzTfHeF7DTEsubhC3Lhyvrj2S_TX-3rOUD7dtHa=zsoQdQ@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Mon, 19 Oct 2020 23:29:25 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=kecqLgQZ3N_XSrAn_AOiYgAQ6cfpSLcgt4=PjdFKYh1A@mail.gmail.com>
Message-ID: <CAJfZ7=kecqLgQZ3N_XSrAn_AOiYgAQ6cfpSLcgt4=PjdFKYh1A@mail.gmail.com>
Subject: Re: [PATCH 2/2] libsepol: silence potential NULL pointer dereference warning
To:     James Carter <jwcart2@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Mon Oct 19 23:29:38 2020 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Oct 15, 2020 at 7:00 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Sat, Oct 3, 2020 at 3:41 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> >
> > When find_avtab_node() is called with key->specified & AVTAB_XPERMS and
> > xperms=NULL, xperms is being dereferenced. This is detected as a
> > "NULL pointer dereference issue" by static analyzers.
> >
> > Even though it does not make much sense to call find_avtab_node() in a
> > way which triggers the NULL pointer dereference issue, static analyzers
> > have a hard time with calls such as:
> >
> >     node = find_avtab_node(handle, avtab, &avkey, cond, NULL);
> >
> > ... where xperms=NULL.
> >
> > So, make the function report an error instead of crashing.
> >
> > Here is an example of report from clang's static analyzer:
> > https://558-118970575-gh.circle-artifacts.com/0/output-scan-build/2020-10-02-065849-6375-1/report-d86a57.html#EndPath
> >
> > Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>
> Acked-by: James Carter <jwcart2@gmail.com>

Thanks. Merged.

Nicolas

> > ---
> >  libsepol/src/expand.c | 23 ++++++++++++++---------
> >  1 file changed, 14 insertions(+), 9 deletions(-)
> >
> > diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
> > index 19e48c507236..eac7e4507d02 100644
> > --- a/libsepol/src/expand.c
> > +++ b/libsepol/src/expand.c
> > @@ -1570,17 +1570,22 @@ static avtab_ptr_t find_avtab_node(sepol_handle_t * handle,
> >
> >         /* AVTAB_XPERMS entries are not necessarily unique */
> >         if (key->specified & AVTAB_XPERMS) {
> > -               node = avtab_search_node(avtab, key);
> > -               while (node) {
> > -                       if ((node->datum.xperms->specified == xperms->specified) &&
> > -                               (node->datum.xperms->driver == xperms->driver)) {
> > -                               match = 1;
> > -                               break;
> > +               if (xperms == NULL) {
> > +                       ERR(handle, "searching xperms NULL");
> > +                       node = NULL;
> > +               } else {
> > +                       node = avtab_search_node(avtab, key);
> > +                       while (node) {
> > +                               if ((node->datum.xperms->specified == xperms->specified) &&
> > +                                       (node->datum.xperms->driver == xperms->driver)) {
> > +                                       match = 1;
> > +                                       break;
> > +                               }
> > +                               node = avtab_search_node_next(node, key->specified);
> >                         }
> > -                       node = avtab_search_node_next(node, key->specified);
> > +                       if (!match)
> > +                               node = NULL;
> >                 }
> > -               if (!match)
> > -                       node = NULL;
> >         } else {
> >                 node = avtab_search_node(avtab, key);
> >         }
> > --
> > 2.28.0
> >

