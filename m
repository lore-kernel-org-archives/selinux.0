Date: Tue, 31 Aug 2004 07:02:52 +0200
From: Nigel Kukard <nkukard@lbsd.net>
To: linux-hotplug-devel@lists.sourceforge.net, SELinux <SELinux@tycho.nsa.gov>,
   "Fedora SELinux support list for users & developers." <fedora-selinux-list@redhat.com>,
   harald@redhat.com, Bill Nottingham <notting@redhat.com>
Subject: Re: [idea] udev + selinux
Message-ID: <20040831050252.GF10151@lbsd.net>
References: <20040830173744.GD10151@lbsd.net> <20040830203140.GB31497@lkcl.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5gxpn/Q6ypwruk0T"
In-Reply-To: <20040830203140.GB31497@lkcl.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--5gxpn/Q6ypwruk0T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

>  you mean on /dev, i presume?

yep, or /udev (configured in the udev config file)

>=20
>  well i had to patch selinux/hooks.c to allow this [on a tmpfs]
>  by relaxing the criteria of the "fscontext=3D" option for mount.
>=20

if its tmpfs, this would void the requirement of passing a mount option
fscontext, udev would set the correct context when started up (a check
could also be added to do this only if the mount point is /dev and its
tmpfs... *shrug*)

>  otherwise it's not _possible_ t set the context on /dev as it is
>  mounted [on a tmpfs].
>=20
>  [if /dev was a persistent filesystem everything would be hunky-dory
>   and this wouldn't be an issue].
>

*nod*

>=20
>  with that in mind, it's more that because you're putting device
>  inodes into a non-persistent filesystem, you end up getting the
>  "default" rules and so you must "restore" the contexts, or
>  you must patch udev to "understand" the contents of
>  /etc/selinux/src/file_contexts/file_contexts (using matchpathcon()
>  and setfscreatecon() from libselinux) such that it will create
>  inodes with the right file context.
>

I applied the patch to tmpfs to make it store xattr attributes which i
found on the mailing list, seems your patch forgets xattr.h?

I also applied the patch which adds  "matchpathcon()" &=20
"setfscreatecon()" support, and modified udev to set the correct=20
context of its root_path on startup.
=20
>  ... but that's not how udev works: it deletes and creates inodes
>  on demand; nothing exists at boot-time, it's all created on-demand.

at boot time i have about 5 devices in /dev with correct contexts set,
udev them mounts tmpfs over this, WorksForMe(tm)

so in actual fact we do need matchpathcon() & setfscreatecon(), if its a
persistent or non-persistent filesystem

>=20
>  so, not only must udev be patched to restore contexts but also
>  the policies and various hacks added to "cope" with /dev being
>  incredibly basic at startup - prior to udev running.

i have a simple persistent /dev which is used before udev runs, udev is
then initialized, mounts a tmpfs over /dev (and restores its context) just=
=20
after sysctl -p is run in my initscripts so its basically one of the=20
first things to run. Seeing as my initial /dev is on a persistent=20
filesystem i don't have a problem with pre-udev stuff running.

>=20
>  _including_ dealing with getting the contexts correct on entries
>  in /.dev [the old /dev remounted with mount --rbind]
>=20
>  l.
>=20
>=20

--=20
Nigel Kukard, PhD CompSc
(Chief Executive Officer)
Linux Based Systems Design (Non-Profit)
Web: www.lbsd.net          Email: nkukard@lbsd.net
Tel: (+27) 023 349 8000     Cell: (+27) 082 333 3723
Fax: (+27) 023 349 1395  Support: 086 747 7600
Address: LIGT House, 2 Klipdrift Rd, Rawsonville
Linux Systems Design & Technology Solutions


   The best language to use is the language that was designed for
                  what you want to use it for.


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Disclaimer
----------
The contents of this message and any attachments are intended=20
solely for the addressee's use and may be legally privileged and/or=20
confidential information. This message may not be retained,=20
distributed, copied or used if you are not he addressee of this=20
message. If this message was sent to you in error, please notify=20
the sender immediately by reply e-mail and then destroy the message=20
and any copies thereof.

Opinions, conclusions and other information in this message may be=20
personal to the sender and is not that of Linux Based Systems Design,
LinuxRulz or any of it's subsideries, associated companies or=20
principals and is therefore not endorsed by Linux Based Systems=20
Design or LinuxRulz. Due to e-maill communication being insecure,=20
Linux Based Systems Design and LinuxRulz do not guarantee=20
confidentiality, security, accuracy or performance of the e-mail.=20
Any liability for viruses is excluded to the fullest extent.

--5gxpn/Q6ypwruk0T
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBNAZ8KoUGSidwLE4RAs1SAKCcS4gqpf2ei6ADVWM3tO5oQM6qdwCgpkak
XGBh7GH4A77Jd/w3ycaSTns=
=O6sw
-----END PGP SIGNATURE-----

--5gxpn/Q6ypwruk0T--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
