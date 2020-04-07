Return-Path: <SRS0=OuNA=5X=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8467C2BA16
	for <selinux@archiver.kernel.org>; Tue,  7 Apr 2020 08:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9E88206F7
	for <selinux@archiver.kernel.org>; Tue,  7 Apr 2020 08:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cf62QyyX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbgDGI7d (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 7 Apr 2020 04:59:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41965 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726353AbgDGI7d (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 7 Apr 2020 04:59:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586249972;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7ifwB8gR15mauHIDjEWzXIpY1UtXOpyuFQq7MAQFO3E=;
        b=Cf62QyyXfaRjWQzmESZhx3jWEmCwg31iDAOlEruM/qSVkEW12ii4ptYWEo7cmWDZgUoBxu
        IduGwMyB6UJ9AiGqQbe8L3ZtiHQ+k+Nz3eVGSgMLDyYrphqu/w8he6xF5A/0P3ZBVeFn2v
        eWT8oYPSIukAlC798SoNDJtj5jQoPQk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-fO4pLihJM9OerqhmHL4ucw-1; Tue, 07 Apr 2020 04:59:30 -0400
X-MC-Unique: fO4pLihJM9OerqhmHL4ucw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF8E91083E83;
        Tue,  7 Apr 2020 08:59:28 +0000 (UTC)
Received: from workstation (unknown [10.40.194.143])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CB2E09DD64;
        Tue,  7 Apr 2020 08:59:26 +0000 (UTC)
Date:   Tue, 7 Apr 2020 10:59:22 +0200
From:   Petr Lautrbach <plautrba@redhat.com>
To:     Russell Coker <russell@coker.com.au>
Cc:     selinux@vger.kernel.org
Subject: Re: libsepol releases
Message-ID: <20200407085922.GA438349@workstation>
References: <3581425.j52oWYpJar@liv>
MIME-Version: 1.0
In-Reply-To: <3581425.j52oWYpJar@liv>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 05, 2020 at 07:46:37PM +1000, Russell Coker wrote:
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D955154
>=20
> We have the above Debian bug report requesting a GIT patch for libsepol f=
or=20
> GCC-10 support.
>=20
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D955286
>=20
> We also have the above for a policy constraint error.
>=20
> Could we have a new upstream release soon to cover all GCC-10 issues as w=
ell=20
> as any other important things?  Maybe version 3.0.1?
>=20


It's more than 4 months since the latest release so I think it's worth it t=
o release 3.1.

If there's no objection, I'll send a heads up that we'll release 3.1-rc1 ne=
xt week.


Petr


--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE1qW2HJpVNBaCkttnviIJHj72InUFAl6MQOQACgkQviIJHj72
InU/xQ//R6qAS3c7X2Kvd6QRohfmE/k1HEqSrn03L2LfgRlcxs2tffzq9bDGmysU
tX6KGTkQl08OH65JY7pnWobB9xgZsj5naYYQayKMYspOo9+VV/6JOHvweGzAsk0G
BhqX1grIzablg9XpU/GIZvb4YD1MaozGAtmvB/tZPc4FOZ84yQZzWskVoXfrVVx/
ed+tcv1JUq6OPdBZVo4eGcLqCIzOaeVoEXflEi60RsNqgm0VeNDGvfH3futYFIqQ
LPwG0cfankNnE4W2OAa2kfk9ZYGkVYn++QotQ7001sbsL4oWlK8wRJ6A3X6/oZZ5
k2OKWhhKNVuy1zUGquqacBDi7q1nq+5GHlQpQdmaA9QokztZ/iuOUVy161Yioi++
W3uIpV0rFHKn/nbx2BdI9GxMNk7uqwwaWOW01b4+r6ByKDXfOFiD0vlv+Gr44qAx
OIa4FaJqjIAwXv7Ajwas9nW1kxiS+2alo4NvVEWIqPa0d/HjOtgYRSv2vyCDozcY
e43MSyyArQO59ITk03biH4SAoqZVigUV6VS8CfL4QsPGgmBjscU1ghc1kXmMH2+Z
fJXWL2EOa3Uj65VsGTtxHhxX/NJOBRPFs3LDXVlE8daf11aj31u/KwdS+U61qqm2
rzsb5vrQXiKoFg0cTPVC8JiiWoV2+SEdqalKHBBwVT4N8IjxqX4=
=6asT
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--

