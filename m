Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAJB4IRb017266
	for <selinux@tycho.nsa.gov>; Wed, 19 Nov 2003 06:04:18 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hAJB3lBb014497
	for <selinux@tycho.nsa.gov>; Wed, 19 Nov 2003 11:03:47 GMT
Received: from ns.sws.net.au (ns.sws.net.au [61.95.69.3])
	by jazzswing.ncsc.mil  with ESMTP id hAJB3j4o014482
	for <selinux@tycho.nsa.gov>; Wed, 19 Nov 2003 11:03:46 GMT
Received: from localhost (localhost [127.0.0.1])
	by ns.sws.net.au (Postfix) with ESMTP id 2686161BE7
	for <selinux@tycho.nsa.gov>; Wed, 19 Nov 2003 22:04:10 +1100 (EST)
Received: from ns.sws.net.au ([127.0.0.1])
	by localhost (ns [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 30291-10 for <selinux@tycho.nsa.gov>;
	Wed, 19 Nov 2003 22:04:09 +1100 (EST)
Received: from tsv.sws.net.au (tsv.sws.net.au [61.95.69.2])
	by ns.sws.net.au (Postfix) with ESMTP id DA9EE61BE6
	for <selinux@tycho.nsa.gov>; Wed, 19 Nov 2003 22:04:09 +1100 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id ABFF7925E8
	for <selinux@tycho.nsa.gov>; Wed, 19 Nov 2003 22:04:09 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 44EA47F0A0
	for <selinux@tycho.nsa.gov>; Wed, 19 Nov 2003 22:04:08 +1100 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: setools
Date: Wed, 19 Nov 2003 22:04:07 +1100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200311192204.07725.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have just uploaded setools to Debian.

I have a few suggestions for new features for apol (the only part of setools 
that I've used so far):

It should take a command line parameter of a policy.conf file.  I want to type
"apol /tmp/policy.conf" and save the effort of going through a GUI to specify 
a file to load.

The "search using type" option in "Roles" displays types that are not domains 
(and therefore can't be in any role).  The drop-down would contain much less 
data if it only listed viable options.

There seems to be no way to say "tell me all interactions between staff_t and 
sshd_t".  Maybe I'm missing something here.


Anyway apol is good, I recommend that you all try it out.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
