Date: Thu, 3 Sep 2015 14:32:15 +0200
From: Dominick Grift <dac.override@gmail.com>
To: James Carter <jwcart2@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Subject: Re: secilc: in segfault
Message-ID: <20150903123214.GA2118@x250>
References: <20150903094844.GA18832@x250>
 <55E83A89.5010208@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="k1lZvvs/B4yU6o8G"
In-Reply-To: <55E83A89.5010208@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 03, 2015 at 08:18:17AM -0400, James Carter wrote:
> On 09/03/2015 05:48 AM, Dominick Grift wrote:
> >Anyone tried "secilc test/in_test.cil" lately? It dumps core here.
> >
> >$ secilc test/in_test.cil
> >Segmentation fault (core dumped)
> >
> >
>=20
> It works for me for the current master branch of SELinux userspace instal=
led
> locally. What version are you using?
>=20
> Jim

It happens with both secilc-2.4-5.fc24.x86_64 as well as
secilc-2.4-6.fc24.x86_64 (which was spun 2 day's ago by Fedora)

It does work with some old secilc i had laying around in my ~/bin

>=20
>=20
> --=20
> James Carter <jwcart2@tycho.nsa.gov>
> National Security Agency
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa=
=2Egov.

--=20
02DFF788
4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
http://keys.gnupg.net/pks/lookup?op=3Dvindex&search=3D0x314883A202DFF788
Dominick Grift

--k1lZvvs/B4yU6o8G
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJV6D3JAAoJENAR6kfG5xmcdzQL/jlemH7wtZLvXRSQd8+9nQ2Y
/pSSL4szRI2YQ8VOpDRn9kR8TTgF4UwEuoVhcC4XCNZPJC1DbBruX/uEaULWKJEK
M+GWweBgY0ONs8NsfSDV7vfcpLLp1k+VcElooUPXgYge3ZfgLes418/xUUvHBNC9
F3/8E4jO2fY45FNUbmPIjHWlwfiWnjacBf5VYzkxAZ9R8M0Jx+qekm2wIA+dJqqR
Jr2BSNZLLg1KnTZMgkmP7cjP5BuEgRSwt7wIZJHWfNsFPLFiscRkJ0zT3Bddccnz
eB/RJMRmabSy4PVUecGk7hUqhMTC+tllpF6l8zXGFxW8iKHVJAMZKam0wqn7FF1z
eatm1OrTIQEWyYgYnqUIMuoUPAg4KkC6PO/k24o5uKBCjou1KKqo9YCQb9zeDnbq
V9mljLb95tNgFD7oOgXTzWLvXwGcpTE6U31LKo9Iwm57oX4V1LyXGAB3pB0WNzM/
yaWyyTiX199TK3i8wLntbNU9xKOduJgb/emWrbO4XQ==
=wYpH
-----END PGP SIGNATURE-----

--k1lZvvs/B4yU6o8G--
