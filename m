Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m08NHvtu026064
	for <selinux@tycho.nsa.gov>; Tue, 8 Jan 2008 18:17:57 -0500
Received: from g4t0016.houston.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m08NHtEC001729
	for <selinux@tycho.nsa.gov>; Tue, 8 Jan 2008 23:17:56 GMT
Received: from g4t0016.houston.hp.com (localhost.localdomain [127.0.0.1])
	by receive-from-antispam-filter (Postfix) with SMTP id E02611449C
	for <selinux@tycho.nsa.gov>; Tue,  8 Jan 2008 23:17:55 +0000 (UTC)
Received: from smtp2.fc.hp.com (smtp2.fc.hp.com [15.11.136.114])
	by g4t0016.houston.hp.com (Postfix) with ESMTP id D591E14190
	for <selinux@tycho.nsa.gov>; Tue,  8 Jan 2008 23:17:55 +0000 (UTC)
Received: from ldl.fc.hp.com (ldl.fc.hp.com [15.11.146.30])
	by smtp2.fc.hp.com (Postfix) with ESMTP id 754EF24FFB3
	for <selinux@tycho.nsa.gov>; Tue,  8 Jan 2008 23:17:55 +0000 (UTC)
Received: from localhost (ldl.fc.hp.com [127.0.0.1])
	by ldl.fc.hp.com (Postfix) with ESMTP id 594DB134002
	for <selinux@tycho.nsa.gov>; Tue,  8 Jan 2008 16:17:55 -0700 (MST)
Received: from ldl.fc.hp.com ([127.0.0.1])
	by localhost (ldl.fc.hp.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1j8QhezuiDmJ for <selinux@tycho.nsa.gov>;
	Tue,  8 Jan 2008 16:17:52 -0700 (MST)
Received: from flek.americas.hpqcorp.net (flek.americas.hpqcorp.net [16.116.102.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by ldl.fc.hp.com (Postfix) with ESMTP id D0CE2134004
	for <selinux@tycho.nsa.gov>; Tue,  8 Jan 2008 16:17:51 -0700 (MST)
From: Paul Moore <paul.moore@hp.com>
To: selinux@tycho.nsa.gov
Subject: Re: [RFC PATCH v11 18/19] SELinux: Add network ingress and egress control permission checks
Date: Tue, 8 Jan 2008 18:17:50 -0500
References: <20080107174952.13733.68074.stgit@flek.americas.hpqcorp.net> <20080107175636.13733.35147.stgit@flek.americas.hpqcorp.net>
In-Reply-To: <20080107175636.13733.35147.stgit@flek.americas.hpqcorp.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200801081817.50884.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> +	/* If skb->dst->xfrm is non-NULL then the packet is undergoing an
> IPsec
> +	 * packet transformation so allow the packet to pass without 
> any checks
> +	 * since we'll have another chance to perform access 
> control checks
> +	 * when the packet is on it's final way out. */ 
> +	if (skb->dst->xfrm != NULL)
> +		return NF_ACCEPT;

Just in case anyone is playing with this right now, the if statement 
above is wrong, it should be:

 if (skb->dst != NULL && skb->dst->xfrm != NULL)
	return NF_ACCEPT;

... it turns out some IPv6 multicast code never sets skb->dst which 
causes some problems :)  I'll be delaying posting a new patchset for a 
few days to try and catch some more bugs, however, I have updated the 
git tree for those of you who are interested.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
