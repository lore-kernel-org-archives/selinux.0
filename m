Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA11550
	for <selinux@tycho.nsa.gov>; Mon, 5 Aug 2002 14:18:53 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id SAA09057
	for <selinux@tycho.nsa.gov>; Mon, 5 Aug 2002 18:17:17 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id SAA09053 for <selinux@tycho.nsa.gov>; Mon, 5 Aug 2002 18:17:15 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Chris Vance <cvance@tislabs.com>
Subject: Re: what is "null" access?
Date: Mon, 5 Aug 2002 20:18:36 +0200
Cc: SE Linux <selinux@tycho.nsa.gov>
References: <Pine.LNX.4.33.0208051335190.13180-100000@zorg.gw.tislabs.com>
In-Reply-To: <Pine.LNX.4.33.0208051335190.13180-100000@zorg.gw.tislabs.com>
MIME-Version: 1.0
Message-Id: <20020805181836.B14D019A4@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 5 Aug 2002 19:43, Chris Vance wrote:
> On Mon, 5 Aug 2002, Russell Coker wrote:
> > Aug ?5 10:58:57 ns kernel: avc: ?denied ?null for ?pid=30897
> > exe=/usr/sbin/apache IPCID=0 scontext=system_u:system_r:httpd_t
> > tcontext=system_u:system_r:httpd_t tclass=shm
> > Aug ?5 10:58:57 ns kernel: avc: ?denied ?null for ?pid=30897
> > exe=/usr/sbin/apache IPCID=0 scontext=system_u:system_r:httpd_t
> > tcontext=system_u:system_r:httpd_t tclass=shm
> >
> > The above messages are appearing on a system running a version of SE
> > Linux that's not the latest (running the original 2002.07.03 release).
>
> The above message indicates that the requested permission is null.  In
> this particular case, it looks like apache is calling shmget() with a
> requested permission that does not include read or write access.  This can
> be a permission of '0000', '0111' or similar.  In May of this year a
> change to the AVC causes this access request to be explicitly denied.
>
> The kernel code path accepts this, and subsequently the ipc_permission()
> hook is called.  The SELinux implementation currently applies masks for
> read and write permissions, and not finding these checks for no (null)
> permission.  We are looking at the logic here and will likely make a
> change, as this denial is not the expected behaviour.

So you are saying that this is a bug in Apache which causes an unexpected 
parameter to a system call, and that parameter is not handled correctly due 
to a bug in SE Linux?


Russell Coker

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
