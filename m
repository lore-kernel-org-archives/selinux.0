Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5GLu8rT006292
	for <selinux@tycho.nsa.gov>; Wed, 16 Jun 2004 17:56:08 -0400 (EDT)
Received: from gkgreen.dor.state.ma.us (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5GLu5ot016347
	for <selinux@tycho.nsa.gov>; Wed, 16 Jun 2004 21:56:05 GMT
Message-Id: <6.1.1.1.0.20040616175353.02db7030@dor-exchange.dor.state.ma.us>
Date: Wed, 16 Jun 2004 17:54:37 -0400
To: selinux@tycho.nsa.gov
From: "bmcmurphy@dor.state.ma.us" <bmcmurphy@dor.state.ma.us>
Subject: RBAC with Unix Groups/GUIDs
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

I think I know the answer to this, but is there any way in selinux to 
assign an entire group (GUID) to a selinux role instead of just adding 
individual users? We are using LDAP-based authentication and I'd like to be 
able to assign a GUID to a selinux role and be done with it, rather than 
having to muck with the selinux policy whenever I add a new user into the 
group. Maybe I'm missing something obvious. Wouldn't be the first time...

Cheers




**********************************************************************
This email and any files transmitted with it are confidential and 
intended solely for the use of the individual or entity to whom they   
are addressed. If you have received this email in error please notify 
the system manager at postmaster at dor.state.ma.us.
**********************************************************************


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
