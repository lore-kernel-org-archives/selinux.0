Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA07663
	for <selinux@tycho.nsa.gov>; Wed, 27 Nov 2002 14:05:47 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id TAA07715
	for <selinux@tycho.nsa.gov>; Wed, 27 Nov 2002 19:03:24 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id TAA07703
	for <selinux@tycho.nsa.gov>; Wed, 27 Nov 2002 19:03:23 GMT
Message-Id: <200211271912.OAA22226@moss-shockers.ncsc.mil>
Date: Wed, 27 Nov 2002 14:12:51 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: network operations
To: selinux@tycho.nsa.gov, russell@coker.com.au
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> When a program tries to establish a TCP connection that is denied by SE Linux 
> policy then the result is that it will hang as the SYN packet is simply 
> dropped.
> 
> Would it be possible for a RST packet to be sent back so that the application 
> will get an error condition and then continue operating?

It would be possible, but you commonly just want to drop the packet upon
a policy denial, whether SELinux policy, IPSEC policy, or a packet
filter rule.  Hence, it would need to be specified in some manner in the
policy as to how to handle the denial.

--
Stephen Smalley, NSA
sds@epoch.ncsc.mil


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
