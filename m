Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA26747
	for <selinux@tycho.nsa.gov>; Mon, 3 Dec 2001 15:18:55 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id UAA10905
	for <selinux@tycho.nsa.gov>; Mon, 3 Dec 2001 20:18:15 GMT
Received: from sentry.gw.tislabs.com (relay.hq.tis.com [192.94.214.100] (may be forged))
	by jazzband.ncsc.mil  with ESMTP id UAA10901
	for <selinux@tycho.nsa.gov>; Mon, 3 Dec 2001 20:18:14 GMT
Date: Mon, 3 Dec 2001 15:18:42 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Justin Smith <jsmith@mcs.drexel.edu>
cc: <selinux@tycho.nsa.gov>
Subject: Re: X windows with i810 chip
In-Reply-To: <1007409909.1588.0.camel@vorpal>
Message-ID: <Pine.GSO.4.33.0112031509320.4293-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On 3 Dec 2001, Justin Smith wrote:

> I am now able to run X windows and even gdm, although gdm has some
> strange problems. When running under it, the newrole command gets the
> error message: 'unable to find user in passwd'. I do not get this
> message when running under ordinary X windows.

You should not use the unmodified gdm program, since it does not set the
security context for the user session.  If you want to use gdm, you'll
need the modified gdm program created by Mark Westerman.  He has a patch
for gdm that allows the user to select a security context from a menu and
that sets the security context appropriately.  I think that he has made it
available on his sourceforge selinux project site, although I'm not sure
if an up-to-date copy is available there at the moment.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
