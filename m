Return-Path: <SRS0=nsQl=BX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22DF7C433E1
	for <selinux@archiver.kernel.org>; Thu, 13 Aug 2020 17:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA6EB20781
	for <selinux@archiver.kernel.org>; Thu, 13 Aug 2020 17:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HLoETjPl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgHMRri (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 Aug 2020 13:47:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54636 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726167AbgHMRri (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 13 Aug 2020 13:47:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597340856;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F7OrG8fIBoasRzik8uq03ERuPVyExEtzaWgMm27w7Tg=;
        b=HLoETjPlUAQ0QqL8gakc2rYRePauqKJQr/5XuBZygNPUUyQVZQ+rrd4xkXc4gIftXUmsCl
        0iVZ1RxVc47sbTlVk/tKvmpm0mSa7jc45N8ieF1NkHmIoK+/1/oMl2DOaRH/jIb5lAZNRR
        CazUoiF/HccPVQnMEWHRswLKi3c+idA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-221-afBXrU9wOreu74XhMkQQAQ-1; Thu, 13 Aug 2020 13:47:27 -0400
X-MC-Unique: afBXrU9wOreu74XhMkQQAQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E690C1854FC2;
        Thu, 13 Aug 2020 17:47:26 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.192.69])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D136C19D6C;
        Thu, 13 Aug 2020 17:47:25 +0000 (UTC)
Date:   Thu, 13 Aug 2020 19:47:22 +0200
From:   Petr Lautrbach <plautrba@redhat.com>
To:     SElinux list <selinux@vger.kernel.org>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: drop symbol versioning from libsepol and libsemanage?
Message-ID: <20200813174722.GA14310@localhost.localdomain>
References: <CAEjxPJ7khd7dprzEKgc5zeyaHWWRQ7P8pOg09LtiBVaOi6jYTg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAEjxPJ7khd7dprzEKgc5zeyaHWWRQ7P8pOg09LtiBVaOi6jYTg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=plautrba@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 07, 2020 at 02:54:18PM -0400, Stephen Smalley wrote:
> As noted in https://github.com/SELinuxProject/selinux/issues/245,
> symbol versioning in libsepol causes problems for LTO.  libsepol and
> libsemanage have a handful of versioned symbols due to incompatible
> ABI changes made early in the CIL integration.  However, as far as I
> can tell, these symbols were only used by other components of the
> selinux userspace, not externally.  Should we stop supporting the old
> versions going forward and simplify the maps? If so, does this truly
> require bumping the .so version or can we omit that since there are no
> external users?  Thoughts?
>=20

AFAIK libsemanage is used by some 3rd parties. We've had requests to ship
libsemanage-devel in RHEL-8 repositories in order customers build their
applications.


From my packager POV I like symbol versioning - it helps to prevent some
dependency issues in development branches, e.g. when libsemanage is built w=
ith
new libsepol symbol but the new package doesn't require newer libsepol. rpm=
 is
able to solve that:

$ rpm -q --requires libsemanage =20
...
libselinux(x86-64) >=3D 3.1-2
libselinux.so.1()(64bit)
libselinux.so.1(LIBSELINUX_1.0)(64bit)
libsepol.so.1()(64bit)
libsepol.so.1(LIBSEPOL_1.0)(64bit)
libsepol.so.1(LIBSEPOL_1.1)(64bit)
libsepol.so.1(LIBSEPOL_3.0)(64bit)
...

$ rpm -q --provides libsemanage
config(libsemanage) =3D 3.1-2.fc33
libsemanage =3D 3.1-2.fc33
libsemanage(x86-64) =3D 3.1-2.fc33
libsemanage.so.1()(64bit)
libsemanage.so.1(LIBSEMANAGE_1.0)(64bit)
libsemanage.so.1(LIBSEMANAGE_1.1)(64bit)


LTO seems to cause problems to other projects as well
https://lists.fedoraproject.org/archives/list/devel@lists.fedoraproject.org=
/message/XMIQMN5KNAZUPX6O3LN6JJGTCZTP4B7J/

So I'd prefer if we try to do and use symbol versioning correctly, but it's=
 not
hard requirement from my side.

Petr

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAl81fKMACgkQviIJHj72
InXing//ZAK7BQJp5k/chk8uIgNkS6AuVWvGWzd0CPM7Y/LBrOYJoytH2DEmAi69
VdcNZ1EEeyzJzdt7Vi6WFcPmmofLcRj+62E+DZaMJ1a73ItUJjxtX+6XGSUNSNV0
QPko9yoUqTSuiSyjoHQdncXBSRZE/Wtj9/p76CFVZVrFc3K8hPdd7jOjn7XDVZjq
CnDMBTwcyGVL2qg70YZ1q+Z2rd7ZW2T3+magPpItQe6ggsfAwdVWWEnBTCkJY0N+
Vn5jhbtrPL9OppOZnCdrvBlOjm4bN8oI9v0I0r7GQ0OBQZ2jr76syibOKGui20OT
9imUvjhbeqlWos9uJl4yWUV4Tcnj3bISZz1PinrLILq+gZpauNCTjpm9lSo5MwFN
ISkZ/dwWASFQkk0oJ8lbXWDDb3M8ZeNJinYgZTsEv8Q0kV5WLVfOXkDEZmzBxO4n
o9+22JcsEwhyJWrEfcWAmAFLPEawDdE4vqP1MPr8FKCokvQKEld0k6rpOWYcBMWE
zeTB7NIXrYMkaHmHUgQYGjq7Fwt5XLu6DbJwSTvhI/ly+MN47xmmd1emM6aX3hK6
eB85zAIWGhNyiJjqu0gyqQ1CH/5gzsP0PNrR9m3ha2q0jqm/QpDH+zIgRhfX2BR/
7F7r64nhFlfFQEPHyuJdkXTwX8b0GVvXwhmwUPNq3EjDZuwu528=
=moib
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--

