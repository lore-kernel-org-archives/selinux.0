Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lBQLZFtv021248
	for <selinux@tycho.nsa.gov>; Wed, 26 Dec 2007 16:35:15 -0500
Received: from penguin.goodinassociates.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id lBQLZBai006003
	for <selinux@tycho.nsa.gov>; Wed, 26 Dec 2007 21:35:12 GMT
Received: from [206.80.71.242] ([206.80.71.242])
	(authenticated bits=0)
	by penguin.goodinassociates.com (8.13.1/8.13.1) with ESMTP id lBQLZAZR025067
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO)
	for <selinux@tycho.nsa.gov>; Wed, 26 Dec 2007 15:35:11 -0600
Subject: cant SSH/Console Login and no deny/error messages
From: Jeremiah Jahn <jeremiah@goodinassociates.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-j5mIb/qdMeT32YLzVhSH"
Date: Wed, 26 Dec 2007 15:35:09 -0600
Message-Id: <1198704909.4073.858.camel@bluejay.goodinassociates.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-j5mIb/qdMeT32YLzVhSH
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I've trying to get SELinux strict up and running on a RHEL4-U4 box and
not having much luck. I have one account and 3 programs that I need to
protect from root. I was unable to get targeted to login under the user
that I created, something about the policy always defaulting to user_u.
So Fine, I tried to install the strict/ref policy from the tresys and
cips. Dues to this being an x86_64 system, that didn't go well either.
Trying plan C  I went with the FC3 strict policy. Obviously some
improvemtns have been made since then, but this was the first strict
policy I was able to install without completely hosing my system. sshd
and login seem to really like having libselinux(64) around.=20


So my question here has to possible answers:

1) where the heck can I find some rpms for RHEl4 -x86_64 and the most
recent ref policy.

--OR--

2) what could possibly be causing no [avc denied] messages to be logged.
Most of the messages I have used with audit2allow to to try and get
everything to work. Finally I go to the point of having no more messages
even when rebooting the machine. If I put things into passive mode
still no more messages, this is with constant reloading of the policy to
clear the avc cache.=20

help please.



=09




"A fractal is by definition a set for which the Hausdorff Besicovitch
dimension strictly exceeds the topological dimension." -- Mandelbrot,
"The Fractal Geometry of Nature"

--=-j5mIb/qdMeT32YLzVhSH
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBHcskN6caZY8jbHDkRAtcCAKCglwiyEVr6DOBm+AUukNsaaGWU5gCdF3ZC
qHrHCV6xfjayaTpbvBFNHks=
=dDlg
-----END PGP SIGNATURE-----

--=-j5mIb/qdMeT32YLzVhSH--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
