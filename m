Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l19EdOge022477
	for <selinux@tycho.nsa.gov>; Fri, 9 Feb 2007 09:39:24 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l19EeVh4006430
	for <selinux@tycho.nsa.gov>; Fri, 9 Feb 2007 14:40:32 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l19EeSjH023828
	for <selinux@tycho.nsa.gov>; Fri, 9 Feb 2007 09:40:28 -0500
Received: from pobox-2.corp.redhat.com (pobox-2.corp.redhat.com [10.11.255.15])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l19EeSQt029451
	for <selinux@tycho.nsa.gov>; Fri, 9 Feb 2007 09:40:28 -0500
Received: from [10.11.14.183] (vpn-14-183.rdu.redhat.com [10.11.14.183])
	by pobox-2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l19EeRoJ018025
	for <selinux@tycho.nsa.gov>; Fri, 9 Feb 2007 09:40:28 -0500
Message-ID: <45CC87EE.9020407@mentalrootkit.com>
Date: Fri, 09 Feb 2007 09:40:46 -0500
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: MITRE releases Polgen 1.4
References: <1169394672.10741.2.camel@zeroKnowledge> <m2lkj8tdn2.fsf@dreaming.mitre.org>
In-Reply-To: <m2lkj8tdn2.fsf@dreaming.mitre.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Brian T. Sniffen wrote:
> 
> Polgen handles the modularity of reference policy by searching through
> .if files to find interfaces that will handle access requirements of
> the program under analysis.  The technique used appears complementary
> to Karl MacMillan's Madison library.

Can you point me to the implementation inside of polgen? It would seem 
to be nice to merge this functionality into a single upstream 
implementation. Do you have any interest in pursuing this?

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
