Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3PHBmia004206
	for <selinux@tycho.nsa.gov>; Wed, 25 Apr 2007 13:11:49 -0400
Received: from mail.and.org (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3PHBlIr019488
	for <selinux@tycho.nsa.gov>; Wed, 25 Apr 2007 17:11:48 GMT
Subject: RE: [PATCH 01/33] libsepol: basic serilization support
From: James Antill <jantill@redhat.com>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Karl MacMillan <kmacmillan@mentalrootkit.com>, selinux@tycho.nsa.gov
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B01588B4044B@exchange.columbia.tresys.com>
References: <20070423213455.741326000@tresys.com>
	 <20070423213721.090230000@tresys.com>
	 <1177444855.10744.25.camel@localhost.localdomain>
	 <6FE441CD9F0C0C479F2D88F959B01588A71AE2@exchange.columbia.tresys.com>
	 <1177476585.3428.91.camel@localhost.localdomain>
	 <6FE441CD9F0C0C479F2D88F959B01588A71B39@exchange.columbia.tresys.com>
	 <1177514210.3428.117.camel@localhost.localdomain>
	 <6FE441CD9F0C0C479F2D88F959B01588B40435@exchange.columbia.tresys.com>
	 <1177515622.3428.126.camel@localhost.localdomain>
	 <6FE441CD9F0C0C479F2D88F959B01588B4043E@exchange.columbia.tresys.com>
	 <1177516853.3428.131.camel@localhost.localdomain>
	 <6FE441CD9F0C0C479F2D88F959B01588B4044B@exchange.columbia.tresys.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-tiHQH52OD4vcY0CTaohq"
Date: Wed, 25 Apr 2007 13:11:39 -0400
Message-Id: <1177521099.22450.15.camel@code.and.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-tiHQH52OD4vcY0CTaohq
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-04-25 at 12:25 -0400, Joshua Brindle wrote:

> So move boiler plate casting and checking to the call site? I guess we
> can do that... :\

 Having a wrapper that does it for you isn't such a bad thing, and
calling that wrapper serialize_sizet/unserialize_sizet or whatever isn't
the worst thing in the world[1].
 The problem, from my POV, is that you check on the receiving side if
size_t happens to be bigger than uint32_t[2]. You are basically sending
a uint64_t over the network that can never hold a value bigger than a
uint32_t, so everything gets to send extra zeros. This is very
misleading, just say what you mean by having the protocol use uint32_t,
and check at the sending side if the value > uint32_t can hold, if so
error in some way.

 Dito with SERIAL_STRING (although that probably fails by accident
atm.), just fail to ever send "large" strings, and use uint32_t for the
length. You should probably also pick a limit on receive instead of
hoping calloc() will save you.


[1] Although an interface name that makes it obvious the size_t is going
to be down converted to uint32_t would be better.

[2] Well it actually uses (unsigned int), via. UINT_MAX, which is
another bug as it should be using UINT32_MAX from stdint.h.

--=20
James Antill <jantill@redhat.com>

--=-tiHQH52OD4vcY0CTaohq
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBGL4vH11eXTEMrxtQRArhWAKCHZBWh4npBq/CGuJmGVE0bkBdaSQCeObOW
nTBbTScGDFGsFS1rgmkQlp8=
=s1Cq
-----END PGP SIGNATURE-----

--=-tiHQH52OD4vcY0CTaohq--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
