Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7NMoRrT022075
	for <selinux@tycho.nsa.gov>; Mon, 23 Aug 2004 18:50:27 -0400 (EDT)
Received: from rwcrmhc11.comcast.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7NMngAS004897
	for <selinux@tycho.nsa.gov>; Mon, 23 Aug 2004 22:49:42 GMT
Message-ID: <412A74A6.9070206@tresys.com>
Date: Mon, 23 Aug 2004 18:50:14 -0400
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: russell@coker.com.au, SE Linux <selinux@tycho.nsa.gov>,
   fedora-selinux-list@redhat.com
Subject: Re: Fedora and udev
References: <200408222125.38169.russell@coker.com.au> <4128B637.8040900@tresys.com> <20040822173457.GD13842@lkcl.net> <20040823224444.GI4694@kroah.com>
In-Reply-To: <20040823224444.GI4694@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Greg KH wrote:

>Please fix that patch up to:
>	- not have any ifdef in the .c files
>	- use the proper coding style
>	- use the same convention as the other build flags have.
>
>Actually, what was wrong with the older selinux support in udev that was
>there?  Why not just dig that stuff up and see if it works or not (I bet
>it does...)  If so, I'll be glad to add it back in, it's just that too
>many people complained about it when it was in there...
>  
>
Who complained and why? When selinux support wasn't built in the 
functions were just stubs, how could that have possibly had any effect 
whatsoever on anyone else?
If you could, please paste a patch from the older version so that we can 
see here whether it should work right (it's possible that the libselinux 
api changed between then and now)

>Oh, and udev does not require a ramfs, or tmpfs at all, that's just how
>the distro decided to use it.
>
>  
>
Joshua Brindle

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
