Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h4IGuTI4000498
	for <selinux@tycho.nsa.gov>; Sun, 18 May 2003 12:56:29 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h4IGu7Qj028438
	for <selinux@tycho.nsa.gov>; Sun, 18 May 2003 16:56:07 GMT
Received: from datas-world.dyndns.org (dsl-213-023-212-162.arcor-ip.net [213.23.212.162])
	by jazzswing.ncsc.mil  with ESMTP id h4IGu6xS028435
	for <selinux@tycho.nsa.gov>; Sun, 18 May 2003 16:56:07 GMT
From: Torsten Knodt <tk-selinux@datas-world.de>
To: selinux@tycho.nsa.gov
Subject: Creating a new lsm function
Date: Sun, 18 May 2003 18:50:49 +0200
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <200305181856.22022.tk-selinux@datas-world.de>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I'd like to create two new function's, which fill a buffer with lsm 
informations about an interface/ a socket. Both will simply give back the 
context. Also, for this two, a function will return a title for these fields.
These function will be used to print out these informations in /proc/net/tcp, 
... to be read by net-tools.

Can someone give me a hint, where this has to be implemented to be independent 
of the used security module?

Thanks
	Torsten

- -- 
Domain in provider transition, hope for smoothness. Planed date is 24.7.2003
pub 1024D/4CD29A2C 2001-01-12 Torsten Knodt <torstenknodt@datas-world.de>
 Schl.-Fingerabdruck = A2B1 C626 F819 7C58 B2F9 4F4C BF16 64B6 4CD2 9A2C
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+x7s0vxZktkzSmiwRAtCKAJ9a70iJksCaUjryHrT6QS7btVsOiACfaGrW
qt8k5tNdc7J70BIiZ63OSEg=
=ii8d
-----END PGP SIGNATURE-----



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
