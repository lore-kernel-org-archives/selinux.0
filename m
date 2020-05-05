Return-Path: <SRS0=X6Oi=6T=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA7FC47254
	for <selinux@archiver.kernel.org>; Tue,  5 May 2020 08:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25CAB2068E
	for <selinux@archiver.kernel.org>; Tue,  5 May 2020 08:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ee0f2nSP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgEEIlV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 5 May 2020 04:41:21 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:49041 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725915AbgEEIlV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 5 May 2020 04:41:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588668079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aUkxgEfxBdsIHW7+rJj8HNZ6u35sXS0N0skGHvA/cbA=;
        b=ee0f2nSPasKvUBDBL8ntalwI7Vwm18AKAJKHqeuowWyNC8ObdeaqeW5jt5c6C+8nB7p467
        2BwKIWlYXfMZJQJAlE2LhzgIcVBKHeUKz7k81ULmxyOXkqDuIxLCrzG+a49yZj7rcpxRIq
        AiynullyK5m0ZpfpMTkMVNDi7ZpIXQc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-NLaYHeniPWinnzmILolV0w-1; Tue, 05 May 2020 04:41:14 -0400
X-MC-Unique: NLaYHeniPWinnzmILolV0w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7FBA080183C;
        Tue,  5 May 2020 08:41:13 +0000 (UTC)
Received: from workstation (unknown [10.40.195.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3225D60BEC;
        Tue,  5 May 2020 08:41:11 +0000 (UTC)
Date:   Tue, 5 May 2020 10:41:08 +0200
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Christian =?iso-8859-1?Q?G=F6ttsche?= <cgzones@googlemail.com>
Subject: Re: [PATCH v3] tree-wide: introduce PYTHON_SETUP_ARGS to customize
 setup.py calls on Debian
Message-ID: <20200505084108.GA7308@workstation>
References: <20200501134604.20070-1-cgzones@googlemail.com>
 <20200504175501.8114-1-cgzones@googlemail.com>
MIME-Version: 1.0
In-Reply-To: <20200504175501.8114-1-cgzones@googlemail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 04, 2020 at 07:55:01PM +0200, Christian G=F6ttsche wrote:
> On Debian the `distutils` module is patched, so `get_python_lib()`
> returns by default `/usr/lib/python3/dist-packages` (no minor version)
>=20
> But `setuptools` affecting setup.py is not patched to create the library
> directory at `/usr/lib/python3/dist-packages` by default, rather than a
> command line argument `--install-layout deb` is added
>=20
> Add PYTHON_SETUP_ARGS as argument to affected setup.py calls and add a
> note in the global README.md
>=20
> See https://www.debian.org/doc/packaging-manuals/python-policy/packaging_=
tools.html
> Section B.1
>=20
> Fixes: https://github.com/SELinuxProject/selinux/issues/187
>=20
> Signed-off-by: Christian G=F6ttsche <cgzones@googlemail.com>

Acked-by: Petr Lautrbach <plautrba@redhat.com>

Thanks!


> ---
> v3:
>   - Correctly spell python
>   - wrap commit message
>=20
> v2:
>   Use env variable PYTON_SETUP_ARGS instead of internal detection logic
>=20
>  README.md                | 2 ++
>  libselinux/src/Makefile  | 2 +-
>  python/sepolicy/Makefile | 2 +-
>  3 files changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/README.md b/README.md
> index f3257ef5..9d64f0b5 100644
> --- a/README.md
> +++ b/README.md
> @@ -95,6 +95,8 @@ To build and install everything under a private directo=
ry, run:
> =20
>      make DESTDIR=3D~/obj install install-rubywrap install-pywrap
> =20
> +On Debian `PYTHON_SETUP_ARGS=3D--install-layout=3Ddeb` needs to be set w=
hen installing the python wrappers in order to create the correct python di=
rectory structure.
> +
>  To run tests with the built libraries and programs, several paths (relat=
ive to `$DESTDIR`) need to be added to variables `$LD_LIBRARY_PATH`, `$PATH=
` and `$PYTHONPATH`.
>  This can be done using [./scripts/env_use_destdir](./scripts/env_use_des=
tdir):
> =20
> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> index 73303c36..190016e2 100644
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
 && echo --root $(DESTDIR)` $(PYTHON_SETUP_ARGS)
>  =09install -m 644 $(SWIGPYOUT) $(DESTDIR)$(PYTHONLIBDIR)/selinux/__init_=
_.py
>  =09ln -sf --relative $(DESTDIR)$(PYTHONLIBDIR)/selinux/_selinux$(PYCEXT)=
 $(DESTDIR)$(PYTHONLIBDIR)/_selinux$(PYCEXT)
> =20
> diff --git a/python/sepolicy/Makefile b/python/sepolicy/Makefile
> index 69f29fa9..3361be4e 100644
> --- a/python/sepolicy/Makefile
> +++ b/python/sepolicy/Makefile
> @@ -27,7 +27,7 @@ test:
>  =09@$(PYTHON) test_sepolicy.py -v
> =20
>  install:
> -=09$(PYTHON) setup.py install --prefix=3D$(PREFIX) `test -n "$(DESTDIR)"=
 && echo --root $(DESTDIR)`
> +=09$(PYTHON) setup.py install --prefix=3D$(PREFIX) `test -n "$(DESTDIR)"=
 && echo --root $(DESTDIR)` $(PYTHON_SETUP_ARGS)
>  =09[ -d $(DESTDIR)$(BINDIR) ] || mkdir -p $(DESTDIR)$(BINDIR)
>  =09install -m 755 sepolicy.py $(DESTDIR)$(BINDIR)/sepolicy
>  =09(cd $(DESTDIR)$(BINDIR); ln -sf sepolicy sepolgen)
> --=20
> 2.26.2
>=20

--=20
()  ascii ribbon campaign - against html e-mail=20
/\  www.asciiribbon.org   - against proprietary attachments

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAl6xJp4ACgkQviIJHj72
InUuiA//UDuZqiZPCjrIlR08tixA89ob1Vo3cxDmrpGknYqUt/kNDx2gI5pKpn55
iKCyNlxSVaHxa7LCElbeWhSglLPjZd0fRgTqOKWJwvdiST+FXSCu1dNEsP32/JQP
ONJI3at3gUPLWwxC08rsBLEXCXfRu55Z9BaiRExkuoSliHXh0wXh77ZWqoaymZuM
wqSioWmtyeLGl/xCI4H+BUVfWZAN+lvHuFug5v0vYl+nUv1Bmd5VbDUBoE5cuDXu
OjotyIiV+2jeQ1p6QkpyxYGDvJR0U6d4jOI56bSBolrwhjAJCfCYytAcmqYWCdbx
I6aUGPfmYAZOBVbaGibW4cFps+WJlIX5dAUBU/TA4EPIxgjb4u8iCaXgPGzZ+LTc
0J5oJYJ4mP0PIm/SvNSSL9u4fT2D8kRqjVggglAvHaah/qc9vK6LgGtBFpUbYNbP
eZmd4kSdvF1z4Oan2PTzwqH7UnLDJ0VClDZjJ0Ywp8nI2UiykvOTm55loHnUYuMj
LoVocgHWn9StdDTSJ2Ha3yPBxu7oTQ8bt+lTDR6GJKS3FH1ngnQGmHZmVykogLKi
ZsNAVZ8ldM/gxU+SPUu4fcEjhnrgXG3crqxamod0ppsALCUiEUD4u9hc7uKRfJCW
oA6DMJs3raXWIrQpJ6Ahl6JF2ZzLGwItUStLlofxF4cSMHTsWEw=
=hgI/
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--

