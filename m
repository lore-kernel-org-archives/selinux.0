Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA06702
	for <selinux@tycho.nsa.gov>; Thu, 17 Jan 2002 15:59:03 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id UAA22344
	for <selinux@tycho.nsa.gov>; Thu, 17 Jan 2002 20:58:14 GMT
Received: from khaipur.xiat.org ([66.125.68.98])
        by jazzband.ncsc.mil  with ESMTP id UAA22340 for <selinux@tycho.nsa.gov>; Thu, 17 Jan 2002 20:58:13 GMT
Received: from [10.0.1.17] (goedel.xiat.org [10.0.1.17])
	(authenticated)
	by khaipur.xiat.org (8.11.6/8.11.6) with ESMTP id g0HKwTL13370
	for <selinux@tycho.nsa.gov>; Thu, 17 Jan 2002 12:58:29 -0800
Date: Thu, 17 Jan 2002 12:58:21 -0800
From: Paul Krumviede <pwk@acm.org>
To: selinux <selinux@tycho.nsa.gov>
Subject: 2.4.16 release, ipsec, roles and ECHILD errors
Message-ID: <408439755.1011272301@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

ever since the december 2001 release, i've been running into
problems getting frees/wan 1.94 working with the 2.4.16 kernel
when selinux is configured in the kernel. after much experimentation
i noticed something that seems quite strange.

background: attempts to get automatically keyed IPsec
connections to go into the "routed" or "up" states would
yield failures with pclose() with errno set to ECHILD. this
happens when pluto, the user-space key management
daemon, tries to run some of the associated scripts.

by happenstance, things started working a few days ago,
and then stopped working. what seemed to make the
difference was the role i used to login on the console.
if i login with the user_r role, run "newrole -r sysadm_r"
and su, then start (using run_init) the ipsec components
and attempt to bring an IPsec connection into a useful
state (e.g., "ipsec auto --route conn-name"), then things
fail as above.

but if i login with the sysadm_r role, su, and then start
up the ipsec components the same way, things work.
things work if i login as root, in either the user_r or
sysadm_r role.

i'm running in permissive mode, so that shouldn't
be a problem. if i compile the same kernel without
selinux, then there doesn't seem to be any problem
getting the IPsec connections up and running.

i took a quick look at some of the ssh code, which
also uses pclose(), but it seems to never check the
error status, while pluto does.

-paul


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
