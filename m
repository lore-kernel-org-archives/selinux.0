Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6TCWurT017983
	for <selinux@tycho.nsa.gov>; Thu, 29 Jul 2004 08:32:56 -0400 (EDT)
Received: from rwcrmhc12.comcast.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6TCWPbB014593
	for <selinux@tycho.nsa.gov>; Thu, 29 Jul 2004 12:32:26 GMT
Message-ID: <4108EE75.6040109@gentoo.org>
Date: Thu, 29 Jul 2004 08:32:53 -0400
From: Joshua Brindle <method@gentoo.org>
MIME-Version: 1.0
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
CC: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: udev and .dev...
References: <20040729091423.GC6443@lkcl.net>
In-Reply-To: <20040729091423.GC6443@lkcl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Luke Kenneth Casson Leighton wrote:

>dear selinux people,
>
>ah ha!  okay, the reason why my hard drive was inaccessible
>is because /.dev/* had all been set to default_t :)
>
>soooo... to fix that [rather than a patch, a sed command]:
>
>	:%s/u?dev/.?u?dev/g
>
>this will allow setfiles to set up the security contexts on
>the /.dev which is the _real_ filesystem /dev stuff which will
>allow things like, oh, init (!!) to access the hard drive.
>
>argh :)
>
>l.
>
>  
>
Why not have a minimal /dev for init and friends and mount the ramfs for 
udev on top of it? it's much easier to deal with 1 /dev and this is 
pretty standard anyway.

Joshua

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
