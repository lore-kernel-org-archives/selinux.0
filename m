Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id QAA00177
	for <selinux@tycho.nsa.gov>; Mon, 5 Feb 2001 16:18:57 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id VAA20003
	for <selinux@tycho.nsa.gov>; Mon, 5 Feb 2001 21:18:55 GMT
Received: from sentry.gw.tislabs.com (relay.hq.tis.com [192.94.214.100])
	by jazzband.ncsc.mil  with ESMTP id VAA19999
	for <selinux@tycho.nsa.gov>; Mon, 5 Feb 2001 21:18:55 GMT
Date: Mon, 5 Feb 2001 16:17:31 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Dustin Reyes <crusader@linuxgames.com>
cc: selinux@tycho.nsa.gov
Subject: Re: Division of Labor?
In-Reply-To: <20010203103643.A27767@linuxgames.com>
Message-ID: <Pine.SOL.3.95.1010205160245.1067A-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>


> What's the current division of labor for knocking out the remaining
> portions of the TODO list (http://www.nsa.gov/selinux/todo.html)?

Currently, Tim Fraser and I are finishing up a port of the kernel
changes to the 2.4.1 kernel.  As part of that port, I've also
revised the implementation of the file mandatory access controls
in preparation for implementing labeling and controls for NFS.

> How are external patches being evaluated?

We haven't received much in the way of external patches.
There were a few patches posted to this mailing list 
as fixes to the last release.

--
Stephen D. Smalley, NAI Labs
sds@tislabs.com



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
