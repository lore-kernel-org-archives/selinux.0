Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i3INcGRb025903
	for <selinux@tycho.nsa.gov>; Sun, 18 Apr 2004 19:38:16 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i3INcBmw015319
	for <selinux@tycho.nsa.gov>; Sun, 18 Apr 2004 23:38:11 GMT
Received: from alfa.intrak.tuke.sk ([147.232.151.3])
        by jazzband.ncsc.mil  with ESMTP id i3INcA4w015316 for <selinux@tycho.nsa.gov>; Sun, 18 Apr 2004 23:38:10 GMT
Received: from localhost (localhost [127.0.0.1])
	by alfa.intrak.tuke.sk (Postfix) with ESMTP id 778F0F167
	for <selinux@tycho.nsa.gov>; Mon, 19 Apr 2004 01:38:08 +0200 (CEST)
Received: from alfa.intrak.tuke.sk ([127.0.0.1])
	by localhost (alfa [127.0.0.1]) (amavisd-new, port 10024) with SMTP
	id 30712-06 for <selinux@tycho.nsa.gov>;
	Mon, 19 Apr 2004 01:38:08 +0200 (CEST)
Received: from mizu (mizu.intrak.tuke.sk [147.232.156.11])
	by alfa.intrak.tuke.sk (Postfix) with ESMTP id 20CBAEF19
	for <selinux@tycho.nsa.gov>; Mon, 19 Apr 2004 01:38:06 +0200 (CEST)
Date: Mon, 19 Apr 2004 01:37:35 +0200
From: mizu <michal@zimen.sk>
To: selinux@tycho.nsa.gov
Subject: sshd, devpts, unix_chkpwd
Message-ID: <20040418233735.GA22543@intrak.sk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi

  I try to make debian to work with last SELinux packages (1.10)
  with patch for 2.6.5 kernel.

   =20
  I still have too much messages like this:
 =20
  Apr 19 01:20:36 fuxo kernel: avc:  denied  { read write } for  pid=3D312
  exe=3D/sbin/unix_chkpwd path=3D/dev/pts/0 dev=3D ino=3D2
  scontext=3Droot:staff_r:system_chkpwd_t
  tcontext=3Dsystem_u:object_r:sshd_devpts_t tclass=3Dchr_file
 =20

  It is from sshd daemon....

  #cat  /etc/pam.d/ssh

  auth       required     pam_nologin.so
  auth       required     pam_env.so # [1]
  @include common-auth
  @include common-account
  @include common-session
  session    optional     pam_motd.so # [1]
  session    optional     pam_mail.so standard noenv # [1]
  session    required     pam_limits.so
  @include common-password
  session required        pam_selinux.so


=20
 [ssh version: 3.8p1-3 (debian sid)]
 =20
  How can i setUp correct access of unix_chkpwd to devpts ?

=20
  Is it possible, that my debian hangs after too much noise of syslogd
  messages ? (my last message is ....* --MARK-- )

  How can i get know the true reason of hang my machine?

 =20
  Thank's a lot

  				mizu
 =20
--=20
              mizu
=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D
[-> E-mail:michal_AT_zimen_DOT_sk   =20
[-> ICQ:97165392
[-> WWW: http://michal.zimen.sk
=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D

--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAgxE/9kFXwDL4DRkRAoMiAJ9HeUln3eDyQAWW7qHsHCs2IoH0CwCfY8Nu
1DRh0FaTaQoPNkZskYko/Kg=
=wgbY
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
