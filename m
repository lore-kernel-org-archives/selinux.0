Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA19902
	for <selinux@tycho.nsa.gov>; Sun, 24 Dec 2000 09:40:20 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id OAA11455
	for <selinux@tycho.nsa.gov>; Sun, 24 Dec 2000 14:39:08 GMT
Received: from maynard.mail.mindspring.net (maynard.mail.mindspring.net [207.69.200.243])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id OAA11449
	for <selinux@tycho.nsa.gov>; Sun, 24 Dec 2000 14:39:07 GMT
Received: from ix.netcom.com (user-2ive2n2.dialup.mindspring.com [165.247.10.226])
	by maynard.mail.mindspring.net (8.9.3/8.8.5) with ESMTP id JAA09421
	for <selinux@tycho.nsa.gov>; Sun, 24 Dec 2000 09:40:17 -0500 (EST)
Message-ID: <3A460ADB.9B1F96C5@ix.netcom.com>
Date: Sun, 24 Dec 2000 09:40:27 -0500
From: Jacques Richer <jpricher@ix.netcom.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: Linux setuid bug
References: <3A455AF2.A544580A@ix.netcom.com> <20001224123540.D8325@lemuria.org>
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
Reply-To: selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

Tom wrote:

> On Sat, Dec 23, 2000 at 09:09:54PM -0500, Jacques Richer wrote:
> > It didn't look like they did _anything_ to the code beyond the changes
> > needed for "flask". I think this was a very clear decision on their
> > part.
>
> second that. from what I've seen in the patchfiles, the only actual
> changes were to implement the domain/role concept. which, I believe, is
> a good thing since it means you can much more easily merge these
> changes with other security fixes that have happened in the meantime
> (or will happen in the near future).
>
> what I'd like to know is whether there's been any code auditing during
> the development. did anyone at NSA look for security problems within
> the kernel and/or user-space programs they have been working on?
>
> --
> -- http://www.lemuria.org
> -- http://www.Nexus-Project.net
> --
> You have received this message because you are subscribed to the selinux list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.

The notes on their website indicate that they have _not_ done a comprehensive
audit, and
that this was only a patch to address one set of issues.

                                Jacques Richer


You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
