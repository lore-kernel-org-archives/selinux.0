Return-Path: <SRS0=N/SO=R5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F46CC43381
	for <selinux@archiver.kernel.org>; Tue, 26 Mar 2019 22:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E30AA2087E
	for <selinux@archiver.kernel.org>; Tue, 26 Mar 2019 22:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729716AbfCZWXv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 26 Mar 2019 18:23:51 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:34549 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729506AbfCZWXv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 26 Mar 2019 18:23:51 -0400
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 7CB0C56125B
        for <selinux@vger.kernel.org>; Tue, 26 Mar 2019 23:23:47 +0100 (CET)
Received: by mail-ot1-f54.google.com with SMTP id o74so13065671ota.3
        for <selinux@vger.kernel.org>; Tue, 26 Mar 2019 15:23:47 -0700 (PDT)
X-Gm-Message-State: APjAAAXtjojDMdTNR8Y4FYDLVyf7rG2MBYnjRFHbr6fwBOyTzZtRT2v2
        y4i7JL3vLPYPhOiG8nOIuj3INopFfEw3lrIqTkk=
X-Google-Smtp-Source: APXvYqzgXm/85g6P8doCiuszElDzGKboG0Vr/vTfqXADnasMHtLP0ipahg7LM95nxfafyPU3q3CyY9SYndW3DpqJM/w=
X-Received: by 2002:a05:6830:14f:: with SMTP id j15mr24122186otp.278.1553639026450;
 Tue, 26 Mar 2019 15:23:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190321100439.7130-1-bigon@debian.org> <pjdk1gsig8p.fsf@redhat.com>
In-Reply-To: <pjdk1gsig8p.fsf@redhat.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Tue, 26 Mar 2019 23:23:34 +0100
X-Gmail-Original-Message-ID: <CAJfZ7=msZeSvv0MqQ0BoNMtZxHYkztwuHTrLaOd=9hmrairGNw@mail.gmail.com>
Message-ID: <CAJfZ7=msZeSvv0MqQ0BoNMtZxHYkztwuHTrLaOd=9hmrairGNw@mail.gmail.com>
Subject: Re: [PATCH] restorecond: Do not link against libpcre
To:     Petr Lautrbach <plautrba@redhat.com>,
        Laurent Bigonville <bigon@debian.org>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Tue Mar 26 23:23:48 2019 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Mar 21, 2019 at 1:06 PM Petr Lautrbach <plautrba@redhat.com> wrote:
>
>
> Laurent Bigonville <bigon@debian.org> writes:
>
> > From: Laurent Bigonville <bigon@bigon.be>
> >
> > For some reasons, restorecond was explicitly linking against
> > libpcre but
> > the code is not using any of its symbols
> >
> > Closes: https://github.com/SELinuxProject/selinux/issues/137
> >
> > Signed-off-by: Laurent Bigonville <bigon@bigon.be>
>
> It looks likes it was accidentally added by commit
> 50f0910cf05bdc1d10710c7c3fb748a178473387 ("libselinux: add support
> for pcre2")
>
>
> Acked-by: Petr Lautrbach <plautrba@redhat.com>

Merged, Thanks.
Nicolas

> > ---
> >  restorecond/Makefile | 12 +-----------
> >  1 file changed, 1 insertion(+), 11 deletions(-)
> >
> > diff --git a/restorecond/Makefile b/restorecond/Makefile
> > index b81f8c82..12452cd2 100644
> > --- a/restorecond/Makefile
> > +++ b/restorecond/Makefile
> > @@ -19,17 +19,7 @@ DBUSLIB = $(shell $(PKG_CONFIG) --libs
> > dbus-glib-1)
> >  CFLAGS ?= -g -Werror -Wall -W
> >  override CFLAGS += $(DBUSFLAGS)
> >
> > -USE_PCRE2 ?= n
> > -ifeq ($(USE_PCRE2),y)
> > -     PCRE_CFLAGS := -DUSE_PCRE2 -DPCRE2_CODE_UNIT_WIDTH=8
> > $(shell $(PKG_CONFIG) --cflags libpcre2-8)
> > -     PCRE_LDLIBS := $(shell $(PKG_CONFIG) --libs libpcre2-8)
> > -else
> > -     PCRE_CFLAGS := $(shell $(PKG_CONFIG) --cflags libpcre)
> > -     PCRE_LDLIBS := $(shell $(PKG_CONFIG) --libs libpcre)
> > -endif
> > -export PCRE_CFLAGS PCRE_LDLIBS
> > -
> > -override LDLIBS += -lselinux $(PCRE_LDLIBS) $(DBUSLIB)
> > +override LDLIBS += -lselinux $(DBUSLIB)
> >
> >  all: restorecond
>

