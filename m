Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB92oNRb020503
	for <selinux@tycho.nsa.gov>; Mon, 8 Dec 2003 21:50:23 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hB92ndlU015485
	for <selinux@tycho.nsa.gov>; Tue, 9 Dec 2003 02:49:39 GMT
Received: from ns.sws.net.au ([61.95.69.3])
	by jazzswing.ncsc.mil  with ESMTP id hB92naSX015458
	for <selinux@tycho.nsa.gov>; Tue, 9 Dec 2003 02:49:38 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Chris PeBenito <pebenito@gentoo.org>
Subject: Re: policy problem with nfs mounting
Date: Tue, 9 Dec 2003 13:48:38 +1100
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
References: <1070904612.15475.7.camel@chris.pebenito.net> <1070909315.7949.40.camel@moss-spartans.epoch.ncsc.mil> <1070914878.16071.10.camel@chris.pebenito.net>
In-Reply-To: <1070914878.16071.10.camel@chris.pebenito.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200312091348.38010.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 9 Dec 2003 07:21, Chris PeBenito <pebenito@gentoo.org> wrote:
> Well I made a mistake on this; I wouldn't have seen this had I not
> missed merging in the two rules at the bottom of mount.te to allow
> mounting of unlabeled fs's.  But since it looks like these other
> interfaces are going to be worked on soon, I put in a rpc_pipefs_t
> anyway, see attached patch.

I've put that in my tree.  It seems like a good interim measure at least 
until/unless Steve determines that something better is needed.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
