Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA29640
	for <selinux@tycho.nsa.gov>; Thu, 12 Sep 2002 13:09:25 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id RAA00132
	for <selinux@tycho.nsa.gov>; Thu, 12 Sep 2002 17:07:39 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id RAA00127 for <selinux@tycho.nsa.gov>; Thu, 12 Sep 2002 17:07:39 GMT
Received: from coalpipe.epoch.ncsc.mil (coalpipe [144.51.25.11])
	by epoch.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA12686
	for <selinux@tycho.nsa.gov>; Thu, 12 Sep 2002 13:09:21 -0400 (EDT)
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
Subject: new login Debian package
Date: Wed, 11 Sep 2002 12:58:39 +0200
To: SELinux <SELinux@tycho.nsa.gov>
MIME-Version: 1.0
Message-Id: <200209111258.45033.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Last week I recommended that everyone who is using my Debian packages upgrade 
their login package to the latest version, that is 
login_20000902-12.se2_i386.deb for unstable/sarge or 
login_20000902-12.se2.woody0_i386.deb for woody.

The previous version had a serious bug where it used the username variable for 
determining the SE Linux credentials instead of the pam_user variable.

username is only set the first time you enter a user name, while pam_user is 
set every time.

To exploit this you could enter the name of an account that's authorised for 
sysadm_r with a bad password.  Then on the second login attempt you could 
enter an un-priviledged account name and the correct password and login to 
the sysadm_r with the un-priv account.

This was discovered in my tutorial (the students didn't discover the extent of 
the bug - they discovered that sometimes they would get user_u:user_r:user_t 
instead of the context they expected and I determined the extent of the bug 
later).

This only affects code I released, not any code that is on the NSA web site.

In my initial advisory I got the URL for the woody files wrong.  As no-one 
asked I presume that everyone who is using my packages for woody knew where 
to get it.

For woody:
deb http://www.coker.com.au/woody/ ./

For Sarge/unstable:
deb http://www.coker.com.au/selinux/ ./

For the source:
http://www.coker.com.au/selinux/login/


Russell Coker
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9fyHiwrB5/PXHUlYRAuMAAKDZSXiQIot2qCx1q2zMJ5IDM+sNOwCdGJgS
BkUm9XOHePXLMlaCudJg4T8=
=fAcr
-----END PGP SIGNATURE-----


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
