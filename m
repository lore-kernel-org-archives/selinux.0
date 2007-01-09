Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l09EE5b3005099
	for <selinux@tycho.nsa.gov>; Tue, 9 Jan 2007 09:14:05 -0500
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l09EEseY005321
	for <selinux@tycho.nsa.gov>; Tue, 9 Jan 2007 14:14:54 GMT
Subject: Re: Error!  Shell is not valid.
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: selinux770@tortenboxer.de
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20070109123122.248320@gmx.net>
References: <20070109123122.248320@gmx.net>
Content-Type: text/plain
Date: Tue, 09 Jan 2007 09:15:00 -0500
Message-Id: <1168352100.31617.3.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-01-09 at 13:31 +0100, selinux770@tortenboxer.de wrote:
> I'm still trying to enable SELinux no my Linux system. Seems to work in some way, but a strange error remains.
> 
> When I want to login via ssh to the system, "newrole" does not work.
[cut]
> lrwxrwxrwx	root	root	system_u:object_r:bin_t		/bin/bash
> linked to
> selinux:~$ ls -Z /usr/bin/bash
> -rwxr-xr-x	root	root	system_u:object_r:bin_t		/usr/bin/bash

Shells need to be shell_exec_t.

chcon -t shell_exec_t /usr/bin/bash

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
