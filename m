Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA16222
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2001 15:54:47 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id UAA24788
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2001 20:53:20 GMT
Received: from sentry.gw.tislabs.com (relay.hq.tis.com [192.94.214.100])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id UAA24784
	for <selinux@tycho.nsa.gov>; Thu, 11 Jan 2001 20:53:19 GMT
Date: Thu, 11 Jan 2001 15:54:04 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Christoph Hellwig <hch@ns.caldera.de>
cc: selinux@tycho.nsa.gov, linux-privs-discuss@sourceforge.net
Subject: Re: SELinux & Linux-privs projects
In-Reply-To: <20010111195932.C27591@caldera.de>
Message-ID: <Pine.SOL.3.95.1010111153918.23465v-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>


> For this you have capabilities.  Look at the allowed set in filesystem
> capabilities.  That's another fine part of Posix 1003.1e: it seperates
> cleanly what does not belong together.

A paper by Spencer Minear in this year's BSD Conference and Expo
provided a brief comparison of the POSIX.1e capability mechanism and
a BSD implementation of Type Enforcement.  You can find a copy under
http://www.bsdcon.com/proceedings/spencer_minear.  This ties in
with my earlier discussion of the advantages of using an
architecture like SELinux to provide similar functionality
to the capability mechanism, as was done in one of the predecessors
of SELinux (the DTOS system).  The paper also has some useful background
information on the development of Type Enforcement and its relationship to
MLS.  

--
Stephen D. Smalley, NAI Labs
sds@tislabs.com



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
