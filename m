Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8KJcvsJ003604
	for <selinux@tycho.nsa.gov>; Sat, 20 Sep 2003 15:38:57 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h8KJYkd6018400
	for <selinux@tycho.nsa.gov>; Sat, 20 Sep 2003 19:37:14 GMT
Received: from sat.sws.net.au (sat.sws.net.au [202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h8J6EOVY021371
	for <selinux@tycho.nsa.gov>; Fri, 19 Sep 2003 06:15:46 GMT
Received: from localhost (localhost [127.0.0.1])
	by sat.sws.net.au (Postfix) with ESMTP id 1B84AC167
	for <selinux@tycho.nsa.gov>; Fri, 19 Sep 2003 16:16:05 +1000 (EST)
Received: from sat.sws.net.au ([127.0.0.1])
 by localhost (sat [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 32468-01 for <selinux@tycho.nsa.gov>;
 Fri, 19 Sep 2003 16:16:04 +1000 (EST)
Received: from tsv.sws.net.au (tsv.sws.net.au [61.95.69.2])
	by sat.sws.net.au (Postfix) with ESMTP id 24914BF15
	for <selinux@tycho.nsa.gov>; Fri, 19 Sep 2003 16:16:04 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id E7753924D6
	for <selinux@tycho.nsa.gov>; Fri, 19 Sep 2003 16:16:03 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id C7ADC7F0E1
	for <selinux@tycho.nsa.gov>; Fri, 19 Sep 2003 16:16:01 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: /dev/tty
Date: Fri, 19 Sep 2003 16:16:01 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200309191616.01134.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

If I have a session with /dev/pts/1 as the controlling tty and I do the 
following:
program < /dev/tty 2> /dev/tty > /dev/tty &

Then changing the context of /dev/pts/1 does not cause my program to lose 
terminal access.  This is not what I expected!

I am not sure whether this would be considered a limitation of SE Linux.  If a 
process has the ability to make a pseudo-tty it's controlling terminal before 
you change the context of the pseudo-tty to do something important with it 
then you probably have some more serious problem.

Obviously in the case of "newrole -r sysadm_r" if you have another user with 
write access to the terminal before the newrole command then they could be 
intercepting what you are doing and you've already lost.

However one thing that may trick people is that when they run
"newrole -r user_r" from a more priviledged role to execute some untrusted 
program, they will think that it's really gone when the command finishes.  It 
seems that the only safe way of using su or newrole to run an untrusted 
program is through using the "exec" command so that when the untrusted 
session is complete there are no priviledged processes waiting to take over 
the terminal.

I am not sure whether there are any other cases in which devtty_t access would 
be considered harmful.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
