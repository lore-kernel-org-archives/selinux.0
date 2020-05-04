Return-Path: <SRS0=mV6Z=6S=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E1BC3A5A9
	for <selinux@archiver.kernel.org>; Mon,  4 May 2020 13:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A04C52063A
	for <selinux@archiver.kernel.org>; Mon,  4 May 2020 13:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZKSSHOwP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbgEDNDk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 4 May 2020 09:03:40 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:37114 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726351AbgEDNDk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 4 May 2020 09:03:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588597418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gK64IIIRVJOK0NG7Z8YIhMo6d6iPO2Z6halgSQaSSoo=;
        b=ZKSSHOwPf8Xt/URzLmt0V2vuin5K889hIp5q9DMO2HY1+qVoFpRUN/AVPNcDPXWz93m388
        sK9Ahe0FDcbOq7gdmE0oh19TTsYaJNQ6JUL0H+aq733eUs1d6en7CZDvPPFYj6KqHxcIvj
        OHxyouRkMASVtNIymmm3aL1I62iF3JE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-3wmpd8wIODyBoDL6wEyBSg-1; Mon, 04 May 2020 09:03:31 -0400
X-MC-Unique: 3wmpd8wIODyBoDL6wEyBSg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C0413107ACF5;
        Mon,  4 May 2020 13:03:30 +0000 (UTC)
Received: from workstation (unknown [10.40.195.183])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 369286293D;
        Mon,  4 May 2020 13:03:27 +0000 (UTC)
Date:   Mon, 4 May 2020 15:03:23 +0200
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Christian =?iso-8859-1?Q?G=F6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Subject: Re: [PATCH v2] tree-wide: introduce PYTON_SETUP_ARGS to customize
 setup.py calls on Debian
Message-ID: <20200504130323.GC251987@workstation>
References: <20200407114514.40253-1-cgzones@googlemail.com>
 <20200501134604.20070-1-cgzones@googlemail.com>
MIME-Version: 1.0
In-Reply-To: <20200501134604.20070-1-cgzones@googlemail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1ccMZA6j1vT5UqiK"
Content-Disposition: inline
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

--1ccMZA6j1vT5UqiK
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 01, 2020 at 03:46:04PM +0200, Christian G=F6ttsche wrote:
> On Debian the `distutils` module is patched, so `get_python_lib()` return=
s by default `/usr/lib/python3/dist-packages` (no minor version).
>

Could you wrap the commit message to 75 chars per line, please?

> But `setuptools` affecting setup.py is not patched to create the library =
directory at `/usr/lib/python3/dist-packages` by default, rather than a com=
mand line argument `--install-layout deb` is added.
>=20
> Add PYTON_SETUP_ARGS as argument to affected setup.py calls and add a not=
e in the global ReadMe.

Fix the file name - ReadMe -> README.md

>
> See https://www.debian.org/doc/packaging-manuals/python-policy/packaging_=
tools.html section B.1.
>=20
> Fixes: https://github.com/SELinuxProject/selinux/issues/187

Please provide Signed-off-by:

Also there's a conflicting patch which changes README.md as well -
https://patchwork.kernel.org/patch/11522349/ which I'm going to merge. Coul=
d you
please rebase this patch based on changes from the mentioned patch?

Other than the comments above, I like the patch. Thanks!


> ---
> v2:
>   Use env variable PYTON_SETUP_ARGS instead of internal detection logic
>=20
>  README.md                | 2 ++
>  libselinux/src/Makefile  | 2 +-
>  python/sepolicy/Makefile | 2 +-
>  3 files changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/README.md b/README.md
> index 974280f9..3c97a5a3 100644
> --- a/README.md
> +++ b/README.md
> @@ -18,6 +18,8 @@ To build and install everything under a private directo=
ry, run:
> =20
>      make DESTDIR=3D~/obj install install-pywrap
> =20
> +Note: On Debian `PYTON_SETUP_ARGS=3D--install-layout=3Ddeb` needs to be =
set in order to create the correct python directory structure.
> +
>  To install as the default system libraries and binaries
>  (overwriting any previously installed ones - dangerous!),
>  on x86_64, run:
> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> index 73303c36..bccc852d 100644
> --- a/libselinux/src/Makefile
> +++ b/libselinux/src/Makefile
> @@ -174,7 +174,7 @@ install: all
>  =09ln -sf --relative $(DESTDIR)$(SHLIBDIR)/$(LIBSO) $(DESTDIR)$(LIBDIR)/=
$(TARGET)
> =20
>  install-pywrap: pywrap
> -=09$(PYTHON) setup.py install --prefix=3D$(PREFIX) `test -n "$(DESTDIR)"=
 && echo --root $(DESTDIR)`
