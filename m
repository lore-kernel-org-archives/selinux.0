Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k6S4JRZR011897
	for <selinux@tycho.nsa.gov>; Fri, 28 Jul 2006 00:19:27 -0400
Received: from mail1.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k6S4JNU8013200
	for <selinux@tycho.nsa.gov>; Fri, 28 Jul 2006 04:19:23 GMT
Date: Fri, 28 Jul 2006 00:19:24 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@parisplace.org>
cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, jbrindle@tresys.com
Subject: Re: [PATCH] SELinux: new /proc/self/attr/ipccreate for expliciteipc
 object labeling
In-Reply-To: <1154019529.5028.19.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0607280018180.13981@d.namei>
References: <6FE441CD9F0C0C479F2D88F959B015882989A9@exchange.columbia.tresys.com>
 <1154019529.5028.19.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 27 Jul 2006, Eric Paris wrote:

> At this point in time SysV IPC objects (semaphores, message queues, etc)
> are labeled with the label of the process which created them.  This
> patch introduces a new /proc/self/attr/ipccreate which will allow a
> program to set the label on ipc objects it is about to create.  This may
> be useful in future trusted applications but at this time I do not know
> of any application which needs this functionality.

This makes it difficult to justify upstream.



-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
