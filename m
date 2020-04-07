Return-Path: <SRS0=OuNA=5X=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF32CC2BA80
	for <selinux@archiver.kernel.org>; Tue,  7 Apr 2020 13:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E491206F7
	for <selinux@archiver.kernel.org>; Tue,  7 Apr 2020 13:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T8gEDEWd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728705AbgDGNiq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 7 Apr 2020 09:38:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38615 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728482AbgDGNip (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 7 Apr 2020 09:38:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586266725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1XGG2Heiwq+3/p3OSTtMnVbKyLLHuowJYyWeJTJ85ak=;
        b=T8gEDEWdARylZDY1HPGemt8aZ0li8FA8TQhX8M3s388Lh583i/5HPkCVYU9ktyp/zhqreM
        Iq7WGXgPY4bbGaAYdILL/jJ1U6gvgI+qVs+X7+naBJA6crQy7aH1UZAp7O5I4+CP+D+oQY
        VQKPpRyk8fan7RvjmCaBmZxM/XTZSGQ=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-849gNmLbMgik94S0yjk9Xw-1; Tue, 07 Apr 2020 09:38:39 -0400
X-MC-Unique: 849gNmLbMgik94S0yjk9Xw-1
Received: by mail-ot1-f71.google.com with SMTP id 22so2560996otg.21
        for <selinux@vger.kernel.org>; Tue, 07 Apr 2020 06:38:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1XGG2Heiwq+3/p3OSTtMnVbKyLLHuowJYyWeJTJ85ak=;
        b=Uy0lrdKTGkPAVAAOWYwUmY28OaHSv6go7qFsGka7bMU2luJ1ismHSNDU4fnWEa/N6q
         qMdZ9MOnwJWouP7p9dtly2bVrND+/hMj1N/yrW9Ehbl+7PE0vwHc7I93WlFbyYaewyjE
         OOLHoHgpPhsdrT37OAlHTffSxOnJAt011S3uGrVG3Q9vFhkcGN8G2QoXGIjGuo3Bwd2u
         uD2WFd9Q1O8aDBFt0dv86bbKSV0muCauRXENca4z2p8NdcQKtg0SXIj76Juv8oIlileP
         KW7c8zxzlZZD82i6kW4+yqD5tAeSaI6HQ6hdVgVq6espUUbcG4//CfvQtgJ+ExS5iaK4
         7LuA==
X-Gm-Message-State: AGi0PuYsXaI8EO7p7HnfrkdGLK0P/L8Lo1JpUkhpHRpQocw3L3TvBjf0
        xPximqEw37nX5R1TGbgaHRYKT3yXRo/Qn/1/krd6X+SqfKTc1qK0sDwc9+flIxVcY3dz6+ZXLUT
        GPxX6tw8x6uw2QKsbiPgwJAseQh5VV9q/cQ==
X-Received: by 2002:aca:d68e:: with SMTP id n136mr1759875oig.103.1586266718559;
        Tue, 07 Apr 2020 06:38:38 -0700 (PDT)
X-Google-Smtp-Source: APiQypJSXO/uxlx4U5XhZws9N6r0XO3Zi8YJ1EB4z35dQX+ADmZdW39x/UiB7/gMGq3qg23CD+RixQFttpCBM2JVZAk=
X-Received: by 2002:aca:d68e:: with SMTP id n136mr1759851oig.103.1586266718262;
 Tue, 07 Apr 2020 06:38:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200407114514.40253-1-cgzones@googlemail.com>
In-Reply-To: <20200407114514.40253-1-cgzones@googlemail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 7 Apr 2020 15:38:27 +0200
Message-ID: <CAFqZXNtjLkhFAr3skqmop0eciDmzdFbnTzeAaQODgeDDzLHNnw@mail.gmail.com>
Subject: Re: [PATCH] tree-wide: install python libraries on Debian with
 appropriate option
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Apr 7, 2020 at 1:45 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
> On Debian the `distutils` module is patched, so `get_python_lib()` return=
s by default `/usr/lib/python3/dist-packages` (no minor version).
>
> But `setuptools` affecting setup.py is not patched to create the library =
directory at `/usr/lib/python3/dist-packages` by default, rather than a com=
mand line argument `--install-layout deb` is added.
>
> Add this option to `python setup.py install` invocation on Debian.
>
> See https://www.debian.org/doc/packaging-manuals/python-policy/packaging_=
tools.html section B.1.
>
> Fixes: https://github.com/SELinuxProject/selinux/issues/187
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  libselinux/src/Makefile  | 2 +-
>  python/sepolicy/Makefile | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> index 2d1c654e..3efbe3aa 100644
> --- a/libselinux/src/Makefile
> +++ b/libselinux/src/Makefile
> @@ -173,7 +173,7 @@ install: all
>         ln -sf --relative $(DESTDIR)$(SHLIBDIR)/$(LIBSO) $(DESTDIR)$(LIBD=
IR)/$(TARGET)
>
>  install-pywrap: pywrap
> -       $(PYTHON) setup.py install --prefix=3D$(PREFIX) `test -n "$(DESTD=
IR)" && echo --root $(DESTDIR)`
> +       $(PYTHON) setup.py install --prefix=3D$(PREFIX) `test -n "$(DESTD=
IR)" && echo --root $(DESTDIR)` `grep -qxF ID=3Ddebian /etc/os-release && e=
cho --install-layout deb`

Wouldn't it be cleaner to instead add something like
$(PYTHON_SETUP_ARGS) and build with 'make
PYTHON_SETUP_ARGS=3D--install-layout=3Ddeb ...' on Debian?

>         install -m 644 $(SWIGPYOUT) $(DESTDIR)$(PYTHONLIBDIR)/selinux/__i=
nit__.py
>         ln -sf --relative $(DESTDIR)$(PYTHONLIBDIR)/selinux/_selinux$(PYC=
EXT) $(DESTDIR)$(PYTHONLIBDIR)/_selinux$(PYCEXT)
>
> diff --git a/python/sepolicy/Makefile b/python/sepolicy/Makefile
> index 69f29fa9..54cd27ca 100644
> --- a/python/sepolicy/Makefile
> +++ b/python/sepolicy/Makefile
> @@ -27,7 +27,7 @@ test:
>         @$(PYTHON) test_sepolicy.py -v
>
>  install:
> -       $(PYTHON) setup.py install --prefix=3D$(PREFIX) `test -n "$(DESTD=
IR)" && echo --root $(DESTDIR)`
> +       $(PYTHON) setup.py install --prefix=3D$(PREFIX) `test -n "$(DESTD=
IR)" && echo --root $(DESTDIR)` `grep -qxF ID=3Ddebian /etc/os-release && e=
cho --install-layout deb`
>         [ -d $(DESTDIR)$(BINDIR) ] || mkdir -p $(DESTDIR)$(BINDIR)
>         install -m 755 sepolicy.py $(DESTDIR)$(BINDIR)/sepolicy
>         (cd $(DESTDIR)$(BINDIR); ln -sf sepolicy sepolgen)
> --
> 2.26.0
>

--
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

