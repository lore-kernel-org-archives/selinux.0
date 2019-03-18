Return-Path: <SRS0=cHrg=RV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D62C43381
	for <selinux@archiver.kernel.org>; Mon, 18 Mar 2019 15:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64D7920863
	for <selinux@archiver.kernel.org>; Mon, 18 Mar 2019 15:26:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfCRP0U (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 18 Mar 2019 11:26:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50632 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726740AbfCRP0U (ORCPT <rfc822;selinux@vger.kernel.org>);
        Mon, 18 Mar 2019 11:26:20 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BCCB7307D84B
        for <selinux@vger.kernel.org>; Mon, 18 Mar 2019 15:26:19 +0000 (UTC)
Received: from localhost (ovpn-204-181.brq.redhat.com [10.40.204.181])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 606CF19C78
        for <selinux@vger.kernel.org>; Mon, 18 Mar 2019 15:26:19 +0000 (UTC)
References: <CAJfZ7==GdCtQGKNw_+Uvrhbx0=dqYfwKYMj0o-fLhUOWD+n--w@mail.gmail.com> <20190318133925.3387-1-plautrba@redhat.com>
User-agent: mu4e 1.0; emacs 26.1
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Subject: Re: [PATCH v2] gui: Install .desktop files to /usr/share/applications by default
In-reply-to: <20190318133925.3387-1-plautrba@redhat.com>
Date:   Mon, 18 Mar 2019 16:26:16 +0100
Message-ID: <pjd8sxc5hlz.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Mon, 18 Mar 2019 15:26:19 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


Petr Lautrbach <plautrba@redhat.com> writes:

> /usr/share/applications is a standard directory for .desktop 
> files.
> Installation path can be changed using DESKTOPDIR variable in 
> installation
> phase, e.g.
>
> make DESKTOPDIR=/usr/local/share/applications install
>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

Travis CI passed
https://travis-ci.org/bachradsusi/SELinuxProject-selinux/builds/507842594


> ---
>  gui/Makefile | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/gui/Makefile b/gui/Makefile
> index b2375fbf..ca965c94 100644
> --- a/gui/Makefile
> +++ b/gui/Makefile
> @@ -5,6 +5,7 @@ BINDIR ?= $(PREFIX)/bin
>  SHAREDIR ?= $(PREFIX)/share/system-config-selinux
>  DATADIR ?= $(PREFIX)/share
>  MANDIR ?= $(PREFIX)/share/man
> +DESKTOPDIR ?= $(PREFIX)/share/applications
>  
>  TARGETS= \
>  booleansPage.py \
> @@ -29,6 +30,7 @@ install: all
>  	-mkdir -p $(DESTDIR)$(DATADIR)/pixmaps
>  	-mkdir -p $(DESTDIR)$(DATADIR)/icons/hicolor/24x24/apps
>  	-mkdir -p $(DESTDIR)$(DATADIR)/polkit-1/actions/
> +	-mkdir -p $(DESTDIR)$(DESKTOPDIR)
>  	install -m 755 system-config-selinux.py 
>  $(DESTDIR)$(SHAREDIR)
>  	install -m 755 system-config-selinux $(DESTDIR)$(BINDIR)
>  	install -m 755 polgengui.py 
>  $(DESTDIR)$(BINDIR)/selinux-polgengui
> @@ -44,7 +46,7 @@ install: all
>  	install -m 644 system-config-selinux.png 
>  $(DESTDIR)$(DATADIR)/pixmaps
>  	install -m 644 system-config-selinux.png 
>  $(DESTDIR)$(DATADIR)/icons/hicolor/24x24/apps
>  	install -m 644 system-config-selinux.png 
>  $(DESTDIR)$(DATADIR)/system-config-selinux
> -	install -m 644 *.desktop 
> $(DESTDIR)$(DATADIR)/system-config-selinux
> +	install -m 644 *.desktop $(DESTDIR)$(DESKTOPDIR)
>  	-mkdir -p $(DESTDIR)$(DATADIR)/pixmaps
>  	install -m 644 sepolicy_256.png 
>  $(DESTDIR)$(DATADIR)/pixmaps/sepolicy.png
>  	for i in 16 22 32 48 256; do \

