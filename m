Subject: Re: [patch 1/3] libsemanage: genhomedircon replacement
From: James Antill <jantill@redhat.com>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Eamon Walsh <ewalsh@tycho.nsa.gov>, Mark Goldman <mgoldman@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <46896D88.7060504@tresys.com>
References: <20070521095414.832619201@tresys.com>
	 <1180034401.3930.203.camel@tresys-winxppro>
	 <1180108369.6331.18.camel@localhost.localdomain>
	 <6FE441CD9F0C0C479F2D88F959B01588BEFF95@exchange.columbia.tresys.com>
	 <1180137749.10334.18.camel@localhost.localdomain>
	 <4677F1BC.2000201@tresys.com>
	 <1182443353.11527.50.camel@localhost.localdomain>
	 <6FE441CD9F0C0C479F2D88F959B01588D01904@exchange.columbia.tresys.com>
	 <1182449086.11527.80.camel@localhost.localdomain>
	 <6FE441CD9F0C0C479F2D88F959B01588D01920@exchange.columbia.tresys.com>
	 <1182449898.11527.83.camel@localhost.localdomain>
	 <6FE441CD9F0C0C479F2D88F959B01588D01928@exchange.columbia.tresys.com>
	 <1182450900.11527.88.camel@localhost.localdomain>
	 <467AE59E.2050501@tycho.nsa.gov>
	 <1182525734.3014.20.camel@localhost.localdomain>
	 <467BFF99.9000404@tycho.nsa.gov>
	 <1182540624.6599.5.camel@localhost.localdomain>
	 <467C3728.6070803@tycho.nsa.gov>  <468904FA.7030102@tresys.com>
	 <1183386217.16330.0.camel@localhost.locald! omain>
	 <46896D88.7060504@tresys.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-4skgGzgbEpia9AIDcEhr"
Date: Mon, 02 Jul 2007 21:12:13 -0400
Message-Id: <1183425133.32465.16.camel@code.and.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-4skgGzgbEpia9AIDcEhr
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2007-07-02 at 17:26 -0400, Joshua Brindle wrote:
> Karl MacMillan wrote:

> > Ustr is intended to be pulled into projects - that's why it is a single
> > file.
> >=20
>=20
> eh?
>=20
> [root@scarecrow ustr-0.99.3]# ls *.c | wc -l
> 23
>=20
> this does not include tests or examples.

 Karl was "consulted" on very earl versions, at which point it was
entirely contained within a single sub 1,000[1] line .h file. You can
still install the developer rpm and use:

 ustr-import main

...which will get you the smallest local copy possible (basically just
the ustr_add, ustr_dup, ustr_del and accessor functions).
 For libselinux usage though, I'd assume you can go for linking to the
shared lib. when[2] that's in the main Fedora repo?

> >>  Additionally ustr's documentation is a=20
> >> bit lacking: http://www.and.org/ustr/functions . Stuff like "This=20
> >> function does nothing." in the docs is a bit disconcerting as well.
> >=20
> > I'm certain James can answer any questions.
> >=20
> > More to the point - what do you think of using some string library?
>=20
> We are deciding if ustr is the right answer right now, and will report=20
> our findings later.

 Well, as Karl said I'd be happy to provide any answers to make the
choice easier for you. I can also be pursuaded to do some code to help
your choice, if you have something in mind?


[1] It's bigger now, but at least it doesn't send email yet :).

[2] I'm looking to do a 1.0, with "significant"[3] documentation and a
stable API within the next week or so.

[3] Ie. maybe not every function, but enough that a normal person could
work out the rest. Also I make no promises about my skill to make you
understand everythign I say :).

--=20
James Antill <jantill@redhat.com>

--=-4skgGzgbEpia9AIDcEhr
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBGiaJt11eXTEMrxtQRAjenAJ9bWRRIFQJs+EPK6NUKaxCWfDJ27ACdEgG6
GHJQyxVq2CYrmvnxSyU8/bo=
=dtfJ
-----END PGP SIGNATURE-----

--=-4skgGzgbEpia9AIDcEhr--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
