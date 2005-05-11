Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4BKg9gA021725
	for <selinux@tycho.nsa.gov>; Wed, 11 May 2005 16:42:09 -0400 (EDT)
Subject: Re: [RFC]{Patch 0/5] Polyinstantation
From: Chad Sellers <cdselle@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <42826782.9040108@redhat.com>
References: <1115825335.28084.27.camel@moss-huskies.epoch.ncsc.mil>
	 <42826782.9040108@redhat.com>
Content-Type: text/plain
Date: Wed, 11 May 2005 16:40:45 -0400
Message-Id: <1115844045.28698.30.camel@moss-huskies.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-05-11 at 16:13 -0400, Daniel J Walsh wrote:

> Why are you still sharing the /tmp directory within the same roles.  I 
> think it would be preferable to
> not share at all.  This would protect one user_u from another.   
This code does polyinstantiation by context, thereby separating one
context from another.  Are you suggesting separating entities within the
same context from one another?  Meaning that the member directory chosen
would be dependent on the source user, role, type, level, compartment,
and uid/unix username?

> How are 
> you handling system sockets?
> /tmp/.X11-unix/
> /tmp/.X0-lock
> I think postrgres also puts stuff out there.
Yes, this is a pain.  The problem with directories like /tmp and $HOME
is that they have become global dumping places.  The problem with
breaking them up is that programs use that global dumping place as a
convenient way to connect to other programs.  So, you have sockfiles and
pipes that need to persist in multiple (but not all) member directories.
The library doesn't handle this stuff, and so I handle it in the
entrypoint patches (see the gdm patch or what happens if you pass -X to
the setupns command line utility).  This is one reason that I remount
the original directory elsewhere for security-aware (and allowed) apps
to access it.  The entrypoint program (say gdm) symlinks the necessary
files into the member directory.  If unionfs gets some upstream support,
it would provide a much more elegant way to do this.

I've only patched this to make X work.  I'm sure other programs (such as
postgres) might require similar modifications in order to work.

> 
> 
-- 
Chad Sellers
cdselle@tycho.nsa.gov


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
