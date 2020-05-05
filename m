Return-Path: <SRS0=X6Oi=6T=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF81C47254
	for <selinux@archiver.kernel.org>; Tue,  5 May 2020 13:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 030D9206A5
	for <selinux@archiver.kernel.org>; Tue,  5 May 2020 13:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ux1Dk3vT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729059AbgEENUV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 5 May 2020 09:20:21 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42488 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728972AbgEENUV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 5 May 2020 09:20:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588684819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JE1PwIQDW20sRdq/mc5xmjEhpwoX0J/NFnPzWkySiOU=;
        b=Ux1Dk3vTyjf/novm+o2Mt+H/AjCMjoV8rbJYwMEaoGYPRlzShSoeRCECNNeyjeL83EjY6S
        6ETLk/dLecfblFZTBJbzot2sokHYsXHf7LTV6Qi/totGxSzBTKvVRA3L+MUvKp23DQuxjX
        QsJaDMrZqlpjnAzhiEPCY3Jn3bC19vM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-504-DwnBLsFCNGSyIaeHphL4sQ-1; Tue, 05 May 2020 09:20:05 -0400
X-MC-Unique: DwnBLsFCNGSyIaeHphL4sQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BC4877BB1;
        Tue,  5 May 2020 13:20:04 +0000 (UTC)
Received: from workstation (unknown [10.40.195.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6DD256295D;
        Tue,  5 May 2020 13:20:03 +0000 (UTC)
Date:   Tue, 5 May 2020 15:19:59 +0200
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Nicolas Iooss <nicolas.iooss@m4x.org>
Subject: Re: [PATCH 2/2] scripts/env_use_destdir: propagate PREFIX, LIBDIR,
 BINDIR, etc.
Message-ID: <20200505131959.GC7308@workstation>
References: <20200501092929.1162708-1-nicolas.iooss@m4x.org>
 <20200501092929.1162708-2-nicolas.iooss@m4x.org>
 <20200504123152.GB251987@workstation>
MIME-Version: 1.0
In-Reply-To: <20200504123152.GB251987@workstation>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="TYecfFk8j8mZq+dy"
Content-Disposition: inline
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

--TYecfFk8j8mZq+dy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 04, 2020 at 02:31:52PM +0200, Petr Lautrbach wrote:
> On Fri, May 01, 2020 at 11:29:29AM +0200, Nicolas Iooss wrote:
> > On systems using non-default `PREFIX`, `LIBDIR`, `SHLIBDIR`, `BINDIR`
> > or `SBINDIR`, running
> > `DESTDIR=3D/path/to/destdir ./scripts/env_use_destdir make test`
> > does not perform the intended behavior, because the testing programs an=
d
> > libraries are installed into locations that are not added to
> > `LD_LIBRARY_PATH` nor `PATH`.
> >=20
> > More precisely, with `LIBDIR=3D/usr/lib64 SHLIBDIR=3D/lib64`, `env_use_=
destdir`
> > does not work. Fix this by adding the installation directories relative
> > to `DESTDIR` in `LD_LIBRARY_PATH` and `PATH`.
> >=20
> > Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>=20
> For both patches:
>=20
> Acked-by: Petr Lautrbach <plautrba@redhat.com>

Both applied.

> > ---
> >  scripts/env_use_destdir | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> >=20
> > diff --git a/scripts/env_use_destdir b/scripts/env_use_destdir
> > index 491da58f9207..8274013e9cf0 100755
> > --- a/scripts/env_use_destdir
> > +++ b/scripts/env_use_destdir
> > @@ -22,7 +22,26 @@ if [ -z "${DESTDIR:-}" ] ; then
> >  fi
> > =20
> >  export LD_LIBRARY_PATH=3D"$DESTDIR/usr/lib:$DESTDIR/lib"
> > +if [ -n "${PREFIX:-}" ] ; then
> > +    LD_LIBRARY_PATH=3D"$DESTDIR$PREFIX/lib:$LD_LIBRARY_PATH"
> > +fi
> > +if [ -n "${LIBDIR:-}" ] ; then
> > +    LD_LIBRARY_PATH=3D"$DESTDIR$LIBDIR:$LD_LIBRARY_PATH"
> > +fi
> > +if [ -n "${SHLIBDIR:-}" ] ; then
> > +    LD_LIBRARY_PATH=3D"$DESTDIR$SHLIBDIR:$LD_LIBRARY_PATH"
> > +fi
> > +
> >  export PATH=3D"$DESTDIR/usr/sbin:$DESTDIR/usr/bin:$DESTDIR/sbin:$DESTD=
IR/bin:$PATH"
> > +if [ -n "${PREFIX:-}" ] ; then
> > +    PATH=3D"$DESTDIR$PREFIX/sbin:$DESTDIR$PREFIX/bin:$LD_LIBRARY_PATH"
> > +fi
> > +if [ -n "${BINDIR:-}" ] ; then
> > +    PATH=3D"$DESTDIR$BINDIR:$PATH"
> > +fi
> > +if [ -n "${SBINDIR:-}" ] ; then
> > +    PATH=3D"$DESTDIR$SBINDIR:$PATH"
> > +fi
> > =20
> >  NEW_PYTHONPATH=3D"$DESTDIR$(${PYTHON:-python3} -c "from distutils.sysc=
onfig import *;print(get_python_lib(plat_specific=3D1, prefix=3D'/usr'))"):=
$DESTDIR$(${PYTHON:-python3} -c "from distutils.sysconfig import *;print(ge=
t_python_lib(prefix=3D'/usr'))")"
> >  if [ -n "${PYTHONPATH:-}" ] ; then
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

--TYecfFk8j8mZq+dy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAl6xZ/gACgkQviIJHj72
InXq2g//VaBPRHMk2sJ3CTdtHwq/FqpXFprAhx17SkAEXHjwBGNAc4yMW4OrlCWA
NPEV0d8gHztYCisDST7iy/AECr+w5v6jF87uuhn8rrBvK4r7e6/XYXsNn8HEV4wn
6iJXS8kII54MxvKyvZZrg3ah4ES8mev3fiFEScMcfGNKSNUyK3Xm8Pn2KRp0XiZ+
4gBUJAWgaeSR/nyl/BCAx6K7H06ypoVGUOBm9PYByvEBjiuY5tuYzL1BV2ph4iwX
uqJX7oTH3RiDualPYvcGxCW3U3EoWcFvS5X/Se1deFy69tWOtsZ66jPuPZgKC/Gn
/isYzzIvNqLR7xSCBP6CvbJlGPCwqHO0OzWf979PuV/xAsG+Vzh6DXhaVlZyFncP
Tw6HCM9zo9BIWnpsxUXT8rWq4+ZxfQ+HxMjNjPPgNLXaMuFqT/Sy08De9sPNX6DT
/YDWf9YU/TnrZXZjTNDAaiSnGqDwRkqszlv2kIhN2vilYbHG0bDZiyTHUbehz9nq
sjgKS5LezvcRLBAeuX9tpdCfcQRNaXLy/4WWu/xUaIyDrqh5HnbM7CASh7+7YEOM
5+GYvrZEfywvPaYDaXaGohfxMtG6gsw3z44HaQ1SjsAeBWcZNmLL36atDGJ7JUTO
WMksL8HePTOiYit8+qfVThq/YlCbZobOVkJlbrjzZSK+o5H1O3M=
=9e6S
-----END PGP SIGNATURE-----

--TYecfFk8j8mZq+dy--

