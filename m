Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9SM9AXZ003708
	for <selinux@tycho.nsa.gov>; Thu, 28 Oct 2004 18:09:10 -0400 (EDT)
Received: from wgimx02.wgint.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9SM7oba002127
	for <selinux@tycho.nsa.gov>; Thu, 28 Oct 2004 22:07:51 GMT
From: "Richard Simpson" <richard.simpson@wgint.com>
To: "Thomas Bleher" <bleher@informatik.uni-muenchen.de>
Cc: "Selinux@Tycho. Nsa. Gov" <selinux@tycho.nsa.gov>
Subject: RE: wrong context for ntpd.pid
Date: Thu, 28 Oct 2004 16:11:45 -0600
Message-ID: <BJENLMGHDPAAAGKKPOFOAEHDCFAA.richard.simpson@wgint.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-15"
In-Reply-To: <20041028165529.GE27776@rom.cip.ifi.lmu.de>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: Thomas Bleher [mailto:bleher@informatik.uni-muenchen.de]
...
> Add the following line to /etc/init.d/ntpd directly after the chown:
>         [ -e /sbin/restorecon ] && /sbin/restorecon /var/run/ntpd.pid
>
> This should be all that is needed.
>

I filed a bug report on this problem:
http://bugs.gentoo.org/show_bug.cgi?id=69288
They chose to fix it by revising the init script to not create the pid file
in the first place. If the daemon creates the file it should be in the
correct context. I will test it tonight.

Thanks for the help,
Richard.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
