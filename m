Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i1NDofRb016687
	for <selinux@tycho.nsa.gov>; Mon, 23 Feb 2004 08:50:42 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i1NDoUQQ003661
	for <selinux@tycho.nsa.gov>; Mon, 23 Feb 2004 13:50:30 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id i1NDoTP0003658 for <selinux@tycho.nsa.gov>; Mon, 23 Feb 2004 13:50:30 GMT
Subject: Re: identity
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200402231535.26738.russell@coker.com.au>
References: <200402231535.26738.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1077544221.18234.9.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 23 Feb 2004 08:50:21 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2004-02-22 at 23:35, Russell Coker wrote:
> One of the benefits of the SE Linux identity is that it tracks the originating 
> user through all operations that they perform.
> 
> With the user_u identity the utility of the identity for logging user 
> activities is reduced.
> 
> Some people are talking about ways of tracking the source IP address for a ssh 
> connection or other information on the login through user sessions in a 
> similar manner.
> 
> It seems to me that we would gain a benefit if we had two parts to the 
> identity string, the user-name that is compiled into the policy (and checked 
> in the constraints file etc), and an arbitary string set by the login program 
> or other equally privileged processes to be used for logging.
> 
> The idea is to have something like rjc#10.0.0.1:user_r:user_t to indicate that 
> I logged in from IP address 10.0.0.1.
> 
> Steve, what do you think?

This seems to overlap with Joshua Brindle's avc ipaddr patches, except
that his patches have the kernel track the IP addr and include it in the
AVC audit messages.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
