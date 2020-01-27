Return-Path: <SRS0=e1+f=3Q=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A82F7C2D0DB
	for <selinux@archiver.kernel.org>; Mon, 27 Jan 2020 12:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C3A42071E
	for <selinux@archiver.kernel.org>; Mon, 27 Jan 2020 12:52:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbgA0Mwc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 27 Jan 2020 07:52:32 -0500
Received: from agnus.defensec.nl ([80.100.19.56]:36000 "EHLO agnus.defensec.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726294AbgA0Mwc (ORCPT <rfc822;selinux@vger.kernel.org>);
        Mon, 27 Jan 2020 07:52:32 -0500
Received: from brutus.lan (brutus.lan [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id 144031320038
        for <selinux@vger.kernel.org>; Mon, 27 Jan 2020 13:52:30 +0100 (CET)
Date:   Mon, 27 Jan 2020 13:52:28 +0100
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     selinux@vger.kernel.org
Subject: question about fs sid
Message-ID: <20200127125228.GA1998492@brutus.lan>
Mail-Followup-To: selinux@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
User-Agent: Every email client sucks, this one just sucks less.
X-PGP-Key: https://sks-keyservers.net/pks/lookup?op=get&search=0xDA7E521F10F64098
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

What is the fs sid used for exactly? What, if any, is its relationship with=
 persistent file systems with xattr support.
Were currently associating a type that is generally also associated with pe=
rsistent filesystems that support xattr but i dont know why.
Why would it not apply to other filesystems, for example tmpfs or vfat or w=
hatever?

Is the fs sid still used and what do i need to consider when determining wh=
at context to associate with it?

--=20
gpg --locate-keys dominick.grift@defensec.nl
Key fingerprint =3D FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
Dominick Grift

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEe2FOk94VrgBPlhBrAlFoDzf+eRMFAl4u3QYACgkQAlFoDzf+
eRMX0A/+N8lWWtrRA6hVDSG2HYmHucfxsahJLZ3fyMVhpZN6lVCvzl7WjHErwZl2
HReziU1+X7wE2nP+bG6n1JqIl4vkuwF7QAwUzxoJI+D67/DTlWgXzQqWqFP9z+mJ
FEgoxl6wbI+PUBmMGLaJG93PBADH0cXy8LtjpAlhkzwKB3OzgjNo7Rc4gdS23N7b
1+0nJa9QF+2kJpAjDNA6WNuCxm8CdvTBxcwVTNHzlggJ19cKzeKHiijLV+w2PyPw
E+1MfLLe0TlZ8eC8FgDZD/jZ3EKQYKd+3AGTcE8rzPaGdm+9cjrE3tiKF135Sszn
oRuYlpvSzdeBvYsG+upu+DTqJrKiQi+Ws1kDE7zthQn8Bk+B69yS3MCxlF/Y2BA5
3gMp90Y1EmkNHw23OJ+1S5CwWTfpDxz9ADVV9h5YE8QTI1ya08unHUYs6MQQ/zsa
qFHnyKkzh3D+Gy8rjGO/eM8JHIm7LmLJMvGKmwEnsB+6SQSzaP1yKKAuocGTVkdR
ancxlo0dQABXNuRirrPadj6gG6+TOwoGhI2DmMi4cq3zVR9AU0MTo28F/VSvQTLG
ipmmumhxF3OG3LXYkLOA8SYYInpYnlOl1k2SJGdrD77hJ5sKzfdLNa2SqmANOJj6
8uCSZCzqLpGqzwyWu9YSqy393OAJOSms4230YjkCH4jO5VamECE=
=9vP6
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
