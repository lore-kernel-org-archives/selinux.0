Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA16671
	for <selinux@tycho.nsa.gov>; Mon, 21 May 2001 09:34:06 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id NAA04516
	for <selinux@tycho.nsa.gov>; Mon, 21 May 2001 13:33:58 GMT
Received: from mail6.bigmailbox.com (mail6.bigmailbox.com [209.132.220.37])
	by jazzswing.ncsc.mil  with ESMTP id NAA04512
	for <selinux@tycho.nsa.gov>; Mon, 21 May 2001 13:33:57 GMT
Date: Mon, 21 May 2001 06:33:25 -0700
Message-Id: <200105211333.GAA01899@mail6.bigmailbox.com>
Content-Type: text/plain
Mime-Version: 1.0
From: "Jonathan Day" <jd9812@my-deja.com>
To: jan.petranek@student.uni-tuebingen.de, maksim@otstavnov.com
Cc: selinux@tycho.nsa.gov
Subject: RE: Re[2]: SELinux as a desktop / workstation?
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>JP> The reason I'm writing this is, that I'm a bit concerned about security
>JP> issues. Up to now, very little viruses have shaken the linux community,
>JP> but except for selinux and sandbox, there is no thing that prevents code
>JP> running in the user space from doing anything in the user space.
>
>RSBAC (www.rsbac.org; see also ftp.altlinux.ru for Beta-version of "ALT
>Linux Castle" distro).

There are a number of ways to prevent viruses in Linux.

1) Tripwire, et al, are "better" detection tools than a virus scanner, as they don't depend on signatures being present, and therefore detect new viruses as well as old ones.

2) Bastille Linux, OpenWall, LIDS, and other "Linux Hardening Programs" use Linux "capabilities" to disable userland services which aren't necessary.

3) POSIX ACL, Trustees, etc, add "access control lists" to Linux. IMHO, Trustees is a more interesting project, as it goes beyond just trivial ACL lists.

4) Mount your application partitions as "read-only". You don't NEED to have those read/write, except when installing software. Logs, spool-files, etc, all go into /var and the user area is all in /home. Put those two into seperate partitions, which -are- read/write, and you're largely fine.

SELinux would certainly help (in that it would quarantine any infected region), but that is not its primary role.

BTW, since this is a SELinux mailing list, I'll throw in the obligatory plea. Is SELinux holding off for 2.4.5, or will we see a 2.4.4 version?

Jonathan




------------------------------------------------------------
--== Sent via Deja.com ==--
http://www.deja.com/

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
