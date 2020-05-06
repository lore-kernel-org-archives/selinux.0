Return-Path: <SRS0=wTGR=6U=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19377C28CBC
	for <selinux@archiver.kernel.org>; Wed,  6 May 2020 14:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5B1D206D5
	for <selinux@archiver.kernel.org>; Wed,  6 May 2020 14:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FTZzmPYR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbgEFOVS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 May 2020 10:21:18 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24060 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726114AbgEFOVS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 6 May 2020 10:21:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588774876;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zkw7YJ1f0BqbDKUE7Eq0CHV9HNM2g9kpmrJ2DsznYsw=;
        b=FTZzmPYRrm7BXpsRiRAeYXKLRg7LTwVjhZBYvtp9dMUWIn05wVXjm2er7z/ridnH1PAu6e
        A4dgNfoValdxuzYtXxNdJZEMGVFPbGsSA0/Do+Sl4d3GZ4mpGi4ylIsznJ5JSQaeJ10oSB
        HCkyajBhzG9CtZjPx2tAMfNMtVdCggM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-cd6ETnFTNMOiey0muHeU7w-1; Wed, 06 May 2020 10:21:09 -0400
X-MC-Unique: cd6ETnFTNMOiey0muHeU7w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7B23A80058A;
        Wed,  6 May 2020 14:21:08 +0000 (UTC)
Received: from workstation (unknown [10.40.194.248])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6C01D62997;
        Wed,  6 May 2020 14:21:05 +0000 (UTC)
Date:   Wed, 6 May 2020 16:21:01 +0200
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Nicolas Iooss <nicolas.iooss@m4x.org>
Subject: Re: [PATCH] Travis-CI: upgrade to Ubuntu 18.04 and latest releases
 of Python and Ruby
Message-ID: <20200506142101.GC52210@workstation>
References: <20200504191122.732231-1-nicolas.iooss@m4x.org>
 <20200505084455.GB7308@workstation>
MIME-Version: 1.0
In-Reply-To: <20200505084455.GB7308@workstation>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="MnLPg7ZWsaic7Fhd"
Content-Disposition: inline
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

