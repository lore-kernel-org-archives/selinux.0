Date: Thu, 15 Sep 2005 00:44:20 +0100
From: Dale Amon <amon@vnl.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Dale Amon <amon@vnl.com>, Ivan Gyurdiev <ivg2@cornell.edu>,
   Joshua Brindle <jbrindle@tresys.com>, SELinux List <SELinux@tycho.nsa.gov>
Subject: Re: [ SEPOL ] Move more things to newer debug system
Message-ID: <20050914234420.GD27187@vnl.com>
References: <43258D48.80702@cornell.edu> <43264DAD.5090903@cornell.edu> <1126641568.29303.241.camel@moss-spartans.epoch.ncsc.mil> <4327521D.5020605@cornell.edu> <1126652637.30915.18.camel@twoface.columbia.tresys.com> <432799F0.7060706@cornell.edu> <43279AED.7040605@cornell.edu> <1126703779.12299.43.camel@moss-spartans.epoch.ncsc.mil> <20050914140508.GC27187@vnl.com> <1126721243.12299.145.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VUDLurXRWRKrGuMn"
In-Reply-To: <1126721243.12299.145.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--VUDLurXRWRKrGuMn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 14, 2005 at 02:07:23PM -0400, Stephen Smalley wrote:
> > > As for threads, Alan Cox said it best:  "A computer is a state machin=
e.
> > > Threads are for people who cant program state machines.".
> >=20
> > A true statement, but... complexity explosion makes
> > it useful to move to techniques which make 'what is
> > happening' clearer and easier to understand and to
> > verify.
>=20
> Sorry, that isn't a motivation to move to threads.  Quite the opposite.

I'm not talking about selinux needs per-se... but I
have found it much clearer to deal with multiple events
via multiple processes (same thing in linux)  rather=20
than with a state machine to try to handle them all.=20
I use both techniques all the time.=20

--=20
------------------------------------------------------
   Dale Amon     amon@islandone.org    +44-7802-188325
       International linux systems consultancy
     Hardware & software system design, security
    and networking, systems programming and Admin
	      "Have Laptop, Will Travel"
------------------------------------------------------

--VUDLurXRWRKrGuMn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDKLXUZHES7UL0zXERAgvNAJ9tQaDsxHpfEPVoBH/YMCt02ipCewCeJezG
m/w9j4hCodMwhdT9ol1fcrs=
=OoCC
-----END PGP SIGNATURE-----

--VUDLurXRWRKrGuMn--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
