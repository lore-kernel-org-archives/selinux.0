Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iASJbFIi007776
	for <selinux@tycho.nsa.gov>; Sun, 28 Nov 2004 14:37:15 -0500 (EST)
Received: from mailrelay1.lrz-muenchen.de (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iASJZg5A025651
	for <selinux@tycho.nsa.gov>; Sun, 28 Nov 2004 19:35:43 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Sun, 28 Nov 2004 20:37:16 +0100
Date: Sun, 28 Nov 2004 20:37:13 +0100
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: James Carter <jwcart2@epoch.ncsc.mil>
Cc: Colin Walters <walters@verbum.org>, SELinux ML <selinux@tycho.nsa.gov>
Subject: Re: patch: misc policy additions
Message-Id: <20041128193712.GA2509@jmh.mhn.de>
References: <20041109210447.GC2543@jmh.mhn.de> <1100046550.26388.8.camel@nexus.verbum.private> <20041110102439.GA2541@jmh.mhn.de> <1100893088.31793.14.camel@moss-lions.epoch.ncsc.mil> <20041127225844.GA2509@jmh.mhn.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
In-Reply-To: <20041127225844.GA2509@jmh.mhn.de>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Thomas Bleher <bleher@informatik.uni-muenchen.de> [2004-11-28 01:26]:
> * James Carter <jwcart2@epoch.ncsc.mil> [2004-11-19 20:35]:
> > Merged.  Except for the following chunk:
> >=20
> > diff -urN orig/domains/program/restorecon.te mod/domains/program/restor=
econ.te
> > --- orig/domains/program/restorecon.te  2004-11-09 08:45:50.000000000 +=
0100
> > +++ mod/domains/program/restorecon.te   2004-11-09 21:50:48.000000000 +=
0100
> > @@ -41,7 +41,7 @@
> >  allow restorecon_t unlabeled_t:dir_file_class_set { getattr relabelfro=
m };
> >  allow restorecon_t unlabeled_t:dir read;
> >  allow restorecon_t device_type:{ chr_file blk_file } { getattr relabel=
=66rom relabelto };
> > -allow restorecon_t { device_t device_type }:{ chr_file blk_file } { ge=
tattr relabelfrom relabelto };
> > +allow restorecon_t { device_t device_type ttyfile }:{ chr_file blk_fil=
e } { getattr relabelfrom relabelto };
> >  ifdef(`distro_redhat', `
> >  allow restorecon_t tmpfs_t:{ chr_file blk_file } { rw_file_perms relab=
elfrom relabelto };
> >  ')
> >=20
> > Why do you want to restorecon_t to relabel a ttyfile? =20
> > The only contexts with the ttyfile attribute are user_tty_device_t,
> > staff_tty_device_t, and sysadm_tty_device_t.  The tty is relabeled to
> > these from an initial tty_device_t context, so the only thing that I see
> > this permission doing is to allow a current session to be relabeled from
> > one of these three contexts to tty_device_t.  Why would we want to do
> > that?
>=20
> I do not remember the exact circumstances when I needed it. However, I
> don't think it's just relabeling between the $1_tty_device_t types. What
> if a device file loses its context? restorecon can relabel all other
> files so it just seemed logical to allow it.

I just looked over it again and realized that tty_file_t doesn't have
attribute ttyfile. So I agree that it's not very useful. We may want to
allow relabelfrom (it's already in initrc-policy) so you can say
        restorecon /dev/tty*
in an init-script and have it work even if the files hadn't been
relabeled back (eg because of a crash)
But I'll leave that for you to decide.

Thanks,
Thomas

--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBqijoxWIrrrL0q+cRApyCAKCGHfpS1jDn8W6sLLIf8u79dfwyZgCgp50k
HfpRA64FiZB5bPnKJlf5B/g=
=j3ns
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
