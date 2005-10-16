Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j9GNPGNs023323
	for <selinux@tycho.nsa.gov>; Sun, 16 Oct 2005 19:25:16 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j9GNMwdD000248
	for <selinux@tycho.nsa.gov>; Sun, 16 Oct 2005 23:22:58 GMT
Message-ID: <4352E0C6.9030201@tresys.com>
Date: Sun, 16 Oct 2005 19:22:46 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: russell@coker.com.au
CC: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: range_transition inside a conditional
References: <200510170757.58947.russell@coker.com.au>
In-Reply-To: <200510170757.58947.russell@coker.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:
> Is that supposed to work?  It doesn't seem to do so at the moment (checkpolicy 
> version 1.27.8-2 in rawhide.
> 

No, Conditional policy only supports rules that are put in an avtab 
(allow, dontaudit, auditallow, type_*)

kernel and libsepol (policydb) changes would be required to support 
range_transition.

Joshua


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