> +=09$(PYTHON) setup.py install --prefix=3D$(PREFIX) `test -n "$(DESTDIR)"=
 && echo --root $(DESTDIR)` $(PYTON_SETUP_ARGS)
>  =09install -m 644 $(SWIGPYOUT) $(DESTDIR)$(PYTHONLIBDIR)/selinux/__init_=
_.py
>  =09ln -sf --relative $(DESTDIR)$(PYTHONLIBDIR)/selinux/_selinux$(PYCEXT)=
 $(DESTDIR)$(PYTHONLIBDIR)/_selinux$(PYCEXT)
> =20
> diff --git a/python/sepolicy/Makefile b/python/sepolicy/Makefile
> index 69f29fa9..4ad0d4dc 100644
> --- a/python/sepolicy/Makefile
> +++ b/python/sepolicy/Makefile
> @@ -27,7 +27,7 @@ test:
>  =09@$(PYTHON) test_sepolicy.py -v
> =20
>  install:
> -=09$(PYTHON) setup.py install --prefix=3D$(PREFIX) `test -n "$(DESTDIR)"=
 && echo --root $(DESTDIR)`
> +=09$(PYTHON) setup.py install --prefix=3D$(PREFIX) `test -n "$(DESTDIR)"=
 && echo --root $(DESTDIR)` $(PYTON_SETUP_ARGS)
>  =09[ -d $(DESTDIR)$(BINDIR) ] || mkdir -p $(DESTDIR)$(BINDIR)
>  =09install -m 755 sepolicy.py $(DESTDIR)$(BINDIR)/sepolicy
>  =09(cd $(DESTDIR)$(BINDIR); ln -sf sepolicy sepolgen)
> --=20
> 2.26.2
>=20

--1ccMZA6j1vT5UqiK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAl6wEpYACgkQviIJHj72
InXORw/9FuG5t6Y818U9sng/HMEBKOUh8JauPwIykst9i6xhMdq+NcQyRUcie75W
pgdd1winP3L8xAKB5oizrD2bqSmlrYSWgjCkb5zyem0UhEnieDR8iiNjnkAgK5SR
cyjIPQRmCcyIM6N0gUXJ7/CAYxT2+PY+fIcdPD/O7H8V4VRsftmFo8Cc4u7d7ALh
IPFX2eNxOmulaAMNWOn/yLCiVenFwBa4XX3kVxk3GL9HY2Z0bayiAJcYrXcr8gE5
XLLqU1f9q20onK6EIooTar+k3VyT7hSDN2W4jD7vY4FbkG7PqnF/zrIi2xtAk5QE
Sf/rlFQGwjhWhutga+Mc4xAHdK5htiWX89TLMa0oPdFEmBmNwMj8Tc8WmywOEUWQ
dDQnAvjUVRTkPiqnZP0zkG34NLoHD3oqn+K0+VE3fzbRi8l6+tapr6ZecauwZMoh
mnKba0i3yhCiYPqyqEELce3hRjcD1baEqmn9BySrLQY5mS1TmDhUiB2vQcSTaJHj
twbsZ84X5JiIehWg+gFjeGlBStwcp8aUnTtpuTTrgufbCg3TZkU0h8rew/mx3BG0
hCTz/LRRDOcBcsu5jrB+p12XFdPV9DDTHDBuVQd+kUrozmR/wUONvIUk4U/TB6VA
oaKiVAXHHDyOu5Exg5VHgut8QYGr5YsdL/3Dtag0aW6vQBL9RbQ=
=ehkL
-----END PGP SIGNATURE-----

--1ccMZA6j1vT5UqiK--

