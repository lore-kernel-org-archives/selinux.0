Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA22947
	for <selinux@tycho.nsa.gov>; Wed, 8 Jan 2003 14:11:18 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h08JBHI06503
	for <selinux@tycho.nsa.gov>; Wed, 8 Jan 2003 19:11:17 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id h08JBFf06499 for <selinux@tycho.nsa.gov>; Wed, 8 Jan 2003 19:11:16 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id EDD4E92666
	for <selinux@tycho.nsa.gov>; Thu,  9 Jan 2003 06:11:00 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 913A33FFE
	for <selinux@tycho.nsa.gov>; Wed,  8 Jan 2003 20:10:53 +0100 (CET)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: <selinux@tycho.nsa.gov>
Subject: Re: Policy Language
Date: Wed, 8 Jan 2003 20:10:53 +0100
References: <000a01c2b740$0f11f420$6600a8c0@columbia.tresys.com>
In-Reply-To: <000a01c2b740$0f11f420$6600a8c0@columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200301082010.53087.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 8 Jan 2003 19:02, Frank Mayer wrote:
> I would ask that we only change the policy syntax reluctantly and as
> limited as possible, and only for strong need.  Every time the language
> changes, it can be a lot or little work for us to sync up our parser for
> setools.  Since we have a requirement to maintain backwards
> compatibility with older policy syntax, each change can be a lot of
> work.

While we're on the topic, I think it would be good if the following files 
change as little as possible, and wherever possible the only changes should 
be in adding new entries.
access_vectors
initial_sids
security_classes
initial_sid_contexts

Whenever we have a major change to the kernel code it seems to result in a 
situation where the policy and the checkpolicy program need to be updated at 
the same time.  Installing the checkpolicy program first has no drastic 
consequences, but installing the new policy first can screw up an existing 
kernel.

This is something I still haven't adequately addressed in my Debian packages, 
and is probably something that will cause problems for other people who are 
preparing SE Linux packages.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
