Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9JHs5xq013776
	for <selinux@tycho.nsa.gov>; Thu, 19 Oct 2006 13:54:05 -0400
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k9JHqesZ016912
	for <selinux@tycho.nsa.gov>; Thu, 19 Oct 2006 17:52:40 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.7/8.13.7) with ESMTP id k9JHrTtp002316
	for <selinux@tycho.nsa.gov>; Thu, 19 Oct 2006 13:53:29 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.7/8.13.7/Submit) id k9JHrTtY002315
	for selinux@tycho.nsa.gov; Thu, 19 Oct 2006 13:53:29 -0400
Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9JDRRNA004419
	for <selinux@tycho.nsa.gov>; Thu, 19 Oct 2006 09:27:27 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k9JDQhwO022448
	for <selinux@tycho.nsa.gov>; Thu, 19 Oct 2006 13:26:44 GMT
Message-ID: <45377BF0.6010403@redhat.com>
Date: Thu, 19 Oct 2006 09:21:52 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: casey@schaufler-ca.com
CC: russell@coker.com.au, redhat-lspp@redhat.com, selinux@tycho.nsa.gov
Subject: Re: [redhat-lspp] Re: MLS enforcing PTYs, sshd, and newrole
References: <20061012153701.75777.qmail@web36603.mail.mud.yahoo.com>
In-Reply-To: <20061012153701.75777.qmail@web36603.mail.mud.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

So one proposed solution to this is to take away the newrole -l 
functionality all together and to add Sensitivity selection to the local 
login. 

We can implement pam_selinux to ask for the sensitivity level


username: dwalsh
passwd: ********
Sensitivity: SystemLow

If we then remove -l from newrole we are done?

Dan

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
