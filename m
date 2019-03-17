Return-Path: <SRS0=VGN0=RU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C625BC43381
	for <selinux@archiver.kernel.org>; Sun, 17 Mar 2019 19:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D09320896
	for <selinux@archiver.kernel.org>; Sun, 17 Mar 2019 19:11:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbfCQTLy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 17 Mar 2019 15:11:54 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:47611 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbfCQTLx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 17 Mar 2019 15:11:53 -0400
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 9523A5605F8
        for <selinux@vger.kernel.org>; Sun, 17 Mar 2019 20:11:49 +0100 (CET)
Received: by mail-ot1-f42.google.com with SMTP id g1so12577546otj.11
        for <selinux@vger.kernel.org>; Sun, 17 Mar 2019 12:11:49 -0700 (PDT)
X-Gm-Message-State: APjAAAUCdKIHQ4znA2MejaSMdG+xfjoN21fH19PjNyx2izRgOQXH3gio
        K77yOemcyQnjSY6/0a6pvVPPgj89+BjZGd18bwE=
X-Google-Smtp-Source: APXvYqxh9+QYlfq14eOEfn4QolqkB8pgvWJlGhM0Io06ftYwgStqSDeheiu1Yp7Iu3qxyXu94av/PQm9k9eiWkvtClk=
X-Received: by 2002:a9d:62c8:: with SMTP id z8mr4482448otk.144.1552849908556;
 Sun, 17 Mar 2019 12:11:48 -0700 (PDT)
MIME-Version: 1.0
References: <pjdimx5l481.fsf@redhat.com> <20190305163856.395-1-plautrba@redhat.com>
In-Reply-To: <20190305163856.395-1-plautrba@redhat.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sun, 17 Mar 2019 20:11:37 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=mqTZy7-kZq2OvEDDCAqrpdMDU97y+=wK656fVzj6dwQA@mail.gmail.com>
Message-ID: <CAJfZ7=mqTZy7-kZq2OvEDDCAqrpdMDU97y+=wK656fVzj6dwQA@mail.gmail.com>
Subject: Re: [PATCH 1/2] gui: Install polgengui.py to /usr/bin/selinux-polgengui
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun Mar 17 20:11:50 2019 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Mar 5, 2019 at 5:39 PM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> polgengui.py is a standalone gui tool which should be in /usr/bin with other
> tools.
>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

Thanks, I applied this patch.

Nicolas

> ---
>  gui/Makefile       | 2 +-
>  gui/modulesPage.py | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/gui/Makefile b/gui/Makefile
> index c2f982de..b2375fbf 100644
> --- a/gui/Makefile
> +++ b/gui/Makefile
> @@ -31,7 +31,7 @@ install: all
>         -mkdir -p $(DESTDIR)$(DATADIR)/polkit-1/actions/
>         install -m 755 system-config-selinux.py $(DESTDIR)$(SHAREDIR)
>         install -m 755 system-config-selinux $(DESTDIR)$(BINDIR)
> -       install -m 755 polgengui.py $(DESTDIR)$(SHAREDIR)
> +       install -m 755 polgengui.py $(DESTDIR)$(BINDIR)/selinux-polgengui
>         install -m 644 $(TARGETS) $(DESTDIR)$(SHAREDIR)
>         install -m 644 system-config-selinux.8 $(DESTDIR)$(MANDIR)/man8
>         install -m 644 selinux-polgengui.8 $(DESTDIR)$(MANDIR)/man8
> diff --git a/gui/modulesPage.py b/gui/modulesPage.py
> index 34c5d9e3..cb856b2d 100644
> --- a/gui/modulesPage.py
> +++ b/gui/modulesPage.py
> @@ -118,7 +118,7 @@ class modulesPage(semanagePage):
>
>      def new_module(self, args):
>          try:
> -            Popen(["/usr/share/system-config-selinux/polgengui.py"])
> +            Popen(["selinux-polgengui"])
>          except ValueError as e:
>              self.error(e.args[0])
>
> --
> 2.20.1
>

