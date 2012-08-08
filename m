Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q78KiIRH009173
	for <selinux@tycho.nsa.gov>; Wed, 8 Aug 2012 16:44:18 -0400
Date: Wed, 8 Aug 2012 22:44:01 +0200
From: Ole Kliemann <ole@plastictree.net>
To: selinux@tycho.nsa.gov
Subject: Re: SELinux performance depending on type count
Message-ID: <20120808204401.GA5403@telvanni>
References: <20120807130244.GE2085@telvanni>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
In-Reply-To: <20120807130244.GE2085@telvanni>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I haven't tested any runtime performance just compile-time and=20
policy size.

All this is done on my old Dell D410 with a 1.73GHz Pentium M.

On Tue, Aug 07, 2012 at 03:02:44PM +0200, Ole Kliemann wrote:
> But if there was a performance problem with a lot of types, at=20
> what number n would it start to hit hard? And how does it=20
> increase (linear, quadratic...)?

n=3D10000, i.e. 20000 types, 10000 attributes and a handful of=20
allows per type and attribute in one module.

compilation is okay, but inserting the said module with=20
semodule... well at 18min CPU-time I killed the process... who=20
knows what size this policy would have had...


n=3D5000, i.e. 10000 types, 5000 attributes and a handful of=20
allows per type and attribute in one module.

inserting the module in about 5m30s walltime. policy is 13M of=20
size.


n=3D1000, i.e. 2000 types, 1000 attributes and a handful of=20
allows per type and attribute in one module.

inserting the module in about 9s walltime. policy is 2.5M of=20
size.


Apparently the runtime of inserting the module is fataly steep in=20
n. Rough estimation would be at least n^2, could be higher=20
depending on how long n=3D10000 would have actually taken.

> And would it be better performance-wise to run a MCS-policy with=20
> say categories c0.cn than to have types c0_t, ... cn_t?

n=3D10000, i.e. 10000 categories, one sensitivity and a handful of=20
mlsconstraints

inserting the module in about 8s walltime. policy is 284K of=20
size.


Of course this is a very rough and inprecise testing. But I guess=20
one can say that the policy infrastructure get's into trouble=20
with high type count whereas a high category count seems to be=20
handled flawlessly.

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAlAiz5EACgkQS1FjE303ERwB+wCggxhI8KAh7BH9uqTSL/0AIeVb
yAkAn3nn6meoZB9cUZCW+9u+oWYQ9wcE
=dPGt
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
