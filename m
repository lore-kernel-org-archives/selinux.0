Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8BKxkrT025918
	for <selinux@tycho.nsa.gov>; Sat, 11 Sep 2004 16:59:47 -0400 (EDT)
Received: from mailrelay2.lrz-muenchen.de (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8BKxj6V009260
	for <selinux@tycho.nsa.gov>; Sat, 11 Sep 2004 20:59:46 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Sat, 11 Sep 2004 22:59:45 +0200
Date: Sat, 11 Sep 2004 23:00:20 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: selinux@tycho.nsa.gov
Subject: Re: PAM in suse9.1 (Re: SuSE 9.1 SELinux)
Message-Id: <20040911210019.GB2557@jmh.mhn.de>
References: <200409071747.i87HkxJ6012464@mms-r00.iijmio.jp> <OF0DD26E97.7776F6AA-ON49256F08.007DAD0E-49256F09.0007B661@jp.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="m51xatjYGsM+13rf"
In-Reply-To: <OF0DD26E97.7776F6AA-ON49256F08.007DAD0E-49256F09.0007B661@jp.ibm.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--m51xatjYGsM+13rf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Takuya Mishina <TMISHINA@jp.ibm.com> [2004-09-08 05:22]:
> I don't know the difference of pam_unix.so and pam_unix2.so, but in my=20
> test, it seems no problem using pam_unix.so instead of pam_unix2.so.
> ( cat /etc/pam.d/newrole | sed 's/pam_unix/pam_unix2/' >=20
> /etc/pam.d/newrole.new )
>=20
> the best may be the combination use of pam_unix2.so and unix_chkpwd, but=
=20
> to be enable SELinux with SuSE 9.1, the easiest way is to setuid=20
> /usr/bin/newrole or to patch pam_unix.so and use it.

I have patched pam for suse 9.0 so only unix_chkpwd needs access to
/etc/shadow. newrole et al can live with permission 0755.
Looking at the pam package not much has changed between 9.0 and 9.1.
I don't have a suse 9.1 machine here so I can't test this right now, but
I have built the 9.1 package with my selinux patch (which was taken from
debian) and it compiles ok. You can find the source package and the
individual patch under
http://www.cip.ifi.lmu.de/~bleher/selinux/suse/srpm-9.1/
I would be interested to hear how it works.
One caveat: You have to use pam_unix_auth.so, pam_unix_session.so and so
on instead of pam_unix.so.

As for policy, you may want to look at my suse policy, available via
arch (tbleher@gmx.de--selinux/policy--suse--0). This policy is currently
only tested on 9.0 so you will probably have to tweak a few things, but
most of the needed stuff should be there.

HTH,
Thomas

--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--m51xatjYGsM+13rf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBQ2djxWIrrrL0q+cRAgIMAJ49bvzRjhIJrls4y24jBYkUBwChRgCgnEDj
kMicjbHsfr4tf78qsp0Nthk=
=gUG/
-----END PGP SIGNATURE-----

--m51xatjYGsM+13rf--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
