Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uB6H1050023660
 for <selinux@tycho.nsa.gov>; Tue, 6 Dec 2016 12:01:01 -0500
Received: from workstation ([185.34.9.224]) by mail.gmx.com (mrgmx102
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0MT60g-1c3kS72shq-00SAc9 for
 <selinux@tycho.nsa.gov>; Tue, 06 Dec 2016 18:00:57 +0100
Date: Tue, 6 Dec 2016 17:00:55 +0000
From: Gary Tierney <gary.tierney@gmx.com>
To: selinux@tycho.nsa.gov
Subject: Filtering an avtab in libsepol
Message-ID: <20161206170055.GA30914@workstation>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I've been working on optimizing out AV rules with no applicable types as=20
well as unused attributes to trim down the size of a policy which uses=20
CIL blocks and attributes extensively.  Looking into the avtab code (and=20
how creating a new avtab is implemented in expand.c) I have a question:

Does the following suffice for taking an existing avtab and creating a=20
new one with all of its elements?  Or do I need to consider=20
avtab_insert_nonunique() like expand.c does?  If I'm following the=20
expand_avtab() code correctly, I'd think I'd need to consider conditional=
=20
avtabs in the following code:

static int copy_avtab_map_fn(avtab_key_t *key, avtab_datum_t *datum,
			     void *args)
{
	avtab_t *avtab =3D (avtab_t *) args;

	return avtab_insert(avtab, key, datum);
}

static int copy_avtab(avtab_t *avtab, avtab_t **out)
{
	avtab_t *tmp =3D NULL;
	if (avtab_init(tmp)) {
		return POLICYDB_ERROR;
	}

	if (avtab_alloc(tmp, MAX_AVTAB_SIZE)) {
		return POLICYDB_ERROR;
	}

	if (avtab_map(avtab, copy_avtab_map_fn, tmp)) {
		return POLICYDB_ERROR;
	}

	*out =3D tmp;
	return POLICYDB_SUCCESS;
}

Is that the right idea?

Thanks.

--=20
Gary Tierney
=20
GPG fingerprint: 412C 0EF9 C305 68E6 B660BDAF 706E D765 85AA 79D8
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x706ED76585AA79D8=
=20

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYRu7AAAoJEHBu12WFqnnY6NEH/1IWJjDiN64trtgr3Xea9S0O
wXvA+uLjGlt2uKpc1OXsHk/35fC1rZZ0e3CDm5mbs4vQDNSENbXDWglJMwzvmXWt
oILYaaOHIbwT2k7tENfG9cxpuAg4yt0d8ue5pdzo5PiHeieULHJCfFHlVU8MWkl5
Gd6DUQ4v25oN12CqJ+kuSZB6gAz7e9t+O3q8rXIdFQE1uaumPdtIRvm0EMnG7lEz
8AijSOioitot9AOUp+AoTLNzHWj1wpfqdyRu4WQAWSRN9J+yVrHp27UJzhMDwFZq
APo7r2MEHl+9oLit26e6DDhlbyYUJ4VPTpyxy95ZdmKMw/tzfomcCf1SmbW0k/o=
=RRcF
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--
