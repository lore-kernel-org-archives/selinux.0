Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6LI9cgA028473
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 14:09:38 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6LI50rg029718
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 18:05:00 GMT
Message-ID: <42DFE3B6.7070402@tresys.com>
Date: Thu, 21 Jul 2005 14:04:38 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: gyurdiev@redhat.com
CC: selinux@tycho.nsa.gov
Subject: Re: [ libsepol 2/6] Ports
References: <1121967601.9844.26.camel@celtics.boston.redhat.com>
In-Reply-To: <1121967601.9844.26.camel@celtics.boston.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:

>The following patch pushes the port loading
>code into libsepol. It adds a function to
>load a port, and a function to get the context
>for a port. No shadowing is allowed. It creates
>a structure for high level representation of
>a port (sepol_portinfo_t). Uses new debug system
>and writes to policydb object. Comments welcome.
>
>libsepol-1.2-ports.diff
>
>This patch depends on:
>libsepol-1.1-context.diff
>  
>
This probably belongs in libsemanage. I'm trying to get a comprehensive 
API and set of structs so that you can start writing the port and user 
code with respect to it. I'll try to get this out later today.

Joshua

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
