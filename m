Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o6IC5FFR023179
	for <selinux@tycho.nsa.gov>; Sun, 18 Jul 2010 08:05:15 -0400
Received: from smtp.sws.net.au (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o6IC4J16003428
	for <selinux@tycho.nsa.gov>; Sun, 18 Jul 2010 12:04:20 GMT
Received: from athena.localnet (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id CB6A61811C
	for <selinux@tycho.nsa.gov>; Sun, 18 Jul 2010 22:05:11 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: transactions in semanage
Date: Sun, 18 Jul 2010 22:05:10 +1000
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201007182205.10960.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Has anyone considered a batch/transaction interface for semanage?

The idea would be that you could redirect input from a script containing a 
list of commands, and either all of them would succeed and be committed to 
disk or none of the changes would apply and an error message would inform the 
user of the cause of the problem.

The first benefit of this would be an improvement in run-time.  Currently 
semanage can be quite time consuming on a low-end system and if you have a 
large number of commands to run (EG a for loop that has each iteration adding 
a number of fcontext rules or user identities) then it could be a real drag.

But having the transactional property as well would also be a good benefit.  
While it's possible to implement the same thing in shell code a basic 
transactional property would be handy - and save shell coding errors.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Main Blog
http://doc.coker.com.au/           My Documents Blog

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
