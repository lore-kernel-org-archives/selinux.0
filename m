Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA17237
	for <selinux@tycho.nsa.gov>; Tue, 20 Mar 2001 17:21:45 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id WAA16679
	for <selinux@tycho.nsa.gov>; Tue, 20 Mar 2001 22:21:43 GMT
Received: from sentry.gw.tislabs.com (relay.hq.tis.com [192.94.214.100])
	by jazzband.ncsc.mil  with ESMTP id WAA16675
	for <selinux@tycho.nsa.gov>; Tue, 20 Mar 2001 22:21:42 GMT
Date: Tue, 20 Mar 2001 17:20:33 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Pedro Rosa <Pedro.Rosa@ksu.ru>
cc: Jeff Largent <jlargent@imagelinks.com>, selinux <selinux@tycho.nsa.gov>
Subject: Re: lids
In-Reply-To: <3AB7CBBB.1060404@ksu.ru>
Message-ID: <Pine.SOL.3.95.1010320171639.9741S-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


I can't speak to the main purpose of LIDS, but the LIDS FAQ itself
mentions that LIDS implements mandatory access controls (as well as other
features). I've examined the LIDS code, and it does indeed implement such
controls.  It is true that some of the LIDS features are orthogonal to
SELinux, such as security alerts and port scan detection, but you can
certainly compare the mandatory access controls of LIDS with SELinux.

--
Stephen D. Smalley, NAI Labs
sds@tislabs.com


On Wed, 21 Mar 2001, Pedro Rosa wrote:

> Sorry but LIDS stands for Linux Intrusion Detection System. Its main 
> purpose has nothing to do with what SELinux deals with. I don't know too 
> much about the inners of LIDS but I know that it is an evolution of some 
> ideas based on NIDS (Network Intrusion Detection System). Well it's a 
> few monthes since I took a look at LIDS so I might be wrong in some 
> point. The tool seems to follow some principles for a NIDS system but it 
> is quite weaker. Besides it seems more concentrated on the inners of the 
> system rather than caring about the networking environment.
> 
> In fact LIDS is a complementary  task of  what SELinux pretends to 
> answer. While SELinux tries cares for the permissions of the system and 
> controls their use, LIDS tries to answer for situations when such 
> control is overcomed.
> 
> Ektanoor



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
