Return-Path: <SRS0=fYOO=63=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02375C433DF
	for <selinux@archiver.kernel.org>; Wed, 13 May 2020 15:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01CE42054F
	for <selinux@archiver.kernel.org>; Wed, 13 May 2020 15:10:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QM8ej942"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389080AbgEMPKN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 May 2020 11:10:13 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44356 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729049AbgEMPKN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 May 2020 11:10:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589382611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qXhZ3B2gRt6xkILDXZ1vlh450A3cDUR+ArWt9NcNX0s=;
        b=QM8ej942LU3sDS30f5YMlC2hUQqmdSvFpoUsTwuDFpstha7ARekDLPtuktVDKeNF4iQApZ
        DSP8/UYeasKPt7E/TNgQj3cyN2IaJUGJi4r6phk/g+iwB4DdXqz2o74XHIsrJ3r/VsOKi6
        Z2cSzzoIDZ8jyLfALt/U6jbeIKTMAy0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-507-6vZMM-7GP2yPpA2-_FGYLg-1; Wed, 13 May 2020 11:10:07 -0400
X-MC-Unique: 6vZMM-7GP2yPpA2-_FGYLg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F6E11030983
        for <selinux@vger.kernel.org>; Wed, 13 May 2020 15:10:06 +0000 (UTC)
Received: from workstation (unknown [10.40.192.247])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 10B685C1BB
        for <selinux@vger.kernel.org>; Wed, 13 May 2020 15:10:05 +0000 (UTC)
Date:   Wed, 13 May 2020 17:10:03 +0200
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Subject: Re: [PATCH] semanage/test-semanage.py: Return non-zero value when
 some of unittest tests fail
Message-ID: <20200513151003.GA184087@workstation>
References: <20200511112308.23523-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline
In-Reply-To: <20200511112308.23523-1-plautrba@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2020 at 01:23:08PM +0200, Petr Lautrbach wrote:
> Previously python/semanage/test-semanage.py returned 0 even when there wa=
s a
> fail in some test and `make test` didn't indicate any problem.
>=20
> Fixes:
>     $ make test
>     ...
>     Ran 10 tests in 110.854s
>     FAILED (failures=3D4)
>     $ echo $?
>     0
>=20
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Applied.

> ---
>  python/semanage/test-semanage.py | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>=20
> diff --git a/python/semanage/test-semanage.py b/python/semanage/test-sema=
nage.py
> index c8f6ec231fc2..d99e3fdaa211 100644
> --- a/python/semanage/test-semanage.py
> +++ b/python/semanage/test-semanage.py
> @@ -233,7 +233,7 @@ def semanage_custom_suite(test_list):
> =20
> =20
>  def semanage_run_test(suite):
> -    unittest.TextTestRunner(verbosity=3D2).run(suite)
> +    return unittest.TextTestRunner(verbosity=3D2).run(suite).wasSuccessf=
ul()
> =20
> =20
>  class CheckTest(argparse.Action):
> @@ -255,9 +255,9 @@ def semanage_args(args):
>          for i in semanage_test_list:
>              print(i)
>      if args.all:
> -        semanage_run_test(semanage_suite())
> +        return semanage_run_test(semanage_suite())
>      if args.test:
> -        semanage_run_test(semanage_custom_suite(args.test))
> +        return semanage_run_test(semanage_custom_suite(args.test))
> =20
> =20
>  def gen_semanage_test_args(parser):
> @@ -281,8 +281,10 @@ if __name__ =3D=3D "__main__":
>          gen_semanage_test_args(parser)
>          try:
>              args =3D parser.parse_args()
> -            args.func(args)
> -            sys.exit(0)
> +            if args.func(args):
> +                sys.exit(0)
> +            else:
> +                sys.exit(1)
>          except ValueError as e:
>              sys.stderr.write("%s: %s\n" % (e.__class__.__name__, str(e)))
>              sys.exit(1)

--=20
()  ascii ribbon campaign - against html e-mail=20
/\  www.asciiribbon.org   - against proprietary attachments

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAl68DcUACgkQviIJHj72
InVIiQ//Uczu6schOdapEYc8D62aC2oRELNPKDA3H5bcwaEVWHXNZUJJZpU8NBm1
FZrpbCVQPEuq5Kgd5s4QvgYiQIO7tdzyeljU+GaJajv7R40NcBWFPhOz72c5JyzT
2jykj0x3F9m5ErRQgMpnbKIVA0wJGn/sEA5Q3/ydKJLujXY5aeKm0+PF9kqw0SrN
rGTZB6TspsJN0tjyrFkds7nCMyK9Fit8Badg17lRUbx/QZnPac24SlDxekruRFYM
xulDnBtZzYSFU+cq/PLgkcTYRMqSxHrCnTxvA63dLzA+EONpfyr1QSO5Uuurusa6
jSN9OA4BurFlzpb+aF3UC9xfYInn2k66p1ed5ghxvmyLZoT72W26BQEQeIEh5vYA
a9XAZG47QBqNqpV8elNhGey9o07xxU4aJnrXbLrzcEPym5dH8f8bvWh3BgI63Bgh
ToZ5o/pzugyJ6+PjcWvubU/tbDC2/wwZGxmBHPu2SkY1YU4ya184t3kX8Mnig74e
cIrsmi6NSNvO0dWIN7YTnABWsOz3VjtuP5HOB9Pj0Lmx+Nc8Od10gUoAtNxgDTsG
uta9+LEjT3WiFygmpPmyfQR2Oo8o+DZwSJhsGD0CEKzLLZp99DRX7sdo/50QREt3
p700+vVACubzZWhC30GAYTYFukc8xSty31Tc4y+mAYxSOC0JWI8=
=csYw
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--