--MnLPg7ZWsaic7Fhd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 05, 2020 at 10:44:55AM +0200, Petr Lautrbach wrote:
> On Mon, May 04, 2020 at 09:11:22PM +0200, Nicolas Iooss wrote:
> > * Test Python 3.8 and Pypy3 3.6-7.2.0
> > * Test Ruby 2.7
> > * Drop Ruby 2.2 and 2.3 (they are not supported with Ubuntu 18.04 in
> >   https://rubies.travis-ci.org/)
> > * While at it, replace deprecated libdbus-glib-1-dev with libglib2.0-de=
v
> >   now that restorecond has been upgraded.
> >=20
> > Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>=20
> Acked-by: Petr Lautrbach <plautrba@redhat.com>

Applied.

>=20
> > ---
> >  .travis.yml | 40 ++++++++++++++++++++--------------------
> >  1 file changed, 20 insertions(+), 20 deletions(-)
> >=20
> > diff --git a/.travis.yml b/.travis.yml
> > index 4361d26cbb83..c36e721a5e1d 100644
> > --- a/.travis.yml
> > +++ b/.travis.yml
> > @@ -11,33 +11,33 @@ compiler:
> >  env:
> >    matrix:
> >      # Test the last version of Python and Ruby together, with some lin=
kers
> > -    - PYVER=3Dpython3.7 RUBYLIBVER=3D2.6
> > -    - PYVER=3Dpython3.7 RUBYLIBVER=3D2.6 TEST_FLAGS_OVERRIDE=3D1
> > -    - PYVER=3Dpython3.7 RUBYLIBVER=3D2.6 TEST_DEBUG=3D1
> > -    - PYVER=3Dpython3.7 RUBYLIBVER=3D2.6 LINKER=3Dgold
> > -    - PYVER=3Dpython3.7 RUBYLIBVER=3D2.6 LINKER=3Dbfd
> > -
> > -    # Test several Python versions
> > -    - PYVER=3Dpython3.5 RUBYLIBVER=3D2.6
> > -    - PYVER=3Dpython3.6 RUBYLIBVER=3D2.6
> > -    - PYVER=3Dpypy3.5-6.0 RUBYLIBVER=3D2.6
> > +    - PYVER=3Dpython3.8 RUBYLIBVER=3D2.7
> > +    - PYVER=3Dpython3.8 RUBYLIBVER=3D2.7 TEST_FLAGS_OVERRIDE=3D1
> > +    - PYVER=3Dpython3.8 RUBYLIBVER=3D2.7 TEST_DEBUG=3D1
> > +    - PYVER=3Dpython3.8 RUBYLIBVER=3D2.7 LINKER=3Dgold
> > +    - PYVER=3Dpython3.8 RUBYLIBVER=3D2.7 LINKER=3Dbfd
> > +
> > +    # Test several Python versions (https://docs.travis-ci.com/user/la=
nguages/python/#python-versions)
> > +    - PYVER=3Dpython3.5 RUBYLIBVER=3D2.7
> > +    - PYVER=3Dpython3.6 RUBYLIBVER=3D2.7
> > +    - PYVER=3Dpython3.7 RUBYLIBVER=3D2.7
> > +    - PYVER=3Dpypy3.6-7.2.0 RUBYLIBVER=3D2.7
> > =20
> >      # Test several Ruby versions (http://rubies.travis-ci.org/)
> > -    - PYVER=3Dpython3.7 RUBYLIBVER=3D2.5.1
> > -    - PYVER=3Dpython3.7 RUBYLIBVER=3D2.4
> > -    - PYVER=3Dpython3.7 RUBYLIBVER=3D2.3
> > -    - PYVER=3Dpython3.7 RUBYLIBVER=3D2.2
> > +    - PYVER=3Dpython3.8 RUBYLIBVER=3D2.6
> > +    - PYVER=3Dpython3.8 RUBYLIBVER=3D2.5.1
> > +    - PYVER=3Dpython3.8 RUBYLIBVER=3D2.4
> > =20
> >  matrix:
> >    exclude:
> >      - compiler: clang
> > -      env: PYVER=3Dpython3.7 RUBYLIBVER=3D2.6 LINKER=3Dgold
> > +      env: PYVER=3Dpython3.8 RUBYLIBVER=3D2.7 LINKER=3Dgold
> >      - compiler: clang
> > -      env: PYVER=3Dpython3.7 RUBYLIBVER=3D2.6 LINKER=3Dbfd
> > +      env: PYVER=3Dpython3.8 RUBYLIBVER=3D2.7 LINKER=3Dbfd
> > =20
> > -# Use Travis-CI Ubuntu 16.04 Xenial Xerus infrastructure, "full image"=
 variant
> > +# Use Travis-CI Ubuntu 18.04 Bionic Beaver, "full image" variant
> >  sudo: required
> > -dist: xenial
> > +dist: bionic
> > =20
> >  # Install SELinux userspace utilities dependencies
> >  addons:
> > @@ -52,7 +52,7 @@ addons:
> >      - libcap-dev
> >      - libcap-ng-dev # This package is not whitelisted for the containe=
r infrastructure (https://github.com/travis-ci/apt-package-whitelist/issues=
/1096)
> >      - libcunit1-dev
> > -    - libdbus-glib-1-dev
> > +    - libglib2.0-dev
> >      - libpcre3-dev
> >      - patch
> >      - python3-dev
> > @@ -78,7 +78,7 @@ install:
> >    # Download the required python version if it is not installed
> >    - VIRTUAL_ENV=3D"$HOME/virtualenv/$PYVER"
> >    - if ! [ -d "$VIRTUAL_ENV" ] ; then
> > -        curl --retry 10 -o python.tar.bz2 "https://s3.amazonaws.com/tr=
avis-python-archives/binaries/ubuntu/16.04/x86_64/${PYVER/python/python-}.t=
ar.bz2" &&
> > +        curl --retry 10 -o python.tar.bz2 "https://s3.amazonaws.com/tr=
avis-python-archives/binaries/ubuntu/18.04/x86_64/${PYVER/python/python-}.t=
ar.bz2" &&
> >          sudo tar xjf python.tar.bz2 --directory / &&
> >          rm python.tar.bz2 ;
> >      fi
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

--MnLPg7ZWsaic7Fhd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAl6yx8cACgkQviIJHj72
InWzQA//fTz35nGlkz7WiUSTY+e0rRuJFeGIFGFah2FrLaIpdiC116S6XFSfp30x
Zwr25Fqke2kr2cr1zP4fdMWHxPmAd9uo35EHwCFsHv4sSoAEh4wXWbO21IUsspd0
5gJ8MjtFCNFeYnIdN0Hw/fy3nYH0seqVHmiySSnLnooL/vEqa/Y0KvxYx2aYBESE
/NDNMouy1fR8ON0s+szGzc6Ny/QMtf5jrSLPgYEYsivdjTrY7KVI+CsawIixLvXD
kFBa48lHFWc4hl9UIbyU9yVXTj8XsTsuvFRctJiHp32arQjDU/FxTZI3FGVAGsIV
QjoMtWpqxoZ2lZ9WEC9GXUdTTNWV3hkvYZWPtpFlFkhvgA2YtI1++3hxJq7V+ytG
BSkpNhr8swjbefQgn4FIlgE+9CQ6N780YKSCWTKwmUykq335kw4GexaWlVPWt9Ov
N/sxoao13NhU/wzc7ON0m7pNd/DhljC1Ip9QoSj843n89/hvyqA0g3v3TprN42l7
5RuYRXuDTp10t8zE5zRU2MO6SdjXKAh9hC1p6o4j8EqxKyhECNmH+o2zb5pqLqkJ
elryI5kidDY/w2HPf3JqKD1CvNQLUs6HNXk4EfEAUc68On4aD3mx7ZBezsncsXlf
UkYS1wwAbH8D111SLge6iPtTMu/dVRoLNKyuvowuErPTCJ7qrEY=
=dVKY
-----END PGP SIGNATURE-----

--MnLPg7ZWsaic7Fhd--

