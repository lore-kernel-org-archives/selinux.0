Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i61JsUrT009909
	for <selinux@tycho.nsa.gov>; Thu, 1 Jul 2004 15:54:31 -0400 (EDT)
Received: from p15107633.pureserver.info (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i61JsSbv010628
	for <selinux@tycho.nsa.gov>; Thu, 1 Jul 2004 19:54:28 GMT
Date: Fri, 2 Jul 2004 13:48:50 +0200
From: Jan Gehring <pr0gm4@linoratix.com>
To: selinux@tycho.nsa.gov
Subject: Compiling error - sysvinit
Message-Id: <20040702134850.353b2f51.pr0gm4@linoratix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello ml,

i tried to compile sysvinit-2.85 but i get the following error.

root@maracuja src # make LDFLAGS="-s -lselinux" CFLAGS="-D_GNU_SOURCE"
cc -c -D_GNU_SOURCE -DWITH_SELINUX init.c
[...]
init.c:97: error: `SELINUXMNT' undeclared (first use in this function)
[...]
init.c:123: error: `SELINUXPOLICY' undeclared (first use in this function)
make: *** [init.o] Error 1


What am i doing wrong?

Thanks for any help

Jan


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
