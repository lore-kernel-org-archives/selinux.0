Subject: Re: request for review of, and collaboration on SELinux models
 wiki entry
From: Dominick Grift <domg472@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1246544997.13464.314.camel@moss-pluto.epoch.ncsc.mil>
References: <1246542053.26320.15.camel@notebook2.grift.internal>
	 <1246544997.13464.314.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-1bRNoB3oCv7YG/BKhOHS"
Date: Thu, 02 Jul 2009 16:54:46 +0200
Message-Id: <1246546486.26320.30.camel@notebook2.grift.internal>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-1bRNoB3oCv7YG/BKhOHS
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2009-07-02 at 10:29 -0400, Stephen Smalley wrote:
> On Thu, 2009-07-02 at 15:40 +0200, Dominick Grift wrote:
> > Recently
> > http://www.nsa.gov/research/_files/selinux/papers/policy2/x86.shtml cam=
e
> > to my attention and i noticed that this article does not reflect the
> > current available SELinux models. Also the descriptions seem a bit
> > technical to me.
> >=20
> > Today i decided to make a new introduction to SELinux models with MCS,
> > MLS and UBAC included for the selinuxproject Wiki. The attempt was to
> > keep it as easy to read for humans as possible.
> >=20
> > I am sure that my entry has mistakes and could use improvements,
> > therefore i ask you to review the entry and submit any improvements.
> >=20
> > You can also send suggestions directly to me.
> >=20
> > http://selinuxproject.org/page/SELinux_models
> >=20
> > Once we feel comfortable with the content we can add a link on the User
> > Resource front page.
>=20
> - Security contexts are assigned to more than just processes and files.

You and i know that but for a common user i think just separation of
files and processes should suffice.

When all is said and done a Linux system is just a bunch of files

I will edit it to read processes and objects although personally i think
objects sound a bit technical.

> - MLS/MCS has a single attribute, the MLS/MCS range, which has the
> syntax:
> lowsensitivity[:lowcategory,...][-highsensitivity[:highcategory,...]]
>=20
> This is a pair of levels (which in the degenerate case where low=3D=3Dhig=
h
> is displayed as a single level for conciseness) where each level
> consists of a sensitivity value and a category set.

I will edit it to reflect this. I must say that reading a security
context and its fields suggests otherwise: user:role:type:level:category

if each field is a seperate attribute then the context suggests
categories are a separate attribute.

> - The motivation of UBAC (which started as rbacsep) was to eliminate the
> need for per-role derived domains for programs and derived types for
> files.  It isn't really its own distinct model per se, just a particular
> configuration of constraints based on SELinux user identity.

Maybe a it is a concept, like SELinux user identities? maybe i should
explain the difference between models and concepts although i feel that
would make things more complicated than needed.

I noted that it is not a distinct model i think by suggesting that it is
an extension to SELinux User identities.

> - MCS and MLS are just particular configurations of constraints for the
> MLS engine and thus share the same field and engine logic.  MCS was an
> attempt to make the MLS field and engine useful for general users, and
> is being leveraged by sandbox and by svirt for separating multiple
> instances of sandboxes or guest VMs.

I think i touched on that by saying: Multi Category Security is a
implementation of Multi Level Security where the use of assigned
Security Categories is to the discretion of the user.

I will think about ways to clear this up.

Thanks for your suggestions. I will apply the corrections soon.

Also feel free to edit the page.

--=-1bRNoB3oCv7YG/BKhOHS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkpMyigACgkQMlxVo39jgT+cuQCgtfgJoQY3u9WJ7GzSIMJ6sgrq
gr0An3Bn7tNuntG8Ts0ZdWG+50ysCQvt
=etF7
-----END PGP SIGNATURE-----

--=-1bRNoB3oCv7YG/BKhOHS--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
