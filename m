Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7MF5irT013397
	for <selinux@tycho.nsa.gov>; Sun, 22 Aug 2004 11:05:45 -0400 (EDT)
Received: from rwcrmhc13.comcast.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7MF5cV1008187
	for <selinux@tycho.nsa.gov>; Sun, 22 Aug 2004 15:05:44 GMT
Message-ID: <4128B637.8040900@tresys.com>
Date: Sun, 22 Aug 2004 11:05:27 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: russell@coker.com.au
CC: SE Linux <selinux@tycho.nsa.gov>, fedora-selinux-list@redhat.com,
   gregkh@gentoo.org
Subject: Re: Fedora and udev
References: <200408222125.38169.russell@coker.com.au>
In-Reply-To: <200408222125.38169.russell@coker.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I posted a patch here that pebenito did a while back for ramfs and lkcl 
also did one for tmpfs (which may be better for /dev since it's swappable)
both are mostly cut and paste jobs but they add the necessary support.

I'd like to reiterate though, that udev support for selinux is *broken*! 
if the correct policy isn't in place you will cause race conditions

Joshua

Russell Coker wrote:

>It seems that udev is now virtually mandatory as of the latest rawhide update.
>
>udev uses ramfs for /tmp, ramfs (as of the latest Fedora kernel 2.6.8-1.525) 
>has no support for file labelling and breaks everything.
>
>Can we get ramfs labelling working in the next few days or do we have to 
>change things to not depend on udev?
>
>  
>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
