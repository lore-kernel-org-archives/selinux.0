Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA13142
	for <selinux@tycho.nsa.gov>; Wed, 2 Oct 2002 07:14:31 -0400 (EDT)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 0ACB692465
	for <selinux@tycho.nsa.gov>; Wed,  2 Oct 2002 21:14:30 +1000 (EST)
Received: from lyta (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id BB606A90D
	for <selinux@tycho.nsa.gov>; Wed,  2 Oct 2002 13:14:22 +0200 (CEST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Subject: attributes for roles?
Date: Wed, 2 Oct 2002 13:14:22 +0200
MIME-Version: 1.0
Message-Id: <200210021314.22359.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've just setup a machine with 5 different user roles.  I want to allow 
administrative accounts to assume any of those roles.  This requires that as 
each role is added the users file be updated for all administrative 
identities.

It would be a lot easier to have the following in the users file:
user root roles { sysadm_r user_roles };

Then in user.te:
allow system_r user_roles;
allow sysadm_r user_roles;

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
