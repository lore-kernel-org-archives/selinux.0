Return-Path: <SRS0=X6Oi=6T=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78737C47247
	for <selinux@archiver.kernel.org>; Tue,  5 May 2020 08:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56392206B9
	for <selinux@archiver.kernel.org>; Tue,  5 May 2020 08:45:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JAs+aI+c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728600AbgEEIpK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 5 May 2020 04:45:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51941 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725766AbgEEIpK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 5 May 2020 04:45:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588668309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3ogJx8TpsyisTYRbsWC4RiCBqJ28mLrHcykZa6jMy1U=;
        b=JAs+aI+cx0EaZAE+Wx1Xp6o2FtLIVCNZ662Am0x9osYRR9XEKkt2H3fRlMyl0h5bD2VDV2
        QFmW9O0s5q3WSK0Dd5PkDufmXD4GFACrFicmO1GoabWTGf7qs7N0RdeCQwdRzpKC9thNDB
        tLbT9qXmOsTu9JNdILExrQOmOQZwBpM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-126-G_df2DkgNoGEC60iF0A3VA-1; Tue, 05 May 2020 04:45:01 -0400
X-MC-Unique: G_df2DkgNoGEC60iF0A3VA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D93E28015D2;
        Tue,  5 May 2020 08:45:00 +0000 (UTC)
