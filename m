Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA14524
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2001 12:51:52 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil (8.9.1/8.9.1) with ESMTP id RAA03267
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2001 17:51:16 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzband.ncsc.mil (8.9.1/8.9.1) with ESMTP id RAA03263
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2001 17:51:15 GMT
Received: from coalstove.epoch.ncsc.mil (coalstove [144.51.25.13])
	by epoch.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA11454
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2001 12:51:43 -0500 (EST)
Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA13737
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2001 11:47:54 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil (8.9.1/8.9.1) with ESMTP id QAA00191
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2001 16:47:18 GMT
Received: from ns.caldera.de (ns.caldera.de [212.34.180.1])
	by jazzband.ncsc.mil (8.9.1/8.9.1) with ESMTP id QAA00186
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2001 16:47:17 GMT
Date: Thu, 11 Jan 2001 17:46:29 +0100
From: Christoph Hellwig <hch@ns.caldera.de>
To: Huagang Xie <xie@gnuchina.org>
Cc: Stephen Smalley <sds@tislabs.com>,
        Jeffry Smith <smith@missioncriticallinux.com>, selinux@tycho.nsa.gov,
        linux-privs-discuss@sourceforge.net
Subject: Re: [Linux-privs-discuss] Re: SELinux & Linux-privs projects
Message-ID: <20010111174629.A11158@caldera.de>
References: <Pine.SOL.3.95.1010111095226.23465N-100000@clipper.gw.tislabs.com> <Pine.LNX.4.21.0101120029450.3618-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.21.0101120029450.3618-100000@localhost.localdomain>; from xie@gnuchina.org on Fri, Jan 12, 2001 at 12:42:56AM +0800
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

On Fri, Jan 12, 2001 at 12:42:56AM +0800, Huagang Xie wrote:
> 
> 
> In fact, the LIDS project(www.lids.org) extend the capability usage to
> integrit in a MAC way. You can disable a capability world width and give 
> the capability to the needed program( label the capability to a
> subject).  

It's rather ugly compared to real filesystem capabilities and even
the elfcap hack.

	Christoph

-- 
Whip me.  Beat me.  Make me maintain AIX.


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
