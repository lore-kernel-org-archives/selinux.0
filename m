Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6MKbaQF030916
	for <selinux@tycho.nsa.gov>; Tue, 22 Jul 2008 16:37:36 -0400
Received: from QMTA07.westchester.pa.mail.comcast.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6MKbZfo008934
	for <selinux@tycho.nsa.gov>; Tue, 22 Jul 2008 20:37:35 GMT
Subject: Re: [refpolicy-patch 02/23] anaconda policy update
From: Chris PeBenito <pebenito@gentoo.org>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: david@hardeman.nu, selinux@tycho.nsa.gov
In-Reply-To: <4885B399.10900@redhat.com>
References: <20080719205002.462190042@hardeman.nu>
	 <20080719210251.406319184@hardeman.nu>  <4885B399.10900@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-sJCTNfqcCW/A5KqjtD6X"
Date: Tue, 22 Jul 2008 16:36:56 -0400
Message-Id: <1216759016.4954.40.camel@defiant.pebenito.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-sJCTNfqcCW/A5KqjtD6X
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2008-07-22 at 06:16 -0400, Daniel J Walsh wrote:
> david@hardeman.nu wrote:
> > Anaconda is a RH installation program, RH should know their own program=
 and
> > the changes are quite trivial
> >=20
> > diff --exclude-from=3Dexclude -N -u -r nsaserefpolicy/policy/modules/ad=
min/anaconda.te serefpolicy-3.5.0/policy/modules/admin/anaconda.te
> > --- nsaserefpolicy/policy/modules/admin/anaconda.te	2008-07-10 11:38:46=
.000000000 -0400
> > +++ serefpolicy-3.5.0/policy/modules/admin/anaconda.te	2008-07-15 14:05=
:12.000000000 -0400
> > @@ -31,16 +31,11 @@
> >  modutils_domtrans_insmod(anaconda_t)
> > =20
> >  seutil_domtrans_semanage(anaconda_t)
> > -
> > -unconfined_domain(anaconda_t)
> > +seutil_domtrans_setsebool(anaconda_t)
> > =20
> >  unprivuser_home_dir_filetrans_home_content(anaconda_t,{ dir file lnk_f=
ile fifo_file sock_file })
> > =20
> >  optional_policy(`
> > -	dmesg_domtrans(anaconda_t)
> > -')
> > -
> > -optional_policy(`
> >  	kudzu_domtrans(anaconda_t)
> >  ')
> > =20
> > @@ -58,5 +53,9 @@
> >  ')
> > =20
> >  optional_policy(`
> > +	unconfined_domain(anaconda_t)
> > +')
> > +
> > +optional_policy(`
> >  	usermanage_domtrans_admin_passwd(anaconda_t)
> >  ')
> >=20
> The main goal of this patch was to get anaconda AVC messages out of the
> log files.  Anaconda has to run the installation in permissive mode so
> we need to avoid avc messages by making it unconfined and avoid
> transitions where ever possible. The goal is to have /root/anaconda.log
> without any SELinux errors.  As for Russells comments we might want to
> make this more of a generic installer policy?

At the moment, I'm not overly concerned about having anaconda in the
tree, since its unconfined, and rarely gets updates.  Is there even
another installer that runs with SELinux enabled, like anaconda during a
RH/Fedora install?

--=20
Chris PeBenito
<pebenito@gentoo.org>
Developer,
Hardened Gentoo Linux
=20
Public Key: http://pgp.mit.edu:11371/pks/lookup?op=3Dget&search=3D0xE6AF924=
3
Key fingerprint =3D B0E6 877A 883F A57A 8E6A  CB00 BC8E E42D E6AF 9243

--=-sJCTNfqcCW/A5KqjtD6X
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkiGROgACgkQvI7kLeavkkOUZwCfT5QTGtkRiNP6eIF4cFWS0NeW
fXEAn2Z/lQbAUqnorgb68jgj6PCOSbKd
=aP4g
-----END PGP SIGNATURE-----

--=-sJCTNfqcCW/A5KqjtD6X--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
