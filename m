Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id VAA12369
	for <selinux@tycho.nsa.gov>; Fri, 23 Nov 2001 21:27:45 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id CAA12479
	for <selinux@tycho.nsa.gov>; Sat, 24 Nov 2001 02:27:24 GMT
Received: from smacky.thistledown.org ([207.121.1.137])
	by jazzswing.ncsc.mil  with ESMTP id CAA12475
	for <selinux@tycho.nsa.gov>; Sat, 24 Nov 2001 02:27:23 GMT
Received: from localhost (olmy@localhost)
	by smacky.thistledown.org (8.11.2/8.11.2) with ESMTP id fAO2UD927164
	for <selinux@tycho.nsa.gov>; Fri, 23 Nov 2001 21:30:13 -0500
Date: Fri, 23 Nov 2001 21:30:13 -0500 (EST)
From: jeff burson <olmy@thistledown.org>
To: <selinux@tycho.nsa.gov>
Subject: selinux, openssh, ipv6
In-Reply-To: <3BFCD537.8080100@namesys.com>
Message-ID: <Pine.LNX.4.33.0111232052040.26754-100000@smacky.thistledown.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


Hello,

I've recently installed selinux on my rh7.1 system using the
full lsm-selinux-200110161355 tarball (opt.1). I'm playing
around with it, learning the system, exploring, etc.

First, my congratulations and gratitude to those who have
put this together: a VERY impressive system (and one of the
best documented installs of an open-source OS security system
I've run across).

A problem I've run into is regarding IPv6. At lsm kernel compile
time, I compiled for IPv6 support and having it successfully
running. The interface is listening on an assigned IPv6
address and is pingable from another IPv6 device. However,
the selinux install of OpenSSH does not appear to be listening
on the IPv6 address (it is listening on the IPv4 address).

I have not run into this problem with manual builds (or rpms)
of regular openssh recently, so am trying to figure out what's
wrong.

here's the relevant output from configure:

struct sockaddr_in6... (cached) yes
checking for struct in6_addr... (cached) yes
checking for ut_addr_v6 field in utmp.h... (cached) yes
checking for ut_addr_v6 field in utmpx.h... (cached) yes
checking if we need to convert IPv4 in IPv6-mapped addresses... yes
(default)
      Use IPv4 by default hack: no
       Translate v4 in v6 hack: yes


Any ideas or suggestions?

jeff





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
