Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h43Em5I4021485
	for <selinux@tycho.nsa.gov>; Sat, 3 May 2003 10:48:06 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h43Em47R006894
	for <selinux@tycho.nsa.gov>; Sat, 3 May 2003 14:48:04 GMT
Received: from sat.sws.net.au ([202.5.161.49])
        by jazzband.ncsc.mil  with ESMTP id h43ElpKP006890 for <selinux@tycho.nsa.gov>; Sat, 3 May 2003 14:48:02 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Subject: SE Linux on Familiar
Date: Sun, 4 May 2003 00:46:40 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200305040046.40916.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have reached a major milestone in my SE Linux on Familiar work.  I now have 
an iPaQ booting in enforcing mode and allowing logins over the serial port 
(both terminal logins and ppp sessions).

All the difficult work is done.

I have developed two solutions to the busybox wrapper problem (I have yet to 
determine which is best or whether there is a place for both of them).

Currently the sshd and xdm programs I am using are not patched (so I login to 
the iPaQ via ssh as system_u:system_r:sysadm_t).  Patching ssh will be easy, 
I have a lot of practise at this.  Patching the xdm program should not be any 
more difficult than patching kdm (painful, nasty and messy - but not 
technically challenging).

Currently the xdm program is not functional.  It does some undesirable things 
(such as wanting read-write access to /root), so I will need some policy 
changes and maybe some code changes to get it going.  But it's a lot easier 
to get this going now that I have the basic functionality in place.

All of the things that could cause the iPaQ to become unbootable if I made a 
mistake (requiring that I spend an hour reloading all the software) are done.  
I have developed basic installation proceedures for this as well.

Some of the code and policy that I have written is rather ugly and needs to be 
cleaned up, that shouldn't be really difficult.  Tomorrow I will post some 
policy patches that are related to my iPaQ work.

I anticipate that I will have an iPaQ that's running SE Linux in enforcing 
mode that is ready for non-development use within a week.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
