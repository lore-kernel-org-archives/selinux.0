Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hA6LfQSf020477
	for <selinux@tycho.nsa.gov>; Thu, 6 Nov 2003 16:41:26 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hA6Lf21W007473
	for <selinux@tycho.nsa.gov>; Thu, 6 Nov 2003 21:41:03 GMT
Received: from moss-tarheels.epoch.ncsc.mil (moss-tarheels.epoch.ncsc.mil [144.51.25.3])
	by jazzswing.ncsc.mil  with ESMTP id hA6Lf25e007470
	for <selinux@tycho.nsa.gov>; Thu, 6 Nov 2003 21:41:02 GMT
Subject: Re: XWindows, trust, EROS
From: Eamon Walsh <ewalsh@epoch.ncsc.mil>
To: Brian May <bam@snoopy.apana.org.au>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20031106065548.GA6956@snoopy.apana.org.au>
References: <20031106065548.GA6956@snoopy.apana.org.au>
Content-Type: text/plain
Message-Id: <1068154876.5193.41.camel@moss-tarheels.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 06 Nov 2003 16:41:16 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

There seem to be two schools of thought on how to manage client objects
inside a trusted X server.  

One is to simply apply the same restrictions to all X clients, which
seems to be the approach taken in the EROS post.  (The concept of giving
a key to each client which they can then give to other clients allowing 
window sharing is new to me, though.  Interesting). 

The other approach is to have separate policy for each X client
application.  This what we eventually want for SELinux.  With this
approach the X server has to know which process is doing what.

I don't think it would be too hard to add kernel functionality to UNIX
domain sockets to find out the PID of the process talking to you.  This
would solve the problem for local clients.  For remote clients, however,
labeled networking will be needed as Bill describes (unless you assign a
default, restrictive policy to all remote clients).

--Eamon 

On Thu, 2003-11-06 at 01:55, Brian May wrote:
> Hello,
> 
> For some reason I thought EROS was dead, but the mailing lists
> seem to be strong...
> 
> Anyway, here is a discussion on X-Windows, trusted windows,
> untrusted windows, etc, which may/may not have implications here for
> people interested in using SE-Linux to limit access to "dangerous"
> X-Windows operations.
> 
> http://www.eros-os.org/pipermail/eros-arch/2003-November/003849.html
> 
> (Note: I haven't read this thread in detail myself yet).
> 
> (Note2: I apologize if this is already common knowledge or totally
> irrelevant...)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
