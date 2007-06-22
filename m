Subject: Re: [patch 1/3] libsemanage: genhomedircon replacement
From: James Antill <jantill@redhat.com>
To: Eamon Walsh <ewalsh@tycho.nsa.gov>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <467BFF99.9000404@tycho.nsa.gov>
References: <20070521095414.832619201@tresys.com>
	 <20070521095518.515998898@tresys.com>
	 <1179868119.9092.38.camel@localhost.localdomain>
	 <1180015458.3930.173.camel@tresys-winxppro>
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
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-6h7Ifh/Wl+DGnoujhxpB"
Date: Fri, 22 Jun 2007 16:00:02 -0400
Message-Id: <1182542402.31779.89.camel@code.and.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-6h7Ifh/Wl+DGnoujhxpB
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2007-06-22 at 12:58 -0400, Eamon Walsh wrote:
> Karl MacMillan wrote:
> > On Thu, 2007-06-21 at 16:54 -0400, Eamon Walsh wrote:
> >=20
> >>   I'm not a fan of the Python dependencies.
> >=20
> > Why?
>=20
> Here's a nice example of RPM hell, courtesy of our Python dependency.  I=20
> got this earlier in the year on one of my machines.
>=20
> # yum -y upgrade
> --> Running transaction check
> --> Processing Dependency: gnutls-devel for package: libsoup-devel
> --> Processing Dependency: python(abi) =3D 2.4 for package: audit-libs-py=
thon
> --> Restarting Dependency Resolution with new changes.
> --> Populating transaction set with selected packages. Please wait.
> ---> Package gnutls-devel.i386 0:1.4.5-1 set to be updated
> --> Running transaction check
> --> Processing Dependency: python(abi) =3D 2.4 for package: audit-libs-py=
thon
> --> Finished Dependency Resolution
> Error: Missing Dependency: python(abi) =3D 2.4 is needed by package=20
> audit-libs-python

 I'm not sure what this is trying to prove, the above is a
packaging/yum/rpm problem (which was fixed, IIRC).
 Also, again IIRC, it also has nothing to do with code being written in
python but because audit-libs-python / libselinux-python (which just
provide _bindings_ to the C API, and I don't think you are trying to
suggest we should remove those bindings) depend on an exact python-abi
and audit-libs / libselinux versions.

--=20
James Antill <jantill@redhat.com>

--=-6h7Ifh/Wl+DGnoujhxpB
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBGfCpB11eXTEMrxtQRAk3qAKCQ7IGqjiJ7FW3tAlyr32JBnlFzPgCeIVFj
k44uIx9BLt4FUPTIsvQ3/u8=
=VHaB
-----END PGP SIGNATURE-----

--=-6h7Ifh/Wl+DGnoujhxpB--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
