Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA17058
	for <selinux@tycho.nsa.gov>; Tue, 20 Mar 2001 16:40:31 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id VAA07697
	for <selinux@tycho.nsa.gov>; Tue, 20 Mar 2001 21:40:22 GMT
Received: from ecstasy.ksu.ru (ecstasy.ksu.ru [193.232.252.41])
	by jazzswing.ncsc.mil  with ESMTP id VAA07692
	for <selinux@tycho.nsa.gov>; Tue, 20 Mar 2001 21:40:21 GMT
Message-ID: <3AB7CBBB.1060404@ksu.ru>
Date: Wed, 21 Mar 2001 00:29:31 +0300
From: Pedro Rosa <Pedro.Rosa@ksu.ru>
MIME-Version: 1.0
To: Stephen Smalley <sds@tislabs.com>
CC: Jeff Largent <jlargent@imagelinks.com>, selinux <selinux@tycho.nsa.gov>
Subject: Re: lids
References: <Pine.SOL.3.95.1010320083916.9741B-100000@clipper.gw.tislabs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Sorry but LIDS stands for Linux Intrusion Detection System. Its main 
purpose has nothing to do with what SELinux deals with. I don't know too 
much about the inners of LIDS but I know that it is an evolution of some 
ideas based on NIDS (Network Intrusion Detection System). Well it's a 
few monthes since I took a look at LIDS so I might be wrong in some 
point. The tool seems to follow some principles for a NIDS system but it 
is quite weaker. Besides it seems more concentrated on the inners of the 
system rather than caring about the networking environment.

In fact LIDS is a complementary  task of  what SELinux pretends to 
answer. While SELinux tries cares for the permissions of the system and 
controls their use, LIDS tries to answer for situations when such 
control is overcomed.

Ektanoor


Stephen Smalley wrote:

> Security-Enhanced Linux (SELinux) has a well-defined architecture for
> flexible mandatory access controls that has been experimentally

<skipped>

> 
> 
> 



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
