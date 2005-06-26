Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5QGaigA018710
	for <selinux@tycho.nsa.gov>; Sun, 26 Jun 2005 12:36:44 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5QGaJFZ013104
	for <selinux@tycho.nsa.gov>; Sun, 26 Jun 2005 16:36:20 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 2A28761AFE
	for <selinux@tycho.nsa.gov>; Mon, 27 Jun 2005 02:36:20 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 06971-08 for <selinux@tycho.nsa.gov>;
	Mon, 27 Jun 2005 02:36:19 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id B91D361AEA
	for <selinux@tycho.nsa.gov>; Mon, 27 Jun 2005 02:36:19 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: Alternative user management approach
Date: Mon, 27 Jun 2005 02:36:14 +1000
Cc: selinux@tycho.nsa.gov
References: <20050624225217.97028.qmail@web31614.mail.mud.yahoo.com> <42BD31CE.9090908@redhat.com>
In-Reply-To: <42BD31CE.9090908@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200506270236.18235.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Saturday 25 June 2005 20:28, Daniel J Walsh <dwalsh@redhat.com> wrote:
> Ok this all sounds good, but how do we come to a consensus.
>
> Do we need an "role attribute" to define "user" roles.

I think we need a role attribute to solve the problem of the ugly 
in_user_role() macro.

> roleattribute staff_r user;
> roleattribute user_r user;
> roleattribute sysadm_r user;
>
> Then do we need a mechanism in policy to associate roles with "user" roles?

Firstly I think we should stick to the established terminology for the moment.  
We have SE Linux identities which determine the roles that are permitted, and 
we have a mapping mechanism to determine the SE Linux identity from the Unix 
UID.  The current mapping mechanism is to look for a match between the Unix 
account name and a SE Linux identity and use that identity if it exists, 
otherwise use "user_u".  We are talking about having a config file using 
user-name and group-name.

The group-name thing could become fun if we have multiple names for the same 
GID (it's not recommended but it works at the moment) and the GID is the 
primary group for some users.  The Unix user-name is unambiguous as we start 
with the name for every operation AFAIK.

> How does all this work with MLS ranges?

How does it cause problems with MLS?

> Do we have a new file which associates uids to user roles?

Unix account names not UIDs.  I think a mapping file is the only way.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
