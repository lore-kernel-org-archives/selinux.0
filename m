Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h4IF7BI4000250
	for <selinux@tycho.nsa.gov>; Sun, 18 May 2003 11:07:11 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h4IF6nQj025663
	for <selinux@tycho.nsa.gov>; Sun, 18 May 2003 15:06:49 GMT
Received: from datas-world.dyndns.org (dsl-213-023-212-162.arcor-ip.net [213.23.212.162])
	by jazzswing.ncsc.mil  with ESMTP id h4IF6mxS025660
	for <selinux@tycho.nsa.gov>; Sun, 18 May 2003 15:06:48 GMT
From: Torsten Knodt <tk-selinux@datas-world.de>
Subject: Thinking about an extension to the cron patch
Date: Sun, 18 May 2003 17:07:00 +0200
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200305181707.00953.tk-selinux@datas-world.de>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,
I'm currently trying to get the SE Linux patches from Russell's homepage into 
upstream via the Debian BTS.

I already had a mail conversation with the cron maintainer about some changes 
to the patch. The patch is now a little smaller, because we don't need the 
*system* hack any more.
But we are also thinking about another change. In the system
crontab's, there are the users. We could split them with a delimiter like :
and allow to set the SE Linux user for this line. As long this isn't used,
the jobs run under system_u. With this change, we could clean up the crond
policy. I don't feel very good allowing all system cronjobs all this. Also it 
would allow to get these policy parts back into the package policies owning 
these jobs.

Regards
	Torsten

- -- 
Domain in provider transition, hope for smoothness. Planed date is 24.7.2003
pub 1024D/4CD29A2C 2001-01-12 Torsten Knodt <torstenknodt@datas-world.de>
 Schl.-Fingerabdruck = A2B1 C626 F819 7C58 B2F9 4F4C BF16 64B6 4CD2 9A2C
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+x6GUvxZktkzSmiwRAj+sAJ9ZD3hMvH0EjPKbejunBJQ7vu0D3gCfavQt
7rLt7ddM3iMFQIxMa8co8iI=
=ZDLL
-----END PGP SIGNATURE-----



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
