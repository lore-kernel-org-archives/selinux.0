Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7KCL8rT003258
	for <selinux@tycho.nsa.gov>; Fri, 20 Aug 2004 08:21:08 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7KCL7Q4023789
	for <selinux@tycho.nsa.gov>; Fri, 20 Aug 2004 12:21:07 GMT
Subject: Re: distro.tun
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200408202215.52503.russell@coker.com.au>
References: <200408192333.25072.russell@coker.com.au>
	 <200408201459.47366.russell@coker.com.au>
	 <1093002687.16585.34.camel@moss-spartans.epoch.ncsc.mil>
	 <200408202215.52503.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1093004388.16585.60.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 20 Aug 2004 08:19:49 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-08-20 at 08:15, Russell Coker wrote:
> I think that there is a need to shout.  As there is currently no upper-case 
> used in the policy the chance of someone using the string "USING_REDHAT" or 
> "DISTRO_REDHAT" is lower than that of "using_redhat" or "distro_redhat".

This rationale would lead us to uppercasing all tunables and possibly
even the program used flags.  Overkill.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
