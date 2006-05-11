Message-Id: <200605110204.k4B24I8b005539@turing-police.cc.vt.edu>
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Cc: James Morris <jmorris@namei.org>, Stephen Smalley <sds@tycho.nsa.gov>,
        selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: [RFC][SECMARK 05/08] Add new packet controls to SELinux
In-Reply-To: Your message of "Thu, 11 May 2006 00:11:47 +0200."
             <20060510221146.GG8937@thorium.jmh.mhn.de>
From: Valdis.Kletnieks@vt.edu
References: <Pine.LNX.4.64.0605071104590.8588@d.namei> <Pine.LNX.4.64.0605071136100.8588@d.namei> <1147106449.23640.102.camel@moss-spartans.epoch.ncsc.mil> <Pine.LNX.4.64.0605081947400.19850@d.namei> <1147174138.32651.5.camel@moss-spartans.epoch.ncsc.mil> <Pine.LNX.4.64.0605091146350.25693@d.namei>
            <20060510221146.GG8937@thorium.jmh.mhn.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1147313058_3441P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Wed, 10 May 2006 22:04:18 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_1147313058_3441P
Content-Type: text/plain; charset=us-ascii

On Thu, 11 May 2006 00:11:47 +0200, Thomas Bleher said:
> (Possibly crazy idea: Would it be possible to change the module format
> so that the kernel recognizes permissions which are not defined in the
> loaded policy at all and automatically allows them? This would allow us
> to define new permissions (e.g. for decomposing CAP_SYS_ADMIN) without
> needing comlex compatibility code or breaking systems.)

Bad idea.

Allowing that to happen automatically means that you can't tell if you've
accidentally loaded a broken module, or one for another security model (as
a counter-example, trying to load a SELinux policy module for 'strict' into
a 'targeted' system, or vice versa, will probably die a quick death).

That, and it will be loads of fun trying to encode the *semantics* of
the permission when it's not in the original source. In the case of
CAP_SYS_ADMIN, if you are decomposing it into 3, or 4, or 5, or many
new permissions, how do you express which ADMIN checks belong in which
new permission?  The obvious answer is to pre-define a bitmap of what
ADMIN controls, and the new thing includes a bitmap of which bits are
included in its purview.

Of course, that requires pre-decomposing CAP_SYS_ADMIN.. And it gets
even messier if you want to take SYS_ADMIN and NET, merge them, and split
them into 4 new categories....

"Glork." -- an unknown programmer

--==_Exmh_1147313058_3441P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEYpuicC3lWbTT17ARAknfAKCYq2Drq1s6YI9umql7NR7eEesa9gCgzqJA
uWHHlC1JHKwVeiIU+SDvy5o=
=WTNj
-----END PGP SIGNATURE-----

--==_Exmh_1147313058_3441P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
