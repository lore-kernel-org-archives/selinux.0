Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8FCpbww028149
	for <selinux@tycho.nsa.gov>; Fri, 15 Sep 2006 08:51:37 -0400
Received: from macii.ads-oh.atg.titan.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8FCohwJ006086
	for <selinux@tycho.nsa.gov>; Fri, 15 Sep 2006 12:50:44 GMT
Received: from [192.168.50.32] (macii.ads-oh.atg.titan.com [66.218.141.147])
	by macii.ads-oh.atg.titan.com (Postfix) with ESMTP id 015D313F8B9
	for <selinux@tycho.nsa.gov>; Fri, 15 Sep 2006 12:42:29 +0000 (GMT)
Mime-Version: 1.0
Message-Id: <p06002037c130476cd8d9@[192.168.50.32]>
Date: Fri, 15 Sep 2006 08:51:01 -0400
To: selinux@tycho.nsa.gov
From: Rosalie Hiebel <rosalie.hiebel@L-3Com.com>
Subject: Question on type_member rule
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm trying to understand precisely how a type_member rule specifies 
the context to place on an instance of a polyinstantiated directory 
when it's done by context.

   type_member <source_type> <target_type>:dir <member_type>;

What exactly will be the context placed on the instance of the 
directory created by a process?   Will this context be the same as 
the context passed to setexeccon ?  Is the <member_type> placed in 
the context of the instance directory ?   Does running in permissive 
mode result in a different context ?

I have experimented with this, and I seem to always get instance 
directories created with the same context as that of the base 
directory (the one being polyinstantiated.)

Thanks,
Rosalie


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
