Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iB8IwvIi007188
	for <selinux@tycho.nsa.gov>; Wed, 8 Dec 2004 13:58:58 -0500 (EST)
Received: from mailrelay1.lrz-muenchen.de (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iB8Iwxu3029320
	for <selinux@tycho.nsa.gov>; Wed, 8 Dec 2004 18:58:59 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Wed, 8 Dec 2004 19:58:59 +0100
Date: Wed, 8 Dec 2004 19:59:01 +0100
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: James Carter <jwcart2@epoch.ncsc.mil>
Cc: SELinux ML <selinux@tycho.nsa.gov>
Subject: Re: patch: general cleanup
Message-Id: <20041208185901.GA5119@jmh.mhn.de>
References: <20041206233528.GD3678@jmh.mhn.de> <20041206234358.GG3678@jmh.mhn.de> <1102529738.30962.13.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
In-Reply-To: <1102529738.30962.13.camel@moss-lions.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* James Carter <jwcart2@epoch.ncsc.mil> [2004-12-08 19:13]:
> On Mon, 2004-12-06 at 18:43, Thomas Bleher wrote:
> > * Thomas Bleher <bleher@informatik.uni-muenchen.de> [2004-12-07 00:35]:
> > > Remove some duplicated permissions and attributes.
> > >=20
> > > Adds a few permissions:
> > > * initrc can setattr xconsole_device_t
> > > * mount can read device_t:lnk_file and read xdm_t:fifo_file
> >=20
> > Oops, forgot to attach patch.
> > Here it is.
> >=20
> > Thomas
>=20
> > --- orig/macros/program/sudo_macros.te
> > +++ mod/macros/program/sudo_macros.te
> > @@ -31,7 +31,6 @@
> >  rw_dir_create_file($1_sudo_t, $1_tmp_t)
> >  rw_dir_create_file($1_sudo_t, $1_home_t)
> >  domain_auto_trans($1_t, sudo_exec_t, $1_sudo_t)
> > -r_dir_file($1_sudo_t, selinux_config_t)
> >  ')
>=20
> This doesn't look like a duplicate rule to me.

OK, I should probably comment my changes a little better.
sudo_domain() includes newrole_domain() which allows
r_dir_file($1_t, selinux_config_t)

>=20
> >  # arch-tag: 67418b54-b56c-44d7-841c-5c895e795cd8
> > --- orig/macros/user_macros.te
> > +++ mod/macros/user_macros.te
> > @@ -221,22 +222,22 @@
> >  #  Allow users to mount file systems like floppies and cdrom
> >  #
> >  mount_domain($1, $1_mount, `, fs_domain')
> > -role $1_r types $1_mount_t;
> >  r_dir_file($1_t, mnt_t)
> > +allow $1_mount_t device_t:lnk_file read;
> >  allow $1_mount_t removable_device_t:blk_file read;
> >  allow $1_mount_t iso9660_t:filesystem relabelfrom;
> >  allow $1_mount_t removable_t:filesystem { mount relabelto };
> >  allow $1_mount_t removable_t:dir mounton;
> >  ifdef(`xdm.te', `
> >  allow $1_mount_t xdm_t:fd use;
> > -allow $1_mount_t xdm_t:fifo_file write;
> > +allow $1_mount_t xdm_t:fifo_file { read write };
> >  ')
> >  ')
>=20
> Same with the role $1_r types $1_mount_t rule.  I see similar role rules
> elsewhere for system_r and sysadm_r, but not for user_r and staff_r.

It's in macros/program/mount_macros.te, line 30.

Thomas

--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBt071xWIrrrL0q+cRAvD7AKCJkccDMFBEjMrZ/ijigzi6RVgRtgCeIOFe
z3rh5ykZcqXSOttpUhtDolU=
=An5b
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
