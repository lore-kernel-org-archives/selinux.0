Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i57NiRrT008513
	for <selinux@tycho.nsa.gov>; Mon, 7 Jun 2004 19:44:27 -0400 (EDT)
Received: from mailrelay2.lrz-muenchen.de (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i57NiL22025482
	for <selinux@tycho.nsa.gov>; Mon, 7 Jun 2004 19:44:22 -0400 (EDT)
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Tue, 8 Jun 2004 01:44:24 +0200
Date: Tue, 8 Jun 2004 01:44:13 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: SELinux ML <selinux@tycho.nsa.gov>
Subject: How to handle tmpfiles under /home ?
Message-Id: <20040607234412.GB2073@jmh.mhn.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/WwmFnJnmDyWGHa4"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--/WwmFnJnmDyWGHa4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I recently ran into a problem with tmpfiles in my homedir. I have
configured mutt to store mails I write under ~/.mutt/tmp/.
Unfortunately, current policy only allows postfix to read user_tmp_t.
This leads to postfix sending totally empty mails in enforcing mode.

Now the question is how to best handle this situation? (I believe this
is more common than just mail as it is generally encouraged to change $TMP
to something not world writable)
First I thought about adding the permissions to all programs accessing
user tmpfiles, but this would practically remove the distinction between
user_home_t and user_tmp_t.

My next thought was to label say ~/.tmp/ as user_tmp_t and point $TMP
there. Unfortunately there is no standard directory across distros for
this.
Ideally this should be configurable by the user, but I'm not sure if
it's worth the trouble.

As I am not sure what the best thing to do is both practically and from
a security POV I am posting this here.

Thoughts?

Thomas

--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--/WwmFnJnmDyWGHa4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAxP3MxWIrrrL0q+cRAopCAKCW4p4/HBOFMP7tJ3kTLyx+MlLMvQCgp62f
WUdlzrQq9RKE/W69nIoxoZc=
=NA2t
-----END PGP SIGNATURE-----

--/WwmFnJnmDyWGHa4--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
