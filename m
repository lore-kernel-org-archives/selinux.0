Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A299C04FE1
	for <selinux@archiver.kernel.org>; Mon, 14 Aug 2023 09:29:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235217AbjHNJ2k (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 14 Aug 2023 05:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236241AbjHNJ2V (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 14 Aug 2023 05:28:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B42173D
        for <selinux@vger.kernel.org>; Mon, 14 Aug 2023 02:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692005191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cEY8zYsUYpuCszfXkzYyo8HPMkMT3K2Ir1fHwRdD2no=;
        b=ZzSYrZNhSk0Nk+QWUJVutnSxNHJ8pkupv2AegKMzXBQrDK9e+AFjoglWmusUkDq6zi2YQw
        m4j4VxwQmWq/7vXVqe45V7XSGoctvEf4ThTUB88hTafxMCqjSm3A0T+TjLEitpylPbijAW
        ShT5kp4ouV3/iBwFVNh6HMWKaKMQFV0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-504-vg4mWzZ2NCCH_BtOSyqrlw-1; Mon, 14 Aug 2023 05:26:27 -0400
X-MC-Unique: vg4mWzZ2NCCH_BtOSyqrlw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 61D9B80557A;
        Mon, 14 Aug 2023 09:26:27 +0000 (UTC)
Received: from localhost (unknown [10.45.224.51])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E026D140E950;
        Mon, 14 Aug 2023 09:26:26 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     James Carter <jwcart2@gmail.com>, selinux@vger.kernel.org
Subject: Re: [PATCH 12/12] semodule-utils: Remove the Russian translations
In-Reply-To: <20230809163059.97671-12-jwcart2@gmail.com>
References: <20230809163059.97671-1-jwcart2@gmail.com>
 <20230809163059.97671-12-jwcart2@gmail.com>
Date:   Mon, 14 Aug 2023 11:26:25 +0200
Message-ID: <87350mc6v2.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

James Carter <jwcart2@gmail.com> writes:

> The Russian translations have not been maintained and are out of
> date, so remove them.
>
> Suggested-by: Petr Lautrbach <plautrba@redhat.com>
> Signed-off-by: James Carter <jwcart2@gmail.com>

Based on https://github.com/SELinuxProject/selinux/pull/405

For all 12:

Acked-by: Petr Lautrbach <lautrbach@redhat.com>

Note that Makefile's still contain:

```
LINGUAS ?=3D ru
...
install: all
...
    for lang in $(LINGUAS) ; do \
		if [ -e $${lang} ] ; then \
			mkdir -p $(DESTDIR)$(MANDIR)/$${lang}/man5 ; \
			mkdir -p $(DESTDIR)$(MANDIR)/$${lang}/man8 ; \
			install -m 644 $${lang}/*.5 $(DESTDIR)$(MANDIR)/$${lang}/man5/ ; \
			install -m 644 $${lang}/*.8 $(DESTDIR)$(MANDIR)/$${lang}/man8/ ; \
		fi ; \
	done
```

I'd simply drop 'ru' from LINGUAS in order to make it possible to use
original ru pages extracted from other source and setting LINGUAS in the
build environment, e.g.:

```
--- a/checkpolicy/Makefile
+++ b/checkpolicy/Makefile
@@ -1,7 +1,7 @@
 #
 # Makefile for building the checkpolicy program
 #
-LINGUAS ?=3D ru
+LINGUAS ?=3D
 PREFIX ?=3D /usr
 BINDIR ?=3D $(PREFIX)/bin
 MANDIR ?=3D $(PREFIX)/share/man
```


> ---
>  .../semodule_expand/ru/semodule_expand.8      | 31 ------------
>  .../semodule_link/ru/semodule_link.8          | 32 -------------
>  .../semodule_package/ru/semodule_package.8    | 48 -------------------
>  .../semodule_package/ru/semodule_unpackage.8  | 24 ----------
>  4 files changed, 135 deletions(-)
>  delete mode 100644 semodule-utils/semodule_expand/ru/semodule_expand.8
>  delete mode 100644 semodule-utils/semodule_link/ru/semodule_link.8
>  delete mode 100644 semodule-utils/semodule_package/ru/semodule_package.8
>  delete mode 100644 semodule-utils/semodule_package/ru/semodule_unpackage=
.8
>
> diff --git a/semodule-utils/semodule_expand/ru/semodule_expand.8 b/semodu=
le-utils/semodule_expand/ru/semodule_expand.8
> deleted file mode 100644
> index 28b381af..00000000
> --- a/semodule-utils/semodule_expand/ru/semodule_expand.8
> +++ /dev/null
> @@ -1,31 +0,0 @@
> -.TH SEMODULE_EXPAND "8" "=D0=BD=D0=BE=D1=8F=D0=B1=D1=80=D1=8C 2005" "Sec=
urity Enhanced Linux"
> -.SH =D0=98=D0=9C=D0=AF=20
> -semodule_expand \- =D1=80=D0=B0=D1=81=D1=88=D0=B8=D1=80=D0=B8=D1=82=D1=
=8C =D0=BF=D0=B0=D0=BA=D0=B5=D1=82 =D0=BC=D0=BE=D0=B4=D1=83=D0=BB=D1=8F =D0=
=BF=D0=BE=D0=BB=D0=B8=D1=82=D0=B8=D0=BA=D0=B8 SELinux
> -
> -.SH =D0=9E=D0=91=D0=97=D0=9E=D0=A0
> -.B semodule_expand [-V ] [ -a ] [ -c [version]] basemodpkg outputfile
> -.br
> -.SH =D0=9E=D0=9F=D0=98=D0=A1=D0=90=D0=9D=D0=98=D0=95
> -.PP
> -semodule_expand - =D1=83=D1=82=D0=B8=D0=BB=D0=B8=D1=82=D0=B0 =D1=80=D0=
=B0=D0=B7=D1=80=D0=B0=D0=B1=D0=BE=D1=82=D0=BA=D0=B8 =D0=B4=D0=BB=D1=8F =D1=
=80=D1=83=D1=87=D0=BD=D0=BE=D0=B3=D0=BE =D1=80=D0=B0=D1=81=D1=88=D0=B8=D1=
=80=D0=B5=D0=BD=D0=B8=D1=8F =D0=BF=D0=B0=D0=BA=D0=B5=D1=82=D0=B0 =D0=B1=D0=
=B0=D0=B7=D0=BE=D0=B2=D0=BE=D0=B3=D0=BE =D0=BC=D0=BE=D0=B4=D1=83=D0=BB=D1=
=8F =D0=BF=D0=BE=D0=BB=D0=B8=D1=82=D0=B8=D0=BA=D0=B8 =D0=B2 =D0=B4=D0=B2=D0=
=BE=D0=B8=D1=87=D0=BD=D1=8B=D0=B9 =D1=84=D0=B0=D0=B9=D0=BB =D0=BF=D0=BE=D0=
=BB=D0=B8=D1=82=D0=B8=D0=BA=D0=B8 =D1=8F=D0=B4=D1=80=D0=B0.
> -=D0=AD=D1=82=D0=BE =D1=81=D1=80=D0=B5=D0=B4=D1=81=D1=82=D0=B2=D0=BE =D0=
=BD=D0=B5 =D1=8F=D0=B2=D0=BB=D1=8F=D0=B5=D1=82=D1=81=D1=8F =D0=BD=D0=B5=D0=
=BE=D0=B1=D1=85=D0=BE=D0=B4=D0=B8=D0=BC=D1=8B=D0=BC =D0=B4=D0=BB=D1=8F =D0=
=BD=D0=BE=D1=80=D0=BC=D0=B0=D0=BB=D1=8C=D0=BD=D0=BE=D0=B9 =D1=80=D0=B0=D0=
=B1=D0=BE=D1=82=D1=8B SELinux. =D0=9E=D0=B1=D1=8B=D1=87=D0=BD=D0=BE =D1=82=
=D0=B0=D0=BA=D0=BE=D0=B5 =D1=80=D0=B0=D1=81=D1=88=D0=B8=D1=80=D0=B5=D0=BD=
=D0=B8=D0=B5 =D0=B2=D1=8B=D0=BF=D0=BE=D0=BB=D0=BD=D1=8F=D0=B5=D1=82=D1=81=
=D1=8F libsemanage =D0=B2=D0=BD=D1=83=D1=82=D1=80=D0=B5=D0=BD=D0=BD=D0=B8=
=D0=BC =D0=BE=D0=B1=D1=80=D0=B0=D0=B7=D0=BE=D0=BC =D0=B2 =D0=BE=D1=82=D0=B2=
=D0=B5=D1=82 =D0=BD=D0=B0 =D0=BA=D0=BE=D0=BC=D0=B0=D0=BD=D0=B4=D1=8B semodu=
le. =D0=9F=D0=B0=D0=BA=D0=B5=D1=82=D1=8B =D0=B1=D0=B0=D0=B7=D0=BE=D0=B2=D1=
=8B=D1=85 =D0=BC=D0=BE=D0=B4=D1=83=D0=BB=D0=B5=D0=B9 =D0=BF=D0=BE=D0=BB=D0=
=B8=D1=82=D0=B8=D0=BA=D0=B8 =D0=BC=D0=BE=D0=B6=D0=BD=D0=BE =D1=81=D0=BE=D0=
=B7=D0=B4=D0=B0=D0=B2=D0=B0=D1=82=D1=8C =D0=BD=D0=B5=D0=BF=D0=BE=D1=81=D1=
=80=D0=B5=D0=B4=D1=81=D1=82=D0=B2=D0=B5=D0=BD=D0=BD=D0=BE =D1=81 =D0=BF=D0=
=BE=D0=BC=D0=BE=D1=89=D1=8C=D1=8E semodule_package =D0=B8=D0=BB=D0=B8 semod=
ule_link (=D0=BF=D1=80=D0=B8 =D1=81=D0=B2=D1=8F=D0=B7=D1=8B=D0=B2=D0=B0=D0=
=BD=D0=B8=D0=B8 =D0=BD=D0=B0=D0=B1=D0=BE=D1=80=D0=B0 =D0=BF=D0=B0=D0=BA=D0=
=B5=D1=82=D0=BE=D0=B2 =D0=B2 =D0=BE=D0=B4=D0=B8=D0=BD =D0=BF=D0=B0=D0=BA=D0=
=B5=D1=82).
> -
> -.SH "=D0=9F=D0=90=D0=A0=D0=90=D0=9C=D0=95=D0=A2=D0=A0=D0=AB"
> -.TP
> -.B \-V
> -=D0=9F=D0=BE=D0=BA=D0=B0=D0=B7=D0=B0=D1=82=D1=8C =D0=B2=D0=B5=D1=80=D1=
=81=D0=B8=D1=8E
> -.TP
> -.B \-c [version]
> -=D0=92=D0=B5=D1=80=D1=81=D0=B8=D1=8F =D0=BF=D0=BE=D0=BB=D0=B8=D1=82=D0=
=B8=D0=BA=D0=B8, =D0=BA=D0=BE=D1=82=D0=BE=D1=80=D1=83=D1=8E =D1=81=D0=BB=D0=
=B5=D0=B4=D1=83=D0=B5=D1=82 =D1=81=D0=BE=D0=B7=D0=B4=D0=B0=D1=82=D1=8C
> -.TP
> -.B \-a
> -=D0=9D=D0=B5 =D0=BF=D1=80=D0=BE=D0=B2=D0=B5=D1=80=D1=8F=D1=82=D1=8C =D1=
=83=D1=82=D0=B2=D0=B5=D1=80=D0=B6=D0=B4=D0=B5=D0=BD=D0=B8=D1=8F. =D0=9F=D1=
=80=D0=B8 =D0=B8=D1=81=D0=BF=D0=BE=D0=BB=D1=8C=D0=B7=D0=BE=D0=B2=D0=B0=D0=
=BD=D0=B8=D0=B8 =D1=8D=D1=82=D0=BE=D0=B3=D0=BE =D0=BF=D0=B0=D1=80=D0=B0=D0=
=BC=D0=B5=D1=82=D1=80=D0=B0 =D0=BF=D0=BE=D0=BB=D0=B8=D1=82=D0=B8=D0=BA=D0=
=B0 =D0=BD=D0=B5 =D0=B1=D1=83=D0=B4=D0=B5=D1=82 =D0=BF=D1=80=D0=BE=D0=B2=D0=
=B5=D1=80=D1=8F=D1=82=D1=8C =D0=B7=D0=B0=D0=BF=D1=80=D0=B5=D1=89=D0=B0=D1=
=8E=D1=89=D0=B8=D0=B5 =D0=BF=D1=80=D0=B0=D0=B2=D0=B8=D0=BB=D0=B0 (neverallo=
w).
> -
> -.SH =D0=A1=D0=9C=D0=9E=D0=A2=D0=A0=D0=98=D0=A2=D0=95 =D0=A2=D0=90=D0=9A=
=D0=96=D0=95
> -.B checkmodule(8), semodule_package(8), semodule(8), semodule_link(8)
> -(8),
> -.SH =D0=90=D0=92=D0=A2=D0=9E=D0=A0=D0=AB
> -.nf
> -=D0=AD=D1=82=D0=B0 =D1=81=D1=82=D1=80=D0=B0=D0=BD=D0=B8=D1=86=D0=B0 =D1=
=80=D1=83=D0=BA=D0=BE=D0=B2=D0=BE=D0=B4=D1=81=D1=82=D0=B2=D0=B0 =D0=B1=D1=
=8B=D0=BB=D0=B0 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BD=D0=B0 Dan Walsh =
<dwalsh@redhat.com>.
> -=D0=9F=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=BC=D0=B0 =D0=B1=D1=8B=D0=
=BB=D0=B0 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BD=D0=B0 Karl MacMillan <=
kmacmillan@tresys.com>, Joshua Brindle <jbrindle@tresys.com>.
> -=D0=9F=D0=B5=D1=80=D0=B5=D0=B2=D0=BE=D0=B4 =D0=BD=D0=B0 =D1=80=D1=83=D1=
=81=D1=81=D0=BA=D0=B8=D0=B9 =D1=8F=D0=B7=D1=8B=D0=BA =D0=B2=D1=8B=D0=BF=D0=
=BE=D0=BB=D0=BD=D0=B8=D0=BB=D0=B0 =D0=93=D0=B5=D1=80=D0=B0=D1=81=D0=B8=D0=
=BC=D0=B5=D0=BD=D0=BA=D0=BE =D0=9E=D0=BB=D0=B5=D1=81=D1=8F <gammaray@baseal=
t.ru>.
> diff --git a/semodule-utils/semodule_link/ru/semodule_link.8 b/semodule-u=
tils/semodule_link/ru/semodule_link.8
> deleted file mode 100644
> index 4a8f414e..00000000
> --- a/semodule-utils/semodule_link/ru/semodule_link.8
> +++ /dev/null
> @@ -1,32 +0,0 @@
> -.TH SEMODULE_LINK "8" "=D0=9D=D0=BE=D1=8F=D0=B1=D1=80=D1=8C 2005" "Secur=
ity Enhanced Linux"
> -.SH =D0=98=D0=9C=D0=AF=20
> -semodule_link \- =D1=81=D0=B2=D1=8F=D0=B7=D0=B0=D1=82=D1=8C =D0=B2=D0=BC=
=D0=B5=D1=81=D1=82=D0=B5 =D0=BF=D0=B0=D0=BA=D0=B5=D1=82=D1=8B =D0=BC=D0=BE=
=D0=B4=D1=83=D0=BB=D0=B5=D0=B9 =D0=BF=D0=BE=D0=BB=D0=B8=D1=82=D0=B8=D0=BA=
=D0=B8 SELinux
> -
> -.SH =D0=9E=D0=91=D0=97=D0=9E=D0=A0
> -.B semodule_link [-Vv] [-o outfile] basemodpkg modpkg1 [modpkg2]...
> -.br
> -.SH =D0=9E=D0=9F=D0=98=D0=A1=D0=90=D0=9D=D0=98=D0=95
> -.PP
> -semodule_link - =D1=83=D1=82=D0=B8=D0=BB=D0=B8=D1=82=D0=B0 =D1=80=D0=B0=
=D0=B7=D1=80=D0=B0=D0=B1=D0=BE=D1=82=D0=BA=D0=B8 =D0=B4=D0=BB=D1=8F =D1=80=
=D1=83=D1=87=D0=BD=D0=BE=D0=B3=D0=BE =D1=81=D0=B2=D1=8F=D0=B7=D1=8B=D0=B2=
=D0=B0=D0=BD=D0=B8=D1=8F =D0=BD=D0=B0=D0=B1=D0=BE=D1=80=D0=B0 =D0=BF=D0=B0=
=D0=BA=D0=B5=D1=82=D0=BE=D0=B2 =D0=BC=D0=BE=D0=B4=D1=83=D0=BB=D0=B5=D0=B9 =
=D0=BF=D0=BE=D0=BB=D0=B8=D1=82=D0=B8=D0=BA=D0=B8 SELinux =D0=B2 =D0=BE=D0=
=B4=D0=B8=D0=BD =D0=BF=D0=B0=D0=BA=D0=B5=D1=82 =D0=BC=D0=BE=D0=B4=D1=83=D0=
=BB=D0=B5=D0=B9 =D0=BF=D0=BE=D0=BB=D0=B8=D1=82=D0=B8=D0=BA=D0=B8.=20
> -=D0=AD=D1=82=D0=BE =D1=81=D1=80=D0=B5=D0=B4=D1=81=D1=82=D0=B2=D0=BE =D0=
=BD=D0=B5 =D1=8F=D0=B2=D0=BB=D1=8F=D0=B5=D1=82=D1=81=D1=8F =D0=BD=D0=B5=D0=
=BE=D0=B1=D1=85=D0=BE=D0=B4=D0=B8=D0=BC=D1=8B=D0=BC =D0=B4=D0=BB=D1=8F =D0=
=BD=D0=BE=D1=80=D0=BC=D0=B0=D0=BB=D1=8C=D0=BD=D0=BE=D0=B9 =D1=80=D0=B0=D0=
=B1=D0=BE=D1=82=D1=8B SELinux. =D0=9E=D0=B1=D1=8B=D1=87=D0=BD=D0=BE =D1=82=
=D0=B0=D0=BA=D0=BE=D0=B5 =D1=81=D0=B2=D1=8F=D0=B7=D1=8B=D0=B2=D0=B0=D0=BD=
=D0=B8=D0=B5 =D0=B2=D1=8B=D0=BF=D0=BE=D0=BB=D0=BD=D1=8F=D0=B5=D1=82=D1=81=
=D1=8F libsemanage =D0=B2=D0=BD=D1=83=D1=82=D1=80=D0=B5=D0=BD=D0=BD=D0=B8=
=D0=BC =D0=BE=D0=B1=D1=80=D0=B0=D0=B7=D0=BE=D0=BC =D0=B2 =D0=BE=D1=82=D0=B2=
=D0=B5=D1=82 =D0=BD=D0=B0 =D0=BA=D0=BE=D0=BC=D0=B0=D0=BD=D0=B4=D1=8B semodu=
le. =D0=9F=D0=B0=D0=BA=D0=B5=D1=82=D1=8B =D0=BC=D0=BE=D0=B4=D1=83=D0=BB=D0=
=B5=D0=B9 =D1=81=D0=BE=D0=B7=D0=B4=D0=B0=D1=8E=D1=82=D1=81=D1=8F =D1=81 =D0=
=BF=D0=BE=D0=BC=D0=BE=D1=89=D1=8C=D1=8E semodule_package.
> -
> -.SH "=D0=9F=D0=90=D0=A0=D0=90=D0=9C=D0=95=D0=A2=D0=A0=D0=AB"
> -.TP
> -.B \-V
> -=D0=9F=D0=BE=D0=BA=D0=B0=D0=B7=D0=B0=D1=82=D1=8C =D0=B2=D0=B5=D1=80=D1=
=81=D0=B8=D1=8E
> -.TP
> -.B \-v
> -=D0=9F=D0=BE=D0=B4=D1=80=D0=BE=D0=B1=D0=BD=D1=8B=D0=B9 =D1=80=D0=B5=D0=
=B6=D0=B8=D0=BC
> -.TP
> -.B \-o <output file>=20
> -=D0=A1=D0=B2=D1=8F=D0=B7=D0=B0=D0=BD=D0=BD=D1=8B=D0=B9 =D0=BF=D0=B0=D0=
=BA=D0=B5=D1=82 =D0=BC=D0=BE=D0=B4=D1=83=D0=BB=D0=B5=D0=B9 =D0=BF=D0=BE=D0=
=BB=D0=B8=D1=82=D0=B8=D0=BA=D0=B8, =D1=81=D0=BE=D0=B7=D0=B4=D0=B0=D0=BD=D0=
=BD=D1=8B=D0=B9 =D1=81 =D0=BF=D0=BE=D0=BC=D0=BE=D1=89=D1=8C=D1=8E =D1=8D=D1=
=82=D0=BE=D0=B3=D0=BE =D1=81=D1=80=D0=B5=D0=B4=D1=81=D1=82=D0=B2=D0=B0
> -
> -
> -.SH =D0=A1=D0=9C=D0=9E=D0=A2=D0=A0=D0=98=D0=A2=D0=95 =D0=A2=D0=90=D0=9A=
=D0=96=D0=95
> -.B checkmodule(8), semodule_package(8), semodule(8), semodule_expand(8)
> -(8),
> -.SH =D0=90=D0=92=D0=A2=D0=9E=D0=A0=D0=AB
> -.nf
> -=D0=AD=D1=82=D0=B0 =D1=81=D1=82=D1=80=D0=B0=D0=BD=D0=B8=D1=86=D0=B0 =D1=
=80=D1=83=D0=BA=D0=BE=D0=B2=D0=BE=D0=B4=D1=81=D1=82=D0=B2=D0=B0 =D0=B1=D1=
=8B=D0=BB=D0=B0 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BD=D0=B0 Dan Walsh =
<dwalsh@redhat.com>.
> -=D0=9F=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=BC=D0=B0 =D0=B1=D1=8B=D0=
=BB=D0=B0 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BD=D0=B0 Karl MacMillan <=
kmacmillan@tresys.com>.
> -=D0=9F=D0=B5=D1=80=D0=B5=D0=B2=D0=BE=D0=B4 =D0=BD=D0=B0 =D1=80=D1=83=D1=
=81=D1=81=D0=BA=D0=B8=D0=B9 =D1=8F=D0=B7=D1=8B=D0=BA =D0=B2=D1=8B=D0=BF=D0=
=BE=D0=BB=D0=BD=D0=B8=D0=BB=D0=B0 =D0=93=D0=B5=D1=80=D0=B0=D1=81=D0=B8=D0=
=BC=D0=B5=D0=BD=D0=BA=D0=BE =D0=9E=D0=BB=D0=B5=D1=81=D1=8F <gammaray@baseal=
t.ru>.
> diff --git a/semodule-utils/semodule_package/ru/semodule_package.8 b/semo=
dule-utils/semodule_package/ru/semodule_package.8
> deleted file mode 100644
> index 3f4b16a9..00000000
> --- a/semodule-utils/semodule_package/ru/semodule_package.8
> +++ /dev/null
> @@ -1,48 +0,0 @@
> -.TH SEMODULE_PACKAGE "8" "=D0=9D=D0=BE=D1=8F=D0=B1=D1=80=D1=8C 2005" "Se=
curity Enhanced Linux"
> -.SH =D0=98=D0=9C=D0=AF=20
> -semodule_package \- =D1=81=D0=BE=D0=B7=D0=B4=D0=B0=D1=82=D1=8C =D0=BF=D0=
=B0=D0=BA=D0=B5=D1=82 =D0=BC=D0=BE=D0=B4=D1=83=D0=BB=D1=8F =D0=BF=D0=BE=D0=
=BB=D0=B8=D1=82=D0=B8=D0=BA=D0=B8 SELinux
> -
> -.SH =D0=9E=D0=91=D0=97=D0=9E=D0=A0
> -.B semodule_package \-o <output file> \-m <module> [\-f <file contexts>]
> -.br
> -.SH =D0=9E=D0=9F=D0=98=D0=A1=D0=90=D0=9D=D0=98=D0=95
> -.PP
> -semodule_package - =D1=83=D1=82=D0=B8=D0=BB=D0=B8=D1=82=D0=B0, =D0=BA=D0=
=BE=D1=82=D0=BE=D1=80=D0=B0=D1=8F =D0=B8=D1=81=D0=BF=D0=BE=D0=BB=D1=8C=D0=
=B7=D1=83=D0=B5=D1=82=D1=81=D1=8F =D0=B4=D0=BB=D1=8F =D1=81=D0=BE=D0=B7=D0=
=B4=D0=B0=D0=BD=D0=B8=D1=8F =D0=BF=D0=B0=D0=BA=D0=B5=D1=82=D0=B0 =D0=BC=D0=
=BE=D0=B4=D1=83=D0=BB=D1=8F =D0=BF=D0=BE=D0=BB=D0=B8=D1=82=D0=B8=D0=BA=D0=
=B8 SELinux =D0=B8=D0=B7 =D0=B4=D0=B2=D0=BE=D0=B8=D1=87=D0=BD=D0=BE=D0=B3=
=D0=BE =D0=BC=D0=BE=D0=B4=D1=83=D0=BB=D1=8F =D0=BF=D0=BE=D0=BB=D0=B8=D1=82=
=D0=B8=D0=BA=D0=B8 =D0=B8 (=D0=BD=D0=B5=D0=BE=D0=B1=D1=8F=D0=B7=D0=B0=D1=82=
=D0=B5=D0=BB=D1=8C=D0=BD=D0=BE) =D0=B4=D1=80=D1=83=D0=B3=D0=B8=D1=85 =D0=B4=
=D0=B0=D0=BD=D0=BD=D1=8B=D1=85, =D1=82=D0=B0=D0=BA=D0=B8=D1=85 =D0=BA=D0=B0=
=D0=BA =D0=BA=D0=BE=D0=BD=D1=82=D0=B5=D0=BA=D1=81=D1=82=D1=8B =D1=84=D0=B0=
=D0=B9=D0=BB=D0=BE=D0=B2. =D0=9A=D0=BE=D0=BC=D0=B0=D0=BD=D0=B4=D0=B0 semodu=
le_package =D1=83=D0=BF=D0=B0=D0=BA=D0=BE=D0=B2=D1=8B=D0=B2=D0=B0=D0=B5=D1=
=82 =D0=B4=D0=B2=D0=BE=D0=B8=D1=87=D0=BD=D1=8B=D0=B5 =D0=BC=D0=BE=D0=B4=D1=
=83=D0=BB=D0=B8 =D0=BF=D0=BE=D0=BB=D0=B8=D1=82=D0=B8=D0=BA=D0=B8, =D1=81=D0=
=BE=D0=B7=D0=B4=D0=B0=D0=BD=D0=BD=D1=8B=D0=B5 =D1=81 =D0=BF=D0=BE=D0=BC=D0=
=BE=D1=89=D1=8C=D1=8E checkmodule. =D0=9F=D0=B0=D0=BA=D0=B5=D1=82 =D0=BF=D0=
=BE=D0=BB=D0=B8=D1=82=D0=B8=D0=BA=D0=B8, =D1=81=D0=BE=D0=B7=D0=B4=D0=B0=D0=
=BD=D0=BD=D1=8B=D0=B9 =D1=81 =D0=BF=D0=BE=D0=BC=D0=BE=D1=89=D1=8C=D1=8E sem=
odule_package, =D0=B7=D0=B0=D1=82=D0=B5=D0=BC =D0=BC=D0=BE=D0=B6=D0=BD=D0=
=BE =D1=83=D1=81=D1=82=D0=B0=D0=BD=D0=BE=D0=B2=D0=B8=D1=82=D1=8C =D1=87=D0=
=B5=D1=80=D0=B5=D0=B7 semodule.=20
> -
> -.SH =D0=9F=D0=A0=D0=98=D0=9C=D0=95=D0=A0
> -.nf
> -# =D0=A1=D0=BE=D0=B1=D1=80=D0=B0=D1=82=D1=8C =D0=BF=D0=B0=D0=BA=D0=B5=D1=
=82 =D0=BF=D0=BE=D0=BB=D0=B8=D1=82=D0=B8=D0=BA=D0=B8 =D0=B4=D0=BB=D1=8F =D0=
=B1=D0=B0=D0=B7=D0=BE=D0=B2=D0=BE=D0=B3=D0=BE =D0=BC=D0=BE=D0=B4=D1=83=D0=
=BB=D1=8F.
> -$ semodule_package \-o base.pp \-m base.mod \-f file_contexts
> -# =D0=A1=D0=BE=D0=B1=D1=80=D0=B0=D1=82=D1=8C =D0=BF=D0=B0=D0=BA=D0=B5=D1=
=82 =D0=BF=D0=BE=D0=BB=D0=B8=D1=82=D0=B8=D0=BA=D0=B8 =D0=B4=D0=BB=D1=8F =D0=
=BC=D0=BE=D0=B4=D1=83=D0=BB=D1=8F httpd.
> -$ semodule_package \-o httpd.pp \-m httpd.mod \-f httpd.fc
> -# =D0=A1=D0=BE=D0=B1=D1=80=D0=B0=D1=82=D1=8C =D0=BF=D0=B0=D0=BA=D0=B5=D1=
=82 =D0=BF=D0=BE=D0=BB=D0=B8=D1=82=D0=B8=D0=BA=D0=B8 =D0=B4=D0=BB=D1=8F =D0=
=BB=D0=BE=D0=BA=D0=B0=D0=BB=D1=8C=D0=BD=D1=8B=D1=85 =D0=BF=D1=80=D0=B0=D0=
=B2=D0=B8=D0=BB =D0=BF=D1=80=D0=B8=D0=BD=D1=83=D0=B4=D0=B8=D1=82=D0=B5=D0=
=BB=D1=8C=D0=BD=D0=BE=D0=B3=D0=BE =D0=BF=D1=80=D0=B8=D1=81=D0=B2=D0=BE=D0=
=B5=D0=BD=D0=B8=D1=8F =D1=82=D0=B8=D0=BF=D0=BE=D0=B2, =D0=BD=D0=B5 =D0=B2=
=D0=BA=D0=BB=D1=8E=D1=87=D0=B0=D1=8F =D0=BA=D0=BE=D0=BD=D1=82=D0=B5=D0=BA=
=D1=81=D1=82=D1=8B =D1=84=D0=B0=D0=B9=D0=BB=D0=BE=D0=B2.
> -$ semodule_package \-o local.pp \-m local.mod
> -.fi
> -
> -.SH "=D0=9F=D0=90=D0=A0=D0=90=D0=9C=D0=95=D0=A2=D0=A0=D0=AB"
> -.TP
> -.B \-o \-\-outfile <output file>=20
> -=D0=A4=D0=B0=D0=B9=D0=BB =D0=BF=D0=B0=D0=BA=D0=B5=D1=82=D0=B0 =D0=BC=D0=
=BE=D0=B4=D1=83=D0=BB=D1=8F =D0=BF=D0=BE=D0=BB=D0=B8=D1=82=D0=B8=D0=BA=D0=
=B8, =D1=81=D0=BE=D0=B7=D0=B4=D0=B0=D0=BD=D0=BD=D1=8B=D0=B9 =D1=8D=D1=82=D0=
=B8=D0=BC =D1=81=D1=80=D0=B5=D0=B4=D1=81=D1=82=D0=B2=D0=BE=D0=BC.
> -.TP
> -.B  \-s \-\-seuser <seuser file>
> -=D0=A4=D0=B0=D0=B9=D0=BB seuser, =D0=BA=D0=BE=D1=82=D0=BE=D1=80=D1=8B=D0=
=B9 =D1=81=D0=BB=D0=B5=D0=B4=D1=83=D0=B5=D1=82 =D0=B2=D0=BA=D0=BB=D1=8E=D1=
=87=D0=B8=D1=82=D1=8C =D0=B2 =D0=BF=D0=B0=D0=BA=D0=B5=D1=82.
> -.TP
> -.B  \-u \-\-user_extra <user extra file>
> -=D0=A4=D0=B0=D0=B9=D0=BB user_extra, =D0=BA=D0=BE=D1=82=D0=BE=D1=80=D1=
=8B=D0=B9 =D1=81=D0=BB=D0=B5=D0=B4=D1=83=D0=B5=D1=82 =D0=B2=D0=BA=D0=BB=D1=
=8E=D1=87=D0=B8=D1=82=D1=8C =D0=B2 =D0=BF=D0=B0=D0=BA=D0=B5=D1=82.
> -.TP
> -.B  \-m \-\-module <Module file>
> -=D0=A4=D0=B0=D0=B9=D0=BB =D0=BC=D0=BE=D0=B4=D1=83=D0=BB=D1=8F =D0=BF=D0=
=BE=D0=BB=D0=B8=D1=82=D0=B8=D0=BA=D0=B8, =D0=BA=D0=BE=D1=82=D0=BE=D1=80=D1=
=8B=D0=B9 =D1=81=D0=BB=D0=B5=D0=B4=D1=83=D0=B5=D1=82 =D0=B2=D0=BA=D0=BB=D1=
=8E=D1=87=D0=B8=D1=82=D1=8C =D0=B2 =D0=BF=D0=B0=D0=BA=D0=B5=D1=82.
> -.TP
> -.B  \-f \-\-fc <File context file>
> -=D0=A4=D0=B0=D0=B9=D0=BB =D0=BA=D0=BE=D0=BD=D1=82=D0=B5=D0=BA=D1=81=D1=
=82=D0=BE=D0=B2 =D1=84=D0=B0=D0=B9=D0=BB=D0=BE=D0=B2 =D0=B4=D0=BB=D1=8F =D0=
=BC=D0=BE=D0=B4=D1=83=D0=BB=D1=8F (=D0=BD=D0=B5=D0=BE=D0=B1=D1=8F=D0=B7=D0=
=B0=D1=82=D0=B5=D0=BB=D1=8C=D0=BD=D0=BE).
> -.TP
> -.B  \-n \-\-nc <netfilter context file>
> -=D0=A4=D0=B0=D0=B9=D0=BB =D0=BA=D0=BE=D0=BD=D1=82=D0=B5=D0=BA=D1=81=D1=
=82=D0=B0 netfilter, =D0=BA=D0=BE=D1=82=D0=BE=D1=80=D1=8B=D0=B9 =D1=81=D0=
=BB=D0=B5=D0=B4=D1=83=D0=B5=D1=82 =D0=B2=D0=BA=D0=BB=D1=8E=D1=87=D0=B8=D1=
=82=D1=8C =D0=B2 =D0=BF=D0=B0=D0=BA=D0=B5=D1=82.
> -
> -.SH =D0=A1=D0=9C=D0=9E=D0=A2=D0=A0=D0=98=D0=A2=D0=95 =D0=A2=D0=90=D0=9A=
=D0=96=D0=95
> -.B checkmodule(8), semodule(8), semodule_unpackage(8)
> -.SH =D0=90=D0=92=D0=A2=D0=9E=D0=A0=D0=AB
> -.nf
> -=D0=AD=D1=82=D0=B0 =D1=81=D1=82=D1=80=D0=B0=D0=BD=D0=B8=D1=86=D0=B0 =D1=
=80=D1=83=D0=BA=D0=BE=D0=B2=D0=BE=D0=B4=D1=81=D1=82=D0=B2=D0=B0 =D0=B1=D1=
=8B=D0=BB=D0=B0 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BD=D0=B0 Dan Walsh =
<dwalsh@redhat.com>.
> -=D0=9F=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=BC=D0=B0 =D0=B1=D1=8B=D0=
=BB=D0=B0 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BD=D0=B0 Karl MacMillan <=
kmacmillan@tresys.com>.
> -=D0=9F=D0=B5=D1=80=D0=B5=D0=B2=D0=BE=D0=B4 =D0=BD=D0=B0 =D1=80=D1=83=D1=
=81=D1=81=D0=BA=D0=B8=D0=B9 =D1=8F=D0=B7=D1=8B=D0=BA =D0=B2=D1=8B=D0=BF=D0=
=BE=D0=BB=D0=BD=D0=B8=D0=BB=D0=B0 =D0=93=D0=B5=D1=80=D0=B0=D1=81=D0=B8=D0=
=BC=D0=B5=D0=BD=D0=BA=D0=BE =D0=9E=D0=BB=D0=B5=D1=81=D1=8F <gammaray@baseal=
t.ru>.
> diff --git a/semodule-utils/semodule_package/ru/semodule_unpackage.8 b/se=
module-utils/semodule_package/ru/semodule_unpackage.8
> deleted file mode 100644
> index 057ae3d7..00000000
> --- a/semodule-utils/semodule_package/ru/semodule_unpackage.8
> +++ /dev/null
> @@ -1,24 +0,0 @@
> -.TH SEMODULE_PACKAGE "8" "=D0=9D=D0=BE=D1=8F=D0=B1=D1=80=D1=8C 2005" "Se=
curity Enhanced Linux"
> -.SH =D0=98=D0=9C=D0=AF
> -semodule_unpackage \- =D0=B8=D0=B7=D0=B2=D0=BB=D0=B5=D1=87=D1=8C =D0=BC=
=D0=BE=D0=B4=D1=83=D0=BB=D1=8C =D0=BF=D0=BE=D0=BB=D0=B8=D1=82=D0=B8=D0=BA=
=D0=B8 =D0=B8 =D1=84=D0=B0=D0=B9=D0=BB =D0=BA=D0=BE=D0=BD=D1=82=D0=B5=D0=BA=
=D1=81=D1=82=D0=BE=D0=B2 =D1=84=D0=B0=D0=B9=D0=BB=D0=BE=D0=B2 =D0=B8=D0=B7 =
=D0=BF=D0=B0=D0=BA=D0=B5=D1=82=D0=B0 =D0=BC=D0=BE=D0=B4=D1=83=D0=BB=D1=8F =
=D0=BF=D0=BE=D0=BB=D0=B8=D1=82=D0=B8=D0=BA=D0=B8 SELinux
> -
> -.SH =D0=9E=D0=91=D0=97=D0=9E=D0=A0
> -.B semodule_unpackage ppfile modfile [fcfile]
> -.br
> -.SH =D0=9E=D0=9F=D0=98=D0=A1=D0=90=D0=9D=D0=98=D0=95
> -.PP
> -semodule_unpackage - =D1=83=D1=82=D0=B8=D0=BB=D0=B8=D1=82=D0=B0, =D0=BA=
=D0=BE=D1=82=D0=BE=D1=80=D0=B0=D1=8F =D0=B8=D1=81=D0=BF=D0=BE=D0=BB=D1=8C=
=D0=B7=D1=83=D0=B5=D1=82=D1=81=D1=8F =D0=B4=D0=BB=D1=8F =D0=B8=D0=B7=D0=B2=
=D0=BB=D0=B5=D1=87=D0=B5=D0=BD=D0=B8=D1=8F =D1=84=D0=B0=D0=B9=D0=BB=D0=B0 =
=D0=BC=D0=BE=D0=B4=D1=83=D0=BB=D1=8F =D0=BF=D0=BE=D0=BB=D0=B8=D1=82=D0=B8=
=D0=BA=D0=B8 SELinux =D0=B8 =D1=84=D0=B0=D0=B9=D0=BB=D0=B0 =D0=BA=D0=BE=D0=
=BD=D1=82=D0=B5=D0=BA=D1=81=D1=82=D0=BE=D0=B2 =D1=84=D0=B0=D0=B9=D0=BB=D0=
=BE=D0=B2 =D0=B8=D0=B7 =D0=BF=D0=B0=D0=BA=D0=B5=D1=82=D0=B0 =D0=BF=D0=BE=D0=
=BB=D0=B8=D1=82=D0=B8=D0=BA=D0=B8 SELinux.
> -
> -.SH =D0=9F=D0=A0=D0=98=D0=9C=D0=95=D0=A0
> -.nf
> -# =D0=98=D0=B7=D0=B2=D0=BB=D0=B5=D1=87=D1=8C =D1=84=D0=B0=D0=B9=D0=BB =
=D0=BC=D0=BE=D0=B4=D1=83=D0=BB=D1=8F httpd =D0=B8=D0=B7 =D0=BF=D0=B0=D0=BA=
=D0=B5=D1=82=D0=B0 =D0=BF=D0=BE=D0=BB=D0=B8=D1=82=D0=B8=D0=BA=D0=B8 httpd.
> -$ semodule_unpackage httpd.pp httpd.mod httpd.fc
> -.fi
> -
> -.SH =D0=A1=D0=9C=D0=9E=D0=A2=D0=A0=D0=98=D0=A2=D0=95 =D0=A2=D0=90=D0=9A=
=D0=96=D0=95
> -.B semodule_package(8)
> -.SH =D0=90=D0=92=D0=A2=D0=9E=D0=A0=D0=AB
> -.nf
> -=D0=AD=D1=82=D0=B0 =D1=81=D1=82=D1=80=D0=B0=D0=BD=D0=B8=D1=86=D0=B0 =D1=
=80=D1=83=D0=BA=D0=BE=D0=B2=D0=BE=D0=B4=D1=81=D1=82=D0=B2=D0=B0 =D0=B1=D1=
=8B=D0=BB=D0=B0 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BD=D0=B0 Dan Walsh =
<dwalsh@redhat.com>.
> -=D0=9F=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=BC=D0=B0 =D0=B1=D1=8B=D0=
=BB=D0=B0 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BD=D0=B0 Stephen Smalley =
<stephen.smalley.work@gmail.com>.
> -=D0=9F=D0=B5=D1=80=D0=B5=D0=B2=D0=BE=D0=B4 =D0=BD=D0=B0 =D1=80=D1=83=D1=
=81=D1=81=D0=BA=D0=B8=D0=B9 =D1=8F=D0=B7=D1=8B=D0=BA =D0=B2=D1=8B=D0=BF=D0=
=BE=D0=BB=D0=BD=D0=B8=D0=BB=D0=B0 =D0=93=D0=B5=D1=80=D0=B0=D1=81=D0=B8=D0=
=BC=D0=B5=D0=BD=D0=BA=D0=BE =D0=9E=D0=BB=D0=B5=D1=81=D1=8F <gammaray@baseal=
t.ru>.
> --=20
> 2.41.0

