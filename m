Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA26807
	for <selinux@tycho.nsa.gov>; Mon, 3 Dec 2001 15:22:58 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id UAA04338
	for <selinux@tycho.nsa.gov>; Mon, 3 Dec 2001 20:22:54 GMT
Received: from sentry.gw.tislabs.com (relay.hq.tis.com [192.94.214.100] (may be forged))
	by jazzswing.ncsc.mil  with ESMTP id UAA04334
	for <selinux@tycho.nsa.gov>; Mon, 3 Dec 2001 20:22:53 GMT
Date: Mon, 3 Dec 2001 15:22:00 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Justin Smith <jsmith@mcs.drexel.edu>
cc: <selinux@tycho.nsa.gov>
Subject: Re: X windows with i810 chip
In-Reply-To: <1007409909.1588.0.camel@vorpal>
Message-ID: <Pine.GSO.4.33.0112031518560.4293-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On 3 Dec 2001, Justin Smith wrote:

> Yes, I saw the reason for this problem. The file_contexts listing
> only assigns xserver_t to /usr/X11R6/bin/Xwrapper when many systems name
> the X server X or XFree86 (mine does the latter). I assigned  the
> xserver_t type to both of these files and it solved the problem.

On my RH7.1 systems, the real X server is in /usr/X11R6/bin/XFree86, but
it must be executed via a setuid wrapper program, /usr/X11R6/bin/Xwrapper.
Hence, we put the xserver_exec_t type on the wrapper program rather than
the server.  /usr/X11R6/bin/X is a symbolic link to Xwrapper.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
