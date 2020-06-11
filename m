Return-Path: <SRS0=nmhN=7Y=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D06C433E0
	for <selinux@archiver.kernel.org>; Thu, 11 Jun 2020 15:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84CE2206C3
	for <selinux@archiver.kernel.org>; Thu, 11 Jun 2020 15:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Udh3zT8U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbgFKPet (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 11 Jun 2020 11:34:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38684 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728380AbgFKPes (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 11 Jun 2020 11:34:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591889687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t3WxHUuixuL6kPIaSBjuGgmyhXe/R0z16eo4Sjdkep8=;
        b=Udh3zT8UfSvDT59tjwzvhxrmt15ISTpKPxQ3y3a1/lS9Hfk8WzDCJdlRQQVkV5NON/VmEa
        KxiFsXi/HimLizumiTIHUeS41a2+KYzTF8i/euS3ZHHazTsUYbmRwSbQS1AUTVHVa0Dp4b
        ySFxIDuxHeaU9emQkR4QQTAulEUO28A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-q0vBRgSGP8-zAcFaBJopjQ-1; Thu, 11 Jun 2020 11:34:39 -0400
X-MC-Unique: q0vBRgSGP8-zAcFaBJopjQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A548A107ACCA;
        Thu, 11 Jun 2020 15:34:38 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.192.14])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2957B61462;
        Thu, 11 Jun 2020 15:34:36 +0000 (UTC)
Date:   Thu, 11 Jun 2020 17:34:34 +0200
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     paul@paul-moore.com, bill.c.roberts@gmail.com,
        stephen.smalley.work@gmail.com, william.c.roberts@intel.com
Subject: Re: [PATCH] ci: dont use hardcoded project name
Message-ID: <20200611153434.GA468661@localhost.localdomain>
References: <CAFftDdqrAhkkeVpm9vExEL8ecnTEz5yeqVj27Zs7PC5_1NVxdg@mail.gmail.com>
 <20200611140557.6359-1-william.c.roberts@intel.com>
MIME-Version: 1.0
In-Reply-To: <20200611140557.6359-1-william.c.roberts@intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2020 at 09:05:57AM -0500, bill.c.roberts@gmail.com wrote:
> From: William Roberts <william.c.roberts@intel.com>
>=20
> Not everyone's github project is "selinux" so use the projects
> name, as derived from TRAVIS_BUILD_DIR. TRAVIS_BUILD_DIR is
> the absolute path to the project checkout on disk, so the
> basename should be sufficient.
>=20
> Tested on Travis CI here:
>   - https://travis-ci.org/github/williamcroberts/selinux/jobs/697201376
>=20
> Signed-off-by: William Roberts <william.c.roberts@intel.com>
> ---
>  scripts/ci/travis-kvm-setup.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/scripts/ci/travis-kvm-setup.sh b/scripts/ci/travis-kvm-setup=
.sh
> index 864dbac96a46..ceedaa6f4e27 100755
> --- a/scripts/ci/travis-kvm-setup.sh
> +++ b/scripts/ci/travis-kvm-setup.sh
> @@ -120,6 +120,7 @@ fi
>  # we don't get blocked on asking to add the servers key to
>  # our known_hosts.
>  #
> -ssh -tt -o StrictHostKeyChecking=3Dno -o LogLevel=3DQUIET "root@$ipaddy"=
 "/root/selinux/$TEST_RUNNER"
> +project_dir=3D"$(basename "$TRAVIS_BUILD_DIR")"
> +ssh -tt -o StrictHostKeyChecking=3Dno -o LogLevel=3DQUIET "root@$ipaddy"=
 "/root/$project_dir/$TEST_RUNNER"
> =20
>  exit 0
> --=20
> 2.17.1
>=20

Thanks!

I'm running a new job again with this fix. But I guess you need to change
fedora-test-runner.sh as well. There's also hardcoded "selinux":=20

~~~
# Move to selinux code and build
#
cd "$HOME/selinux"
~~~


--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAl7iTwMACgkQviIJHj72
InV5nBAAwIplBT8FU6Im6ystA4CnN/3MoGW4DzlDASzp5QeSPlDEd2EgcBNeGAkB
6eFK6n5WboxMqERTl1K7Jf7XDGGpBalPAkbs0gOD4cH30xTou5lo2ArnAUvGthNC
sbaypk+i1KKD3aGHACAYQxZ0ExI8C49Gnz2uPU6b7O3h24BZpckTl0yLhvzBb/jF
mCSveMZ6WQgYbCnXLYKUOeeOD1yzWHtqkO5Pgo7xzWsntvmJdRzYtP4sbf2aHvuI
pPUdpJZ5wfn+j2LSrXENLQK59/2NFsWQQxhN+JF0elxhlEC6deLdjw6vvq4WTa9C
zQllo4hbRiMOlZJz7s8K/Im1Y16r0ppUnif9N88r36/cZHHObNCEufkzzeI0wsi0
NKVjmREw1EJkTBhmF1TDcBIP9hIR3hcbO14DcdwwuciK+Q77PHt/U+AmuEyOydJZ
C2GVlp4BxgyAgFN/gPxRf5wV6SoVFF/7TlSjwdX/sO2x77bk8IItQfqcZ7dg8kjz
LmAP7zWrp+3wbeJrWxMhU2gpzozU6HvVLHPODrrxFjSM0F2FycJV5mYJS2n1klHn
gFtyiMrHU4sG4qlYFRpU+ZxHscvd251F0MOha8RNexT4OZm+YIkgYRkPfy+MltdT
CitpF0upQ+xDcZcqtfvHVlKtUoTb3DkSXeuy6G7TevaHysn2WAk=
=D3b7
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--

