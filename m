Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4AFosU6001210
	for <selinux@tycho.nsa.gov>; Thu, 10 May 2007 11:50:54 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4AFoqaY004079
	for <selinux@tycho.nsa.gov>; Thu, 10 May 2007 15:50:53 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l4AFoqHT029418
	for <selinux@tycho.nsa.gov>; Thu, 10 May 2007 11:50:52 -0400
Received: from pobox-2.corp.redhat.com (pobox-2.corp.redhat.com [10.11.255.15])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l4AFoleT028555
	for <selinux@tycho.nsa.gov>; Thu, 10 May 2007 11:50:47 -0400
Subject: Re: Making Fedora a contributer friendly environment
From: Karl MacMillan <kmacmill@redhat.com>
To: Development discussions related to Fedora Core <fedora-devel-list@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <46433B4D.1050304@city-fan.org>
References: <1178291788.2702.10.camel@vorpal.macdev.com>
	 <200705091725.58679.opensource@till.name>
	 <1178805305.17816.29.camel@localhost.localdomain>
	 <200705101650.50233.opensource@till.name>  <46433B4D.1050304@city-fan.org>
Content-Type: text/plain
Date: Thu, 10 May 2007 11:50:46 -0400
Message-Id: <1178812246.24335.38.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-05-10 at 16:33 +0100, Paul Howarth wrote:
> Till Maas wrote:
> > On Do Mai 10 2007, Karl MacMillan wrote:
> > 

[...]

> > 
> > I would be happy, if I am wrong with this. But if this problem is not solvable 
> > with semanage, imho semanage is not a good way to add selinux support to a 
> > package.
> 
> I agree entirely, and would advocate using a policy module instead of 
> semanage, even if all the module contains are file contexts and no rules 
> (you may need a dummy rule that duplicates an existing one to get the 
> module to build and install properly though). Policy modules have 
> versioning built in and so upgrades work as expected. It's just a lot 
> more work to package them.
> 

I'm not convinced of this yet, but I can be. The modules seem like
overkill in many ways, though we could make it possible to make a file
context only module. That would ease some of the pain.

> For simple context fixes, getting them into the main selinux-policy 
> package is almost certainly the best and least hassle method though.
> 

Agreed.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
