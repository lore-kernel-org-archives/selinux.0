Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id TAA17769
	for <selinux@tycho.nsa.gov>; Tue, 20 Mar 2001 19:41:21 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id AAA22526
	for <selinux@tycho.nsa.gov>; Wed, 21 Mar 2001 00:41:19 GMT
Received: from ecstasy.ksu.ru (ecstasy.ksu.ru [193.232.252.41])
	by jazzband.ncsc.mil  with ESMTP id AAA22522
	for <selinux@tycho.nsa.gov>; Wed, 21 Mar 2001 00:41:18 GMT
Message-ID: <3AB7F7C0.4080506@ksu.ru>
Date: Wed, 21 Mar 2001 03:37:20 +0300
From: Pedro Rosa <Pedro.Rosa@ksu.ru>
MIME-Version: 1.0
CC: Stephen Smalley <sds@tislabs.com>, Jeff Largent <jlargent@imagelinks.com>,
        selinux <selinux@tycho.nsa.gov>
Subject: Re: lids
References: <Pine.LNX.4.30.0103201734350.549-100000@biocserver.BIOC.CWRU.Edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Jose Nazario wrote:

> On Wed, 21 Mar 2001, Pedro Rosa wrote:
> 
>> Sorry but LIDS stands for Linux Intrusion Detection System. Its main
>> purpose has nothing to do with what SELinux deals with. I don't know
>> too much about the inners of LIDS but I know that it is an evolution
>> of some ideas based on NIDS (Network Intrusion Detection System).
> 
> 
> the name LIDS is a misnomer. as someone who works a lot with IDS stuff, it
> pisses me off, too, that such a fundamental mistake was made in the
> naming.
> 
> http://www.lids.org/about.html

Well I just decided to take a walk through this LIDS world... Yes, you 
are right about the name... However this tool is far from being 
equivalent to SELinux.

ACLs are one of its main components but not the main one.
First LIDS present a series of switch options. It looks like that you 
can turn on or off this stuff in a very flexible and dynamic manner.
Second LIDS presents some features with a very non-traditional taste. 
For example, it tries to hang-up the programs that violate the 
restrictions. Besides the way programs depend on ACLs is not seen 
exactly in the same view of SELinux. Here things look more as walking on 
a minefield rather than impose an administrative order in work.
Third LIDS has tools that put it much more near a NIDS. For example it 
registers net scannings. But not only, it also tries to protect the 
system from DoS attacks based on this capability. And it tries to be 
simple and concise in reporting repeating events. 
Fourth it has a remote reporting system that sounds much like those seen 
on some monitoring systems.

I would consider that LIDS is more a tool for those users who occur to 
be in a untrusted environment or are forced to go regularly through 
such. On the contrary, SELinux sounds much more like a tool that 
guarantees the existence of a trusted environment. Besides I think that 
there is a big difference on both. On SELinux we have MACs, which seem 
controlled from a central point. On LIDS we just have a strict set of 
controls that are not controlled from any center. In fact LIDS looks 
quite autonomous in terms of setup.

Frankly I can't state anything good or bad about these two systems. They 
have clearly two different purposes. They are only similar on particular 
points but we cannot state any strongnesses or weaknesses here. In fact 
a central administration could be useless or even damaging to what LIDS 
pretends to answer. Imagine taking a trip to a foreign country with your 
notebook full of valuable data. On the other way, an administrative 
autonomy on SELinux would only rise the consume of coffee and cigarettes 
among sysadmins.

Ektanoor

> 
> 



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