Received: from workstation (unknown [10.40.195.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 037D85C665;
        Tue,  5 May 2020 08:44:58 +0000 (UTC)
Date:   Tue, 5 May 2020 10:44:55 +0200
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Nicolas Iooss <nicolas.iooss@m4x.org>
Subject: Re: [PATCH] Travis-CI: upgrade to Ubuntu 18.04 and latest releases
 of Python and Ruby
Message-ID: <20200505084455.GB7308@workstation>
References: <20200504191122.732231-1-nicolas.iooss@m4x.org>
MIME-Version: 1.0
In-Reply-To: <20200504191122.732231-1-nicolas.iooss@m4x.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="b5gNqxB1S1yM7hjW"
Content-Disposition: inline
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

--b5gNqxB1S1yM7hjW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 04, 2020 at 09:11:22PM +0200, Nicolas Iooss wrote:
> * Test Python 3.8 and Pypy3 3.6-7.2.0
> * Test Ruby 2.7
> * Drop Ruby 2.2 and 2.3 (they are not supported with Ubuntu 18.04 in
>   https://rubies.travis-ci.org/)
> * While at it, replace deprecated libdbus-glib-1-dev with libglib2.0-dev
>   now that restorecond has been upgraded.
>=20
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Acked-by: Petr Lautrbach <plautrba@redhat.com>


> ---
>  .travis.yml | 40 ++++++++++++++++++++--------------------
>  1 file changed, 20 insertions(+), 20 deletions(-)
>=20
> diff --git a/.travis.yml b/.travis.yml
> index 4361d26cbb83..c36e721a5e1d 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -11,33 +11,33 @@ compiler:
>  env:
>    matrix:
>      # Test the last version of Python and Ruby together, with some linke=
rs
> -    - PYVER=3Dpython3.7 RUBYLIBVER=3D2.6
> -    - PYVER=3Dpython3.7 RUBYLIBVER=3D2.6 TEST_FLAGS_OVERRIDE=3D1
> -    - PYVER=3Dpython3.7 RUBYLIBVER=3D2.6 TEST_DEBUG=3D1
> -    - PYVER=3Dpython3.7 RUBYLIBVER=3D2.6 LINKER=3Dgold
> -    - PYVER=3Dpython3.7 RUBYLIBVER=3D2.6 LINKER=3Dbfd
> -
> -    # Test several Python versions
> -    - PYVER=3Dpython3.5 RUBYLIBVER=3D2.6
> -    - PYVER=3Dpython3.6 RUBYLIBVER=3D2.6
> -    - PYVER=3Dpypy3.5-6.0 RUBYLIBVER=3D2.6
> +    - PYVER=3Dpython3.8 RUBYLIBVER=3D2.7
> +    - PYVER=3Dpython3.8 RUBYLIBVER=3D2.7 TEST_FLAGS_OVERRIDE=3D1
> +    - PYVER=3Dpython3.8 RUBYLIBVER=3D2.7 TEST_DEBUG=3D1
> +    - PYVER=3Dpython3.8 RUBYLIBVER=3D2.7 LINKER=3Dgold
> +    - PYVER=3Dpython3.8 RUBYLIBVER=3D2.7 LINKER=3Dbfd
> +
> +    # Test several Python versions (https://docs.travis-ci.com/user/lang=
uages/python/#python-versions)
> +    - PYVER=3Dpython3.5 RUBYLIBVER=3D2.7
> +    - PYVER=3Dpython3.6 RUBYLIBVER=3D2.7
> +    - PYVER=3Dpython3.7 RUBYLIBVER=3D2.7
> +    - PYVER=3Dpypy3.6-7.2.0 RUBYLIBVER=3D2.7
> =20
>      # Test several Ruby versions (http://rubies.travis-ci.org/)
> -    - PYVER=3Dpython3.7 RUBYLIBVER=3D2.5.1
> -    - PYVER=3Dpython3.7 RUBYLIBVER=3D2.4
> -    - PYVER=3Dpython3.7 RUBYLIBVER=3D2.3
> -    - PYVER=3Dpython3.7 RUBYLIBVER=3D2.2
> +    - PYVER=3Dpython3.8 RUBYLIBVER=3D2.6
> +    - PYVER=3Dpython3.8 RUBYLIBVER=3D2.5.1
> +    - PYVER=3Dpython3.8 RUBYLIBVER=3D2.4
> =20
>  matrix:
>    exclude:
>      - compiler: clang
> -      env: PYVER=3Dpython3.7 RUBYLIBVER=3D2.6 LINKER=3Dgold
> +      env: PYVER=3Dpython3.8 RUBYLIBVER=3D2.7 LINKER=3Dgold
>      - compiler: clang
> -      env: PYVER=3Dpython3.7 RUBYLIBVER=3D2.6 LINKER=3Dbfd
> +      env: PYVER=3Dpython3.8 RUBYLIBVER=3D2.7 LINKER=3Dbfd
> =20
> -# Use Travis-CI Ubuntu 16.04 Xenial Xerus infrastructure, "full image" v=
ariant
> +# Use Travis-CI Ubuntu 18.04 Bionic Beaver, "full image" variant
>  sudo: required
> -dist: xenial
> +dist: bionic
> =20
>  # Install SELinux userspace utilities dependencies
>  addons:
> @@ -52,7 +52,7 @@ addons:
>      - libcap-dev
>      - libcap-ng-dev # This package is not whitelisted for the container =
infrastructure (https://github.com/travis-ci/apt-package-whitelist/issues/1=
096)
>      - libcunit1-dev
> -    - libdbus-glib-1-dev
> +    - libglib2.0-dev
>      - libpcre3-dev
>      - patch
>      - python3-dev
> @@ -78,7 +78,7 @@ install:
>    # Download the required python version if it is not installed
>    - VIRTUAL_ENV=3D"$HOME/virtualenv/$PYVER"
>    - if ! [ -d "$VIRTUAL_ENV" ] ; then
> -        curl --retry 10 -o python.tar.bz2 "https://s3.amazonaws.com/trav=
is-python-archives/binaries/ubuntu/16.04/x86_64/${PYVER/python/python-}.tar=
.bz2" &&
> +        curl --retry 10 -o python.tar.bz2 "https://s3.amazonaws.com/trav=
is-python-archives/binaries/ubuntu/18.04/x86_64/${PYVER/python/python-}.tar=
.bz2" &&
>          sudo tar xjf python.tar.bz2 --directory / &&
>          rm python.tar.bz2 ;
>      fi
> --=20
> 2.26.2
>=20

--=20
()  ascii ribbon campaign - against html e-mail=20
/\  www.asciiribbon.org   - against proprietary attachments

--b5gNqxB1S1yM7hjW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAl6xJ4AACgkQviIJHj72
InWdfxAAmMhTy9bxzHCFljignh5EAENv2VIlpUSyAI0taL4dJw9yWKd4GbmMVobk
6G56sGWygu1yclkyUzmVIJLt4WA8RIUBoOfSeLo0POyyLV8ZviWmaBHWMH3yNcaW
UArI0p28fRWrgKLdnaZC33X93yTm4/IPziUS5O7RaG0hxnauMdxVaUVGlzFF8RJf
c8nsrLZlF5F/z+wwmIe3/ypcuoJk8kRZZ8ST5+rj2bjx70KO7XiJ0zjdVgfstRnn
WszIl/kTmU854VeW6oEkT5TdDRGdXuHFBc0zJybGi4HnEg91d5b257gp74My487c
IoLZ/JYHpy2fqGA46nf39Pk3T1T3p1ypnAVRedzvtZLXz69k+b2Oa+K2PqV8z/7W
L8CW+WPsKVLCja9fINfOELIyhXXb5pGWOrHdpmsDYl3Gp+WEREHp43WckF/wFVMN
OkgGFpFJMzZizFXJ4qFKLzW3KBYI2p5xKLr50GHA/TpOQ+eLdB8Gg2pYwYtyytES
uNVDh2HH06+QXSgpkTYQjhiXee6mjb8rJYRupDY7bZI4B9d9VaX/ll7WGskLq9fb
t8/aQ8q+i1bPaBgQ9mwsqRD7SJdfGtOLPet0lPhuNHXG1tKyr8dFf7hjF/P/TA9w
OO449qOuvB7Ywjsm+LDclL19l6kRvSqwNgiqKewEAqJC9I2ThrQ=
=vdpd
-----END PGP SIGNATURE-----

--b5gNqxB1S1yM7hjW--

