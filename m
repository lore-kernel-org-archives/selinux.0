Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA06711
	for <selinux@tycho.nsa.gov>; Tue, 3 Dec 2002 09:54:06 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA14881
	for <selinux@tycho.nsa.gov>; Tue, 3 Dec 2002 14:51:50 GMT
Received: from sendmail (savages.net [12.154.202.18])
	by jazzswing.ncsc.mil  with ESMTP id OAA14876
	for <selinux@tycho.nsa.gov>; Tue, 3 Dec 2002 14:51:48 GMT
Message-ID: <3DECC486.7080201@pcez.com>
Date: Tue, 03 Dec 2002 06:49:42 -0800
From: Shaun Savage <savages@pcez.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: sailorn@attglobal.net
Subject: Re: RH 8.1
References: <200212021621.LAA25269@moss-shockers.ncsc.mil>
In-Reply-To: <200212021621.LAA25269@moss-shockers.ncsc.mil>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Stephen D. Smalley wrote:
|
|>Until I get a Debian distro I plan to try to install SELinux on RH
8.1.  A
|
| basic question I have, is SELinux distro version specific?
|
|>In the LSM README files, the instructions do say RH 7.1 or RH 7.2.  Can I
|
| install SELinux on RH 8.1?
|
| Do you mean RH8.0?  The SELinux release does appear to install ok on
RH8.0,
| but the policy configuration will need some updating for it.  Also, the
| patched utilities and daemons are based on older versions (from RH7.x), so
| you will ultimately want to port the patches forward to the RH8.0 base
| sources, although you may be able to use the older versions in the short
| term.
|
|
I have port most of the utils to RH 8.0. I have created rpms for both
source and binary.  I still have problems with fileutils and strace patches.


I do need a site that I can upload these to for distribution.  My DSL
would be way too slow.

Shaun

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE97MSDn6I06Opz+XURAi9lAJ9/B8z7EWQGfUvCwls0KPgN32/lWwCdHFLW
e881Vc7c1TEibBgfYe4qlMU=
=vhCL
-----END PGP SIGNATURE-----


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
