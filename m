Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8IDABxF005838
	for <selinux@tycho.nsa.gov>; Thu, 18 Sep 2003 09:10:11 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h8ID8RLY004139
	for <selinux@tycho.nsa.gov>; Thu, 18 Sep 2003 13:08:27 GMT
Received: from sat.sws.net.au (sat.sws.net.au [202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h8ID8PsG004119
	for <selinux@tycho.nsa.gov>; Thu, 18 Sep 2003 13:08:26 GMT
Received: from localhost (localhost [127.0.0.1])
	by sat.sws.net.au (Postfix) with ESMTP id 26CA4C162
	for <selinux@tycho.nsa.gov>; Thu, 18 Sep 2003 23:09:59 +1000 (EST)
Received: from sat.sws.net.au ([127.0.0.1])
 by localhost (sat [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 23132-02 for <selinux@tycho.nsa.gov>;
 Thu, 18 Sep 2003 23:09:58 +1000 (EST)
Received: from tsv.sws.net.au (tsv.sws.net.au [61.95.69.2])
	by sat.sws.net.au (Postfix) with ESMTP id 29D8BBF34
	for <selinux@tycho.nsa.gov>; Thu, 18 Sep 2003 23:09:58 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 1A568924D6
	for <selinux@tycho.nsa.gov>; Thu, 18 Sep 2003 23:09:57 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 6BD037F0E2
	for <selinux@tycho.nsa.gov>; Thu, 18 Sep 2003 23:09:55 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: ssh problems etc
Date: Thu, 18 Sep 2003 23:09:54 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200309182309.54805.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have written some policy to deal with the problems of ssh and put a test 
version on my play machine.

The file /root/id_test on the play machine is a ssh identity file to allow you 
to login as test via the command:
ssh -i id_test test@cose.coker.com.au

Logging in like this gives you the context of test:user_r:user_mini_t and very 
little access to the system.  All that can be done is to allow the shell to 
execute it's profile (I've assigned a special type for it that only allows 
read access) and run newrole.  Searching /dev/pts and /proc/pid is denied (to 
prevent gaining access to terminals for other sessions).  ptrace is denied 
for obvious reasons, as is signal access other than sigchld.

The idea is that you have sshd run from inetd and only inetd can bind to port 
22.  Every port 22 connection causes a new sshd to be launched with no privs 
to interfere with previously running sshd's (still working on this part).  
For an external interface (or all interfaces for the more paranoid) the sshd 
runs in a context that only allows transitioning to a domain such as 
user_mini_t and therefore cracking a sshd will not grant any significant 
access.  Merely getting user_mini_t gains you nothing.

Of course cracking sshd still does an attacker some good as it allows choosing 
an arbitary identity and role (from the set of roles that have mini domains 
defined).  If you knew the password of an account where login was prevented 
by some other means (eg the PermitRootLogin setting of the sshd config) then 
cracking the sshd would permit you to get the identity and therefore exploit 
the knowledge of the password in situations where otherwise knowing the 
password would gain you nothing.

As for whether sshd's can interfere with each other.  I'm going through the 
sshd access right now and reducing what is allowed.  I'm not sure if I can 
totally prevent this without changing the sshd source.

I'll have the policy for this online in the usual place soon.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
