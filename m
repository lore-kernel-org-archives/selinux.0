Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA28497
	for <selinux@tycho.nsa.gov>; Fri, 15 Mar 2002 09:11:07 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA11415
	for <selinux@tycho.nsa.gov>; Fri, 15 Mar 2002 14:10:04 GMT
Received: from sentry.gw.tislabs.com (firewall-user@sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id OAA11411 for <selinux@tycho.nsa.gov>; Fri, 15 Mar 2002 14:10:04 GMT
Date: Fri, 15 Mar 2002 09:10:15 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: stat now supports SE Linux in the upstream
In-Reply-To: <20020314210721.E851B1A005@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0203150900430.15480-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 14 Mar 2002, Russell Coker wrote:

> The latest version of stat has SE Linux support, so there's probably no need
> for the patch on the NSA site, just a reference that version 3.1 is needed.

This is good to hear - I take it that you submitted the SELinux changes to
the stat maintainer?  If so, then thanks.  One caveat:  the utility
modifications aren't necessarily in the form that I would like to see
mainstreamed (many of them were done as quick learning exercises by
others, and we haven't cleaned them up).  For example, some of the modified
utilities use a fixed size buffer for the security context and fail if the
buffer size is too small rather than resizing and trying again.  See the
sid_to_context test program for how to correctly handle this.

We're likely to continue distributing our modified stat until the new
version is picked up by RedHat as a convenience to our users.

> There is a bug in displaying the context though, the following patch fixes it.

I assume that you've submitted this patch to the stat maintainer.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
