Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h91BqmsJ024322
	for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2003 07:52:48 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h91Bp0Zt021174
	for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2003 11:51:00 GMT
Received: from tsv.sws.net.au ([61.95.69.2])
	by jazzswing.ncsc.mil  with ESMTP id h91BowM3021165
	for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2003 11:50:59 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 7927A924F2
	for <selinux@tycho.nsa.gov>; Wed,  1 Oct 2003 21:52:40 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id B39487F0E7
	for <selinux@tycho.nsa.gov>; Wed,  1 Oct 2003 21:52:38 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: shlib_t vs lib_t for symbolic links
Date: Wed, 1 Oct 2003 21:52:38 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200310012152.38059.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Is there any reason why the symbolic links under /lib and /usr/lib have type 
shlib_t instead of lib_t?

I've looked through the policy for different access for those types.  I found 
three examples, there's user_ssh_t etc (which is a minor policy bug that I've 
fixed), there's apt_t (which may not be what we desire, but as apt_t can 
destroy your system in many ways that are easier than fiddling with sym-links 
it's not an issue), and there's the ldconfig_t policy for keeping the 
sym-links in shlib_t.

It seems that it would be simpler to have the sym-links in question have type 
lib_t, and with the current implementation there's no difference in access.

The reason I ask is that it would simplify things a bit (less policy in 
ldconfig.te and a possibility of optimising setfiles) to give the sym-links 
lib_t.

If there are any plans to do things differently in regard to lib_t/shlib_t in 
the future then I think that now would be a good time to discuss them.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
