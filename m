Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id GAA19589
	for <selinux@tycho.nsa.gov>; Sun, 24 Dec 2000 06:37:57 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id LAA07455
	for <selinux@tycho.nsa.gov>; Sun, 24 Dec 2000 11:36:45 GMT
Received: from mail.lemuria.org (www.lemuria.org [62.197.4.112])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id LAA07451
	for <selinux@tycho.nsa.gov>; Sun, 24 Dec 2000 11:36:43 GMT
Received: from unicorn.lemuria.org (p3ee2d5ca.dip.t-dialin.net [62.226.213.202])
	by mail.lemuria.org (Postfix) with ESMTP id 5C91627AE2
	for <selinux@tycho.nsa.gov>; Sun, 24 Dec 2000 12:36:23 +0100 (MET)
Date: Sun, 24 Dec 2000 12:35:41 +0100
From: Tom <tom@lemuria.org>
To: selinux@tycho.nsa.gov
Subject: Re: Linux setuid bug
Message-ID: <20001224123540.D8325@lemuria.org>
References: <3A455AF2.A544580A@ix.netcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3A455AF2.A544580A@ix.netcom.com>; from jpricher@ix.netcom.com on Sat, Dec 23, 2000 at 09:09:54PM -0500
Sender: owner-selinux@tycho.nsa.gov
Reply-To: selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

On Sat, Dec 23, 2000 at 09:09:54PM -0500, Jacques Richer wrote:
> It didn't look like they did _anything_ to the code beyond the changes
> needed for "flask". I think this was a very clear decision on their
> part.

second that. from what I've seen in the patchfiles, the only actual
changes were to implement the domain/role concept. which, I believe, is
a good thing since it means you can much more easily merge these
changes with other security fixes that have happened in the meantime
(or will happen in the near future).

what I'd like to know is whether there's been any code auditing during
the development. did anyone at NSA look for security problems within
the kernel and/or user-space programs they have been working on?



-- 
-- http://www.lemuria.org
-- http://www.Nexus-Project.net
--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
