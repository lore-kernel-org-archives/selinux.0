Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6M17iHa017727
	for <selinux@tycho.nsa.gov>; Mon, 21 Jul 2003 21:07:44 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h6M16dFB002370
	for <selinux@tycho.nsa.gov>; Tue, 22 Jul 2003 01:06:39 GMT
Received: from zaphod.crypt.gen.nz (203-79-74-204.adsl.paradise.net.nz [203.79.74.204])
	by jazzswing.ncsc.mil  with ESMTP id h6M16cGD002367
	for <selinux@tycho.nsa.gov>; Tue, 22 Jul 2003 01:06:38 GMT
Message-ID: <2332.202.27.185.71.1058836061.squirrel@www.crypt.gen.nz>
Date: Tue, 22 Jul 2003 13:07:41 +1200 (NZST)
Subject: Re: make quickinstall redhat9 problem
From: "Kerry Thompson" <kerry@crypt.gen.nz>
To: <selinux@tycho.nsa.gov>
In-Reply-To: <000001c34fe6$c761e5a0$6601a8c0@inspiron>
References: <000001c34fe6$c761e5a0$6601a8c0@inspiron>
Cc: <sreese@prcdigital.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Reese said:
> make[1]: Entering directory `/home/installs/selinux/tools'
> make[2]: Entering directory `/home/installs/selinux/tools/setools' cd
> apol; make install
> make[3]: Entering directory `/home/installs/selinux/tools/setools/apol'
> gcc  -Wall -g -I/usr/include -DUSE_SORTING  -c apol_gui.c
> apol_gui.c:14:17: tcl.h: No such file or directory
> apol_gui.c:15:16: tk.h: No such file or directory
[snip]

SETools requires the TCL and TK libraries to be installed. You can either
install TCL & TK packages or just build without these tools. SELinux will
install just fine without the tools, just comment out the line which
builds and installs the tools from the top-level Makefile:

  # @echo "Building and installing SELinux tools"
  # cd tools && make install


Kerry

-- 
Kerry Thompson, CCNA CISSP
Information Systems Security Consultant
http://www.crypt.gen.nz  kerry@crypt.gen.nz



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
