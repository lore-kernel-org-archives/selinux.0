Return-Path: <SRS0=Gc5K=6Z=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 359F5C47255
	for <selinux@archiver.kernel.org>; Mon, 11 May 2020 12:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10D0620801
	for <selinux@archiver.kernel.org>; Mon, 11 May 2020 12:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dz4KwW4k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729642AbgEKM1O (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 11 May 2020 08:27:14 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54939 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728084AbgEKM1O (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 11 May 2020 08:27:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589200032;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IFwLGxcCqCG5Wa2wbv4Fmg/KgvFns76fkGn+JrDZuFU=;
        b=dz4KwW4kGfGJgvJpeECdXmfoldBxBOyfrgKqv64BBWbk5uRBYErEP9VZro7B9HFS5vptxe
        0uRRZZUK+UQ/YvUlMnoEFjEMsPiR4X2tdDLnZeswg/og+eqgHakEpv8K6cO0+tBOFIolzQ
        peNnXCx10h+Q3xcHXAGHihtRBNXxmJg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-Yjai8aDxOv-_z7WkD1_wBQ-1; Mon, 11 May 2020 08:27:08 -0400
X-MC-Unique: Yjai8aDxOv-_z7WkD1_wBQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1EF148005B7;
        Mon, 11 May 2020 12:27:07 +0000 (UTC)
Received: from workstation (unknown [10.40.195.203])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E71141002394;
        Mon, 11 May 2020 12:27:05 +0000 (UTC)
Date:   Mon, 11 May 2020 14:27:03 +0200
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        James Carter <jwcart2@gmail.com>
Subject: Re: [RFC PATCH v2] libsepol/cil: raise default attrs_expand_size to 2
Message-ID: <20200511122703.GA26404@workstation>
References: <20200305135337.113248-1-omosnace@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200305135337.113248-1-omosnace@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 05, 2020 at 02:53:37PM +0100, Ondrej Mosnacek wrote:
> The value attrs_expand_size =3D=3D 1 removes all empty attributes, but it
> also makes sense to expand all attributes that have only one type. This
> removes some redundant rules (there is sometimes the same rule for the
> type and the attribute) and reduces the number of attributes that the
> kernel has to go through when looking up rules.
>=20
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>=20
> v2: fix typos (Tne -> The; cointains -> contains)
>=20
>  libsepol/cil/src/cil.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/libsepol/cil/src/cil.c b/libsepol/cil/src/cil.c
> index d222ad3a..c010ca2a 100644
> --- a/libsepol/cil/src/cil.c
> +++ b/libsepol/cil/src/cil.c
> @@ -452,7 +452,8 @@ void cil_db_init(struct cil_db **db)
>  =09(*db)->disable_dontaudit =3D CIL_FALSE;
>  =09(*db)->disable_neverallow =3D CIL_FALSE;
>  =09(*db)->attrs_expand_generated =3D CIL_FALSE;
> -=09(*db)->attrs_expand_size =3D 1;
> +=09/* 2 =3D=3D remove attributes that contain none or just 1 type */
> +=09(*db)->attrs_expand_size =3D 2;
>  =09(*db)->preserve_tunables =3D CIL_FALSE;
>  =09(*db)->handle_unknown =3D -1;
>  =09(*db)->mls =3D -1;
> --=20
> 2.24.1
>=20


This patch broke `semanage node -l` on Fedora [1]

:: [ 21:25:25 ] :: [  BEGIN   ] :: Running 'make LIBDIR=3D/usr/lib64 SHLIBD=
IR=3D/lib64 test'
...
test_list (__main__.SemanageTests) ... Traceback (most recent call last):
  File "/usr/sbin/semanage", line 967, in <module>
    do_parser()
  File "/usr/sbin/semanage", line 946, in do_parser
    args.func(args)
  File "/usr/sbin/semanage", line 649, in handleNode
    OBJECT =3D object_dict['node'](args)
  File "/usr/lib/python3.8/site-packages/seobject.py", line 1849, in __init=
__
    self.valid_types =3D list(list(sepolicy.info(sepolicy.ATTRIBUTE, "node_=
type"))[0]["types"])
IndexError: list index out of range

While the `IndexError: list index out of range` error can be simply fixed, =
it
uncovered the problem that semanage uses attibutes to list certain records =
-
node_type, port_type, file_type, device_node, ... and these attributes can =
disappear when
there's only 1 type assigned.

I guess it should be reverted as there's no other way how to find out that =
a
type node_t is node_type.

[1] https://jenkins-continuous-infra.apps.ci.centos.org/job/fedora-rawhide-=
pr-pipeline/3462/artifact/package-tests/logs/FAIL-upstream-err.log

Petr

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAl65RJAACgkQviIJHj72
InVvEg/+OcYjAzs+S6Q64xtFwGCW0oUeEtpJJwuWSZV8qEtFkI4Q2VVZs8qmQptz
xw6Zj7MJ1DSobMV1DN5HOfdN/Bo83GPLDAz2DNAYR3iQirEz2Yt7LQHXeorc5jpU
9HCNwWBxObHg93uxolaEb7s/EU/7K2jOKQoK+l5pcSPy+5Eeo2BM2pj62BtfutY2
rVvvFPMSZZqvpV0zCsuWfzEc+oTUwx8LkLtdMah4XeyflwosvVWKRN9opkhXTnOl
U7A/MPr7juetoyE9Tcw3ac75+0sjdlf2ZIOuw/TIuJKWPyXYsXuerqw5PYxDydlC
1L7UEgcjep0gwRSN3m7wfHYu0kfMnhdYZw0L4BcOuZ9xPXM0+xdFnvx2/fQ5Fc+r
PL6i3C1AU6go3L00LlH/2nGOZdF+i3W9PhbpS0+ITMo883CveRiRK77nIkMDioek
HWjvckXu0BJ5G9STMEsVxNKSA1CH2qRtFwWb1XtxGtmLeo0254n5ma0rZNJxpDpH
Ffze+r6A1D6JlIizku4l6Oh0qCi2bKBiWanPFYQimtZkTlbuIqsIERh9JtDrONJt
7vTX68C8KINcYNtGACGNwqbiU0sC1wP5MQI0eb6ZLsZk1/G8MZqafaqNsqjDSTMk
3qhR1DeABR9KQ6Lf7n9MHvUihOB8uuaoJR2kYYClszRtyTGPHY4=
=+OVM
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--

