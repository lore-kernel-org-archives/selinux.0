Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6M33LHa018143
	for <selinux@tycho.nsa.gov>; Mon, 21 Jul 2003 23:03:21 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h6M33KDW017646
	for <selinux@tycho.nsa.gov>; Tue, 22 Jul 2003 03:03:20 GMT
Received: from mgr1.xmission.com (mgr1.xmission.com [198.60.22.201])
        by jazzband.ncsc.mil  with ESMTP id h6M33JeN017643 for <selinux@tycho.nsa.gov>; Tue, 22 Jul 2003 03:03:20 GMT
Received: from mail by mgr1.xmission.com with spam-scanned (Exim 3.35 #1)
	id 19enQr-0007nj-01
	for selinux@tycho.nsa.gov; Mon, 21 Jul 2003 21:03:18 -0600
From: "Lamont R. Peterson" <lrp@xmission.com>
Reply-To: lrp@xmission.com
To: "Kerry Thompson" <kerry@crypt.gen.nz>, <selinux@tycho.nsa.gov>
Subject: Re: make quickinstall redhat9 problem
Date: Mon, 21 Jul 2003 21:03:03 -0600
Cc: <sreese@prcdigital.com>
References: <000001c34fe6$c761e5a0$6601a8c0@inspiron> <2332.202.27.185.71.1058836061.squirrel@www.crypt.gen.nz>
In-Reply-To: <2332.202.27.185.71.1058836061.squirrel@www.crypt.gen.nz>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200307212103.09775.lrp@xmission.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Monday 21 July 2003 07:07 pm, Kerry Thompson wrote:
> Stephen Reese said:
> > make[1]: Entering directory `/home/installs/selinux/tools'
> > make[2]: Entering directory `/home/installs/selinux/tools/setools' cd
> > apol; make install
> > make[3]: Entering directory `/home/installs/selinux/tools/setools/apol'
> > gcc  -Wall -g -I/usr/include -DUSE_SORTING  -c apol_gui.c
> > apol_gui.c:14:17: tcl.h: No such file or directory
> > apol_gui.c:15:16: tk.h: No such file or directory
>
> [snip]
>
> SETools requires the TCL and TK libraries to be installed. You can either
> install TCL & TK packages or just build without these tools. SELinux will

Oops, I decided to read the message from the bottom up, and stopped reading 
before I go to here.  Just shows how trying to debug in a hurry is not a good 
idea :-).

> install just fine without the tools, just comment out the line which
> builds and installs the tools from the top-level Makefile:
>
>   # @echo "Building and installing SELinux tools"
>   # cd tools && make install

Good advice.
- -- 
Sincerely,
Lamont R. Peterson <lrp@xmission.com>
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE/HKlsg5LkF3+ZgzARAnfUAJ0Yv6cwXBGAkk8VDzJf/YeFppr9JQCfY7Qa
JsKDAoYrm/H0vzqRKYdHXrI=
=xWYK
-----END PGP SIGNATURE-----



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
