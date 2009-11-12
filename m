Date: Thu, 12 Nov 2009 08:58:57 +0100
From: Michal Svoboda <michal.svoboda@agents.felk.cvut.cz>
To: SELinux@tycho.nsa.gov
Subject: Re: MCS read only cats
Message-ID: <20091112075857.GO28630@myhost.felk.cvut.cz>
References: <C72056E1.AFD7E%csellers@tresys.com>
 <200911121413.31687.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mejza3ZMMA5Za1mX"
In-Reply-To: <200911121413.31687.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--mejza3ZMMA5Za1mX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Russell Coker wrote:
> Currently we don't support ranges on files, but we can change policy
> to allow it.  You could have something like the following:
>=20
> mlsconstrain file { read }
>         (( h1 dom l2 ) or ( t2 =3D=3D domain ) or ( t1 =3D=3D mlsfileread=
 ));
>=20
> mlsconstrain file { create relabelto }
>         (( h1 dom h2 ) and ( l1 dom l2 ));

Hello,

thanks for the tip. Actually I had the same idea yesterday! Only that I
thought of=20

mlsconstrain file { create relabelto }
         (( h1 dom h2 ) and ( h1 dom l2 ));
	                      ^

because in my MCS schema users usually have low =3D s0.

What exactly do you mean by not supporting ranges on files? Normally MCS
has a constrain on create/relabelto such as h2 eq l2, but I think if the
constrain is relaxed in the abovementioned fashion then there would be
no other problems? (I have seen multiranged files in the MLS policy...)

> But generally read-only files are implemented with new types.  I do
> that on the custom policy for my SE Linux Play Machine.

Well, what I want is to give users one login that maps to a generic
identity (say, user_u), but control their access to file of various
projects via MCS categories.

Now, if I had read only and read/write TE rules, I can imagine giving
every user 2 accounts, of which one would result in a shell that is
confined to read only operations, but has more MCS cats, but I can't
imagine how would I accomplish that with one account.

Or I could create a separate selinux user for everyone and by some
wicked macro machinery give that user the appropriate TE types and rules
for every project, but that seems to me like a lot of mess and generally
asking for trouble.

Regards,
Michal Svoboda

--mejza3ZMMA5Za1mX
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkr7wEEACgkQg/fU9pp1uX4/iwCeMR9WCL70uk9wcQwVJXMggdSZ
CTMAoJ3LQGPrGsRUUMhjWwH61h6IaPHA
=aX8p
-----END PGP SIGNATURE-----

--mejza3ZMMA5Za1mX--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
