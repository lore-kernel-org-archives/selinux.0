Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1FF9us2022468
	for <selinux@tycho.nsa.gov>; Fri, 15 Feb 2008 10:09:56 -0500
Received: from penguin.goodinassociates.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1FF9t31029207
	for <selinux@tycho.nsa.gov>; Fri, 15 Feb 2008 15:09:55 GMT
Subject: Re: secadm question
From: Jeremiah Jahn <jeremiah@goodinassociates.com>
To: Paul Moore <paul.moore@hp.com>
Cc: selinux <selinux@tycho.nsa.gov>
In-Reply-To: <200802150855.47722.paul.moore@hp.com>
References: <1203030583.3669.197.camel@bluejay.goodinassociates.com>
	 <200802150855.47722.paul.moore@hp.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-dzg+qrjhfb4ADkLOs/VF"
Date: Fri, 15 Feb 2008 09:09:47 -0600
Message-Id: <1203088187.3669.241.camel@bluejay.goodinassociates.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-dzg+qrjhfb4ADkLOs/VF
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

So if I change my build.conf to be mls I should be up and running. I'm
on RHEL5 btw

On Fri, 2008-02-15 at 08:55 -0500, Paul Moore wrote:
> On Thursday 14 February 2008 6:09:43 pm Jeremiah Jahn wrote:
> > I see a number of places where the secadm_r role shows up, but It
> > doesn't show up in the list of users and what not, Is there something
> > simple I need to enable it, or 	do I need to build it from scratch?
> > My goal it to have sysadm not able to modify policy enforcement, and
> > my secadm not be able to do anything but. If there is a standard way
> > to do this, I'd love to know.
>=20
> I believe the secadm_r role is only defined for the "mls" policy builds;=20
> if you are running a "mcs" (the Fedora default) policy I don't think=20
> the secadm_r role is present.
>=20
Boy, n.: A noise with dirt on it.

--=-dzg+qrjhfb4ADkLOs/VF
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBHtas76caZY8jbHDkRAthrAJwLpILtyGb6Hl9bk/cedNNXt0ympgCdG7Gs
ldPsBrr7c70j2Hh2KEk1sIk=
=6Q+f
-----END PGP SIGNATURE-----

--=-dzg+qrjhfb4ADkLOs/VF--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
