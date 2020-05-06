Return-Path: <SRS0=wTGR=6U=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B3C6C28CBC
	for <selinux@archiver.kernel.org>; Wed,  6 May 2020 14:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52C4620746
	for <selinux@archiver.kernel.org>; Wed,  6 May 2020 14:20:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RFgbXLr7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbgEFOUq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 May 2020 10:20:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39070 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726114AbgEFOUq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 6 May 2020 10:20:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588774844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XE/RuSpZisBGIrUP0156iZqyo+47JxyDUP0ZiQFvvRE=;
        b=RFgbXLr7WssgAo0tiL4L3uFtbUW7tozE4itn4By74bu+aWRybyifJUzgugP79DFoOTNoDZ
        rnrOB9SucnXfhpo2GjRNKNgbnKun0HrO3SjDmm1xanMVSLBAZ6SwZmtc9hz5Mrm39MoOVb
        Nc73JNqNhf3HlF8R+ty63RM8taULrGg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-Ec7vWbU7PQWY6KE0y1me4w-1; Wed, 06 May 2020 10:20:31 -0400
X-MC-Unique: Ec7vWbU7PQWY6KE0y1me4w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5ADEE107ACF6;
        Wed,  6 May 2020 14:20:30 +0000 (UTC)
Received: from workstation (unknown [10.40.194.248])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 451835C1D6;
        Wed,  6 May 2020 14:20:28 +0000 (UTC)
Date:   Wed, 6 May 2020 16:20:25 +0200
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Christian =?iso-8859-1?Q?G=F6ttsche?= <cgzones@googlemail.com>
Subject: Re: [PATCH v3] tree-wide: introduce PYTHON_SETUP_ARGS to customize
 setup.py calls on Debian
Message-ID: <20200506142025.GB52210@workstation>
References: <20200501134604.20070-1-cgzones@googlemail.com>
 <20200504175501.8114-1-cgzones@googlemail.com>
 <20200505084108.GA7308@workstation>
MIME-Version: 1.0
In-Reply-To: <20200505084108.GA7308@workstation>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0ntfKIWw70PvrIHh"
Content-Disposition: inline
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

--0ntfKIWw70PvrIHh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 05, 2020 at 10:41:08AM +0200, Petr Lautrbach wrote:
> On Mon, May 04, 2020 at 07:55:01PM +0200, Christian G=F6ttsche wrote:
> > On Debian the `distutils` module is patched, so `get_python_lib()`
> > returns by default `/usr/lib/python3/dist-packages` (no minor version)
> >=20
> > But `setuptools` affecting setup.py is not patched to create the librar=
y
> > directory at `/usr/lib/python3/dist-packages` by default, rather than a
> > command line argument `--install-layout deb` is added
> >=20
> > Add PYTHON_SETUP_ARGS as argument to affected setup.py calls and add a
> > note in the global README.md
> >=20
> > See https://www.debian.org/doc/packaging-manuals/python-policy/packagin=
g_tools.html
> > Section B.1
> >=20
> > Fixes: https://github.com/SELinuxProject/selinux/issues/187
> >=20
> > Signed-off-by: Christian G=F6ttsche <cgzones@googlemail.com>
>=20
> Acked-by: Petr Lautrbach <plautrba@redhat.com>
>=20
> Thanks!

Applied.

>=20
> > ---
> > v3:
> >   - Correctly spell python
> >   - wrap commit message
> >=20
> > v2:
> >   Use env variable PYTON_SETUP_ARGS instead of internal detection logic
> >=20
> >  README.md                | 2 ++
> >  libselinux/src/Makefile  | 2 +-
> >  python/sepolicy/Makefile | 2 +-
> >  3 files changed, 4 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/README.md b/README.md
> > index f3257ef5..9d64f0b5 100644
> > --- a/README.md
> > +++ b/README.md
> > @@ -95,6 +95,8 @@ To build and install everything under a private direc=
tory, run:
> > =20
> >      make DESTDIR=3D~/obj install install-rubywrap install-pywrap
> > =20
> > +On Debian `PYTHON_SETUP_ARGS=3D--install-layout=3Ddeb` needs to be set=
 when installing the python wrappers in order to create the correct python =
