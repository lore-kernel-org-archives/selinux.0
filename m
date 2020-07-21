Return-Path: <SRS0=VL4G=BA=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A547BC433DF
	for <selinux@archiver.kernel.org>; Tue, 21 Jul 2020 06:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85BE620658
	for <selinux@archiver.kernel.org>; Tue, 21 Jul 2020 06:41:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbgGUGlo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 21 Jul 2020 02:41:44 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:38026 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbgGUGlo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 21 Jul 2020 02:41:44 -0400
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 2FF29564DE3
        for <selinux@vger.kernel.org>; Tue, 21 Jul 2020 08:36:28 +0200 (CEST)
Received: by mail-oi1-f179.google.com with SMTP id h17so16383038oie.3
        for <selinux@vger.kernel.org>; Mon, 20 Jul 2020 23:36:28 -0700 (PDT)
X-Gm-Message-State: AOAM5305hXhV01Fj6mUoaTQT8+EiUzl32Ic2nb2qswrz7hicGL+V1vMg
        1uBnu9sfpTBYlNgEYsqwS+jr9nsTUSoam75shSc=
X-Google-Smtp-Source: ABdhPJy+U2ByXSM8SW80WH0mxRP3BrBJNSYvfBp0+VybBFUqP8e42EhW+DGELpfXmfcUdUtzQoLC2kgMH9J1ElXKj3o=
X-Received: by 2002:aca:c70f:: with SMTP id x15mr2096161oif.40.1595313387317;
 Mon, 20 Jul 2020 23:36:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200716122213.454087-1-bigon@debian.org> <CAJfZ7=nZY+DFwVT9X7mJVTBG1=p3ZgR-aX4DNuK02qzVTT_g4Q@mail.gmail.com>
In-Reply-To: <CAJfZ7=nZY+DFwVT9X7mJVTBG1=p3ZgR-aX4DNuK02qzVTT_g4Q@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Tue, 21 Jul 2020 08:36:16 +0200
X-Gmail-Original-Message-ID: <CAJfZ7=m1=1Y0aH-KeoXWLjra62h_nnQ0PkcUfEyZyXk6-JQfWw@mail.gmail.com>
Message-ID: <CAJfZ7=m1=1Y0aH-KeoXWLjra62h_nnQ0PkcUfEyZyXk6-JQfWw@mail.gmail.com>
Subject: Re: [PATCH] restorecond: Set X-GNOME-HiddenUnderSystemd=true in
 restorecond.desktop file
To:     Laurent Bigonville <bigon@debian.org>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Tue Jul 21 08:36:28 2020 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sun, Jul 19, 2020 at 6:40 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> On Thu, Jul 16, 2020 at 2:28 PM Laurent Bigonville <bigon@debian.org> wrote:
> >
> > From: Laurent Bigonville <bigon@bigon.be>
> >
> > This completely inactivate the .desktop file incase the user session is
> > managed by systemd as restorecond also provide a service file
> >
> > Signed-off-by: Laurent Bigonville <bigon@bigon.be>
> > ---
> >  restorecond/restorecond.desktop | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/restorecond/restorecond.desktop b/restorecond/restorecond.desktop
> > index af728680..7df85472 100644
> > --- a/restorecond/restorecond.desktop
> > +++ b/restorecond/restorecond.desktop
> > @@ -5,3 +5,4 @@ Comment=Fix file context in owned by the user
> >  Type=Application
> >  StartupNotify=false
> >  X-GNOME-Autostart-enabled=false
> > +X-GNOME-HiddenUnderSystemd=true
> > --
> > 2.28.0.rc0
>
> I was not aware of this option, but it makes sense. Thanks!
>
> Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>
> If nobody complains, I will apply this patch tomorrow.

Applied.
Thanks,
Nicolas

