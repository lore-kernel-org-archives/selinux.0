Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9KFbNWt020510
	for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2003 11:37:23 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9KFbMmR012419
	for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2003 15:37:22 GMT
Received: from Cantor.suse.de (ns.suse.de [195.135.220.2])
        by jazzband.ncsc.mil  with ESMTP id h9KFbLjp012416 for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2003 15:37:22 GMT
Received: from Hermes.suse.de (Hermes.suse.de [195.135.221.8])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by Cantor.suse.de (Postfix) with ESMTP id 13E5F17247FA
	for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2003 17:37:21 +0200 (CEST)
Date: Mon, 20 Oct 2003 17:37:20 +0200
From: Thorsten Kukuk <kukuk@suse.de>
To: selinux@tycho.nsa.gov
Subject: Re: libselinux.so.1 and some utils shouldn't be in /usr
Message-ID: <20031020153720.GA29503@suse.de>
References: <20031018113455.GA22140@wavehammer.waldi.eu.org> <200310190035.06420.russell@coker.com.au> <20031019121044.GA29052@wavehammer.waldi.eu.org> <200310192301.20068.russell@coker.com.au> <20031019163501.GA26554@wavehammer.waldi.eu.org> <20031020145526.H321@lemuria.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20031020145526.H321@lemuria.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Oct 20, Tom wrote:

> On Sun, Oct 19, 2003 at 06:35:01PM +0200, Bastian Blank wrote:
> > okay, i see it. but it seems to violate the fhs by put the libselinux.so
> > symlink into /lib as well, it is not essential for running applications.
> 
> It is. For all apps that reside in /bin or /sbin and could potentially
> be executed before /usr is mounted.

Tom, don't be confused with the real library and the .so symlink.

The real library should be in /lib
The .so link, which is only used for linking applications against
this library and never for runtime, should reside in /usr/lib.

  Thorsten

-- 
Thorsten Kukuk       http://www.suse.de/~kukuk/        kukuk@suse.de
SuSE Linux AG        Deutschherrnstr. 15-19        D-90429 Nuernberg
--------------------------------------------------------------------    
Key fingerprint = A368 676B 5E1B 3E46 CFCE  2D97 F8FD 4E23 56C6 FB4B

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
