Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA09805
	for <selinux@tycho.nsa.gov>; Fri, 18 Jan 2002 09:55:44 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA00697
	for <selinux@tycho.nsa.gov>; Fri, 18 Jan 2002 14:54:55 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id OAA00692 for <selinux@tycho.nsa.gov>; Fri, 18 Jan 2002 14:54:55 GMT
Received: from coalpipe.epoch.ncsc.mil (coalpipe [144.51.25.11])
	by epoch.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA28843
	for <selinux@tycho.nsa.gov>; Fri, 18 Jan 2002 09:55:10 -0500 (EST)
Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA09446
	for <selinux@tycho.nsa.gov>; Fri, 18 Jan 2002 08:39:19 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id NAA28764
	for <selinux@tycho.nsa.gov>; Fri, 18 Jan 2002 13:38:41 GMT
Received: from csoc-fire1.csoconline.com (csoc-mail-imc.csoconline.com [140.169.2.142])
	by jazzswing.ncsc.mil  with SMTP id NAA28760
	for <selinux@tycho.nsa.gov>; Fri, 18 Jan 2002 13:38:40 GMT
Message-ID: <72222DC86846D411ABD300A0C9EB08A1015242A0@csoc-mail-box.csoconline.com>
From: "Westerman, Mark" <Mark.Westerman@csoconline.com>
To: "'Paul Krumviede'" <pwk@acm.org>, selinux <selinux@tycho.nsa.gov>
Subject: RE: 2.4.16 release, ipsec, roles and ECHILD errors
Date: Fri, 18 Jan 2002 07:39:17 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The 1.94 version  has bugs that make non-usable
From: freeswan web page
"While freeswan-1.94 has shipped, there are serious known bugs 
in it that make it unsuitable for use. You have two choices, 
use the latest snapshot (snap2001dec25b seems ok) where the 
show stopper bugs seem fixed or use an older 'stable' release 
like 1.91 or maybe 1.92 from this "

Try a different version and see if you have the same problem


Mark

-----Original Message-----
From: Paul Krumviede [mailto:pwk@acm.org]
Sent: Thursday, January 17, 2002 2:58 PM
To: selinux
Subject: 2.4.16 release, ipsec, roles and ECHILD errors


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
You have received this message because you are subscribed to the selinux
list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with
the words "unsubscribe selinux" without quotes as the message.


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
