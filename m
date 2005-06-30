Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5U5k8gA019478
	for <selinux@tycho.nsa.gov>; Thu, 30 Jun 2005 01:46:08 -0400 (EDT)
Received: from perch.kroah.org (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5U5jAfl017550
	for <selinux@tycho.nsa.gov>; Thu, 30 Jun 2005 05:45:10 GMT
Date: Wed, 29 Jun 2005 22:44:33 -0700
From: Greg KH <greg@kroah.com>
To: serue@us.ibm.com
Cc: linux-security-module@wirex.com, SELinux <selinux@tycho.nsa.gov>
Subject: Re: RFC: jail functionality
Message-ID: <20050630054433.GA23147@kroah.com>
References: <20050629161409.GB16233@serge.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050629161409.GB16233@serge.austin.ibm.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Jun 29, 2005 at 11:14:09AM -0500, serue@us.ibm.com wrote:
> Hi,
> 
> I'd still like to see bsdjail/vserver/zone functionality in linux.  It
> seems to me the following pieces are needed:
> 
> 	more?

/sbin/hotplug and/or kevents.

I spent a few hours with one of the authors of the bsd jail code talking
about this and in the end, he just laughed and said "good luck."  He
also admitted that this was one of the reasons bsd wouldn't get such an
event notifier subsystem, so I figured it was a fair trade off.

Oh, and devfs in a jail is a pain in the ass, but if you solve the
hotplug/kevent issue, you can just use udev to handle that.

Good luck,

greg k-h

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
