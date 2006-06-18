Subject: Re: [PATCH] pam_namespace : allow use of X and gdm while
	polyinstantiating /tmp
From: James Antill <jantill@redhat.com>
To: russell@coker.com.au
Cc: Daniel J Walsh <dwalsh@redhat.com>, janak@us.ibm.com,
        "Timothy R. Chavez" <tinytim@us.ibm.com>, sgrubb@redhat.com,
        tmraz@redhat.com, klaus@atsec.com, Valdis.Kletnieks@vt.edu,
        sds@tycho.nsa.gov, selinux@tycho.nsa.gov
In-Reply-To: <200606172027.51997.russell@coker.com.au>
References: <1150426606.12904.3.camel@localhost.localdomain>
	 <200606171030.57042.russell@coker.com.au> <4493D0DE.3050805@redhat.com>
	 <200606172027.51997.russell@coker.com.au>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-vpwyTG6hD07rHoDBHGzk"
Date: Sun, 18 Jun 2006 14:51:04 -0400
Message-Id: <1150656664.29837.170.camel@code.and.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-vpwyTG6hD07rHoDBHGzk
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2006-06-17 at 20:27 +1000, Russell Coker wrote:
> On Saturday 17 June 2006 19:52, Daniel J Walsh <dwalsh@redhat.com> wrote:
> > > What exactly do you mean?  Do you mean moving it somewhere else such
> > > as /var/run or do you mean using TCP instead?
> >
> > They are talking about using abstract namespaces.
>=20
> What exactly do you mean?

 man 7 unix

--=20
James Antill <jantill@redhat.com>

--=-vpwyTG6hD07rHoDBHGzk
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBElaCY11eXTEMrxtQRAgQ2AJ97k+dEPzKnh/pyVWXOJaf0p9UUbQCgq74g
O46c54xEvIjEDfn0iSfKBoU=
=Y/qB
-----END PGP SIGNATURE-----

--=-vpwyTG6hD07rHoDBHGzk--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
