Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i0D3KoRb017020
	for <selinux@tycho.nsa.gov>; Mon, 12 Jan 2004 22:20:50 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i0D3KniV025957
	for <selinux@tycho.nsa.gov>; Tue, 13 Jan 2004 03:20:49 GMT
Received: from ns.sws.net.au ([61.95.69.3])
        by jazzband.ncsc.mil  with ESMTP id i0D3Kb06025908 for <selinux@tycho.nsa.gov>; Tue, 13 Jan 2004 03:20:48 GMT
Received: from localhost (localhost [127.0.0.1])
	by ns.sws.net.au (Postfix) with ESMTP id D52E061BAA
	for <selinux@tycho.nsa.gov>; Tue, 13 Jan 2004 14:19:14 +1100 (EST)
Received: from ns.sws.net.au ([127.0.0.1])
	by localhost (ns [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 10804-05 for <selinux@tycho.nsa.gov>;
	Tue, 13 Jan 2004 14:19:14 +1100 (EST)
Received: from tsv.sws.net.au (tsv.sws.net.au [61.95.69.2])
	by ns.sws.net.au (Postfix) with ESMTP id 6C66161B17
	for <selinux@tycho.nsa.gov>; Tue, 13 Jan 2004 14:19:14 +1100 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 1A13B924F5
	for <selinux@tycho.nsa.gov>; Tue, 13 Jan 2004 14:19:14 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 5B0CAB5871
	for <selinux@tycho.nsa.gov>; Tue, 13 Jan 2004 14:19:24 +1100 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Samba and NFSv4 user-space server
Date: Tue, 13 Jan 2004 14:19:23 +1100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200401131419.23834.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

For Samba it's possible for a single TCP connection to be used for multiple 
identities.  This is standard practise for "Windws Terminal Server", and 
would be used when you specify different user-id's for different "net use" 
commands if the Windows SMB client code wasn't so buggy.

This means that having a separate SE Linux context for each copy of smbd would 
be impossible if full functionality is to be maintained, and in spite of this 
it would be really difficult to change the smbd code to make it re-exec 
itself every time someone authenticates.

I spent some time discussing the matter with Tridge, he seems quite convinced 
that SE Linux needs some method to allow an smbd to change security context 
for file system operations (similar in concept to setfsuid() perhaps).

After that Tridge and Linus spent some time discussing the possibility of 
having a method of storing all process context (UID, GID, supplemental GIDs, 
signal state, etc) and allowing a process to switch some large amount of it's 
process state with a single system call.  They suggested having SE Linux 
context be part of this process state to be changed.


We don't want to allow wide and arbitary changing of context as setuid() 
allows.  But allowing transitions between samba_user_t and samba_staff_t 
should be OK.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
