Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l119w2eA023509
	for <selinux@tycho.nsa.gov>; Thu, 1 Feb 2007 04:58:02 -0500
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l119x1sV011929
	for <selinux@tycho.nsa.gov>; Thu, 1 Feb 2007 09:59:03 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 5718F620E1
	for <selinux@tycho.nsa.gov>; Thu,  1 Feb 2007 20:58:35 +1100 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp.sws.net.au [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z+GoY1n8GJxu for <selinux@tycho.nsa.gov>;
	Thu,  1 Feb 2007 20:58:35 +1100 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 0B47C620DE
	for <selinux@tycho.nsa.gov>; Thu,  1 Feb 2007 20:58:35 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id B1CD320B05
	for <selinux@tycho.nsa.gov>; Thu,  1 Feb 2007 21:00:38 +1100 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: Fwd: Bug#409173: ITP: incron -- cron like daemon which handles filesystem events
Date: Thu, 1 Feb 2007 09:19:01 +1100
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200702010919.02668.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This program (which Emmanuel Intends to Package for Debian) has an interesting 
concept.  It should be able to do everything that the restorecond does and a 
lot more.

I haven't looked at the source.  If the code sucks then maybe writing a new 
program to implement the same concept would be a better solution to the 
restorecond problem.

----------  Forwarded Message  ----------

Subject: Bug#409173: ITP: incron -- cron like daemon which handles filesystem 
events
Date: Wednesday 31 January 2007 23:13
From: Emmanuel Bouthenot <kolter@openics.org>
To: Debian Bug Tracking System <submit@bugs.debian.org>

Package: wnpp
Severity: wishlist
Owner: Emmanuel Bouthenot <kolter@openics.org>

* Package name    : incron
  Version         : O.5.1
  Upstream Author : Lukas Jelinek <lukas@aiken.cz>
* URL             : http://inotify.aiken.cz/
* License         : tri-licenced : GPLv2, LGPLv2.1, X11 like
  Programming Lang: C++
  Description     : cron like daemon which handles filesystem events

 incron is an "inotify cron" system. It works like the regular
 cron but is driven by filesystem events instead of time periods.
 It contains two programs, a daemon called "incrond" (analogous
 to crond) and a table manipulator "incrontab" (like "crontab").
 .
 incron use Linux Kernel inotify syscalls.
 .
 like cron, each user can edit its own incron tables.
 .
 incron can be use to :
  - notifying programs (e.g. server daemons) about changes in configuration
  - guarding changes in critical files (with their eventual recovery)
  - file usage monitoring, statistics
  - automatic on-crash cleanup
  - automatic on-change backup or versioning
  - new mail notification (for maildir)
  - server upload notification
  - installation management (outside packaging systems)
  - ..and many others
 .
 HomePage: http://inotify.aiken.cz/

-- System Information:
Debian Release: 4.0
  APT prefers unstable
  APT policy: (500, 'unstable')
Architecture: i386 (i686)
Shell:  /bin/sh linked to /bin/bash
Kernel: Linux 2.6.18-4-k7
Locale: LANG=fr_FR.UTF-8, LC_CTYPE=fr_FR.UTF-8 (charmap=UTF-8)


--
To UNSUBSCRIBE, email to debian-devel-REQUEST@lists.debian.org
with a subject of "unsubscribe". Trouble? Contact listmaster@lists.debian.org

-------------------------------------------------------

-- 
russell@coker.com.au
http://etbe.blogspot.com/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
