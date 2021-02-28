Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80DD6C433E9
	for <selinux@archiver.kernel.org>; Sun, 28 Feb 2021 08:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 511C664E51
	for <selinux@archiver.kernel.org>; Sun, 28 Feb 2021 08:34:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbhB1Iel (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 28 Feb 2021 03:34:41 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:35663 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbhB1Iek (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 28 Feb 2021 03:34:40 -0500
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 0D1EB564E38
        for <selinux@vger.kernel.org>; Sun, 28 Feb 2021 09:33:58 +0100 (CET)
Received: by mail-pl1-f182.google.com with SMTP id a24so7688165plm.11
        for <selinux@vger.kernel.org>; Sun, 28 Feb 2021 00:33:57 -0800 (PST)
X-Gm-Message-State: AOAM533QPXs7hV57UY20AkayJjjZvZEIhvLKMmebRmKWzeDDl75YR88q
        ee1vA0+J1Lfh6LjrybrYsfJ5BWhYPgnCc4B3rWE=
X-Google-Smtp-Source: ABdhPJzGPD3AecksQ/W8H4jafKiFHmfqr+1OfAf25BwX0Kr4myP8kk+xwytfp2TDGKSJQlmLbueXc+5ndwzUbPO99pc=
X-Received: by 2002:a17:902:c952:b029:e4:89ad:fae2 with SMTP id
 i18-20020a170902c952b02900e489adfae2mr5112987pla.14.1614501236911; Sun, 28
 Feb 2021 00:33:56 -0800 (PST)
MIME-Version: 1.0
References: <20210225104002.1333-1-lutianxiong@huawei.com> <CAP+JOzT1PPn0VoyjZgpUfJ3hrZK1gZeSK+tmvqLpmYTuD6=Wdw@mail.gmail.com>
In-Reply-To: <CAP+JOzT1PPn0VoyjZgpUfJ3hrZK1gZeSK+tmvqLpmYTuD6=Wdw@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sun, 28 Feb 2021 09:33:45 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=mo_CNgKZAsbQrPTkpqDTPao=XZRrDk6pVWp0aa1T4xNw@mail.gmail.com>
Message-ID: <CAJfZ7=mo_CNgKZAsbQrPTkpqDTPao=XZRrDk6pVWp0aa1T4xNw@mail.gmail.com>
Subject: Re: [PATCH] libsepol/cil: fix NULL pointer dereference in cil_fill_ipaddr
To:     James Carter <jwcart2@gmail.com>
Cc:     lutianxiong <lutianxiong@huawei.com>,
        SElinux list <selinux@vger.kernel.org>, jiqin.ji@huawei.com,
        liaoqingwei@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun Feb 28 09:33:58 2021 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Feb 25, 2021 at 2:55 PM James Carter <jwcart2@gmail.com> wrote:
>
> On Thu, Feb 25, 2021 at 5:44 AM lutianxiong <lutianxiong@huawei.com> wrote:
> >
> > Found a NULL pointer dereference by fuzzing, reproducing:
> >     $ echo "(nodecon(())o(e()))" > tmp.cil
> >     $ secilc tmp.cil
> >     Segmentation fault (core dumped)
> >
> > Add NULL check for addr_node->data in cil_fill_ipaddr.
> >
> > Signed-off-by: lutianxiong <lutianxiong@huawei.com>
>
> Acked-by: James Carter <jwcart2@gmail.com>

Merged. Thanks!
Nicolas

> > ---
> >  libsepol/cil/src/cil_build_ast.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
> > index 726f46c..4e53f06 100644
> > --- a/libsepol/cil/src/cil_build_ast.c
> > +++ b/libsepol/cil/src/cil_build_ast.c
> > @@ -5660,7 +5660,7 @@ int cil_fill_ipaddr(struct cil_tree_node *addr_node, struct cil_ipaddr *addr)
> >  {
> >         int rc = SEPOL_ERR;
> >
> > -       if (addr_node == NULL || addr == NULL) {
> > +       if (addr_node == NULL || addr_node->data == NULL || addr == NULL) {
> >                 goto exit;
> >         }
> >
> > --
> > 2.23.0
> >