directory structure.
> > +
> >  To run tests with the built libraries and programs, several paths (rel=
ative to `$DESTDIR`) need to be added to variables `$LD_LIBRARY_PATH`, `$PA=
TH` and `$PYTHONPATH`.
> >  This can be done using [./scripts/env_use_destdir](./scripts/env_use_d=
estdir):
> > =20
> > diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> > index 73303c36..190016e2 100644
> > --- a/libselinux/src/Makefile
> > +++ b/libselinux/src/Makefile
> > @@ -174,7 +174,7 @@ install: all
> >  =09ln -sf --relative $(DESTDIR)$(SHLIBDIR)/$(LIBSO) $(DESTDIR)$(LIBDIR=
)/$(TARGET)
> > =20
> >  install-pywrap: pywrap
> > -=09$(PYTHON) setup.py install --prefix=3D$(PREFIX) `test -n "$(DESTDIR=
)" && echo --root $(DESTDIR)`
> > +=09$(PYTHON) setup.py install --prefix=3D$(PREFIX) `test -n "$(DESTDIR=
)" && echo --root $(DESTDIR)` $(PYTHON_SETUP_ARGS)
> >  =09install -m 644 $(SWIGPYOUT) $(DESTDIR)$(PYTHONLIBDIR)/selinux/__ini=
t__.py
> >  =09ln -sf --relative $(DESTDIR)$(PYTHONLIBDIR)/selinux/_selinux$(PYCEX=
T) $(DESTDIR)$(PYTHONLIBDIR)/_selinux$(PYCEXT)
> > =20
> > diff --git a/python/sepolicy/Makefile b/python/sepolicy/Makefile
> > index 69f29fa9..3361be4e 100644
> > --- a/python/sepolicy/Makefile
> > +++ b/python/sepolicy/Makefile
> > @@ -27,7 +27,7 @@ test:
> >  =09@$(PYTHON) test_sepolicy.py -v
> > =20
> >  install:
> > -=09$(PYTHON) setup.py install --prefix=3D$(PREFIX) `test -n "$(DESTDIR=
)" && echo --root $(DESTDIR)`
> > +=09$(PYTHON) setup.py install --prefix=3D$(PREFIX) `test -n "$(DESTDIR=
)" && echo --root $(DESTDIR)` $(PYTHON_SETUP_ARGS)
> >  =09[ -d $(DESTDIR)$(BINDIR) ] || mkdir -p $(DESTDIR)$(BINDIR)
> >  =09install -m 755 sepolicy.py $(DESTDIR)$(BINDIR)/sepolicy
> >  =09(cd $(DESTDIR)$(BINDIR); ln -sf sepolicy sepolgen)
> > --=20
> > 2.26.2
> >=20
>=20
> --=20
> ()  ascii ribbon campaign - against html e-mail=20
> /\  www.asciiribbon.org   - against proprietary attachments



--=20
()  ascii ribbon campaign - against html e-mail=20
/\  www.asciiribbon.org   - against proprietary attachments

--0ntfKIWw70PvrIHh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAl6yx6MACgkQviIJHj72
InV97Q/8CLzvr18GSZIv1FoyNkkv3WH1pD5QlYnEsYge11k3Vs6MTYWHZRzKT+3K
Yky+I1OWmOUuLVg0eNzFjIlHJkz7ruL08EHTIL9BGrgrne1/jhO9uCwiqpb9yauY
2wsxSxZ9LzASYB4KvJUXjcBJUThJIyMQdjw6qKM1lGqfW4NNY4W8V5OrCeECfQ0q
CebrULiHN0TD/4+b0kHsEKvG51HqoLap/+Hry9rCS8L0pxF6EWkW9s9eRnVMePed
AGsIYsgR7E9kLFtPCCdlF6b2ULQMuOTvycBdf+9qbFw0wcyyQqrbubTJtH/5Kr2L
xqmGm67pkIZ1nb6UEtAYPzdSQeWkM9oYJikquCXd2iRQBs1ZspTBWnZoktW8bo+a
DQiGg0kB+7MuvufI/07pc6htDyAOxAV28gA5W+OjXFnRgcILKRcN1IOaF9mc3tVb
nTF7uGtp7q4ugWTtw+bLX5kR+tgzwQPF8l+jhx08/ViuuoZ9I/7sqIWD4loCDoxo
O+OZO0V7JMLJiOA/Okg+1HFiEuKiZaY3Ewcg81Yce2dCBAOVRoI1XS73rk1t8nbt
rIXh+JnexGF2orZSrfQGm6pYZYioYnVD0ZLwG5CqprYgi7uZTnBYcXJNb+TMtleU
2y1qyJ4/+VHKzAPpAgNbdQ2O5r0K2HwSmJ1ziwXcCAyYcK/h7BI=
=+Sst
-----END PGP SIGNATURE-----

--0ntfKIWw70PvrIHh--

