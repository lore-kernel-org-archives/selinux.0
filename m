Date: Wed, 12 Oct 2005 20:24:04 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: Valdis.Kletnieks@vt.edu
Cc: SELinux@tycho.nsa.gov
Subject: Re: System hang during boot on Debian Sid
Message-Id: <20051012182404.GA7754@thorium.jmh.mhn.de>
References: <20051009083426.GA10995@localhost.localdomain> <1129033658.3308.48.camel@moss-spartans.epoch.ncsc.mil> <20051011132002.GA6249@localhost.localdomain> <20051011170544.GE8829@lkcl.net> <20051012083430.GA8035@thorium.jmh.mhn.de> <200510121607.j9CG7wVb017607@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
In-Reply-To: <200510121607.j9CG7wVb017607@turing-police.cc.vt.edu>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Valdis.Kletnieks@vt.edu [2005-10-12 18:27]:
> On Wed, 12 Oct 2005 10:34:30 +0200, Thomas Bleher said:
>=20
> > special modifications or patches (at least for normal user logins). If
> > kdm should be able to shutdown the system it needs to have some access
> > to lilo, but I don't remember completely (could dig it up if you want).
>=20
> lilo? To shutdown the system?  That doesn't sound right...

Lilo has a nice feature in that it let's you set the target for the next
boot (lilo -R). Very handy if you want to boot an install kernel or
something like that. KDM supports this interface, so if you have the
appropriate permissions you can select which target to boot via a drop
down menu.
Of course, it gets a bit scary when you look at the needed permissions.
I have this snippet in policy:

# kdm_greet wants this - determine which systems can be booted
allow xdm_t boot_t:dir search;
type xdm_lilo_t, domain, fs_domain, privmem;
domain_auto_trans(xdm_t, bootloader_exec_t, xdm_lilo_t)
role system_r types xdm_lilo_t;
uses_shlib(xdm_lilo_t)
allow xdm_lilo_t boot_t:dir search;
allow xdm_lilo_t { bootloader_etc_t boot_t etc_t }:file { getattr read };
allow xdm_lilo_t boot_t:file write;
allow xdm_lilo_t device_t:dir { getattr search };
allow xdm_lilo_t fixed_disk_device_t:blk_file { getattr read write ioctl };
allow xdm_lilo_t xdm_t:unix_stream_socket { getattr read write };
allow xdm_lilo_t fs_t:filesystem getattr;
allow xdm_lilo_t memory_device_t:chr_file read;
allow xdm_lilo_t self:capability sys_rawio;

Thomas

--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDTVTED9qpeVMU938RAmvQAKCfEDt7QMtjPQz1e+hbNfwf1xQIfACgj1Zi
SuxNK6iH8opSQIYaUbPHCTg=
=/TnY
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
