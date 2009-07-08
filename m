Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n68HuMd6011105
	for <selinux@tycho.nsa.gov>; Wed, 8 Jul 2009 13:56:22 -0400
Received: from bosmailout08.eigbox.net (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n68Hv2Cj013957
	for <selinux@tycho.nsa.gov>; Wed, 8 Jul 2009 17:57:02 GMT
Received: from bosmailscan14.eigbox.net ([10.20.15.14])
	by bosmailout08.eigbox.net with esmtp (Exim)
	id 1MObNV-0003Kw-Bb
	for selinux@tycho.nsa.gov; Wed, 08 Jul 2009 13:56:21 -0400
Received: from bosimpout01.eigbox.net ([10.20.55.1])
	by bosmailscan14.eigbox.net with esmtp (Exim)
	id 1MObNV-0007b8-6a
	for selinux@tycho.nsa.gov; Wed, 08 Jul 2009 13:56:21 -0400
Received: from [64.17.255.138] (helo=BrianKrusicW.logan.internal)
	by bosauthsmtp06.eigbox.net with esmtpa (Exim)
	id 1MObNU-0006aD-DR
	for selinux@tycho.nsa.gov; Wed, 08 Jul 2009 13:56:20 -0400
Message-Id: <5C85BC70-8118-4E7D-8D96-ADAE9F14A905@krusic.com>
From: Brian Krusic <brian@krusic.com>
To: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: removing context
Date: Wed, 8 Jul 2009 10:56:13 -0700
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

Unsure if this is the right place to post so I apologize in advance.

When doing an ls -lZ, some files show a security context like;

root:object_r:user_home_t:s0

... while some don't.  I do not of selinux enabled although at one  
point I did.

Does any one know how to remove this context either on a file, dir or  
file system level?

The reason I ask is that while dump/restore work over NFS, they don't  
work with selinux context so I keep getting errors like;

restore: ./etc/ysyconfig/network-scripts/ifcfg-eth0: EA set  
security.selinux:system_u:object_r:etc_t:s0 failed: Operation not  
supported.

And while the dump/restore work and the files get copied, this error  
causes my incremental backs to work as full backups.

Thanks in advance,
- Brian

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
