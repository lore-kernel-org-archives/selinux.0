Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA14482
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2001 12:49:47 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id RAA15428
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2001 17:48:19 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id RAA15423
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2001 17:48:19 GMT
Received: from coalstove.epoch.ncsc.mil (coalstove [144.51.25.13])
	by epoch.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA11403
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2001 12:49:42 -0500 (EST)
Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA13114
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2001 10:47:09 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil (8.9.1/8.9.1) with ESMTP id PAA27175
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2001 15:46:32 GMT
Received: from ns.caldera.de (ns.caldera.de [212.34.180.1])
	by jazzband.ncsc.mil (8.9.1/8.9.1) with ESMTP id PAA27171
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2001 15:46:31 GMT
Date: Thu, 11 Jan 2001 16:45:56 +0100
From: Christoph Hellwig <hch@ns.caldera.de>
To: Jeffry Smith <smith@missioncriticallinux.com>
Cc: selinux@tycho.nsa.gov, linux-privs-discuss@sourceforge.net
Subject: Re: [Linux-privs-discuss] SELinux & Linux-privs projects
Message-ID: <20010111164556.A2075@caldera.de>
References: <E14GiyE-0000nL-00@smith>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E14GiyE-0000nL-00@smith>; from smith@missioncriticallinux.com on Thu, Jan 11, 2001 at 09:44:54AM -0500
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

On Thu, Jan 11, 2001 at 09:44:54AM -0500, Jeffry Smith wrote:
> Sent to both lists
> Since I hadn't seen any traffic on the two lists about the other project, I 
> thought I'd cross-send a message, to ensure the two communities are aware of 
> what the other is doing.  I figure, although the projects are tackling 
> different parts of the security of linux, there should be some overlap, since 
> privileges should make it easier to do the type enforcement (I think), and the 

Linux-privs and other Posix1003.1e subsystems currenlty in development
for Linux provide a UNIXish way of trusted systems, while SELinux
implements ruleset-based security and is rather differnt and put
policy into the kernel, something that is dtringly disliked in UNIX.

So they are two rather different ways to archive the same goal.

	Christoph

-- 
Whip me.  Beat me.  Make me maintain AIX.


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
