Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k2F00B78013717
	for <selinux@tycho.nsa.gov>; Tue, 14 Mar 2006 19:00:11 -0500
Received: from mail.nagafix.co.uk (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k2F008iu013902
	for <selinux@tycho.nsa.gov>; Wed, 15 Mar 2006 00:00:09 GMT
Subject: Re: virtual SELinux appliances, automated test suites
From: Antoine Martin <antoine@nagafix.co.uk>
To: coderman <coderman@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <4ef5fec60602281726j2895cdcfwdc10696c1c081560@mail.gmail.com>
References: <4ef5fec60602281726j2895cdcfwdc10696c1c081560@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 14 Mar 2006 23:59:40 +0000
Message-Id: <1142380780.16395.10.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-02-28 at 17:26 -0800, coderman wrote:
> there have been some interesting discussions in the past here and
> elsewhere related to combining virtual machines and SELinux enabled
> operating system instances. (open source NetTop where virtual
> instances also apply SELinux policy internally?) [1] [2] [3]
http://uml.nagafix.co.uk/SELinux/

> the various User Mode Linux images which support SELinux policy are
> relevant though i would prefer a stronger xen/vmware isolation between
> virtual instances. [6] [7]
What makes you think that the isolation with UML is weaker than
xen/vmware? Have you looked at skas0 (and skas3 without procmm) ?
On the page above you can also find some policies for containing the UML
instance on the host using SELinux. (as well as running SELinux in the
guest)

Antoine


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
