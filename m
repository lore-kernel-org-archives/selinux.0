Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6LID3gA028569
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 14:13:03 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6LI8Org029986
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 18:08:25 GMT
Subject: Re: [ libsepol 2/6] Ports
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: Joshua Brindle <jbrindle@tresys.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <42DFE3B6.7070402@tresys.com>
References: <1121967601.9844.26.camel@celtics.boston.redhat.com>
	 <42DFE3B6.7070402@tresys.com>
Content-Type: text/plain
Date: Thu, 21 Jul 2005 14:06:00 -0400
Message-Id: <1121969160.9844.54.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-07-21 at 14:04 -0400, Joshua Brindle wrote:
> Ivan Gyurdiev wrote:
> 
> >The following patch pushes the port loading
> >code into libsepol. It adds a function to
> >load a port, and a function to get the context
> >for a port. No shadowing is allowed. It creates
> >a structure for high level representation of
> >a port (sepol_portinfo_t). Uses new debug system
> >and writes to policydb object. Comments welcome.
> >
> >libsepol-1.2-ports.diff
> >
> >This patch depends on:
> >libsepol-1.1-context.diff
> >  
> >
> This probably belongs in libsemanage. I'm trying to get a comprehensive 
> API and set of structs so that you can start writing the port and user 
> code with respect to it. I'll try to get this out later today.

There are two chunks to every piece - the data source chunk, file
iteration, transactions, and opaque-structure API go into libsemanage...

Then the part that actually modifies policy goes into libsepol, in
order to keep things self-contained.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
