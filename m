Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA28596
	for <selinux@tycho.nsa.gov>; Thu, 4 Oct 2001 14:09:01 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id SAA01531
	for <selinux@tycho.nsa.gov>; Thu, 4 Oct 2001 18:07:16 GMT
Received: from sentry.gw.tislabs.com (relay.hq.tis.com [192.94.214.100] (may be forged))
	by jazzswing.ncsc.mil  with ESMTP id SAA01527
	for <selinux@tycho.nsa.gov>; Thu, 4 Oct 2001 18:07:15 GMT
Date: Thu, 4 Oct 2001 14:08:07 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Conan Callen <ccallen@windowpane.com>
cc: <selinux@tycho.nsa.gov>
Subject: Re: debugging tools
In-Reply-To: <Pine.LNX.4.33.0110041000330.15881-100000@localhost.localdomain>
Message-ID: <Pine.GSO.4.33.0110041359440.7555-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 4 Oct 2001, Conan Callen wrote:

> I want to start stepping through the selinux / lsm code so I can see what
> is happening. Does anyone have any recomendations on kernel debugging
> tools for doing this? I've been using vstudio on windows for years and the
> windows sdk debugger for working with kernel code. So far the only
> tool used on linux are emacs and vi ;)

Is this just a learning exercise or have you encountered a bug that you
want to track down?  If you really want some kind of kernel debugger, you
might try the SGI kGDB (see http://kgdb.sourceforge.net).

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
