Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5PJkfgA015058
	for <selinux@tycho.nsa.gov>; Sat, 25 Jun 2005 15:46:41 -0400 (EDT)
Received: from postoffice9.mail.cornell.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5PJjss8028717
	for <selinux@tycho.nsa.gov>; Sat, 25 Jun 2005 19:45:54 GMT
Subject: Re: Alternative user management approach
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, selinux@tycho.nsa.gov
In-Reply-To: <1119728228.13078.34.camel@localhost.localdomain>
References: <20050624225217.97028.qmail@web31614.mail.mud.yahoo.com>
	 <42BD31CE.9090908@redhat.com>  <42BD7A43.909@tresys.com>
	 <1119728228.13078.34.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sat, 25 Jun 2005 15:49:26 -0400
Message-Id: <1119728966.13078.41.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> Please note that none of this addresses the speed issue.
> A policydb still needs to be constructed for validation purposes.

I could use libselinux for validation, but it's not clear
that I should do that...

In other words if I'm adding permanent policy changes (like
writing file contexts in a file for future use)
it's not clear that I should be querying the runtime
policy (libselinux), instead of the on-disk policy (libsepol)
to check their validity.

The latter requires a policydb object...which takes 5 seconds 
to construct and load on a slow laptop, 2 seconds my athlon3k
at home, and probably 3 seconds on a laptop if you only
read it, and not write it back out (for purposes of loading).

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
