Return-Path: <SRS0=BHhV=EI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D56C00A89
	for <selinux@archiver.kernel.org>; Mon,  2 Nov 2020 10:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57ED820706
	for <selinux@archiver.kernel.org>; Mon,  2 Nov 2020 10:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NgthtAJW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbgKBKRU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 2 Nov 2020 05:17:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35272 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728132AbgKBKRU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 2 Nov 2020 05:17:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604312238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y4/FSZnt/CKEi3mCabR8+rLiRCrx++InG6g7xWKZZzA=;
        b=NgthtAJWZ1Pb/XaqkiHcAfIW5muD5OsAz3gTBWvn/HGHIguPghwrwfPHdcSftTeQJGHdxU
        vkmLP2afAly8p6Se1jFMxFipr55ZLYIo2+45rrUFXH+/KNJgnz6Ps35/mNssbp9xj8Q+jv
        laC+2e5SlSrZqW7jZ6/cDHmiXPM9lZk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-QVhdpZJMOuqne1Ea5VAOZw-1; Mon, 02 Nov 2020 05:17:15 -0500
X-MC-Unique: QVhdpZJMOuqne1Ea5VAOZw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D7FE3809DC8;
        Mon,  2 Nov 2020 10:17:14 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.195.78])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C6EA26EF79;
        Mon,  2 Nov 2020 10:17:13 +0000 (UTC)
Date:   Mon, 2 Nov 2020 11:17:10 +0100
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        William Roberts <bill.c.roberts@gmail.com>
Subject: Re: [PATCH userspace] ci: bump Fedora image version to 33
Message-ID: <20201102101710.GA210822@localhost.localdomain>
References: <20201102094310.484837-1-omosnace@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201102094310.484837-1-omosnace@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=plautrba@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 02, 2020 at 10:43:10AM +0100, Ondrej Mosnacek wrote:
> The testsuite will soon be switching to testing multiple filesystems,
> which exposes a bug in F32 image's kernel. Since Fedora 33 has been
> released recently and the testsuite runs just fine on it, just bump the
> image version to avoid the bug.
>=20
> This commit also fixes the script to read out the Fedora image version
> from environment variables instead of using hard-coded values.
>=20
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

Would it make sense to use Rawhide images from the link bellow?

https://download.fedoraproject.org/pub/fedora/linux/development/rawhide/Clo=
ud/x86_64/images/

I think Paul already asked for it in past but I'm not sure what was the out=
come.


> ---
>  .travis.yml                    |  2 +-
>  scripts/ci/travis-kvm-setup.sh | 12 +++++++-----
>  2 files changed, 8 insertions(+), 6 deletions(-)
>=20
> diff --git a/.travis.yml b/.travis.yml
> index 8ea6cc74..6c0f6241 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -36,7 +36,7 @@ matrix:
>        env: PYVER=3Dpython3.8 RUBYLIBVER=3D2.7 LINKER=3Dbfd
>    include:
>      - compiler: gcc
> -      env: TRAVIS_RUN_KVM=3Dtrue TRAVIS_CLOUD_IMAGE_VERSION=3D"32:1.6"
> +      env: TRAVIS_RUN_KVM=3Dtrue FEDORA_MAJOR=3D33 FEDORA_MINOR=3D1.2
>        install:
>          - skip
>        before_script:
> diff --git a/scripts/ci/travis-kvm-setup.sh b/scripts/ci/travis-kvm-setup=
.sh
> index 2b573417..756fab82 100755
> --- a/scripts/ci/travis-kvm-setup.sh
> +++ b/scripts/ci/travis-kvm-setup.sh
> @@ -7,13 +7,15 @@ TEST_RUNNER=3D"scripts/ci/fedora-test-runner.sh"
>  #
>  # Variables for controlling the Fedora Image version and download URLs.
>  #
> -MAJOR_VERSION=3D"32"
> -MINOR_VERSION=3D"1.6"
> +if [ -z "$FEDORA_MAJOR" ] || [ -z "$FEDORA_MINOR" ]; then
> +    echo "$0: FEDORA_MAJOR and FEDORA_MINOR must be set!" 1>&2
> +    exit 1
> +fi
> =20
>  BASE_URL=3D"https://download.fedoraproject.org/pub/fedora/linux/releases
>" -IMAGE_BASE_NAME=3D"Fedora-Cloud-Base-$MAJOR_VERSION-$MINOR_VERSION.x86_=
64"
> -IMAGE_URL=3D"$BASE_URL/$MAJOR_VERSION/Cloud/x86_64/images/$IMAGE_BASE_NA=
ME.raw.xz"
> -CHECK_URL=3D"$BASE_URL/$MAJOR_VERSION/Cloud/x86_64/images/Fedora-Cloud-$=
MAJOR_VERSION-$MINOR_VERSION-x86_64-CHECKSUM"
> +IMAGE_BASE_NAME=3D"Fedora-Cloud-Base-$FEDORA_MAJOR-$FEDORA_MINOR.x86_64"
> +IMAGE_URL=3D"$BASE_URL/$FEDORA_MAJOR/Cloud/x86_64/images/$IMAGE_BASE_NAM=
E.raw.xz"
> +CHECK_URL=3D"$BASE_URL/$FEDORA_MAJOR/Cloud/x86_64/images/Fedora-Cloud-$F=
EDORA_MAJOR-$FEDORA_MINOR-x86_64-CHECKSUM"
>  GPG_URL=3D"https://getfedora.org/static/fedora.gpg"
> =20
>  #
> --=20
> 2.26.2
>=20

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAl+f3J8ACgkQviIJHj72
InXJ+RAAuJnsxQWuHPRggSYKTciURj3c0glNWciOd7h496bUVNRSL4RmLNFZfXpX
T/hRxVMCabWBQSF9Y95iHlFDx3Fnut4V53eupFckHoNi0M7uNr37MI6XZROrNa/h
33Dq9ABPRb/HpyD6jk4H7AwPWlisP98zxavxolUlqa5rxmRj1q0x+U6k0cpDt0DL
Muq+PTDBPrOijLnVIQwlfKCKRHwrqya71VXCf0zRa+QuS3ghgFs1kM1Os1HNAKoH
P1xmSWq+DKPR3MshOsNRB4GcVc+sT2yyuica28nIegiT9oPxdnjb5I24G47inzxh
EsMRe92/0BcwAl7DGPcCifcjF+Y+EjM/nJdc2FZ9Dp0KLhxwdzgZRXd4MQH/M07Y
0UAX7TJFmlDFEfihYaH9sSFdA0duupyD3X76OR1mq0cn1sXV9//84D5GMVB0Z5NP
GKvQ2NzQECqzxBCKubyZCiseYluT7e2q2OuaQMYdHLxcuujlOx1FjwUft+n8e2e5
rCEf6F54LFIJYps3o/pjl+xYjdjHvn1GQVQXq1wyFJLsY60F8O3wIyKNwqAJjnVX
urAXtVPK6yzAXghvYWQjKuUAuf/Tvb374+jXdXptPvHIBpRV1pGSZ7vrjbl+MIrP
hsYUnTZ+MbFpzsMZGzIcU6BmyMJmn4YzlRLs1m/4CNSlvefDqFg=
=RGNs
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--

