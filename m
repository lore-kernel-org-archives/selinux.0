Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hBB04xRb000934
	for <selinux@tycho.nsa.gov>; Wed, 10 Dec 2003 19:04:59 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hBB04DlU015825
	for <selinux@tycho.nsa.gov>; Thu, 11 Dec 2003 00:04:14 GMT
Received: from mozart.fwsystems.com (mozart.fwsystems.com [63.101.67.2])
	by jazzswing.ncsc.mil  with ESMTP id hBB049SX015822
	for <selinux@tycho.nsa.gov>; Thu, 11 Dec 2003 00:04:13 GMT
Received: from athena (athena.fwsystems.com [63.101.67.13])
	(authenticated bits=0)
	by mozart.fwsystems.com (8.12.8p1/8.12.8) with ESMTP id hBB04rAm048120
	for <selinux@tycho.nsa.gov>; Wed, 10 Dec 2003 19:04:53 -0500
Date: Wed, 10 Dec 2003 19:04:53 -0500
From: forrest whitcher <fw@fwsystems.com>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: changing root to default to sysadm_r
Message-Id: <20031210190453.6c39bbdb.fw@fwsystems.com>
In-Reply-To: <1071096702.4060.948.camel@hawaii.efficax.net>
References: <1071096702.4060.948.camel@hawaii.efficax.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Nick

I don't know why you're having problems changing it but I know why
it was/is set this way.

If root defaults to sysadm_r, then certain kinds of sshd exploits
(kinds that _heve_ been seen before) can get the attacker sysadm_r,
game over, not good.

The requirement to authenticate explicitly thru newrole intends to
to avoid this.

forrest




On Wed, 10 Dec 2003 16:51:42 -0600 (unchecked - local sync NTPstrat4)
Nick <nagray@austin.rr.com> did inscribe thusly:

> I thought I could do make root come up in the sysadm_r initially by
> changing the users.te file
> 
> diff users .users
> 42c42
> < user root roles { sysadm_r staff_r };
> ---
> > user root roles { staff_r sysadm_r };
> 
> and recompiling the policy.
> 
> Apparently not, suggestions! and comments why it is not this way
> already.
> 
> -- 
> Nick (Nix) Gray
> Senior Systems Engineer
> Bruzenak Inc.
> (512) 331-7998
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
