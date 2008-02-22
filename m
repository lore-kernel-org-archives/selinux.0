Subject: Re: secadm/sysadm discussion
From: Jeremiah Jahn <jeremiah@goodinassociates.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, Paul Moore <paul.moore@hp.com>,
        selinux <selinux@tycho.nsa.gov>
In-Reply-To: <47BAEC42.60708@redhat.com>
References: <1203030583.3669.197.camel@bluejay.goodinassociates.com>
	 <200802150855.47722.paul.moore@hp.com>
	 <1203088187.3669.241.camel@bluejay.goodinassociates.com>
	 <1203088562.16038.196.camel@moss-spartans.epoch.ncsc.mil>
	 <1203089944.13618.40.camel@gorn>
	 <1203091760.3669.249.camel@bluejay.goodinassociates.com>
	 <1203091792.13618.56.camel@gorn>
	 <1203092070.3669.251.camel@bluejay.goodinassociates.com>
	 <1203092610.13618.58.camel@gorn>
	 <1203093415.3669.258.camel@bluejay.goodinassociates.com>
	 <47B60285.9010801@redhat.com> <1203341839.13618.71.camel@gorn>
	 <47BAEC42.60708@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ElCMb0q5Ypamkp2X5u/M"
Date: Fri, 22 Feb 2008 08:39:04 -0600
Message-Id: <1203691144.3669.893.camel@bluejay.goodinassociates.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-ElCMb0q5Ypamkp2X5u/M
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2008-02-19 at 09:48 -0500, Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>=20
> Christopher J. PeBenito wrote:
> > On Fri, 2008-02-15 at 16:22 -0500, Daniel J Walsh wrote:
> >> <rant>
> >>
> >>
> >> Personally I think sysadm_t is a waste of time.  It is a poor mans
> >> unconfined_t and should be eliminated from the face of the earth.  All
> >> it does is generate Bugs and avc messages without supplying any real
> >> security.  It makes no sense, as a confinement of a root user since it
> >> is so easily gotten around.  If you have an administrator of a machine=
,
> >> that you want to confine, start with only allowing him the privs that
> >> are required to do his job.  You can't start by saying he can do
> >> everything except ABC.
> >=20
> > As long as policy is used in a strict configuration, sysadm will be
> > needed.  I would prefer to tighten it up.
> >=20
> This is what I question.  If you can not define what a strict
> configuration is then sysadm_t is useless.  And tightening it up a
> little does nothing.  If sysadm_t can build an install an RPM all bets
> are off.  If he can format disk, add users, change passwords, run su,
> modify sudo, change contents of the homedir of the "sysadm_t" homedir.
> Then you can not stop him.
>=20
> So why carry on the charade that this is useful.  I my mind you either
> fully trust your admin or you don't.  If you don't you need to define
> exactly what you want him to be allowed to do, and then write policy for
> that.  If you can't write policy tight enough to stop him from doing
> evil things, then you need to fall back to auditing his every move.
> Writing a special mishmash of admin called sysadm is a waste of time.

This is essentially what I have done. I went through userdomain.te and
moved most references regrading sysadm to secadm or auditadm. I left
only the ones I need to do my job (Hi i'm the sysadm). I've commented
out everything that required mls to be defined and made it the default,
and then commented out any 'else' situation that defaulted to giving the
sysadm the power. initrc, logrotate, rpm etc. The thing I dislike most
about what I'm currently dealing with seem to be the cascading
transitions. from sysadm->rpm_t->initrc->my secure service for example.
I've gotten rid of all of those, and I still can't disable the sysadm
role from seeing all of the running processes in ps aux. In a perfect
world I'd like to have an abstract list of everything that can happen on
the system, and then add each role to it. I think the refpolicy is
closing in on this, but there are still some awfully detailed issues
that still have to be taken into account.  It's the permissions NOT in
userdomain.te that are where I get lost/frustrated.=20

>=20
>=20
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.8 (GNU/Linux)
> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org
>=20
> iEYEARECAAYFAke67EIACgkQrlYvE4MpobPtxACePPwf7FQeH+TME/pcZ1SvwRq8
> 6hYAnR3S1xw8DVjySDuJAMgw6q9bMl1M
> =3DhqGN
> -----END PGP SIGNATURE-----
=46rom the moment I picked your book up until I put it down I was
convulsed with laughter. Some day I intend reading it. -- Groucho Marx,
from "The Book of Insults"

--=-ElCMb0q5Ypamkp2X5u/M
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBHvt6I6caZY8jbHDkRAn+IAJwNGIfECV8/EUKxFApd9pVuCuFQnACfUQWw
jL7CDFRebs2wDFcBSpB1Ddc=
=LFZa
-----END PGP SIGNATURE-----

--=-ElCMb0q5Ypamkp2X5u/M--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
