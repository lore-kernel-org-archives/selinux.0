Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jA78sfMA020273
	for <selinux@tycho.nsa.gov>; Mon, 7 Nov 2005 03:54:42 -0500 (EST)
Received: from smtpscan-nl2.aots.nl (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id jA78lsQF015386
	for <selinux@tycho.nsa.gov>; Mon, 7 Nov 2005 08:48:05 GMT
Received: from smtpscan-nl2.aots.nl (localhost [127.0.0.1])
	by localhost.aots.nl (Postfix) with ESMTP id A5676F2D
	for <selinux@tycho.nsa.gov>; Mon,  7 Nov 2005 09:30:32 +0100 (MET)
Received: from sat-relay2.telecom.ptt.nl (relay4.kpn-telecom.nl [145.7.200.30])
	by smtpscan-nl2.aots.nl (Postfix) with ESMTP id 778C6D67
	for <selinux@tycho.nsa.gov>; Mon,  7 Nov 2005 09:30:32 +0100 (MET)
Received: from tmail001s.telecom.ptt.nl (tmail001s.pc.telecom.ptt.nl [10.1.88.44])
	by sat-relay2.telecom.ptt.nl (8.11.6p2-20030924/8.11.6) with ESMTP id jA78UTG22746
	for <selinux@tycho.nsa.gov>; Mon, 7 Nov 2005 09:30:29 +0100
Message-ID: <04B7A8D2D61A4E4A8EBE8BF45D4C52AC82F390@pb05.mobilan.mobidata>
From: b.c.jansen@kpn.com
To: selinux@tycho.nsa.gov
Subject: Question about selinux
Date: Mon, 7 Nov 2005 09:30:19 +0100 
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello everyone,

I was wondering if anyone is interested in helping me out with a certain
situation. My company wants to start doing backup straight to disk and
skipping the entire tape phase and they asked me to do it. Now i have
decided to go for a rsync push from several servers on different times via
cron to the disk array (actual backup server).

For security reasons i wanted each client to have it's own host where it
couldn't do any damage, the problem here is that the user that rsync uses
has to have near equal rights (or basically the same) as the root user
because it has to keep the file ownerships and similair. I thought about
using chroot for this problem but well.... Chroot is quite breachable and as
such i was trying to do it with selinux.

For that i have been fiddling in the src files i downloaded from the nsa
site but have been unable to get a satisfactionary policy made, and there is
my question :P

Is anyone here willign to help me out with this situation? It would involve
making a policy that prevents the user from doing anything (on a system call
level) other then creating/changing and deleting directories, files and
links (rsync's incremental option). If so just mail me at b.c.jansen@kpn.com

Best Regards,
Bas Jansen
Student

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
