Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9KFurWt020628
	for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2003 11:56:53 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9KFuf0p009743
	for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2003 15:56:41 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h9KFuer7009740
	for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2003 15:56:40 GMT
Subject: Re: libselinux.so.1 and some utils shouldn't be in /usr
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Thorsten Kukuk <kukuk@suse.de>
Cc: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <20031020153720.GA29503@suse.de>
References: <20031018113455.GA22140@wavehammer.waldi.eu.org>
	 <200310190035.06420.russell@coker.com.au>
	 <20031019121044.GA29052@wavehammer.waldi.eu.org>
	 <200310192301.20068.russell@coker.com.au>
	 <20031019163501.GA26554@wavehammer.waldi.eu.org>
	 <20031020145526.H321@lemuria.org>  <20031020153720.GA29503@suse.de>
Content-Type: text/plain
Message-Id: <1066665402.22196.166.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 20 Oct 2003 11:56:42 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2003-10-20 at 11:37, Thorsten Kukuk wrote:
> Tom, don't be confused with the real library and the .so symlink.
> 
> The real library should be in /lib
> The .so link, which is only used for linking applications against
> this library and never for runtime, should reside in /usr/lib.

Ok, we'll have to fix this in the Makefile, as the current patch from
Dan Walsh causes both the real shared library and the .so link to be
created in /lib, with the static library in /usr/lib.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
