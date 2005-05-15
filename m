Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4FGVMgA013755
	for <selinux@tycho.nsa.gov>; Sun, 15 May 2005 12:31:22 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j4FGS9iA012339
	for <selinux@tycho.nsa.gov>; Sun, 15 May 2005 16:28:09 GMT
Date: Sun, 15 May 2005 17:37:26 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: SELinux <selinux@tycho.nsa.gov>
Subject: Re: ls -Z on non-SE machine
Message-ID: <20050515163726.GC8522@lkcl.net>
References: <200505151921.23171.russell@coker.com.au> <20050515102704.GA16326@lkcl.net> <200505152111.34732.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200505152111.34732.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, May 15, 2005 at 09:11:31PM +1000, Russell Coker wrote:
> On Sunday 15 May 2005 20:27, Luke Kenneth Casson Leighton <lkcl@lkcl.net> 
> wrote:
> > how about just silently ignoring the -Z option if selinux is
> > detected to not be enabled?
> >
> > or placing dummy information in its place which any selinux-aware
> > shell scripts can pick up on.
> 
> You appear to have totally ignored my points about analysis of SE Linux disks 
> in non-SE machines and recovery of SE Linux systems from non-SE rescue disks.
 
 .... ignored, no.
 
 implications-of: hadn't sunk in.

 yep - i get it now.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
