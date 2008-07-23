Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6N9xnsx017513
	for <selinux@tycho.nsa.gov>; Wed, 23 Jul 2008 05:59:49 -0400
Received: from nospam.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6N9xlbI008381
	for <selinux@tycho.nsa.gov>; Wed, 23 Jul 2008 09:59:48 GMT
Received: from localhost (localhost [127.0.0.1])
	by nospam.sws.net.au (Postfix) with ESMTP id DDA2518033
	for <selinux@tycho.nsa.gov>; Wed, 23 Jul 2008 19:59:45 +1000 (EST)
Received: from nospam.sws.net.au ([127.0.0.1])
	by localhost (etbe.coker.com.au [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VcCNmN-cKGGA for <selinux@tycho.nsa.gov>;
	Wed, 23 Jul 2008 19:59:45 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by nospam.sws.net.au (Postfix) with ESMTP id 8A98E18024
	for <selinux@tycho.nsa.gov>; Wed, 23 Jul 2008 19:59:45 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id 4DBFB215B6
	for <selinux@tycho.nsa.gov>; Wed, 23 Jul 2008 19:59:44 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: openssh and roles
Date: Wed, 23 Jul 2008 19:59:42 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200807231959.43788.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=492024

I've just filed the above bug report because using the user/role syntax of 
logging in to an ssh server causes the authorized_keys file to be ignored.  I 
believe that the current functionality in this regard is broken, but I am not 
certain that merely using the authorized_keys file in all situations is 
correct.

I think that it might be worth implementing a check similar to the check made 
when running a cron job.  So if user_home_ssh_t is not an entry-point for the 
sysadm_t domain then a key in a file of that type would not be usable to 
authenticate such a session.

What do you think?

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
