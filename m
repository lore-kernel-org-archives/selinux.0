Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h7Q35fLa029081
	for <selinux@tycho.nsa.gov>; Mon, 25 Aug 2003 23:05:41 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h7Q34E4F016544
	for <selinux@tycho.nsa.gov>; Tue, 26 Aug 2003 03:04:14 GMT
Received: from sat.sws.net.au (sat.sws.net.au [202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h7Q34BFC016525
	for <selinux@tycho.nsa.gov>; Tue, 26 Aug 2003 03:04:12 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Pisupati, Ajay" <ajay.pisupati@pw.utc.com>,
   SE Linux <selinux@tycho.nsa.gov>
Subject: Re: SElinux vs. Grsecruity
Date: Tue, 26 Aug 2003 13:04:49 +1000
References: <FAB2059733EB46409AD28AC957F663F70BEE5C@pusmde04.mt.pweh.com>
In-Reply-To: <FAB2059733EB46409AD28AC957F663F70BEE5C@pusmde04.mt.pweh.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200308261304.49538.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 26 Aug 2003 00:43, Pisupati, Ajay wrote:
> 	I just started reading about SE Linux and grsecurity.  Having used
> neither one (and wanting to learn), I wanted to find out the differences
> (advantages and disadvantes) between both.  I am not looking for a detailed
> explanation of how things work but just an introduction on a conceptual
> level.

GR Security includes PaX for protection against stack smashing and other 
similar attacks.  But it also has an ACL system of it's own and limited 
chroot's (IE process in chroot can't touch the outside environment or other 
chroot's).

SE Linux is an implementation of the domain-type security model.  The domain a 
process is in determines that access it is given.  Domains can change 
automatically on execution of certain processes (eg getty, login, and ping) 
or when executing a process a SE Linux aware program can specify the security 
context of the child process (within a certain range), login, sshd, and cron 
do this.

The grsec ACL system and RSBAC don't support modifying applications to specify 
the security context, so they don't support giving different access to 
different non-root users.

I think that Grsec has better support for some aspects of IP networking 
control, such as controlling which IP address a process can bind to 
(currently SE Linux only supports controlling bind access by port).

RSBAC has lots of options for a huge number of things as they take the kitchen 
sink approach.  You have to answer about 40 questions at kernel configuration 
time, and it's not clear which combinations of options are viable.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
