Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m0VIF9Le027590
	for <selinux@tycho.nsa.gov>; Thu, 31 Jan 2008 13:15:09 -0500
Received: from florence.astrium.eads.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m0VIF8Du016773
	for <selinux@tycho.nsa.gov>; Thu, 31 Jan 2008 18:15:09 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: UNCLASSIFIED - Realtime Scheduling...
Date: Thu, 31 Jan 2008 18:14:59 -0000
Message-ID: <7F6B06837A5DBD49AC6E1650EFF5490601C64C1A@auk52177.ukr.astrium.corp>
From: "HAWKER, Dan 2 \(external\)" <Dan.HAWKER@uk4.astrium.eads.net>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



Hi All,

Am not 100% sure if this is completely an SELinux question, but am
hoping the pool of knowledge will be able to help me out :)

I have an daemon that a developer has created, that I am creating an
SELinux policy for. Works well and is easy enough, however it needs to
run as non-root. Again this is not a problem, however it does two things
that makes this a problem.
1) it changes the system time...
2) it generates threads that have edited SCHED_FIFO so as to gain
realtime scheduling...

Presently (non-SELinux) both are implemented using standard internal
calls to appropriate libraries (rather than external system calls or
apps) and hence require root access.

Was wondering if there was an elegant solution (can think of inelegant
ones) to this problem, by where I can use SELinux to grant the
appropriate privileges to the un-modified (or slightly modified)
daemon???

Obviously we could re-architect the daemon and get it to call another
root enabled but heavily constrained (with SELinux) app to change the
time, however by my understanding (but I am a sysadmin not a programmer
type), that method isn't viable for the realtime scheduling problem.

So, is there a way with roles (or another way) that I can give the
daemon the required privilege to set realtime scheduling with SELinux???

TIA

Dan
--

Dan Hawker
Linux System Administrator
Astrium
http://www.astrium.eads.net

-- 

This email (including any attachments) may contain confidential and/or
privileged information or information otherwise protected from disclosure.
If you are not the intended recipient, please notify the sender
immediately, do not copy this message or any attachments and do not use it
for any purpose or disclose its content to any person, but delete this
message and any attachments from your system. Astrium disclaims any and all
liability if this email transmission was virus corrupted, altered or
falsified.
---------------------------------------------------------------------
Astrium Limited, Registered in England and Wales No. 2449259
REGISTERED OFFICE:-
Gunnels Wood Road, Stevenage, Hertfordshire, SG1 2AS, England


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
