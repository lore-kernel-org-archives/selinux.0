Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9103EC04A6A
	for <selinux@archiver.kernel.org>; Tue, 15 Aug 2023 07:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235386AbjHOHww (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 15 Aug 2023 03:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235448AbjHOHwX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 15 Aug 2023 03:52:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A731BEA
        for <selinux@vger.kernel.org>; Tue, 15 Aug 2023 00:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692085888;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+fFSVGthJCkm/froVQeFnSbc1Pb9pMw5obnm7ku1U0o=;
        b=fZglzHLVyElmX/snr5zH2G0EkFt9/5nXEDfELca3ZNJnoZueTGUVPLvw9P3FBMDLNAazY6
        voa93O1Do5W9ej77DMtqimVuM1JOWGY/2ICJpUy+1vUl9QV8fEsV1nE88nkqYCtggFwYwM
        ir2O/mo+SK6/w1kKkZT5EBbw60x0QEw=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-513-tBjCi3IGOPaeICE5j2__JA-1; Tue, 15 Aug 2023 03:51:24 -0400
X-MC-Unique: tBjCi3IGOPaeICE5j2__JA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0A3A73C0E444;
        Tue, 15 Aug 2023 07:51:24 +0000 (UTC)
Received: from localhost (unknown [10.45.226.154])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BF73663F6D;
        Tue, 15 Aug 2023 07:51:23 +0000 (UTC)
From:   Petr Lautrbach <lautrbach@redhat.com>
To:     James Carter <jwcart2@gmail.com>, selinux@vger.kernel.org
Subject: Re: [PATCH] Do not automatically install Russian translations
In-Reply-To: <20230814142516.505390-1-jwcart2@gmail.com>
References: <20230814142516.505390-1-jwcart2@gmail.com>
Date:   Tue, 15 Aug 2023 09:51:23 +0200
Message-ID: <87pm3obv5w.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

James Carter <jwcart2@gmail.com> writes:

> Since they are being removed, there will be nothing to install.
>
> Suggested-by: Petr Lautrbach <plautrba@redhat.com>
> Signed-off-by: James Carter <jwcart2@gmail.com>

Acked-by: Petr Lautrbach <lautrbach@redhat.com>

Thanks!


> ---
>  checkpolicy/Makefile                     | 2 +-
>  gui/Makefile                             | 2 +-
>  libselinux/man/Makefile                  | 2 +-
>  libsemanage/man/Makefile                 | 2 +-
>  libsepol/man/Makefile                    | 2 +-
>  mcstrans/man/Makefile                    | 2 +-
>  policycoreutils/load_policy/Makefile     | 2 +-
>  policycoreutils/man/Makefile             | 2 +-
>  policycoreutils/newrole/Makefile         | 2 +-
>  policycoreutils/run_init/Makefile        | 2 +-
>  policycoreutils/scripts/Makefile         | 2 +-
>  policycoreutils/secon/Makefile           | 2 +-
>  policycoreutils/semodule/Makefile        | 2 +-
>  policycoreutils/sestatus/Makefile        | 2 +-
>  policycoreutils/setfiles/Makefile        | 2 +-
>  policycoreutils/setsebool/Makefile       | 2 +-
>  python/audit2allow/Makefile              | 2 +-
>  python/chcat/Makefile                    | 2 +-
>  python/semanage/Makefile                 | 2 +-
>  python/sepolicy/Makefile                 | 2 +-
>  restorecond/Makefile                     | 2 +-
>  sandbox/Makefile                         | 2 +-
>  semodule-utils/semodule_expand/Makefile  | 2 +-
>  semodule-utils/semodule_link/Makefile    | 2 +-
>  semodule-utils/semodule_package/Makefile | 2 +-
>  25 files changed, 25 insertions(+), 25 deletions(-)
>
> diff --git a/checkpolicy/Makefile b/checkpolicy/Makefile
> index f9e1fc7c..c37e0310 100644
> --- a/checkpolicy/Makefile
> +++ b/checkpolicy/Makefile
> @@ -1,7 +1,7 @@
>  #
>  # Makefile for building the checkpolicy program
>  #
> -LINGUAS ?= ru
> +LINGUAS ?=
>  PREFIX ?= /usr
>  BINDIR ?= $(PREFIX)/bin
>  MANDIR ?= $(PREFIX)/share/man
> diff --git a/gui/Makefile b/gui/Makefile
> index 4035fb21..b29610d4 100644
> --- a/gui/Makefile
> +++ b/gui/Makefile
> @@ -1,5 +1,5 @@
>  # Installation directories.
> -LINGUAS ?= ru
> +LINGUAS ?=
>  PREFIX ?= /usr
>  BINDIR ?= $(PREFIX)/bin
>  SHAREDIR ?= $(PREFIX)/share/system-config-selinux
> diff --git a/libselinux/man/Makefile b/libselinux/man/Makefile
> index 4b3626d2..fdc0825f 100644
> --- a/libselinux/man/Makefile
> +++ b/libselinux/man/Makefile
> @@ -1,5 +1,5 @@
>  # Installation directories.
> -LINGUAS ?= ru
> +LINGUAS ?=
>  PREFIX	?= /usr
>  MANDIR ?=  $(PREFIX)/share/man
>  MAN3SUBDIR ?= man3
> diff --git a/libsemanage/man/Makefile b/libsemanage/man/Makefile
> index f626447d..5e21a65e 100644
> --- a/libsemanage/man/Makefile
> +++ b/libsemanage/man/Makefile
> @@ -1,5 +1,5 @@
>  # Installation directories.
> -LINGUAS ?= ru
> +LINGUAS ?=
>  PREFIX ?= /usr
>  MANDIR ?=  $(PREFIX)/share/man
>  MAN3SUBDIR ?= man3
> diff --git a/libsepol/man/Makefile b/libsepol/man/Makefile
> index f54e478d..0b410c19 100644
> --- a/libsepol/man/Makefile
> +++ b/libsepol/man/Makefile
> @@ -1,5 +1,5 @@
>  # Installation directories.
> -LINGUAS ?= ru
> +LINGUAS ?=
>  PREFIX ?= /usr
>  MANDIR ?=  $(PREFIX)/share/man
>  MAN3SUBDIR ?= man3
> diff --git a/mcstrans/man/Makefile b/mcstrans/man/Makefile
> index 71713818..895a592d 100644
> --- a/mcstrans/man/Makefile
> +++ b/mcstrans/man/Makefile
> @@ -1,5 +1,5 @@
>  # Installation directories.
> -LINGUAS ?= ru
> +LINGUAS ?=
>  PREFIX ?= /usr
>  MANDIR ?=  $(PREFIX)/share/man
>  MAN5SUBDIR ?= man5
> diff --git a/policycoreutils/load_policy/Makefile b/policycoreutils/load_policy/Makefile
> index c1ba805b..ad80d500 100644
> --- a/policycoreutils/load_policy/Makefile
> +++ b/policycoreutils/load_policy/Makefile
> @@ -1,5 +1,5 @@
>  # Installation directories.
> -LINGUAS ?= ru
> +LINGUAS ?=
>  PREFIX ?= /usr
>  SBINDIR ?= $(PREFIX)/sbin
>  MANDIR ?= $(PREFIX)/share/man
> diff --git a/policycoreutils/man/Makefile b/policycoreutils/man/Makefile
> index 94bbf586..a4539f24 100644
> --- a/policycoreutils/man/Makefile
> +++ b/policycoreutils/man/Makefile
> @@ -1,5 +1,5 @@
>  # Installation directories.
> -LINGUAS ?= ru
> +LINGUAS ?=
>  PREFIX ?= /usr
>  MANDIR ?= $(PREFIX)/share/man
>  MAN5DIR ?= $(MANDIR)/man5
> diff --git a/policycoreutils/newrole/Makefile b/policycoreutils/newrole/Makefile
> index b3ccf671..4b8145d3 100644
> --- a/policycoreutils/newrole/Makefile
> +++ b/policycoreutils/newrole/Makefile
> @@ -1,5 +1,5 @@
>  # Installation directories.
> -LINGUAS ?= ru
> +LINGUAS ?=
>  PREFIX ?= /usr
>  BINDIR ?= $(PREFIX)/bin
>  MANDIR ?= $(PREFIX)/share/man
> diff --git a/policycoreutils/run_init/Makefile b/policycoreutils/run_init/Makefile
> index e86364a4..619ebc1d 100644
> --- a/policycoreutils/run_init/Makefile
> +++ b/policycoreutils/run_init/Makefile
> @@ -1,6 +1,6 @@
>  
>  # Installation directories.
> -LINGUAS ?= ru
> +LINGUAS ?=
>  PREFIX ?= /usr
>  SBINDIR ?= $(PREFIX)/sbin
>  MANDIR ?= $(PREFIX)/share/man
> diff --git a/policycoreutils/scripts/Makefile b/policycoreutils/scripts/Makefile
> index 75e75b80..6d8196c6 100644
> --- a/policycoreutils/scripts/Makefile
> +++ b/policycoreutils/scripts/Makefile
> @@ -1,5 +1,5 @@
>  # Installation directories.
> -LINGUAS ?= ru
> +LINGUAS ?=
>  PREFIX ?= /usr
>  SBINDIR ?= $(PREFIX)/sbin
>  MANDIR ?= $(PREFIX)/share/man
> diff --git a/policycoreutils/secon/Makefile b/policycoreutils/secon/Makefile
> index 576a6203..440503a1 100644
> --- a/policycoreutils/secon/Makefile
> +++ b/policycoreutils/secon/Makefile
> @@ -1,5 +1,5 @@
>  # secon tool - command-line context
> -LINGUAS ?= ru
> +LINGUAS ?=
>  PREFIX ?= /usr
>  BINDIR ?= $(PREFIX)/bin
>  MANDIR ?= $(PREFIX)/share/man
> diff --git a/policycoreutils/semodule/Makefile b/policycoreutils/semodule/Makefile
> index 73801e48..9fbf99d6 100644
> --- a/policycoreutils/semodule/Makefile
> +++ b/policycoreutils/semodule/Makefile
> @@ -1,5 +1,5 @@
>  # Installation directories.
> -LINGUAS ?= ru
> +LINGUAS ?=
>  PREFIX ?= /usr
>  SBINDIR ?= $(PREFIX)/sbin
>  MANDIR = $(PREFIX)/share/man
> diff --git a/policycoreutils/sestatus/Makefile b/policycoreutils/sestatus/Makefile
> index 3dbb792b..aebf050c 100644
> --- a/policycoreutils/sestatus/Makefile
> +++ b/policycoreutils/sestatus/Makefile
> @@ -1,5 +1,5 @@
>  # Installation directories.
> -LINGUAS ?= ru
> +LINGUAS ?=
>  PREFIX ?= /usr
>  BINDIR ?= $(PREFIX)/bin
>  SBINDIR ?= $(PREFIX)/sbin
> diff --git a/policycoreutils/setfiles/Makefile b/policycoreutils/setfiles/Makefile
> index d7670a8f..84ffb08b 100644
> --- a/policycoreutils/setfiles/Makefile
> +++ b/policycoreutils/setfiles/Makefile
> @@ -1,5 +1,5 @@
>  # Installation directories.
> -LINGUAS ?= ru
> +LINGUAS ?=
>  PREFIX ?= /usr
>  SBINDIR ?= /sbin
>  MANDIR = $(PREFIX)/share/man
> diff --git a/policycoreutils/setsebool/Makefile b/policycoreutils/setsebool/Makefile
> index c1440c1c..fc5b4ff6 100644
> --- a/policycoreutils/setsebool/Makefile
> +++ b/policycoreutils/setsebool/Makefile
> @@ -1,5 +1,5 @@
>  # Installation directories.
> -LINGUAS ?= ru
> +LINGUAS ?=
>  PREFIX ?= /usr
>  SBINDIR ?= $(PREFIX)/sbin
>  MANDIR = $(PREFIX)/share/man
> diff --git a/python/audit2allow/Makefile b/python/audit2allow/Makefile
> index 76bf4e37..fb04b8bd 100644
> --- a/python/audit2allow/Makefile
> +++ b/python/audit2allow/Makefile
> @@ -2,7 +2,7 @@ PYTHON ?= python3
>  SECILC ?= secilc
>  
>  # Installation directories.
> -LINGUAS ?= ru
> +LINGUAS ?=
>  PREFIX ?= /usr
>  BINDIR ?= $(PREFIX)/bin
>  MANDIR ?= $(PREFIX)/share/man
> diff --git a/python/chcat/Makefile b/python/chcat/Makefile
> index e4873bf4..7b3ee17f 100644
> --- a/python/chcat/Makefile
> +++ b/python/chcat/Makefile
> @@ -1,5 +1,5 @@
>  # Installation directories.
> -LINGUAS ?= ru
> +LINGUAS ?=
>  PREFIX ?= /usr
>  BINDIR ?= $(PREFIX)/bin
>  MANDIR ?= $(PREFIX)/share/man
> diff --git a/python/semanage/Makefile b/python/semanage/Makefile
> index b53ee33d..628d135a 100644
> --- a/python/semanage/Makefile
> +++ b/python/semanage/Makefile
> @@ -1,7 +1,7 @@
>  PYTHON ?= python3
>  
>  # Installation directories.
> -LINGUAS ?= ru
> +LINGUAS ?=
>  PREFIX ?= /usr
>  SBINDIR ?= $(PREFIX)/sbin
>  MANDIR = $(PREFIX)/share/man
> diff --git a/python/sepolicy/Makefile b/python/sepolicy/Makefile
> index 4e9e93d0..1a26cfdc 100644
> --- a/python/sepolicy/Makefile
> +++ b/python/sepolicy/Makefile
> @@ -1,7 +1,7 @@
>  PYTHON ?= python3
>  
>  # Installation directories.
> -LINGUAS ?= ru
> +LINGUAS ?=
>  PREFIX ?= /usr
>  BINDIR ?= $(PREFIX)/bin
>  MANDIR ?= $(PREFIX)/share/man
> diff --git a/restorecond/Makefile b/restorecond/Makefile
> index 8e9a5ef1..1ddfcc92 100644
> --- a/restorecond/Makefile
> +++ b/restorecond/Makefile
> @@ -1,7 +1,7 @@
>  PKG_CONFIG ?= pkg-config
>  
>  # Installation directories.
> -LINGUAS ?= ru
> +LINGUAS ?=
>  PREFIX ?= /usr
>  SBINDIR ?= $(PREFIX)/sbin
>  MANDIR = $(PREFIX)/share/man
> diff --git a/sandbox/Makefile b/sandbox/Makefile
> index 84cb5a39..360a8bc5 100644
> --- a/sandbox/Makefile
> +++ b/sandbox/Makefile
> @@ -1,7 +1,7 @@
>  PYTHON ?= python3
>  
>  # Installation directories.
> -LINGUAS ?= ru
> +LINGUAS ?=
>  PREFIX ?= /usr
>  SYSCONFDIR ?= /etc/sysconfig
>  BINDIR ?= $(PREFIX)/bin
> diff --git a/semodule-utils/semodule_expand/Makefile b/semodule-utils/semodule_expand/Makefile
> index e63dcff2..ad776b15 100644
> --- a/semodule-utils/semodule_expand/Makefile
> +++ b/semodule-utils/semodule_expand/Makefile
> @@ -1,5 +1,5 @@
>  # Installation directories.
> -LINGUAS ?= ru
> +LINGUAS ?=
>  PREFIX ?= /usr
>  BINDIR ?= $(PREFIX)/bin
>  MANDIR ?= $(PREFIX)/share/man
> diff --git a/semodule-utils/semodule_link/Makefile b/semodule-utils/semodule_link/Makefile
> index c5cf69cd..936d161c 100644
> --- a/semodule-utils/semodule_link/Makefile
> +++ b/semodule-utils/semodule_link/Makefile
> @@ -1,5 +1,5 @@
>  # Installation directories.
> -LINGUAS ?= ru
> +LINGUAS ?=
>  PREFIX ?= /usr
>  BINDIR ?= $(PREFIX)/bin
>  MANDIR ?= $(PREFIX)/share/man
> diff --git a/semodule-utils/semodule_package/Makefile b/semodule-utils/semodule_package/Makefile
> index 680ab836..6a289f73 100644
> --- a/semodule-utils/semodule_package/Makefile
> +++ b/semodule-utils/semodule_package/Makefile
> @@ -1,5 +1,5 @@
>  # Installation directories.
> -LINGUAS ?= ru
> +LINGUAS ?=
>  PREFIX ?= /usr
>  BINDIR ?= $(PREFIX)/bin
>  MANDIR ?= $(PREFIX)/share/man
> -- 
> 2.41.0

