Return-Path: <SRS0=d3z6=4V=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD89FC3F2D1
	for <selinux@archiver.kernel.org>; Wed,  4 Mar 2020 07:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8107E215A4
	for <selinux@archiver.kernel.org>; Wed,  4 Mar 2020 07:42:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbgCDHmz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 4 Mar 2020 02:42:55 -0500
Received: from agnus.defensec.nl ([80.100.19.56]:46626 "EHLO agnus.defensec.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725271AbgCDHmz (ORCPT <rfc822;selinux@vger.kernel.org>);
        Wed, 4 Mar 2020 02:42:55 -0500
Received: from brutus.lan (brutus.lan [IPv6:2001:985:d55d::438])
        by agnus.defensec.nl (Postfix) with ESMTPSA id A05EF132006F
        for <selinux@vger.kernel.org>; Wed,  4 Mar 2020 08:42:53 +0100 (CET)
Date:   Wed, 4 Mar 2020 08:42:51 +0100
From:   Dominick Grift <dominick.grift@defensec.nl>
To:     selinux@vger.kernel.org
Subject: Re: strange pam selinux issue
Message-ID: <20200304074251.GA1032355@brutus.lan>
Mail-Followup-To: selinux@vger.kernel.org
References: <20200304072940.GA1026144@brutus.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
In-Reply-To: <20200304072940.GA1026144@brutus.lan>
User-Agent: Every email client sucks, this one just sucks less.
X-PGP-Key: https://sks-keyservers.net/pks/lookup?op=get&search=0xDA7E521F10F64098
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 04, 2020 at 08:29:40AM +0100, Dominick Grift wrote:
> The easiest way to explain this is as follows.
>=20
> Consider this scenario:
>=20
> # seinfo -xuwheel.id
>=20
> Users: 1
>    user wheel.id roles wheel.role level s0 range s0;
>=20
> # selinuxconlist wheel.id sys.id:sys.role:sys.isid:s0
> wheel.id:wheel.role:user.systemd.subj:s0
>=20
> Now consider this scenario:
>=20
> # echo '(userrole wheel.id sys.role)' > hack.cil && semodule -i hack.cil
>=20
> # seinfo -xuwheel.id
>=20
> Users: 1
>    user wheel.id roles { wheel.role sys.role } level s0 range s0;
>=20
> Here is the issue:
>=20
> # selinuxconlist wheel.id sys.id:sys.role:sys.isid:s0
> wheel.id:sys.role:sys.isid:s0

For completeness:

# cat /etc/selinux/dssp3-mcs/contexts/users/wheel.id
sys.role:login.subj:s0 wheel.role:user.subj:s0
sys.role:ssh.daemon.subj:s0 wheel.role:user.ssh.subj:s0
sys.role:sys.isid:s0 wheel.role:user.systemd.subj:s0

--=20
gpg --locate-keys dominick.grift@defensec.nl
Key fingerprint =3D FCD2 3660 5D6B 9D27 7FC6  E0FF DA7E 521F 10F6 4098
Dominick Grift

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEe2FOk94VrgBPlhBrAlFoDzf+eRMFAl5fW/UACgkQAlFoDzf+
eRMvUA/+NOnrTQY5QMRRpte9+MvIM3ukicWpy0r214HI8ZpTw+ToliSj6tokXScJ
52F8zXXZiY7ebL6IDs2rV02FBkLvJG/NPXNO1kgT0Wf2lzMNvZnfgeTDyN60TSvm
5eKkBIA/EHO5hVzC2OrQspQ3bDzkmv8nyYmDCsJufXR5lvwJmxATy9216kjcj1mu
gLYPmx3a9XyQ2njXi883nmzTmBzYqrLILwUbdL9ZDUQimTrwPMPl8KZXMW6xtFDb
/LAQSAR2fYggtJ45t8ALTUeWjUozuTMvNawmoN5V2C6JZDuaI1QVhQX7VdoZO9ws
f355D8gJGjd2TISMMRIHCIe2XpPHcNgJ9KQsRoe24OPy2Oq2HqCnMDW1yr1gOg16
JMvDZRtcrNxEdK+iFesayeWJOCdmNEDyRhqlu5jPydG32AF9kcN6btYkO8fRROms
WVImATvHdD+DgNXXZXHy6vVq8/AqAoof0qXQbLuYEpO9ygaJgDNy6TOLPP5qPVdU
J34VI+1w9PJxidCvN7x6n9aSQvgoLWK0t6y5kQB1SPtNvqCMynLM8RLQ1fekCXQj
FiYgVKLQUOjUEgjWHn0ykN5MoSrbnQ/o/DkAC2IK04w5+8hyHNQaN1MoqNrAEmxk
gFqdwHBY12lxgPAnQsVcNGK3+v18ACYKF3IvrbZVxsmbf4oI2dU=
=rhHF
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
