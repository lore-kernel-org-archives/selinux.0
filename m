Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9KHnFWt021541
	for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2003 13:49:15 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9KHnEmR019873
	for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2003 17:49:14 GMT
Received: from extern.mail.waldi.eu.org (wavehammer.waldi.eu.org [82.139.196.55])
        by jazzband.ncsc.mil  with ESMTP id h9KHnDjp019861 for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2003 17:49:13 GMT
Date: Mon, 20 Oct 2003 19:49:05 +0200
From: Bastian Blank <bastian+selinux=tycho.nsa.gov@waldi.eu.org>
To: selinux@tycho.nsa.gov
Subject: Re: libselinux.so.1 and some utils shouldn't be in /usr
Message-ID: <20031020174905.GA25624@wavehammer.waldi.eu.org>
References: <20031018113455.GA22140@wavehammer.waldi.eu.org> <200310190035.06420.russell@coker.com.au> <20031019121044.GA29052@wavehammer.waldi.eu.org> <200310192301.20068.russell@coker.com.au> <1066654911.22196.7.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1066654911.22196.7.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Oct 20, 2003 at 09:01:51AM -0400, Stephen Smalley wrote:
>                     Instead, a patch by Dan Walsh (available from his
> SRPM, under ftp://people.redhat.com/dwalsh/SELinux/srpms) was merged to
> only install libselinux.so to /lib, and his spec file was
> correspondingly adjusted.

hmm, is it possible to merge such things in the public cvs?

bastian

-- 
Suffocating together ... would create heroic camaraderie.
		-- Khan Noonian Singh, "Space Seed", stardate 3142.8

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
