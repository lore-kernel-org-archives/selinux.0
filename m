Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA25572
	for <selinux@tycho.nsa.gov>; Tue, 23 Apr 2002 08:25:53 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id MAA24217
	for <selinux@tycho.nsa.gov>; Tue, 23 Apr 2002 12:24:07 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id MAA24213
	for <selinux@tycho.nsa.gov>; Tue, 23 Apr 2002 12:24:07 GMT
Date: Tue, 23 Apr 2002 08:25:14 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Chad Nantais <cnantais@rednaxel.com>
cc: <selinux@tycho.nsa.gov>
Subject: Re: NSA Web Site - available?
In-Reply-To: <3CC46C1F.1000103@rednaxel.com>
Message-ID: <Pine.GSO.4.33.0204230818140.18931-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Mon, 22 Apr 2002, Chad Nantais wrote:

> I have been trying to reach the NSA web site for days.  Is it down from
> anyone else's point of view?

Yes, the NSA site seems inaccessible from here as well.  Until they get
it fixed, if you need to obtain a copy of the last public release of
SELinux, you can download a copy from the sourceforge selinux
project site's CVS tree, e.g.

CVSROOT=:pserver:anonymous@cvs.selinux.sourceforge.net:/cvsroot/selinux
cvs -z3 co nsa

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com






--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
