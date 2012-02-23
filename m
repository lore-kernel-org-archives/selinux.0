Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q1NA4Q92003465
	for <selinux@tycho.nsa.gov>; Thu, 23 Feb 2012 05:04:26 -0500
Message-ID: <1329991460.3678.5.camel@mattotaupa>
Subject: Re: No feedback when cloning `http://oss.tresys.com/git/selinux.git`
From: Paul Menzel <paulepanter@users.sourceforge.net>
To: Joe Nall <joe@nall.com>
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>, selinux@tycho.nsa.gov
Date: Thu, 23 Feb 2012 11:04:20 +0100
In-Reply-To: <6BF36172-D831-4087-8096-803DCB9AD957@nall.com>
References: <1329939142.3296.5.camel@mattotaupa>
	 <4F4546F6.5050603@tresys.com>
	 <6BF36172-D831-4087-8096-803DCB9AD957@nall.com>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-mHu3IHnzLWFGWPBT/3PI"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-mHu3IHnzLWFGWPBT/3PI
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Am Mittwoch, den 22.02.2012, 14:02 -0600 schrieb Joe Nall:
> On Feb 22, 2012, at 1:50 PM, Christopher J. PeBenito wrote:
>=20
> > On 02/22/12 14:32, Paul Menzel wrote:

> >> trying to clone the SELinux user space programs [1] I issue
> >>=20
> >>=20
> >>        $ git clone http://oss.tresys.com/git/selinux.git
> >>        Cloning into 'selinux'...
> >>=20
> >> but it just hangs there. So I thought it does not work. Letting it sta=
y
> >> for more than a minute it finished. Other Git repositories give some
> >> kind of feedback. Are some hooks missing?
> >=20
> > Are you sure you're waiting long enough?  I was able to clone a fresh c=
opy of the repo using the above command w/o problem.  It took 48s for me.
>=20
> I think what he is referring to is:
>=20
> time git clone http://oss.tresys.com/git/selinux.git
> Cloning into selinux...
>=20
> real	0m46.487s
> user	0m1.255s
> sys	0m2.326s
>=20
> time git clone https://github.com/joyent/node.git
> Cloning into node...
> remote: Counting objects: 60958, done.
> remote: Compressing objects: 100% (15947/15947), done.
> Receiving objects:  17% (10687/60958), 16.84 MiB | 820 KiB/s  =20
>=20
> the remote: and Receiving objects: lines

Correct, that is what amount by writing =C2=BBfeedback=C2=AB. I am sorry fo=
r the
confusion.


Thanks,

Paul

--=-mHu3IHnzLWFGWPBT/3PI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAk9GDyQACgkQPX1aK2wOHVjV2wCeM9Ny9w5Nluc+bM11glpZ+H03
cEcAn01rDGWd+9+TFMegZEc1gNZM71b4
=ytz7
-----END PGP SIGNATURE-----

--=-mHu3IHnzLWFGWPBT/3PI--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
