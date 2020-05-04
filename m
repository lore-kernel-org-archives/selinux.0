Return-Path: <SRS0=mV6Z=6S=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA651C3A5A9
	for <selinux@archiver.kernel.org>; Mon,  4 May 2020 12:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A73FA20661
	for <selinux@archiver.kernel.org>; Mon,  4 May 2020 12:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bENxhzMs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgEDMcF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 4 May 2020 08:32:05 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28888 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726712AbgEDMcF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 4 May 2020 08:32:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588595523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8QFuori7USVR44t5+xheDZQcebvzmjX9MeKXpoaUUwI=;
        b=bENxhzMsd8mBxqTflHyK10RVI54egKBSPgBOnU2Yk9IHMJ/UoDMnN8LXduWTvAGtUTSn9S
        QPbPDsnBPZzwVpRVLmA4zZByV4oHocz7xZcHyIjYz+Dbd0DAYySl7tprMjZUKJKZ78jNSl
        Sed1egvNdaOeGJ64T8rSQDVaWEFAzA0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-J2PMWODWPnmSgbp9aMM6pg-1; Mon, 04 May 2020 08:31:59 -0400
X-MC-Unique: J2PMWODWPnmSgbp9aMM6pg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BE978100CCC6;
        Mon,  4 May 2020 12:31:58 +0000 (UTC)
Received: from workstation (unknown [10.40.195.183])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1718946;
        Mon,  4 May 2020 12:31:56 +0000 (UTC)
Date:   Mon, 4 May 2020 14:31:52 +0200
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Nicolas Iooss <nicolas.iooss@m4x.org>
Subject: Re: [PATCH 2/2] scripts/env_use_destdir: propagate PREFIX, LIBDIR,
 BINDIR, etc.
Message-ID: <20200504123152.GB251987@workstation>
References: <20200501092929.1162708-1-nicolas.iooss@m4x.org>
 <20200501092929.1162708-2-nicolas.iooss@m4x.org>
MIME-Version: 1.0
In-Reply-To: <20200501092929.1162708-2-nicolas.iooss@m4x.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dc+cDN39EJAMEtIO"
Content-Disposition: inline
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

--dc+cDN39EJAMEtIO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 01, 2020 at 11:29:29AM +0200, Nicolas Iooss wrote:
> On systems using non-default `PREFIX`, `LIBDIR`, `SHLIBDIR`, `BINDIR`
> or `SBINDIR`, running
> `DESTDIR=3D/path/to/destdir ./scripts/env_use_destdir make test`
> does not perform the intended behavior, because the testing programs and
> libraries are installed into locations that are not added to
> `LD_LIBRARY_PATH` nor `PATH`.
>=20
> More precisely, with `LIBDIR=3D/usr/lib64 SHLIBDIR=3D/lib64`, `env_use_de=
stdir`
> does not work. Fix this by adding the installation directories relative
> to `DESTDIR` in `LD_LIBRARY_PATH` and `PATH`.
>=20
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

For both patches:

Acked-by: Petr Lautrbach <plautrba@redhat.com>

> ---
>  scripts/env_use_destdir | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>=20
> diff --git a/scripts/env_use_destdir b/scripts/env_use_destdir
> index 491da58f9207..8274013e9cf0 100755
> --- a/scripts/env_use_destdir
> +++ b/scripts/env_use_destdir
> @@ -22,7 +22,26 @@ if [ -z "${DESTDIR:-}" ] ; then
>  fi
> =20
>  export LD_LIBRARY_PATH=3D"$DESTDIR/usr/lib:$DESTDIR/lib"
> +if [ -n "${PREFIX:-}" ] ; then
> +    LD_LIBRARY_PATH=3D"$DESTDIR$PREFIX/lib:$LD_LIBRARY_PATH"
> +fi
> +if [ -n "${LIBDIR:-}" ] ; then
> +    LD_LIBRARY_PATH=3D"$DESTDIR$LIBDIR:$LD_LIBRARY_PATH"
> +fi
> +if [ -n "${SHLIBDIR:-}" ] ; then
> +    LD_LIBRARY_PATH=3D"$DESTDIR$SHLIBDIR:$LD_LIBRARY_PATH"
> +fi
> +
>  export PATH=3D"$DESTDIR/usr/sbin:$DESTDIR/usr/bin:$DESTDIR/sbin:$DESTDIR=
/bin:$PATH"
> +if [ -n "${PREFIX:-}" ] ; then
> +    PATH=3D"$DESTDIR$PREFIX/sbin:$DESTDIR$PREFIX/bin:$LD_LIBRARY_PATH"
> +fi
> +if [ -n "${BINDIR:-}" ] ; then
> +    PATH=3D"$DESTDIR$BINDIR:$PATH"
> +fi
> +if [ -n "${SBINDIR:-}" ] ; then
> +    PATH=3D"$DESTDIR$SBINDIR:$PATH"
> +fi
> =20
>  NEW_PYTHONPATH=3D"$DESTDIR$(${PYTHON:-python3} -c "from distutils.syscon=
fig import *;print(get_python_lib(plat_specific=3D1, prefix=3D'/usr'))"):$D=
ESTDIR$(${PYTHON:-python3} -c "from distutils.sysconfig import *;print(get_=
python_lib(prefix=3D'/usr'))")"
>  if [ -n "${PYTHONPATH:-}" ] ; then
> --=20
> 2.26.2
>=20

--=20
()  ascii ribbon campaign - against html e-mail=20
/\  www.asciiribbon.org   - against proprietary attachments

--dc+cDN39EJAMEtIO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAl6wCzIACgkQviIJHj72
InVq/A/+K3p+0YnRnUhRLxkyxFeh3Qda8oRp9slvlaKVZHX5mNjeIOzAFfPCD/cU
vI84vXIosii1wBy33QpRkzlbOd6fGa4EGCsNwC39idGZoRUQ/VlMz2t4IhHKHS+w
EaStSObZQiciwTy1H359n1VuhrqvvtxHLzQhfbiU6mXgfxu6xPLlCAoo8v2SPhaL
S85aVnue/6QIpMscplCAOnhD0XqMn5hYghs2c6pMhRPPVIiq/9yYtUc0CWuRMYd0
gtRGqsIF6KtD9pa8cuN0LrkgumN1337WUdpIvqMfPcgiCHF7UKIY8zzG9JFhg/NU
D8w0wB9jZJDrYflXw5Vc1YTb2raOGSJU/273DYZmbdgYS2kP1iBmQOYuWSpa/37q
0r+5WkjUC8a68u/YhmCD02cnrzzmCsqFLK05DweSAToGoMntHsI2wW8jSgo5FxZ3
pjbhkngI+nVJebd4zfeWyETf7celVQxb/EXRN1gkS2XwJXies74/72aS2OJUOckQ
Dh0u0zvMZ+j1GypbzYAQfL5FQuFZqR8t5Kz//UAvG/N1Zbi0UKm8CdUQNs4Gl569
hrzaKR17U9kyGqKnegG7S1DKdlShuonPMfXDDRmF3WclRAezScSIpBu1wtvgaj4C
RZ5xuv+B82IsqwFV9EWmPoXsqXjAwBd7wUknu4ocWK8fBts2LpE=
=B+UK
-----END PGP SIGNATURE-----

--dc+cDN39EJAMEtIO--

