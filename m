Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i1N62jRb015488
	for <selinux@tycho.nsa.gov>; Mon, 23 Feb 2004 01:02:45 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i1N61BlK013540
	for <selinux@tycho.nsa.gov>; Mon, 23 Feb 2004 06:01:11 GMT
Received: from petrus.dynamic.digitasaru.net (hb6.lcom.net [216.51.236.182])
	by jazzswing.ncsc.mil  with ESMTP id i1N61BOX013519
	for <selinux@tycho.nsa.gov>; Mon, 23 Feb 2004 06:01:11 GMT
Date: Mon, 23 Feb 2004 00:02:23 -0600
From: Joseph Pingenot <trelane@digitasaru.net>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: identity
Message-ID: <20040223060220.GC9438@digitasaru.net>
Reply-To: trelane@digitasaru.net
References: <200402231535.26738.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200402231535.26738.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>From Russell Coker on Monday, 23 February, 2004:
>One of the benefits of the SE Linux identity is that it tracks the originating 
>user through all operations that they perform.
>With the user_u identity the utility of the identity for logging user 
>activities is reduced.
>Some people are talking about ways of tracking the source IP address for a ssh 
>connection or other information on the login through user sessions in a 
>similar manner.
>It seems to me that we would gain a benefit if we had two parts to the 
>identity string, the user-name that is compiled into the policy (and checked 
>in the constraints file etc), and an arbitary string set by the login program 
>or other equally privileged processes to be used for logging.
>The idea is to have something like rjc#10.0.0.1:user_r:user_t to indicate that 
>I logged in from IP address 10.0.0.1.
>Steve, what do you think?

Sorry.  Not Steve here.  :)

Sounds like a good idea.  One question:
Could you also record a signature of the data?  This would help distinguish
       processes who aren't supposed to be letting users on the system
       (since they'd not have a valid signature).  That'd potentially
       be able to plug a standard usage of rooted systems: leave open a
       port to the outside world to log in from.

-Joseph

-- 
Joseph===============================================trelane@digitasaru.net
      Graduate Student in Physics, Freelance Free Software Developer

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
