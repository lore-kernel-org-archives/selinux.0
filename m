Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j28JnhDo019660
	for <selinux@tycho.nsa.gov>; Tue, 8 Mar 2005 14:49:43 -0500 (EST)
Subject: Re: shm denials
From: Ivan Gyurdiev <ivg2@cornell.edu>
Reply-To: ivg2@cornell.edu
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1108396290.15437.67.camel@moss-spartans.epoch.ncsc.mil>
References: <1108222744.23018.5.camel@cobra.ivg2.net>
	 <1108393789.15437.53.camel@moss-spartans.epoch.ncsc.mil>
	 <1108395654.11637.3.camel@cobra.ivg2.net>
	 <1108396290.15437.67.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 08 Mar 2005 14:49:32 -0500
Message-Id: <1110311372.4508.7.camel@cobra.ivg2.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> Yes, no surprise there.  Again, someone would need to assess the risk
> posed by allowing it (e.g. does X create any shared memory objects that
> should not be directly writable by the user domains, what safeguards
> does X apply in handling the potentially malicious data from the shared
> memory object, etc).  Possibly a candidate for a boolean.
> 

Should I cross-post this to X-devel for discussion?
What needs to be done to ensure this issue is not forgotten?

-- 
Ivan Gyurdiev <ivg2@cornell.edu>
Cornell University


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
