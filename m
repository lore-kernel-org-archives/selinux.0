Return-Path: <SRS0=yRyW=65=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79696C433E0
	for <selinux@archiver.kernel.org>; Fri, 15 May 2020 13:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D9B420657
	for <selinux@archiver.kernel.org>; Fri, 15 May 2020 13:35:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NzPl4AGx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbgEONft (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 15 May 2020 09:35:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57634 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726141AbgEONft (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 15 May 2020 09:35:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589549748;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lWw8RwGv2A17eryTuzPC3CmBir9xZqDRIK3sLe11T3Q=;
        b=NzPl4AGxztKNH5YlcXl97+wTvgpUokY/ZDi2zp4raGqho7SdY/hSuMZdW2hav7KvNH5bSs
        F4R+GLNGfl+JWTRxy5onju4cEmqROGVG3YmHrrINEi4P1xWhreJnVpkZTbwdWRrUn5hMLq
        kylh9OoggDNB1qN73qo/mcQ0GN9t8Pc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-6M4UZM5LMD-qxGyPlfHjGQ-1; Fri, 15 May 2020 09:35:44 -0400
X-MC-Unique: 6M4UZM5LMD-qxGyPlfHjGQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C9180107ACF5;
        Fri, 15 May 2020 13:35:43 +0000 (UTC)
Received: from workstation (unknown [10.40.194.255])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F0DFB1001B2C;
        Fri, 15 May 2020 13:35:42 +0000 (UTC)
Date:   Fri, 15 May 2020 15:35:40 +0200
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Topi Miettinen <toiwoton@gmail.com>
Subject: Re: [PATCH v3] secilc/docs: fix use of TMPDIR
Message-ID: <20200515133540.GD255621@workstation>
References: <20200515114111.11428-1-toiwoton@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20200515114111.11428-1-toiwoton@gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vni90+aGYgRvsTuO"
Content-Disposition: inline
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

--vni90+aGYgRvsTuO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 15, 2020 at 02:41:11PM +0300, Topi Miettinen wrote:
> Environment variable TMPDIR may be already set for the user building
> and this could be equal to $XDG_RUNTIME_DIR or /tmp which are existing
> directories. Then when running 'make clean', there are unintended side
> effects:
>=20
> rm -rf /run/user/1000
> rm: cannot remove '/run/user/1000/dconf/user': Permission denied
> rm: cannot remove '/run/user/1000/systemd': Permission denied
> rm: cannot remove '/run/user/1000/gnupg': Permission denied
> rm: cannot remove '/run/user/1000/dbus-1': Is a directory
> rm: cannot remove '/run/user/1000/inaccessible': Permission denied
> make[1]: *** [Makefile:68: clean] Error 1
>=20
> Fix by always setting the variable.
>=20
> Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
> Suggested-by: Petr Lautrbach <plautrba@redhat.com>

Acked-by: Petr Lautrbach <plautrba@redhat.com>

Thanks!

> ---
>  secilc/docs/Makefile | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/secilc/docs/Makefile b/secilc/docs/Makefile
> index 6b07ce7f..197ccef2 100644
> --- a/secilc/docs/Makefile
> +++ b/secilc/docs/Makefile
> @@ -1,8 +1,8 @@
> -CWD ?=3D $(shell pwd)
> -HTMLDIR ?=3D $(CWD)/html
> -PDFDIR ?=3D $(CWD)/pdf
> -TMPDIR ?=3D $(CWD)/tmp
> -TESTDIR ?=3D $(CWD)/../test
> +CWD =3D $(shell pwd)
> +HTMLDIR =3D $(CWD)/html
> +PDFDIR =3D $(CWD)/pdf
> +TMPDIR =3D $(CWD)/tmp
> +TESTDIR =3D $(CWD)/../test
> =20
>  # All the markdown files that make up the guide:
>  FILE_LIST ?=3D cil_introduction.md \
> --=20
> 2.26.2
>=20

--=20
()  ascii ribbon campaign - against html e-mail=20
/\  www.asciiribbon.org   - against proprietary attachments

--vni90+aGYgRvsTuO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAl6+mqUACgkQviIJHj72
InXJfBAAgsgoyvaQ1N3W++iWFqO8oD9zGjD/iL1al5r6aaWRXjzU3n8sWTklI0fN
QXUY5RkRw0LykQc3EfZWLEmHwS+NJcxBRhaaSVrVbgRSB8Qul2omOvu4xnKTkXQv
5VxpJwaFLJZcCtC1nndhYG422EkG5wNxvrk0tl1VuN9YYhE1bku+d/2wP9Mdmobb
xRCv6U1JKO8TNBDcmblxvWzJOQTgI0huVqVCwY77WI7eEKl+owkR7quwzbzcnvVf
1gU6mwwCG9ngMunU7yC3Y+LpZuh/PZsUkUK4Ud2S2GlcRB1WIaDI9B98mKKuyRHQ
ZJDf6+0mNcn51fpnRINCrbxhZFNVaNQsjoH/nel2Ao8730au12F3u4DW8j0RtR4T
G/frJuQTt/ynt+eTyS+4sPxCqfXtRNeMzr0I5B4Gp4c8lC3deJrwiLmY1GWNr5a+
ohx28Q9BAMZ/StfBT40GNDBgGnxZexaQAATdNIqr17Bxe5GNlvYooPCq6JwABklo
hUgXEeACmLCq7/Z2FOyeavIjx2FzcpnfzsP4L40jnqQr7paoW8ALSk6x92U6ZCim
ZANnpv2Vl21OqaRmKXU6CZ+DnnZRGuNMuzHKwFSWQeKFvX7HMqKHy7rcJ3kiqWgA
pUCy67A6Gr6R17Vv97v43km2mIfeR20Tew2qrJfZ8X9NAUZ1fgA=
=0Aa6
-----END PGP SIGNATURE-----

--vni90+aGYgRvsTuO--

