Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h576XAI4007539
	for <selinux@tycho.nsa.gov>; Sat, 7 Jun 2003 02:33:10 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h576X9tV007133
	for <selinux@tycho.nsa.gov>; Sat, 7 Jun 2003 06:33:09 GMT
Received: from sat.sws.net.au ([202.5.161.49])
        by jazzband.ncsc.mil  with ESMTP id h576X7al007130 for <selinux@tycho.nsa.gov>; Sat, 7 Jun 2003 06:33:08 GMT
Received: from localhost (localhost [127.0.0.1])
	by sat.sws.net.au (Postfix) with ESMTP id ECC2EBF3F
	for <selinux@tycho.nsa.gov>; Sat,  7 Jun 2003 16:33:05 +1000 (EST)
Received: from sat.sws.net.au ([127.0.0.1])
 by localhost (sat [127.0.0.1:10024]) (amavisd-new) with ESMTP id 18629-01
 for <selinux@tycho.nsa.gov>; Sat,  7 Jun 2003 16:33:04 +1000 (EST)
Received: from tsv.sws.net.au (tsv.sws.net.au [61.95.69.2])
	by sat.sws.net.au (Postfix) with ESMTP id 85C24BF3D
	for <selinux@tycho.nsa.gov>; Sat,  7 Jun 2003 16:33:04 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 46BE592740
	for <selinux@tycho.nsa.gov>; Sat,  7 Jun 2003 16:33:04 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id D4E589D22
	for <selinux@tycho.nsa.gov>; Sat,  7 Jun 2003 16:32:05 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: SE Linux questions
Date: Sat, 7 Jun 2003 16:32:05 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200306071632.05459.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

[Is SE Linux ready for production]

I'm running two ISPs on SE Linux.  I think it's production ready.

The only problem with SE Linux at the moment for serious installations is the 
lack of support for backup of security contexts of files.  This will be fully 
addresses in Linux 2.6.0, and in the mean time there are hacks you can use, 
but nothing satisfactory.

However for a typical multi-user system the files you are most interested in 
controlling are system files (which can easily be relabeled after a restore).  
The labels for 99% of user files can also be correctly re-assigned by the 
setfiles program.  Of the other 1%, most of such files don't even exist if 
you don't have users running programs such as Netscape or UML.

As you won't want people using your server for running Netscape then the most 
you will have to worry about is some small difficulty with UML, which could 
easily be fixed by changing the policy.  Also as your typical user probably 
won't be interested in great security they will probably run UML kernels 
under their own user domain, in which case the issue is moot.

[Can I patch procmail in a similar way to login etc]

I have considered the possibility of patching a mail server to run procmail 
for delivery in a special user context.  Then procmail can safely access the 
.procmailrc file and deliver mail to the user's home directory, but it can't 
access the home directory of a user in another role.

However will you even be using multiple roles?  For a system such as you 
describe it's likely that you will have three roles, staff_r (for minor 
administration tasks), sysadm_r (for serious administration - mkfs, fdisk, 
etc), and user_r (for the users).  Now if you demand that all people in 
staff_r also have an account in user_r for their email, then you can just 
restrict procmail to only accessing user_r.

The above are some questions I answered in private mail.  I decided that other 
people on the list may be interested so I posted an extract here.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
