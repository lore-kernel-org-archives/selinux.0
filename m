Subject: Re: [patch 1/3] libsemanage: genhomedircon replacement
From: James Antill <jantill@redhat.com>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Eamon Walsh <ewalsh@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Mark Goldman <mgoldman@tresys.com>, SE Linux <selinux@tycho.nsa.gov>,
        Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <468904FA.7030102@tresys.com>
References: <20070521095414.832619201@tresys.com>
	 <1180017921.2940.24.camel@localhost.localdomain>
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
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-zBnrnuFHLAXQF0Jv6oeq"
Date: Mon, 02 Jul 2007 10:54:19 -0400
Message-Id: <1183388059.21760.4.camel@code.and.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-zBnrnuFHLAXQF0Jv6oeq
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2007-07-02 at 10:00 -0400, Joshua Brindle wrote:=20
> Eamon Walsh wrote:
> > Karl MacMillan wrote:
> >> Can I suggest a middle ground? Implement in C (or C++) but use a strin=
g
> >> library.
> >=20
> > A library would be great, I'm still depressed about glib's=20
> > abort-on-malloc making it unusable.  ustr was mentioned earlier as a=20
> > possible library that could be used.
>=20
> Unfortunately ustr isn't in yum so we'd have to pull code into the lib=20
> itself, which I'd prefer not to.

 Right, it's not in Fedora's main repo. yet. But it should be "real soon
now".

> Additionally ustr's documentation is a=20
> bit lacking: http://www.and.org/ustr/functions . Stuff like "This=20
> function does nothing." in the docs is a bit disconcerting as well.

 Well I'm working on the documentation (and lack of it is one reason
I've held off putting it in the Fedora repo.), but there are examples
and test cases for every function. The function that did nothing was
ustr_pool_sys_free()[1], because you couldn't free an individual piece
of memory from a pool (just the pool itself).


[1] Which is now a virtual function of the pool, alas. the documentation
didn't get updated because I forgot I'd written documentation for it!

--=20
James Antill <jantill@redhat.com>

--=-zBnrnuFHLAXQF0Jv6oeq
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBGiRGX11eXTEMrxtQRAl9MAJ4v+KRQiiO0zSy73SHK2z+24YMhwgCgwCv0
/vSNsO+vxl22cA4ZDPtuZno=
=8BS2
-----END PGP SIGNATURE-----

--=-zBnrnuFHLAXQF0Jv6oeq--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
