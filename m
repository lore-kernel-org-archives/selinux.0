Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5PAQsgA013374
	for <selinux@tycho.nsa.gov>; Sat, 25 Jun 2005 06:26:54 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5PAQBs8011508
	for <selinux@tycho.nsa.gov>; Sat, 25 Jun 2005 10:26:11 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id j5PAQjf5021056
	for <selinux@tycho.nsa.gov>; Sat, 25 Jun 2005 06:26:45 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id j5PAQju03526
	for <selinux@tycho.nsa.gov>; Sat, 25 Jun 2005 06:26:45 -0400
Received: from [172.16.50.12] (vpn50-12.rdu.redhat.com [172.16.50.12])
	by mail.boston.redhat.com (8.12.8/8.12.8) with ESMTP id j5PAQic0026306
	for <selinux@tycho.nsa.gov>; Sat, 25 Jun 2005 06:26:45 -0400
Message-ID: <42BD31CE.9090908@redhat.com>
Date: Sat, 25 Jun 2005 06:28:30 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
CC: selinux@tycho.nsa.gov
Subject: Re: Alternative user management approach
References: <20050624225217.97028.qmail@web31614.mail.mud.yahoo.com>
In-Reply-To: <20050624225217.97028.qmail@web31614.mail.mud.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ok this all sounds good, but how do we come to a consensus. 

Do we need an "role attribute" to define "user" roles.

roleattribute staff_r user;
roleattribute user_r user;
roleattribute sysadm_r user;

Then do we need a mechanism in policy to associate roles with "user" roles?

How does all this work with MLS ranges?

Should we have a brainstorming session?  It is important to us (Red Hat) 
that we get this settled soon.

Do we have a new file which associates uids to user roles?

Dan


-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
