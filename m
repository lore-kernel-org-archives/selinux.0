Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA15390
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2001 14:24:51 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil (8.9.1/8.9.1) with ESMTP id TAA07432
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2001 19:24:14 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzband.ncsc.mil (8.9.1/8.9.1) with ESMTP id TAA07424
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2001 19:24:14 GMT
Received: from coalstove.epoch.ncsc.mil (coalstove [144.51.25.13])
	by epoch.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA11809
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2001 14:24:47 -0500 (EST)
Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA15173
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2001 13:59:45 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id SAA19008
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2001 18:58:18 GMT
Received: from ns.caldera.de (ns.caldera.de [212.34.180.1])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id SAA19004
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2001 18:58:16 GMT
Date: Thu, 11 Jan 2001 19:59:32 +0100
From: Christoph Hellwig <hch@ns.caldera.de>
To: Stephen Smalley <sds@tislabs.com>
Cc: Casey Schaufler <casey@sgi.com>, selinux@tycho.nsa.gov,
        linux-privs-discuss@sourceforge.net
Subject: Re: [Linux-privs-discuss] SELinux & Linux-privs projects
Message-ID: <20010111195932.C27591@caldera.de>
References: <3A5DEEFB.6C988852@sgi.com> <Pine.SOL.3.95.1010111132105.23465e-100000@clipper.gw.tislabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.SOL.3.95.1010111132105.23465e-100000@clipper.gw.tislabs.com>; from sds@tislabs.com on Thu, Jan 11, 2001 at 01:31:44PM -0500
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

On Thu, Jan 11, 2001 at 01:31:44PM -0500, Stephen Smalley wrote:
> > That's because those are the only operations POSIX systems
> > support! It's implicit in being a POSIX (DRAFT) standard.
> 
> You can define distinct operations (permissions) in the
> mandatory security policy for distinct kernel services
> without altering the interfaces or behavior for discretionary
> access controls. 

Sure you can.  But Posix 1003.1e is designed to fit nicely into
a UNIX/Posix enviroment.  And that's exactly why I like it.

> As discussed ad nauseum on the robust open source mailing list,
> Type Enforcement is desirable for its support for ensuring that
> applications are unbypassable and tamperproof, that processes
> with any sort of privileges cannot execute untrustworthy
> code, and for providing least privilege.

For this you have capabilities.  Look at the allowed set in filesystem
capabilities.  That's another fine part of Posix 1003.1e: it seperates
cleanly what does not belong together.

	Christoph

-- 
Whip me.  Beat me.  Make me maintain AIX.


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
