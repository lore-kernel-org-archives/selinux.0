Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2PEfpDo009502
	for <selinux@tycho.nsa.gov>; Fri, 25 Mar 2005 09:41:51 -0500 (EST)
Received: from vds-320151.amen-pro.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2PEcu54014037
	for <selinux@tycho.nsa.gov>; Fri, 25 Mar 2005 14:38:56 GMT
Subject: Re: [RFC] selinux-support (1.0.1) available
From: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?= =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: ubuntu-hardened@lists.ubuntu.com, selinux@tycho.nsa.gov
In-Reply-To: <1111759697.15280.53.camel@moss-spartans.epoch.ncsc.mil>
References: <1111704432.27644.62.camel@localhost.localdomain>
	 <1111759697.15280.53.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-XwmXuRV4CgL3Ni3fPTRQ"
Date: Fri, 25 Mar 2005 15:41:02 +0100
Message-Id: <1111761662.27644.121.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-XwmXuRV4CgL3Ni3fPTRQ
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

El vie, 25-03-2005 a las 09:08 -0500, Stephen Smalley escribi=F3:
> Can you explain the purpose of this package?  I'm not sure I understand
> what you mean, or why the above packages would depend on it.  What is
> the purpose of the /etc/selinux.conf file in this package, and how does
> it compare to the already existing /etc/selinux/config file that is
> being used by libselinux and various scripts?  Do you expect this to
> remain Ubuntu-specific?
>=20

The purpose is to provide a meta-package such as the harden &
harden-environment ones, that installs all the user-land tools packages
for supporting SELinux, among other interesting packages or needed
stuff.

/etc/selinux.conf is to be used by front-end utilities, configuration
tools and other stuff.
We are now thinking in a "Security Center"-like [1] solution for Ubuntu,
so, it also makes sense for such thing.

In my opinion, it's going to be Ubuntu specific until it's back-accepted
in Debian, anyways, I expect to have, at least, the user-land ready for
SELinux support within the Ubuntu Linux distribution, for the Hoary+1
release (Breezy).

[1]:
http://lists.ubuntu.com/archives/ubuntu-hardened/2005-March/000003.html

Cheers,
PS: I'm CC'ing to ubuntu-hardened to keep the thread, just if someone
needs to know or ask about the same information and ends up on
ubuntu-hardened.
--=20
Lorenzo Hern=E1ndez Garc=EDa-Hierro <lorenzo@gnu.org>=20
[1024D/6F2B2DEC] & [2048g/9AE91A22][http://tuxedo-es.org]

--=-XwmXuRV4CgL3Ni3fPTRQ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBCRCL+DcEopW8rLewRAjEMAJ9J6+E4yyjDJH6BPT/AB1QyqqrKuwCfc83S
OJD5T2EgFzqrPqObabDa3Lk=
=mzn0
-----END PGP SIGNATURE-----

--=-XwmXuRV4CgL3Ni3fPTRQ--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
