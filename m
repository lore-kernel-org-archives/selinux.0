Return-Path: <SRS0=KSUI=QR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B11C282C2
	for <selinux@archiver.kernel.org>; Sun, 10 Feb 2019 16:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB3732176F
	for <selinux@archiver.kernel.org>; Sun, 10 Feb 2019 16:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbfBJQuN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 10 Feb 2019 11:50:13 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:36101 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbfBJQuN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 10 Feb 2019 11:50:13 -0500
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id ABA97561267
        for <selinux@vger.kernel.org>; Sun, 10 Feb 2019 17:50:09 +0100 (CET)
Received: by mail-ot1-f52.google.com with SMTP id w25so13668637otm.13
        for <selinux@vger.kernel.org>; Sun, 10 Feb 2019 08:50:09 -0800 (PST)
X-Gm-Message-State: AHQUAuYpGDacKq2iYRCPuL4F8xf43ORCfuXP/jsGTIxtFp7KI2zPfMOs
        9uKVzgDPh4qNPVgrL7tHHrUhetdGcZ0vec+skRw=
X-Google-Smtp-Source: AHgI3IZbbp9h3JzmBFMyiBF+fPcTqKTR5VwC5llr+N5vWcuqKtIV0di5bzNi4ucb87Dxx2K5QTDHAV3QJ8FzDjOlmzc=
X-Received: by 2002:a9d:730c:: with SMTP id e12mr1214171otk.144.1549817408825;
 Sun, 10 Feb 2019 08:50:08 -0800 (PST)
MIME-Version: 1.0
References: <20190206194156.24804-1-plautrba@redhat.com> <CAJfZ7=nzFtrLJNE2UhS67ecN2nPy3JACt26Pqmov4fnnOHp3qA@mail.gmail.com>
In-Reply-To: <CAJfZ7=nzFtrLJNE2UhS67ecN2nPy3JACt26Pqmov4fnnOHp3qA@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sun, 10 Feb 2019 17:49:58 +0100
X-Gmail-Original-Message-ID: <CAJfZ7==exr3c+cnaJpYCa-wP1B6KmJ72t0t6Pt8CW5Y4Y9u-0g@mail.gmail.com>
Message-ID: <CAJfZ7==exr3c+cnaJpYCa-wP1B6KmJ72t0t6Pt8CW5Y4Y9u-0g@mail.gmail.com>
Subject: Re: [PATCH] gui: Make all polgen button labels translatable
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     selinux@vger.kernel.org, Vit Mojzis <vmojzis@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun Feb 10 17:50:10 2019 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Feb 7, 2019 at 10:21 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Wed, Feb 6, 2019 at 8:42 PM Petr Lautrbach <plautrba@redhat.com> wrote:
> >
> > From: Vit Mojzis <vmojzis@redhat.com>
> >
> > Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
>
> Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Merged.

Nicolas

> > ---
> >  gui/polgen.ui | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/gui/polgen.ui b/gui/polgen.ui
> > index aa4c70af..6a8c0672 100644
> > --- a/gui/polgen.ui
> > +++ b/gui/polgen.ui
> > @@ -1975,7 +1975,7 @@ Tab</property>
> >                                        <object class="GtkLabel" id="label17">
> >                                          <property name="visible">True</property>
> >                                          <property name="can_focus">False</property>
> > -                                        <property name="label">Add File</property>
> > +                                        <property name="label" translatable="yes">Add File</property>
> >                                          <property name="use_underline">True</property>
> >                                        </object>
> >                                        <packing>
> > @@ -2028,7 +2028,7 @@ Tab</property>
> >                                        <object class="GtkLabel" id="label16">
> >                                          <property name="visible">True</property>
> >                                          <property name="can_focus">False</property>
> > -                                        <property name="label">Add Directory</property>
> > +                                        <property name="label" translatable="yes">Add Directory</property>
> >                                          <property name="use_underline">True</property>
> >                                        </object>
> >                                        <packing>
> > @@ -2176,7 +2176,7 @@ Tab</property>
> >                                        <object class="GtkLabel" id="label3">
> >                                          <property name="visible">True</property>
> >                                          <property name="can_focus">False</property>
> > -                                        <property name="label">Add Boolean</property>
> > +                                        <property name="label" translatable="yes">Add Boolean</property>
> >                                          <property name="use_underline">True</property>
> >                                        </object>
> >                                        <packing>
> > --
> > 2.20.1
> >

