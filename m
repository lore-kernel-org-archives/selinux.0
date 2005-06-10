Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5A2IigA015499
	for <selinux@tycho.nsa.gov>; Thu, 9 Jun 2005 22:18:45 -0400 (EDT)
Received: from sccrmhc12.comcast.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5A2BDpU008897
	for <selinux@tycho.nsa.gov>; Fri, 10 Jun 2005 02:11:13 GMT
Message-ID: <42A8F6C1.20106@tresys.com>
Date: Thu, 09 Jun 2005 22:11:13 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: gyurdiev@redhat.com
CC: Daniel J Walsh <dwalsh@redhat.com>, SELinux <selinux@tycho.nsa.gov>,
   selinux-dev@tresys.com
Subject: Re: Restorecon script
References: <1118328119.29360.4.camel@dhcp83-8.boston.redhat.com>
In-Reply-To: <1118328119.29360.4.camel@dhcp83-8.boston.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:

>Any comments on the following script?
>It's a profile script, to be shipped with selinux-policy-strict, 
>executed per login shell. It hardcodes the applications, 
>unfortunately, but does what we want for right now 
>(at least a temp. solution, unless someone has a better one?)
>Also, user needs to start a login shell to get it to run.
>  
>
What problem is this solving? In general relabeling isn't something that 
should be done without careful attention, especially when automated. 
User home directories shouldn't have incorrect labels is care is taken 
(ie, skel contains the directories you'd be relabeling anyway and they 
are labeled correctly when the user is added).

Joshua Brindle

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
