Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3HIhDOV022054
	for <selinux@tycho.nsa.gov>; Tue, 17 Apr 2007 14:43:13 -0400
Received: from mail.and.org (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3HIhAC3028248
	for <selinux@tycho.nsa.gov>; Tue, 17 Apr 2007 18:43:12 GMT
Subject: Re: FCGlob
From: James Antill <jantill@redhat.com>
To: "John D. Ramsdell" <ramsdell@mitre.org>
Cc: Christopher Ashworth <cashworth@tresys.com>, selinux@tycho.nsa.gov
In-Reply-To: <ogtzm56khxx.fsf@oolong.mitre.org>
References: 
	 <6FE441CD9F0C0C479F2D88F959B01588A7153E@exchange.columbia.tresys.com>
	 <ogtzm56khxx.fsf@oolong.mitre.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-vDpRB5CbxX8I5gwPFHC+"
Date: Tue, 17 Apr 2007 14:42:54 -0400
Message-Id: <1176835374.19144.14.camel@code.and.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-vDpRB5CbxX8I5gwPFHC+
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2007-04-17 at 13:51 -0400, John D. Ramsdell wrote:

> The paper states that an FCGlob prototype would require creating:
>=20
>    A comparison function that receives two patterns as parameters and
>    returns the set relationship. Possible set relationships between
>    the set of paths pattern A matches and the set of paths pattern B
>    matches are: subset, superset, disjoint and ambiguous.
>=20
> I speculated that finite automata is required to implement the
> comparison function as specified.  Do you have an alternative
> algorithm that meets the above specification?  I don't recall seeing
> one in the paper.

 Sections two and three (and figure 3 within section three) explains
this, AIUI. The idea is that you can split the "patterns" into a list of
nodes and the easily compare nodes, so:

cmp("/x/y/a*/**/b", "/x/**/b")

  =3D=3D

cmp(["x", "y", "a*", "**", "b"], ["x", "**", "b"])

  =3D=3D

cmp(["x", "y", "a*", "b"], ["x", "*", "*", "*", "b"])

...and the comparison function for the last part should "be easy",
although AIUI they hadn't written it.

--=20
James Antill - <james.antill@redhat.com>
setsockopt(fd, IPPROTO_TCP, TCP_CONGESTION, ...);
setsockopt(fd, IPPROTO_TCP, TCP_DEFER_ACCEPT, ...);
setsockopt(fd, SOL_SOCKET,  SO_ATTACH_FILTER, ...);


--=-vDpRB5CbxX8I5gwPFHC+
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBGJRUu11eXTEMrxtQRAvUNAJ4uanBB0x5TD1OdTNSroBGFTSjfmgCcDM39
STe/PMtj1+K/9BRvPPgVJN4=
=NqiW
-----END PGP SIGNATURE-----

--=-vDpRB5CbxX8I5gwPFHC+--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
