Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5UMukgA027386
	for <selinux@tycho.nsa.gov>; Thu, 30 Jun 2005 18:56:47 -0400 (EDT)
Received: from e1.ny.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5UMtefl008823
	for <selinux@tycho.nsa.gov>; Thu, 30 Jun 2005 22:55:40 GMT
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id j5UMtcLL005214
	for <selinux@tycho.nsa.gov>; Thu, 30 Jun 2005 18:55:38 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j5UMtclF240238
	for <selinux@tycho.nsa.gov>; Thu, 30 Jun 2005 18:55:38 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11/8.13.3) with ESMTP id j5UMtbEP003434
	for <selinux@tycho.nsa.gov>; Thu, 30 Jun 2005 18:55:38 -0400
Date: Thu, 30 Jun 2005 18:01:26 -0500
From: serue@us.ibm.com
To: Greg KH <greg@kroah.com>
Cc: linux-security-module@wirex.com, SELinux <selinux@tycho.nsa.gov>
Subject: Re: RFC: jail functionality
Message-ID: <20050630230126.GA24203@serge.austin.ibm.com>
References: <20050629161409.GB16233@serge.austin.ibm.com> <20050630054433.GA23147@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050630054433.GA23147@kroah.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting Greg KH (greg@kroah.com):
> On Wed, Jun 29, 2005 at 11:14:09AM -0500, serue@us.ibm.com wrote:
> > Hi,
> > 
> > I'd still like to see bsdjail/vserver/zone functionality in linux.  It
> > seems to me the following pieces are needed:
> > 
> > 	more?
> 
> /sbin/hotplug and/or kevents.

Thanks - I can't even imagine what the issues would be.  I'll need to
look at their architectures in more detail.

> I spent a few hours with one of the authors of the bsd jail code talking
> about this and in the end, he just laughed and said "good luck."  He
> also admitted that this was one of the reasons bsd wouldn't get such an
> event notifier subsystem, so I figured it was a fair trade off.

I wonder how/whether it's working under linux-vserver.

I'll have to look into these.

thanks,
-serge

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
