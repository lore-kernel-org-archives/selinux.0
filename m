Date: Thu, 28 May 2015 15:09:27 -0400
From: Stephen Frost <sfrost@snowman.net>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: postgresql policy
Message-ID: <20150528190926.GG26667@tamriel.snowman.net>
References: <CAFPpqQH8nFm0YRM-sgQ_8ijmEy6AFiBaU9-71MWRUJ_w0y6L3Q@mail.gmail.com>
 <55676482.6000302@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lDlKsL52Cv6NDSIn"
In-Reply-To: <55676482.6000302@tycho.nsa.gov>
Cc: SELinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--lDlKsL52Cv6NDSIn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Stephen,

* Stephen Smalley (sds@tycho.nsa.gov) wrote:
> On 05/28/2015 12:52 PM, Ted Toth wrote:
> > The ref policy contains a number of sepgsql_ types that are specific
> > to the sepgsql postgresql module. The sepgsql module was written to
> > support a postgresql security patch that was never accepted by the
> > upstream. Now postgresql has gone in a different direction security
> > wise adding row level security (RLS). I've been working on developing
> > RLS policy to label rows on insert and update and to check access
> > perms on select. I've tried using the sepgsql module in the RLS policy
> > but have come to the conclusion that because it was not designed for
> > this purpose it is not usable. So I'd like to suggest that these types
> > be moved out of the postgresql policy possibly into their own module
> > although I personally think they have little if any use.
>=20
> Should probably post a rfc patch to refpolicy list.
>=20
> On a different note, does this RLS implementation have any SELinux
> integration or is it just the typical "let's implement our own custom
> policy engine in the database manager and not link it in any way to the
> OS security model" approach?  Pity if it is the latter.

As the one who committed RLS to PostgreSQL, I'm hopeful that what we
have is actually able to provide both.  There is a system inside of
PostgreSQL for creating policies, which was a requirement of the PG
community as we fully expect it to be used in non-SELinux environments,
but there are also hooks available where a module (such as the sepgsql
contrib module that's included with PG) could add its own restrictive
and/or permissive policies.

I'm certainly interested in the type changes being discussed here and
would love to work with someone from the SELinux community on improving
the sepgsql contrib module (or, perhaps, adding a different and simpler
module which is closer to a shim around SELinux than the existing
sepgsql module).

	Thanks!

		Stephen

--lDlKsL52Cv6NDSIn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVZ2fmAAoJEO1sijiDR2RV4wMP/i9Z+d9Wd+XYIMe9H5R/rxst
Hi5zk49mIgq3OlR0P6sSM7b6yicRsvqFnICCzRwbbtI99E39z+OvHa165dDbjmKV
12dcUg2zqQ0IzvGA9VxiQZ4Ixbnreone0lNPt23W2iRClaIv9RDit2/F2baCJTek
mVkLPkTVbY22RI5MCRTtfQowp9h1ghZ9HfJx+nTNkd4E3tNoWjmmUmW6BrdwYkXg
58sAC88gk4MT/Xdp/PMba2rydzRWbuu2ga+TNPJJUXrZCzeYvNOotR/VdZBu6HwD
xLE7UtVX/xv1a6nxpsrQmFbu6bzl/nVf5ZLe8MSyJkdTNluW7pgXTG9JlI3Ntb16
hvJubrmKIaXde+qs7AjsFJYpA9bx9QJx7ZUW6f5TJ4SLffPeXvRyFJdRxHw8ycGL
/ZtUeMITIMDygerahZyIC4sr58kYAQKskfVo6pMbPLkGhPC1nlcIkcrjPTExYtn8
HGQXwLO37UdzVOW2IfyeiojdmEEVzhGH/COmETubvT3NP63Tc3L8SfPJdTwyr+EN
zd4RbuTPRSZi1oKrGZFDRIdK6ttcsxxAbL5VjWe82/uM/7n2O3+PAwlPNcaivQq+
W5/YCPqcawNg+lCWuT6JmkHSgmZ9IGpf4yd5z4zEAqRIZtkXHFvSHP/yV1SdKDPT
2a656q++sI1PR9jwOzzV
=PXSF
-----END PGP SIGNATURE-----

--lDlKsL52Cv6NDSIn--
